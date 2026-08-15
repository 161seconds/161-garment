package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartItemDTO;
import model.OrderDAO;
import model.OrderDTO;
import model.OrderDetailDTO;
import model.UserDTO;

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("CART");
        
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        double total = 0;
        for (CartItemDTO item : cart) {
            total += item.getProduct().getPrice() * item.getQuantity();
        }
        request.setAttribute("TOTAL", total);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("CART");
        UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
        
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD";
        }
        
        String formattedAddress = address;
        if (fullName != null && phone != null && !fullName.trim().isEmpty() && !phone.trim().isEmpty()) {
            formattedAddress = fullName.trim() + " (" + phone.trim() + ") - " + address.trim();
        }
        
        double total = 0;
        List<OrderDetailDTO> details = new ArrayList<>();
        String orderID = "ORD" + (System.currentTimeMillis() % 1000000000L); // Clean readable order ID
        
        for (CartItemDTO item : cart) {
            total += item.getProduct().getPrice() * item.getQuantity();
            details.add(new OrderDetailDTO(orderID, item.getProduct().getProductID(), item.getProduct().getPrice(), item.getQuantity()));
        }

        String paymentLabel = "QR_CODE".equalsIgnoreCase(paymentMethod) ? "[Thanh toán VietQR]" : "[Thanh toán COD]";
        String fullNote = paymentLabel + (note != null && !note.trim().isEmpty() ? " " + note.trim() : "");

        OrderDTO order = new OrderDTO();
        order.setOrderID(orderID);
        order.setUserID(user != null ? user.getUserID() : "GUEST");
        order.setTotalMoney(total);
        order.setShippingAddress(formattedAddress);
        order.setNote(fullNote);

        OrderDAO dao = new OrderDAO();
        boolean check = dao.insertOrder(order, details);
        
        if (check) {
            session.removeAttribute("CART");
            request.setAttribute("SUCCESS_ORDER_ID", orderID);
            request.setAttribute("PAYMENT_METHOD", paymentMethod);
            request.setAttribute("TOTAL_MONEY", total);
            request.setAttribute("SUCCESS", "Đặt hàng thành công! Mã đơn: #" + orderID);
            request.getRequestDispatcher("order-success.jsp").forward(request, response);
        } else {
            request.setAttribute("ERROR", "Đặt hàng thất bại, vui lòng thử lại!");
            request.setAttribute("TOTAL", total);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}
