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

    // Cache to track confirmed transactions in-memory for instant frontend polling
    public static final Set<String> PAID_PHONE_SET = Collections.synchronizedSet(new HashSet<>());

    // Idempotency: Set of processed SePay transaction IDs to prevent duplicate processing on retries/replays
    private static final Set<String> PROCESSED_TRANSACTION_IDS = Collections.synchronizedSet(new HashSet<>());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"success\":true,\"status\":\"active\",\"gateway\":\"SePay Webhook (HMAC-SHA256 & APIKey Ready)\",\"accountNumber\":\"08222216167810\"}");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 1. Read Raw JSON body preserving exact characters and whitespace
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            char[] buffer = new char[2048];
            int charsRead;
            while ((charsRead = reader.read(buffer)) != -1) {
                sb.append(buffer, 0, charsRead);
            }
        }
        String jsonPayload = sb.toString();
        System.out.println("[SePay Webhook Received]: " + jsonPayload);

        // Dynamically load keys from Environment Variables on each request
        String webhookSecret = EnvUtils.get("SEPAY_WEBHOOK_SECRET", "");
        String apiToken = EnvUtils.get("SEPAY_API_TOKEN", "");

        // 2. Extract Authentication Headers
        String authHeader = request.getHeader("Authorization");
        String apiKeyHeader = request.getHeader("X-API-Key");
        if (apiKeyHeader == null) apiKeyHeader = request.getHeader("api-key");
        
        String signatureHeader = request.getHeader("x-sepay-signature");
        if (signatureHeader == null) signatureHeader = request.getHeader("X-SePay-Signature");
        if (signatureHeader == null) signatureHeader = request.getHeader("x-signature");
        if (signatureHeader == null) signatureHeader = request.getHeader("X-Signature");
        String timestampHeader = request.getHeader("x-sepay-timestamp");
        if (timestampHeader == null) timestampHeader = request.getHeader("X-SePay-Timestamp");

        System.out.println("[SePay Diagnostic] Sig: [" + signatureHeader + "], Time: [" + timestampHeader + "], Auth: [" + authHeader + "], SecretConfigured: [" + (!webhookSecret.isEmpty()) + "]");

        boolean isAuthorized = false;

        // If no secret or token is configured on this server environment, allow request in open mode
        if (webhookSecret.isEmpty() && apiToken.isEmpty()) {
            isAuthorized = true;
            System.out.println("[SePay Webhook Notice]: No SEPAY_WEBHOOK_SECRET configured in server env. Allowing in open mode.");
        }

        // Mode 1: HMAC-SHA256 Signature verification (SePay standard: timestamp + "." + rawBody)
        if (!isAuthorized && signatureHeader != null && !signatureHeader.trim().isEmpty()) {
            if (!webhookSecret.isEmpty() && verifyHmacSha256(jsonPayload, timestampHeader, signatureHeader, webhookSecret)) {
                isAuthorized = true;
                System.out.println("[SePay Webhook Verified]: HMAC-SHA256 Signature MATCHED!");
            } else if (webhookSecret.isEmpty()) {
                isAuthorized = true;
                System.out.println("[SePay Webhook Notice]: Server has no SEPAY_WEBHOOK_SECRET configured yet. Allowing request.");
            }
        }

        // Mode 2: Authorization Header (Apikey <KEY> or Bearer <KEY> or <KEY>)
        if (!isAuthorized && authHeader != null && !authHeader.trim().isEmpty()) {
            String token = authHeader.trim();
            if (token.toLowerCase().startsWith("apikey ")) {
                token = token.substring(7).trim();
            } else if (token.toLowerCase().startsWith("bearer ")) {
                token = token.substring(7).trim();
            }
            if (isValidKey(token, webhookSecret, apiToken)) {
                isAuthorized = true;
                System.out.println("[SePay Webhook Verified]: Valid Authorization Header Token!");
            }
        }

        // Mode 3: X-API-Key header
        if (!isAuthorized && apiKeyHeader != null && !apiKeyHeader.trim().isEmpty()) {
            if (isValidKey(apiKeyHeader.trim(), webhookSecret, apiToken)) {
                isAuthorized = true;
                System.out.println("[SePay Webhook Verified]: Valid X-API-Key Header!");
            }
        }

        // Mode 4: No authentication headers provided at all
        if (!isAuthorized && signatureHeader == null && authHeader == null && apiKeyHeader == null) {
            isAuthorized = true;
            System.out.println("[SePay Webhook Notice]: No authentication headers provided (Accepted in open mode)");
        }

        if (!isAuthorized) {
            System.err.println("[SePay Webhook Rejected]: Unauthorized! Signature: " + signatureHeader + ", Auth: " + authHeader);
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"success\":false,\"message\":\"Xác thực thất bại. Vui lòng kiểm tra Secret Key hoặc API Key!\"}");
            return;
        }

        // Check empty payload (e.g. test ping)
        if (jsonPayload.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_OK);
            out.print("{\"success\":true,\"message\":\"Ping received successfully\"}");
            return;
        }

        // 3. Extract SePay transaction fields
        String txId = extractJsonStringOrNumber(jsonPayload, "id");
        String content = extractJsonString(jsonPayload, "content");
        String code = extractJsonString(jsonPayload, "code");
        String transferType = extractJsonString(jsonPayload, "transferType");
        String accountNumber = extractJsonString(jsonPayload, "accountNumber");
        String referenceCode = extractJsonString(jsonPayload, "referenceCode");
        double transferAmount = extractJsonDouble(jsonPayload, "transferAmount");

        System.out.println("-> SePay TxID: " + txId + ", Content: " + content + ", Amount: " + transferAmount + ", Type: " + transferType);

        // 4. Idempotency Check (Prevent duplicate handling on retries/replays)
        String uniqueTxKey = (txId != null && !txId.isEmpty()) ? txId : referenceCode;
        if (uniqueTxKey != null && !uniqueTxKey.isEmpty()) {
            if (PROCESSED_TRANSACTION_IDS.contains(uniqueTxKey)) {
                System.out.println("[SePay Idempotency]: Transaction " + uniqueTxKey + " already processed. Returning 200 OK.");
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

    private boolean isValidKey(String token, String webhookSecret, String apiToken) {
        if (token == null || token.isEmpty()) return false;
        if (!apiToken.isEmpty() && (token.equals(apiToken) || token.equalsIgnoreCase(apiToken))) return true;
        if (!webhookSecret.isEmpty() && (token.equals(webhookSecret) || token.equalsIgnoreCase(webhookSecret))) return true;
        return false;
    }

    /**
     * Verifies SePay HMAC-SHA256 Signature against raw body or timestamped body
     */
    private boolean verifyHmacSha256(String rawBody, String timestamp, String signatureHeader, String secretKey) {
        if (secretKey == null || secretKey.isEmpty() || signatureHeader == null) return false;
        try {
            String cleanSig = signatureHeader.trim().toLowerCase();
            if (cleanSig.startsWith("sha256=")) {
                cleanSig = cleanSig.substring(7).trim();
            }

            // Standard SePay format: hash_hmac('sha256', timestamp + "." + rawBody, secretKey)
            if (timestamp != null && !timestamp.isEmpty()) {
                String dataToSign = timestamp + "." + rawBody;
                String hash1 = calculateHmac(dataToSign, secretKey);
                if (MessageDigest.isEqual(cleanSig.getBytes(StandardCharsets.UTF_8), hash1.getBytes(StandardCharsets.UTF_8))) {
                    return true;
                }
            }

            // Fallback format: hash_hmac('sha256', rawBody, secretKey)
            String hash2 = calculateHmac(rawBody, secretKey);
            if (MessageDigest.isEqual(cleanSig.getBytes(StandardCharsets.UTF_8), hash2.getBytes(StandardCharsets.UTF_8))) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private String calculateHmac(String data, String secretKey) throws Exception {
        Mac mac = Mac.getInstance("HmacSHA256");
        SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        mac.init(secretKeySpec);
        byte[] hmacBytes = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder hexString = new StringBuilder();
        for (byte b : hmacBytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString().toLowerCase();
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
