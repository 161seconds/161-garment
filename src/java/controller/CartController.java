package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartItemDTO;
import model.ProductDAO;
import model.ProductDTO;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("CART");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        if (action != null) {
            if (action.equals("add")) {
                String productID = request.getParameter("id");
                if (productID == null || productID.isEmpty()) {
                    productID = request.getParameter("productID");
                }
                
                int addQty = 1;
                String qtyParam = request.getParameter("quantity");
                if (qtyParam != null && !qtyParam.isEmpty()) {
                    try {
                        addQty = Integer.parseInt(qtyParam);
                        if (addQty < 1) addQty = 1;
                    } catch (Exception e) {
                        addQty = 1;
                    }
                }
                
                ProductDAO pDao = new ProductDAO();
                ProductDTO product = pDao.getProductByID(productID);
                
                if (product != null) {
                    boolean exist = false;
                    for (CartItemDTO item : cart) {
                        if (item.getProduct().getProductID().equals(productID)) {
                            int newTotal = item.getQuantity() + addQty;
                            if (product.getQuantity() > 0 && newTotal > product.getQuantity()) {
                                newTotal = product.getQuantity();
                            }
                            item.setQuantity(newTotal);
                            exist = true;
                            break;
                        }
                    }
                    if (!exist) {
                        if (product.getQuantity() > 0 && addQty > product.getQuantity()) {
                            addQty = product.getQuantity();
                        }
                        cart.add(new CartItemDTO(product, addQty));
                    }
                    session.setAttribute("SUCCESS_MSG", "Đã thêm " + addQty + " sản phẩm [" + product.getName() + "] vào giỏ hàng!");
                }
            } else if (action.equals("inc")) {
                String productID = request.getParameter("id");
                for (CartItemDTO item : cart) {
                    if (item.getProduct().getProductID().equals(productID)) {
                        if (item.getProduct().getQuantity() > item.getQuantity()) {
                            item.setQuantity(item.getQuantity() + 1);
                        }
                        break;
                    }
                }
            } else if (action.equals("dec")) {
                String productID = request.getParameter("id");
                for (int i = 0; i < cart.size(); i++) {
                    CartItemDTO item = cart.get(i);
                    if (item.getProduct().getProductID().equals(productID)) {
                        if (item.getQuantity() > 1) {
                            item.setQuantity(item.getQuantity() - 1);
                        } else {
                            cart.remove(i);
                        }
                        break;
                    }
                }
            } else if (action.equals("remove")) {
                String productID = request.getParameter("id");
                cart.removeIf(item -> item.getProduct().getProductID().equals(productID));
            } else if (action.equals("update")) {
                String productID = request.getParameter("id");
                try {
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    for (CartItemDTO item : cart) {
                        if (item.getProduct().getProductID().equals(productID)) {
                            if (quantity > 0) {
                                if (item.getProduct().getQuantity() > 0 && quantity > item.getProduct().getQuantity()) {
                                    quantity = item.getProduct().getQuantity();
                                }
                                item.setQuantity(quantity);
                            } else {
                                cart.remove(item);
                            }
                            break;
                        }
                    }
                } catch (NumberFormatException ignored) {}
            } else if (action.equals("clear")) {
                cart.clear();
            }
        }
        
        session.setAttribute("CART", cart);
        
        // Calculate total amount and total items
        double total = 0;
        int totalItems = 0;
        for (CartItemDTO item : cart) {
            total += item.getProduct().getPrice() * item.getQuantity();
            totalItems += item.getQuantity();
        }
        request.setAttribute("TOTAL", total);
        request.setAttribute("TOTAL_ITEMS", totalItems);
        
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

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
}
