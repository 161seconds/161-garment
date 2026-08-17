package controller;

import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDAO;
import model.UserDTO;

@WebServlet(name = "ProfileController", urlPatterns = {"/profile", "/settings", "/account"})
public class ProfileController extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session != null) ? (UserDTO) session.getAttribute("LOGIN_USER") : null;

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=profile");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        if ("update-info".equalsIgnoreCase(action)) {
            handleUpdateProfile(request, response, session, loginUser);
            return;
        } else if ("change-password".equalsIgnoreCase(action)) {
            handleChangePassword(request, response, session, loginUser);
            return;
        }

        // Default view: fetch latest user info and stats
        UserDTO freshUser = userDAO.getUserByID(loginUser.getUserID());
        if (freshUser != null) {
            session.setAttribute("LOGIN_USER", freshUser);
            loginUser = freshUser;
        }

        Map<String, Object> stats = userDAO.getUserOrderStats(loginUser.getUserID());
        request.setAttribute("USER_STATS", stats);

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserDTO loginUser)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        String errorMsg = null;
        if (fullName == null || fullName.trim().isEmpty()) {
            errorMsg = "Họ và tên không được để trống!";
        } else if (phone == null || !phone.trim().matches("^[0-9]{9,11}$")) {
            errorMsg = "Số điện thoại không hợp lệ (cần 9 - 11 chữ số)!";
        } else if (email == null || !email.trim().contains("@")) {
            errorMsg = "Địa chỉ email không hợp lệ!";
        }

        if (errorMsg != null) {
            request.setAttribute("ERROR_PROFILE", errorMsg);
            request.setAttribute("ACTIVE_TAB", "profile");
            Map<String, Object> stats = userDAO.getUserOrderStats(loginUser.getUserID());
            request.setAttribute("USER_STATS", stats);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        boolean updated = userDAO.updateProfile(loginUser.getUserID(), fullName.trim(), email.trim(), phone.trim());
        if (updated) {
            loginUser.setFullName(fullName.trim());
            loginUser.setEmail(email.trim());
            loginUser.setPhone(phone.trim());
            session.setAttribute("LOGIN_USER", loginUser);
            request.setAttribute("SUCCESS_PROFILE", "Cập nhật thông tin cá nhân thành công!");
        } else {
            request.setAttribute("ERROR_PROFILE", "Có lỗi xảy ra trong quá trình cập nhật. Vui lòng thử lại!");
        }

        request.setAttribute("ACTIVE_TAB", "profile");
        Map<String, Object> stats = userDAO.getUserOrderStats(loginUser.getUserID());
        request.setAttribute("USER_STATS", stats);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserDTO loginUser)
            throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String errorMsg = null;
        if (oldPassword == null || oldPassword.trim().isEmpty()) {
            errorMsg = "Vui lòng nhập mật khẩu hiện tại!";
        } else if (!utils.PasswordUtils.isValidComplexity(newPassword)) {
            errorMsg = utils.PasswordUtils.getPasswordRequirementsMessage();
        } else if (!newPassword.equals(confirmPassword)) {
            errorMsg = "Xác nhận mật khẩu mới không khớp!";
        }

        if (errorMsg != null) {
            request.setAttribute("ERROR_PASSWORD", errorMsg);
            request.setAttribute("ACTIVE_TAB", "security");
            Map<String, Object> stats = userDAO.getUserOrderStats(loginUser.getUserID());
            request.setAttribute("USER_STATS", stats);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        boolean changed = userDAO.changePassword(loginUser.getUserID(), oldPassword, newPassword);
        if (changed) {
            request.setAttribute("SUCCESS_PASSWORD", "Đổi mật khẩu thành công! Mật khẩu mới đã có hiệu lực.");
        } else {
            request.setAttribute("ERROR_PASSWORD", "Mật khẩu hiện tại không chính xác. Vui lòng kiểm tra lại!");
        }

        request.setAttribute("ACTIVE_TAB", "security");
        Map<String, Object> stats = userDAO.getUserOrderStats(loginUser.getUserID());
        request.setAttribute("USER_STATS", stats);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
