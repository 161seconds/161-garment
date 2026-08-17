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

        // 1. Consume in-memory webhook event (remove upon consumption so it only fires ONCE per real transaction)
        if (phone != null && !phone.isEmpty()) {
            if (SepayWebhookController.PAID_PHONE_SET.remove(phone)) {
                isPaid = true;
                System.out.println("[Payment Polling] Real-time payment detected and consumed for phone: " + phone);
            }
        }

        // 2. Check Database: ONLY check orders created in the last 5 minutes that were updated by SePay
        if (!isPaid && phone != null && !phone.isEmpty()) {
            String sql = "SELECT TOP 1 orderID, status, note FROM [Order] "
                       + "WHERE (shippingAddress LIKE ? OR note LIKE ?) "
                       + "AND status = 'PROCESSING' "
                       + "AND note LIKE '%[SePay:%' "
                       + "AND DATEDIFF(minute, orderDate, GETDATE()) <= 5 "
                       + "ORDER BY orderDate DESC";
            try (Connection conn = DBUtils.getConnection();
                 PreparedStatement ptm = conn.prepareStatement(sql)) {
                ptm.setString(1, "%" + phone + "%");
                ptm.setString(2, "%" + phone + "%");
                try (ResultSet rs = ptm.executeQuery()) {
                    if (rs.next()) {
                        orderID = rs.getString("orderID");
                        isPaid = true;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        out.print("{\"paid\":" + isPaid + (orderID != null ? ",\"orderID\":\"" + orderID + "\"" : "") + "}");
    }
}
