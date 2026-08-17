package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.OrderDAO;
import model.OrderDTO;
import model.OrderDetailDAO;
import model.OrderDetailDTO;
import model.UserDTO;

@WebServlet(name = "OrderHistoryController", urlPatterns = {"/my-orders", "/orders"})
public class OrderHistoryController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session != null) ? (UserDTO) session.getAttribute("LOGIN_USER") : null;

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=my-orders");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        if (action.equals("cancel")) {
            String orderID = request.getParameter("id");
            OrderDTO order = orderDAO.getOrderByID(orderID);
            if (order != null && order.getUserID().equals(loginUser.getUserID()) && "PENDING".equalsIgnoreCase(order.getStatus())) {
                orderDAO.updateOrderStatus(orderID, "CANCELLED");
                response.sendRedirect(request.getContextPath() + "/my-orders?success=cancelled");
                return;
            }
        }

        // List user's orders
        String statusFilter = request.getParameter("status");
        if (statusFilter == null || statusFilter.isEmpty()) {
            statusFilter = "ALL";
        }

        List<OrderDTO> allUserOrders = orderDAO.getOrdersByUserID(loginUser.getUserID());
        
        // Filter by status if requested
        List<OrderDTO> filteredOrders = new java.util.ArrayList<>();
        for (OrderDTO o : allUserOrders) {
            if ("ALL".equalsIgnoreCase(statusFilter) || o.getStatus().equalsIgnoreCase(statusFilter)) {
                filteredOrders.add(o);
            }
        }

        // Map orderID -> List<OrderDetailDTO>
        Map<String, List<OrderDetailDTO>> orderDetailsMap = new HashMap<>();
        for (OrderDTO o : filteredOrders) {
            List<OrderDetailDTO> details = orderDetailDAO.getOrderDetails(o.getOrderID());
            orderDetailsMap.put(o.getOrderID(), details);
        }

        request.setAttribute("ORDERS", filteredOrders);
        request.setAttribute("ORDER_DETAILS_MAP", orderDetailsMap);
        request.setAttribute("SELECTED_STATUS", statusFilter);
        request.setAttribute("TOTAL_USER_ORDERS", allUserOrders.size());

        request.getRequestDispatcher("my-orders.jsp").forward(request, response);
    }
}
