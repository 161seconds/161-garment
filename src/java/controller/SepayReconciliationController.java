package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBUtils;
import utils.EnvUtils;

@WebServlet(name = "SepayReconciliationController", urlPatterns = {"/api/reconcile-sepay", "/admin/reconcile-sepay"})
public class SepayReconciliationController extends HttpServlet {

    // Default Token from .env
    private static final String DEFAULT_API_TOKEN = EnvUtils.get("SEPAY_API_TOKEN", "JHNJIPVMTXJBZ1JZICEODLL8AUVV0ZAGMGQRPVS52M5ROWUYIRT2P3EF6UD89AON");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processReconciliation(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processReconciliation(request, response);
    }

    private void processReconciliation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String token = request.getParameter("token");
        if (token == null || token.trim().isEmpty()) {
            token = System.getenv("SEPAY_API_TOKEN");
            if (token == null || token.isEmpty()) {
                token = DEFAULT_API_TOKEN;
            }
        }

        try {
            // 1. Call SePay Transactions API
            String apiUrl = "https://userapi.sepay.vn/v2/transactions?per_page=100";
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + token);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(15000);

            int responseCode = conn.getResponseCode();
            StringBuilder sb = new StringBuilder();

            if (responseCode == 200) {
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        sb.append(line);
                    }
                }
            } else {
                // If token not configured or API returns error, return diagnostic info
                out.print("{\"success\":false,\"message\":\"SePay API returned status " + responseCode + ". Vui lòng kiểm tra SEPAY_API_TOKEN trong .env.\",\"status\":" + responseCode + "}");
                return;
            }

            String jsonResponse = sb.toString();

            // 2. Reconcile with Database Pending Orders
            int totalFetched = 0;
            int reconciledCount = 0;

            try (Connection dbConn = DBUtils.getConnection()) {
                if (dbConn != null) {
                    // Match transactions containing phone numbers with PENDING orders
                    Pattern txPattern = Pattern.compile("\\{(?:[^{}]|\\{[^{}]*\\})*\\}");
                    Matcher txMatcher = txPattern.matcher(jsonResponse);

                    while (txMatcher.find()) {
                        String txJson = txMatcher.group(0);
                        if (!txJson.contains("\"transaction_date\"") && !txJson.contains("\"transactionDate\"")) {
                            continue;
                        }
                        totalFetched++;

                        // Extract content / code
                        String content = extractJsonValue(txJson, "transaction_content");
                        if (content == null) content = extractJsonValue(txJson, "content");
                        String code = extractJsonValue(txJson, "code");

                        String target = (code != null ? code + " " : "") + (content != null ? content : "");
                        String matchedPhone = null;

                        Pattern p = Pattern.compile("(?:161GM|161gm|161)\\s*([0-9]{9,11})");
                        Matcher m = p.matcher(target);
                        if (m.find()) {
                            matchedPhone = m.group(1);
                        } else {
                            Pattern p2 = Pattern.compile("(0[0-9]{9,10})");
                            Matcher m2 = p2.matcher(target);
                            if (m2.find()) {
                                matchedPhone = m2.group(1);
                            }
                        }

                        if (matchedPhone != null) {
                            SepayWebhookController.PAID_PHONE_SET.add(matchedPhone);

                            String sqlUpdate = "UPDATE [Order] SET status = 'PROCESSING', note = note + N' [SePay Reconciled]' "
                                             + "WHERE (shippingAddress LIKE ? OR note LIKE ?) AND status = 'PENDING'";
                            try (PreparedStatement ptm = dbConn.prepareStatement(sqlUpdate)) {
                                ptm.setString(1, "%" + matchedPhone + "%");
                                ptm.setString(2, "%" + matchedPhone + "%");
                                int rows = ptm.executeUpdate();
                                if (rows > 0) {
                                    reconciledCount += rows;
                                }
                            }
                        }
                    }
                }
            }

            out.print("{\"success\":true,\"totalTransactions\":" + totalFetched + ",\"reconciledOrders\":" + reconciledCount + ",\"message\":\"Đối soát SePay hoàn tất. Đã xử lý " + reconciledCount + " đơn hàng chờ.\"}");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false,\"message\":\"Lỗi đối soát: " + e.getMessage() + "\"}");
        }
    }

    private String extractJsonValue(String json, String key) {
        Pattern pattern = Pattern.compile("\"" + key + "\"\\s*:\\s*\"([^\"]*)\"");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }
}
