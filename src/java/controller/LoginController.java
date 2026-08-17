package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDAO;
import model.UserDTO;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String identifier = request.getParameter("email");
        if (identifier == null || identifier.trim().isEmpty()) {
            identifier = request.getParameter("userID");
        }
        String password = request.getParameter("password");

        if (identifier == null || identifier.trim().isEmpty()) {
            request.setAttribute("ERROR", "Vui lòng nhập Email hoặc Tên đăng nhập!");
            request.setAttribute("enteredEmail", identifier);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        UserDTO user = dao.checkLogin(identifier.trim(), password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("LOGIN_USER", user);
            
            if ("ADMIN".equals(user.getRoleID())) {
                response.sendRedirect("admin/dashboard");
            } else {
                response.sendRedirect("home");
            }
        } else {
            request.setAttribute("ERROR", "Email / Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.setAttribute("enteredEmail", identifier);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
