package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBUtils;
import utils.EnvUtils;

@WebServlet(name = "SepayWebhookController", urlPatterns = {"/api/sepay-webhook", "/sepay-webhook"})
public class SepayWebhookController extends HttpServlet {

    // SePay HMAC-SHA256 Secret Key (Loaded dynamically from .env)
    private static final String SEPAY_WEBHOOK_SECRET = EnvUtils.get("SEPAY_WEBHOOK_SECRET", "whsec_7mLCLdsB2vPQk9gA4djFsERqIiTlZ2HO");

    // Cache to track confirmed transactions in-memory for instant frontend polling
    public static final Set<String> PAID_PHONE_SET = Collections.synchronizedSet(new HashSet<>());

    // Idempotency: Set of processed SePay transaction IDs to prevent duplicate processing on retries/replays
    private static final Set<String> PROCESSED_TRANSACTION_IDS = Collections.synchronizedSet(new HashSet<>());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"status\":\"active\",\"gateway\":\"SePay MBBank Webhook (HMAC-SHA256 Enabled)\",\"accountNumber\":\"08222216167810\"}");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 1. Read Raw JSON body sent by SePay
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        String jsonPayload = sb.toString();
        System.out.println("[SePay Webhook Received]: " + jsonPayload);

        if (jsonPayload.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\":false,\"message\":\"Empty payload\"}");
            return;
        }

        // 2. Validate HMAC-SHA256 Signature from SePay Headers
        String signatureHeader = request.getHeader("X-SePay-Signature");
        String timestampHeader = request.getHeader("X-SePay-Timestamp");

        if (signatureHeader != null && timestampHeader != null) {
            boolean isValidSignature = verifyHmacSha256(jsonPayload, timestampHeader, signatureHeader, SEPAY_WEBHOOK_SECRET);
            if (!isValidSignature) {
                System.err.println("[SePay Webhook Rejected]: Invalid HMAC-SHA256 Signature!");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"success\":false,\"message\":\"Invalid HMAC-SHA256 signature\"}");
                return;
            }
            System.out.println("[SePay Webhook Verified]: HMAC-SHA256 Signature is valid!");
        } else {
            System.out.println("[SePay Webhook Notice]: No signature headers provided (Allowing local simulation mode)");
        }

        // 3. Extract SePay fields
        String txId = extractJsonStringOrNumber(jsonPayload, "id");
        String content = extractJsonString(jsonPayload, "content");
        String code = extractJsonString(jsonPayload, "code");
        String transferType = extractJsonString(jsonPayload, "transferType");
        String accountNumber = extractJsonString(jsonPayload, "accountNumber");
        String referenceCode = extractJsonString(jsonPayload, "referenceCode");
        double transferAmount = extractJsonDouble(jsonPayload, "transferAmount");

        System.out.println("-> SePay TxID: " + txId + ", Content: " + content + ", Amount: " + transferAmount + ", Type: " + transferType);

        // 4. Idempotency Check (Chống trùng lặp khi SePay retry hoặc Admin replay)
        String uniqueTxKey = (txId != null && !txId.isEmpty()) ? txId : referenceCode;
        if (uniqueTxKey != null && !uniqueTxKey.isEmpty()) {
            if (PROCESSED_TRANSACTION_IDS.contains(uniqueTxKey)) {
                System.out.println("[SePay Idempotency]: Transaction " + uniqueTxKey + " has already been processed. Returning 200 OK.");
                response.setStatus(HttpServletResponse.SC_OK);
                out.print("{\"success\":true}");
                return;
            }
            PROCESSED_TRANSACTION_IDS.add(uniqueTxKey);
        }

        // 5. Only process incoming money (transferType == "in")
        if (transferType != null && !transferType.equalsIgnoreCase("in")) {
            response.setStatus(HttpServletResponse.SC_OK);
            out.print("{\"success\":true}");
            return;
        }

        // 6. Extract Phone Number or Order ID from transaction content / code (e.g., "161GM 0987654321")
        String matchedPhone = null;
        String searchTarget = (code != null && !code.isEmpty()) ? code + " " + content : content;

        if (searchTarget != null) {
            Pattern p = Pattern.compile("(?:161GM|161gm|161)\\s*([0-9]{9,11})");
            Matcher m = p.matcher(searchTarget);
            if (m.find()) {
                matchedPhone = m.group(1);
            } else {
                // Fallback: any 10-11 digit phone number starting with 0
                Pattern p2 = Pattern.compile("(0[0-9]{9,10})");
                Matcher m2 = p2.matcher(searchTarget);
                if (m2.find()) {
                    matchedPhone = m2.group(1);
                }
            }
        }

        if (matchedPhone != null) {
            PAID_PHONE_SET.add(matchedPhone);
            System.out.println("-> Payment confirmed for phone: " + matchedPhone);
        }

        // 7. Update Database if matching pending order exists
        if (matchedPhone != null) {
            try (Connection conn = DBUtils.getConnection()) {
                if (conn != null) {
                    // Update latest Order status for this phone to PROCESSING
                    String sqlUpdate = "UPDATE [Order] SET status = 'PROCESSING', note = note + N' [SePay: Đã thanh toán MBBank qua Webhook]' "
                                     + "WHERE (shippingAddress LIKE ? OR note LIKE ?) AND status = 'PENDING'";
                    try (PreparedStatement ptm = conn.prepareStatement(sqlUpdate)) {
                        ptm.setString(1, "%" + matchedPhone + "%");
                        ptm.setString(2, "%" + matchedPhone + "%");
                        int updated = ptm.executeUpdate();
                        System.out.println("-> Orders updated in database: " + updated);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 8. Always respond 200 OK with {"success": true} as required by SePay
        response.setStatus(HttpServletResponse.SC_OK);
        out.print("{\"success\":true}");
    }

    /**
     * Verifies SePay HMAC-SHA256 Signature
     * Expected format: sha256=hash_hmac('sha256', timestamp . '.' . payload, secret)
     */
    private boolean verifyHmacSha256(String rawBody, String timestamp, String signatureHeader, String secretKey) {
        try {
            String dataToSign = timestamp + "." + rawBody;
            Mac mac = Mac.getInstance("HmacSHA256");
            SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            mac.init(secretKeySpec);

            byte[] hmacBytes = mac.doFinal(dataToSign.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hmacBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

            String expectedSignature = "sha256=" + hexString.toString();
            String cleanSignature = signatureHeader.trim();
            if (!cleanSignature.startsWith("sha256=")) {
                cleanSignature = "sha256=" + cleanSignature;
            }

            return MessageDigest.isEqual(
                expectedSignature.getBytes(StandardCharsets.UTF_8),
                cleanSignature.getBytes(StandardCharsets.UTF_8)
            );
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private String extractJsonString(String json, String key) {
        Pattern pattern = Pattern.compile("\"" + key + "\"\\s*:\\s*\"([^\"]*)\"");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }

    private String extractJsonStringOrNumber(String json, String key) {
        Pattern pattern = Pattern.compile("\"" + key + "\"\\s*:\\s*\"?([0-9a-zA-Z_-]+)\"?");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }

    private double extractJsonDouble(String json, String key) {
        Pattern pattern = Pattern.compile("\"" + key + "\"\\s*:\\s*([0-9.]+)");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            try {
                return Double.parseDouble(matcher.group(1));
            } catch (NumberFormatException e) {
                return 0.0;
            }
        }
        return 0.0;
    }
}
