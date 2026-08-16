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

@WebServlet(name = "MainController", urlPatterns = {"/home"})
public class MainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ProductDAO pDao = new ProductDAO();
        CategoryDAO cDao = new CategoryDAO();

        List<CategoryDTO> categories = cDao.getAllCategories();
        request.setAttribute("CATEGORIES", categories);

        String categoryID = request.getParameter("categoryID");
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

        int totalProducts = pDao.getTotalProducts(categoryID);
        int endPage = totalProducts / pageSize;
        if (totalProducts % pageSize != 0) {
            endPage++;
        }

        if (page < 1) {
            page = 1;
        }
        if (endPage > 0 && page > endPage) {
            page = endPage;
        }

        int offset = (page - 1) * pageSize;
        List<ProductDTO> products = pDao.getProductsByPage(categoryID, offset, pageSize);

        request.setAttribute("PRODUCTS", products);
        request.setAttribute("endPage", endPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalProducts", totalProducts);

        request.getRequestDispatcher("home.jsp").forward(request, response);
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
