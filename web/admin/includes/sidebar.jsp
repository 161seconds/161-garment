<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Admin Sidebar Column -->
<div class="col-lg-2 col-md-3">
    <div class="list-group sidebar-admin shadow-none rounded-0">
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" 
           class="list-group-item list-group-item-action ${param.activeMenu eq 'dashboard' || empty param.activeMenu ? 'active' : ''}">
            <i class="fa-solid fa-chart-pie me-2"></i> Tổng quan
        </a>
        <a href="${pageContext.request.contextPath}/admin/product?action=list" 
           class="list-group-item list-group-item-action ${param.activeMenu eq 'products' ? 'active' : ''}">
            <i class="fa-solid fa-box me-2"></i> Quản lý Sản phẩm
        </a>
        <a href="#" 
           class="list-group-item list-group-item-action ${param.activeMenu eq 'categories' ? 'active' : ''}">
            <i class="fa-solid fa-list me-2"></i> Quản lý Danh mục
        </a>
        <a href="#" 
           class="list-group-item list-group-item-action ${param.activeMenu eq 'users' ? 'active' : ''}">
            <i class="fa-solid fa-users me-2"></i> Quản lý Người dùng
        </a>
        <a href="#" 
           class="list-group-item list-group-item-action ${param.activeMenu eq 'orders' ? 'active' : ''}">
            <i class="fa-solid fa-cart-flatbed me-2"></i> Quản lý Đơn hàng
        </a>
    </div>
</div>
