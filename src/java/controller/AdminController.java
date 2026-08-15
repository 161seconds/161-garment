package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoryDAO;
import model.CategoryDTO;
import model.ProductDAO;
import model.ProductDTO;

@WebServlet(name = "AdminController", urlPatterns = {"/admin/product"})
public class AdminController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ProductDAO pDao = new ProductDAO();
        CategoryDAO cDao = new CategoryDAO();
        
        if (action == null || action.equals("list")) {
            List<ProductDTO> products = pDao.getAllProducts();
            request.setAttribute("PRODUCTS", products);
            request.getRequestDispatcher("/admin/manage-product.jsp").forward(request, response);
        } else if (action.equals("add")) {
            // Hiển thị form add
            List<CategoryDTO> categories = cDao.getAllCategories();
            request.setAttribute("CATEGORIES", categories);
            request.getRequestDispatcher("/admin/form-product.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            String productID = request.getParameter("id");
            pDao.deleteProduct(productID);
            response.sendRedirect("product?action=list");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        ProductDAO pDao = new ProductDAO();
        
        if (action.equals("add_submit")) {
            ProductDTO product = new ProductDTO();
            product.setProductID(request.getParameter("productID"));
            product.setName(request.getParameter("name"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            product.setCategoryID(request.getParameter("categoryID"));
            product.setImage(request.getParameter("image"));
            
            pDao.insertProduct(product);
            response.sendRedirect("product?action=list");
        } else if (action.equals("update_submit")) {
            ProductDTO product = new ProductDTO();
            product.setProductID(request.getParameter("productID"));
            product.setName(request.getParameter("name"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            product.setCategoryID(request.getParameter("categoryID"));
            product.setImage(request.getParameter("image"));
            product.setStatus(true);
            
            pDao.updateProduct(product);
            response.sendRedirect("product?action=list");
        }
    }
}
