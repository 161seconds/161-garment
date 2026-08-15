package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserDAO;
import model.UserDTO;
import utils.CSRFUtils;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Validate CSRF (nếu có form register phức tạp, ở đây tạm thời dùng cơ bản)
        
        String userID = request.getParameter("userID");
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (!password.equals(confirm)) {
            request.setAttribute("ERROR", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserDTO user = new UserDTO();
        user.setUserID(userID);
        user.setFullName(fullName);
        user.setPassword(password); // UserDAO sẽ tự hash password
        user.setEmail(email);
        user.setPhone(phone);
        user.setRoleID("CUS");
        user.setStatus(true);

        UserDAO dao = new UserDAO();
        try {
            boolean check = dao.insertUser(user);
            if (check) {
                request.setAttribute("SUCCESS", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("ERROR", "Đăng ký thất bại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("ERROR", "ID User hoặc Email đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
