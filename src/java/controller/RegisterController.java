package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserDAO;
import model.UserDTO;

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        UserDAO dao = new UserDAO();

        // Validation
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("ERROR", "Vui lòng nhập họ và tên!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (email == null || !email.trim().contains("@")) {
            request.setAttribute("ERROR", "Địa chỉ email không hợp lệ!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (dao.isEmailExists(email.trim())) {
            request.setAttribute("ERROR", "Địa chỉ email này đã được đăng ký!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (phone != null && !phone.trim().isEmpty() && dao.isPhoneExists(phone.trim())) {
            request.setAttribute("ERROR", "Số điện thoại này đã được đăng ký!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!utils.PasswordUtils.isValidComplexity(password)) {
            request.setAttribute("ERROR", utils.PasswordUtils.getPasswordRequirementsMessage());
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirm)) {
            request.setAttribute("ERROR", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Auto-generate User ID (e.g. USR01, USR02, USR25)
        String newUserID = dao.generateNextUserID();

        UserDTO user = new UserDTO();
        user.setUserID(newUserID);
        user.setFullName(fullName.trim());
        user.setPassword(password); // UserDAO will hash using SHA-256
        user.setEmail(email.trim());
        user.setPhone(phone != null ? phone.trim() : "");
        user.setRoleID("CUS");
        user.setStatus(true);

        try {
            boolean check = dao.insertUser(user);
            if (check) {
                request.setAttribute("SUCCESS", "Đăng ký thành công! Mã thành viên: " + newUserID + ". Bạn có thể đăng nhập bằng Email hoặc Số điện thoại.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("ERROR", "Đăng ký thất bại. Vui lòng thử lại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("ERROR", "Có lỗi xảy ra trong quá trình đăng ký tài khoản!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
