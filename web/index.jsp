<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Chuyển hướng người dùng đến MainController (trang chủ) ngay khi truy cập vào thư mục gốc của server
    response.sendRedirect("home");
%>
