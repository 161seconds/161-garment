<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ProductDAO, java.util.List, model.ProductDTO, utils.DBUtils, java.sql.*"%>
<%
try {
    out.println("Testing DB Connection...<br>");
    Connection conn = DBUtils.getConnection();
    out.println("Connected!<br>");
    ProductDAO dao = new ProductDAO();
    List<ProductDTO> list = dao.getAllProducts();
    out.println("Products count: " + list.size());
} catch (Exception e) {
    out.println("Error: " + e.getMessage() + "<br>");
    for (StackTraceElement el : e.getStackTrace()) {
        out.println(el.toString() + "<br>");
    }
}
%>
