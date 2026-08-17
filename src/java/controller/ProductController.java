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

@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ProductDAO pDao = new ProductDAO();
        CategoryDAO cDao = new CategoryDAO();
        
        List<CategoryDTO> categories = cDao.getAllCategories();
        request.setAttribute("CATEGORIES", categories);

        if (action == null || action.equals("list")) {
            String categoryID = request.getParameter("categoryID");
            String keyword = request.getParameter("keyword");
            String sort = request.getParameter("sort");
            
            int pageSize = 10;
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            int totalProducts;
            List<ProductDTO> products;

            boolean hasKeyword = (keyword != null && !keyword.trim().isEmpty());

            if (hasKeyword) {
                totalProducts = pDao.countSearchProductsAdmin(keyword.trim(), categoryID);
            } else {
                totalProducts = pDao.getTotalProducts(categoryID);
            }
            
            int endPage = (totalProducts % pageSize == 0) ? (totalProducts / pageSize) : (totalProducts / pageSize + 1);
            
            if (page < 1) {
                page = 1;
            }
            if (endPage > 0 && page > endPage) {
                page = endPage;
            }
            
            int offset = (page - 1) * pageSize;

            if (hasKeyword) {
                products = pDao.searchProductsAdmin(keyword.trim(), categoryID, offset, pageSize, sort);
            } else {
                products = pDao.getProductsByPage(categoryID, offset, pageSize, sort);
            }
            
            request.setAttribute("PRODUCTS", products);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("endPage", endPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("keyword", keyword);
            request.setAttribute("categoryID", categoryID);
            request.setAttribute("sort", sort);
            
            request.getRequestDispatcher("product.jsp").forward(request, response);
            
        } else if (action.equals("detail")) {
            String productID = request.getParameter("id");
            ProductDTO product = pDao.getProductByID(productID);
            request.setAttribute("PRODUCT", product);

            List<ProductDTO> childProducts = pDao.getChildProducts(productID);
            request.setAttribute("CHILD_PRODUCTS", childProducts);

            String catName = "Thời Trang";
            if (product != null && product.getCategoryID() != null && categories != null) {
                for (CategoryDTO c : categories) {
                    if (c.getCategoryID().equalsIgnoreCase(product.getCategoryID())) {
                        catName = c.getName();
                        break;
                    }
                }
            }
            request.setAttribute("CATEGORY_NAME", catName);
            request.getRequestDispatcher("product-detail.jsp").forward(request, response);
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
        processRequest(request, response);
    }
}
