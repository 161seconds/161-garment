package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBUtils;

@WebServlet(name = "CheckPaymentController", urlPatterns = {"/api/check-payment"})
public class CheckPaymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String phone = request.getParameter("phone");
        if (phone != null) {
            phone = phone.trim().replace(" ", "");
        }

        boolean isPaid = false;
        String orderID = null;

        // 1. Check in-memory fast cache from SePay Webhook
        if (phone != null && SepayWebhookController.PAID_PHONE_SET.contains(phone)) {
            isPaid = true;
        }

        // 2. Check Database if not in cache
        if (!isPaid && phone != null && !phone.isEmpty()) {
            String sql = "SELECT TOP 1 orderID, status FROM [Order] WHERE (shippingAddress LIKE ? OR note LIKE ?) ORDER BY orderDate DESC";
            try (Connection conn = DBUtils.getConnection();
                 PreparedStatement ptm = conn.prepareStatement(sql)) {
                ptm.setString(1, "%" + phone + "%");
                ptm.setString(2, "%" + phone + "%");
                try (ResultSet rs = ptm.executeQuery()) {
                    if (rs.next()) {
                        orderID = rs.getString("orderID");
                        String status = rs.getString("status");
                        if ("PROCESSING".equalsIgnoreCase(status) || "PAID".equalsIgnoreCase(status) || "DELIVERED".equalsIgnoreCase(status)) {
                            isPaid = true;
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        out.print("{\"paid\":" + isPaid + (orderID != null ? ",\"orderID\":\"" + orderID + "\"" : "") + "}");
    }
}
