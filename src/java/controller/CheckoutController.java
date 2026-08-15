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

        String address = request.getParameter("address");
        String note = request.getParameter("note");
        
        double total = 0;
        List<OrderDetailDTO> details = new ArrayList<>();
        String orderID = UUID.randomUUID().toString().substring(0, 20); // Generate simple ID
        
        for (CartItemDTO item : cart) {
            total += item.getProduct().getPrice() * item.getQuantity();
            details.add(new OrderDetailDTO(orderID, item.getProduct().getProductID(), item.getProduct().getPrice(), item.getQuantity()));
        }

        OrderDTO order = new OrderDTO();
        order.setOrderID(orderID);
        order.setUserID(user.getUserID());
        order.setTotalMoney(total);
        order.setShippingAddress(address);
        order.setNote(note);

        OrderDAO dao = new OrderDAO();
        boolean check = dao.insertOrder(order, details);
        
        if (check) {
            session.removeAttribute("CART");
            request.setAttribute("SUCCESS", "Đặt hàng thành công!");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else {
            request.setAttribute("ERROR", "Đặt hàng thất bại!");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}
