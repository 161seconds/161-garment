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
        
        model.UserDTO loginUser = (model.UserDTO) session.getAttribute("LOGIN_USER");
        model.CartDAO cartDAO = new model.CartDAO();
        
        List<CartItemDTO> cart = null;

        if (loginUser != null) {
            cart = cartDAO.getCartByUserID(loginUser.getUserID());
        } else {
            cart = (List<CartItemDTO>) session.getAttribute("CART");
        }

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
                    if (product.getQuantity() > 0 && addQty > product.getQuantity()) {
                        addQty = product.getQuantity();
                    }

                    if (loginUser != null) {
                        cartDAO.addToCart(loginUser.getUserID(), productID, addQty);
                        cart = cartDAO.getCartByUserID(loginUser.getUserID());
                    } else {
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
                            cart.add(new CartItemDTO(product, addQty));
                        }
                    }
                    session.setAttribute("SUCCESS_MSG", "Đã thêm " + addQty + " sản phẩm [" + product.getName() + "] vào giỏ hàng!");
                }
            } else if (action.equals("inc")) {
                String productID = request.getParameter("id");
                for (CartItemDTO item : cart) {
                    if (item.getProduct().getProductID().equals(productID)) {
                        if (item.getProduct().getQuantity() > item.getQuantity()) {
                            int newQty = item.getQuantity() + 1;
                            if (loginUser != null) {
                                cartDAO.updateQuantity(loginUser.getUserID(), productID, newQty);
                            } else {
                                item.setQuantity(newQty);
                            }
                        }
                        break;
                    }
                }
                if (loginUser != null) {
                    cart = cartDAO.getCartByUserID(loginUser.getUserID());
                }
            } else if (action.equals("dec")) {
                String productID = request.getParameter("id");
                for (int i = 0; i < cart.size(); i++) {
                    CartItemDTO item = cart.get(i);
                    if (item.getProduct().getProductID().equals(productID)) {
                        if (item.getQuantity() > 1) {
                            int newQty = item.getQuantity() - 1;
                            if (loginUser != null) {
                                cartDAO.updateQuantity(loginUser.getUserID(), productID, newQty);
                            } else {
                                item.setQuantity(newQty);
                            }
                        } else {
                            if (loginUser != null) {
                                cartDAO.removeCartItem(loginUser.getUserID(), productID);
                            } else {
                                cart.remove(i);
                            }
                        }
                        break;
                    }
                }
                if (loginUser != null) {
                    cart = cartDAO.getCartByUserID(loginUser.getUserID());
                }
            } else if (action.equals("remove")) {
                String productID = request.getParameter("id");
                if (loginUser != null) {
                    cartDAO.removeCartItem(loginUser.getUserID(), productID);
                    cart = cartDAO.getCartByUserID(loginUser.getUserID());
                } else {
                    cart.removeIf(item -> item.getProduct().getProductID().equals(productID));
                }
            } else if (action.equals("update")) {
                String productID = request.getParameter("id");
                try {
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    if (loginUser != null) {
                        cartDAO.updateQuantity(loginUser.getUserID(), productID, quantity);
                        cart = cartDAO.getCartByUserID(loginUser.getUserID());
                    } else {
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
                    }
                } catch (NumberFormatException ignored) {}
            } else if (action.equals("clear")) {
                if (loginUser != null) {
                    cartDAO.clearCart(loginUser.getUserID());
                    cart.clear();
                } else {
                    cart.clear();
                }
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
