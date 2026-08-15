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
                            item.setQuantity(item.getQuantity() + addQty);
                            exist = true;
                            break;
                        }
                    }
                    if (!exist) {
                        cart.add(new CartItemDTO(product, addQty));
                    }
                    session.setAttribute("SUCCESS_MSG", "Đã thêm " + addQty + " sản phẩm [" + product.getName() + "] vào giỏ hàng!");
                }
            } else if (action.equals("remove")) {
                String productID = request.getParameter("id");
                cart.removeIf(item -> item.getProduct().getProductID().equals(productID));
            } else if (action.equals("update")) {
                String productID = request.getParameter("id");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                for (CartItemDTO item : cart) {
                    if (item.getProduct().getProductID().equals(productID)) {
                        if (quantity > 0) {
                            item.setQuantity(quantity);
                        } else {
                            cart.remove(item);
                        }
                        break;
                    }
                }
            }
        }
        
        session.setAttribute("CART", cart);
        
        // Caculate total
        double total = 0;
        for (CartItemDTO item : cart) {
            total += item.getProduct().getPrice() * item.getQuantity();
        }
        request.setAttribute("TOTAL", total);
        
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
