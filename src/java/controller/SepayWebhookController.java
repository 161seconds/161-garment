package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBUtils;

@WebServlet(name = "SepayWebhookController", urlPatterns = {"/api/sepay-webhook", "/sepay-webhook"})
public class SepayWebhookController extends HttpServlet {

    // Cache to track confirmed transactions in-memory for instant polling
    public static final Set<String> PAID_PHONE_SET = Collections.synchronizedSet(new HashSet<>());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"status\":\"active\",\"gateway\":\"SePay MBBank Webhook\",\"accountNumber\":\"08222216167810\"}");
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

        // 2. Extract SePay fields
        String content = extractJsonString(jsonPayload, "content");
        String transferType = extractJsonString(jsonPayload, "transferType");
        String accountNumber = extractJsonString(jsonPayload, "accountNumber");
        String referenceCode = extractJsonString(jsonPayload, "referenceCode");
        double transferAmount = extractJsonDouble(jsonPayload, "transferAmount");

        System.out.println("-> SePay Content: " + content + ", Amount: " + transferAmount + ", Type: " + transferType);

        // Only process incoming money (transferType == "in")
        if (transferType != null && !transferType.equalsIgnoreCase("in")) {
            out.print("{\"success\":true,\"message\":\"Ignored out transfer\"}");
            return;
        }

        // 3. Extract Phone Number or Order ID from transaction content (e.g., "161GM 0987654321")
        String matchedPhone = null;
        if (content != null) {
            Pattern p = Pattern.compile("(?:161GM|161gm|161)\\s*([0-9]{9,11})");
            Matcher m = p.matcher(content);
            if (m.find()) {
                matchedPhone = m.group(1);
            } else {
                // Fallback: any 10-11 digit phone number
                Pattern p2 = Pattern.compile("(0[0-9]{9,10})");
                Matcher m2 = p2.matcher(content);
                if (m2.find()) {
                    matchedPhone = m2.group(1);
                }
            }
        }

        if (matchedPhone != null) {
            PAID_PHONE_SET.add(matchedPhone);
            System.out.println("-> Payment confirmed for phone: " + matchedPhone);
        }

        // 4. Update Database if matching pending order exists
        if (matchedPhone != null) {
            try (Connection conn = DBUtils.getConnection()) {
                if (conn != null) {
                    // Update latest Order status for this phone to PROCESSING
                    String sqlUpdate = "UPDATE [Order] SET status = 'PROCESSING', note = note + N' [SePay: Đã thanh toán MBBank]' "
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

        // 5. Always respond 200 OK to SePay
        response.setStatus(HttpServletResponse.SC_OK);
        out.print("{\"success\":true,\"message\":\"Payment processed successfully\"}");
    }

    private String extractJsonString(String json, String key) {
        Pattern pattern = Pattern.compile("\"" + key + "\"\\s*:\\s*\"([^\"]+)\"");
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
