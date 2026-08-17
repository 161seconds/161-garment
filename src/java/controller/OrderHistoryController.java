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
        } else if (action.equals("reorder")) {
            String orderID = request.getParameter("id");
            OrderDTO order = orderDAO.getOrderByID(orderID);
            if (order != null && order.getUserID().equals(loginUser.getUserID())) {
                List<OrderDetailDTO> details = orderDetailDAO.getOrderDetails(orderID);
                model.ProductDAO productDAO = new model.ProductDAO();
                List<model.CartItemDTO> cart = (List<model.CartItemDTO>) session.getAttribute("CART");
                if (cart == null) {
                    cart = new java.util.ArrayList<>();
                }

                for (OrderDetailDTO d : details) {
                    model.ProductDTO p = productDAO.getProductByID(d.getProductID());
                    if (p != null && p.isStatus()) {
                        boolean found = false;
                        for (model.CartItemDTO ci : cart) {
                            if (ci.getProduct().getProductID().equals(p.getProductID())) {
                                int newQty = ci.getQuantity() + d.getQuantity();
                                if (p.getQuantity() > 0 && newQty > p.getQuantity()) {
                                    newQty = p.getQuantity();
                                }
                                ci.setQuantity(newQty);
                                found = true;
                                break;
                            }
                        }
                        if (!found) {
                            int addQty = d.getQuantity();
                            if (p.getQuantity() > 0 && addQty > p.getQuantity()) {
                                addQty = p.getQuantity();
                            }
                            cart.add(new model.CartItemDTO(p, addQty));
                        }
                    }
                }
                session.setAttribute("CART", cart);
                session.setAttribute("SUCCESS_MSG", "Đã thêm các sản phẩm từ đơn hàng #" + orderID + " vào giỏ hàng!");
                response.sendRedirect(request.getContextPath() + "/cart");
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
