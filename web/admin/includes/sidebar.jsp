<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Admin Sidebar Column -->
<div class="col-lg-2 col-md-3 mb-4 mb-md-0">
    <div class="list-group sidebar-admin shadow-none rounded-0">
        <a href="${pageContext.request.contextPath}/admin/dashboard" 
           class="list-group-item list-group-item-action ${param.activeMenu eq 'dashboard' || empty param.activeMenu ? 'active' : ''}">
            <i class="fa-solid fa-chart-pie me-2"></i> Tổng quan
        </a>
        <a href="${pageContext.request.contextPath}/admin/product?action=list" 
           class="list-group-item list-group-item-action ${param.activeMenu eq 'products' ? 'active' : ''}">
            <i class="fa-solid fa-box me-2"></i> Quản lý Sản phẩm
        </a>
        <a href="${pageContext.request.contextPath}/admin/category?action=list" 
           class="list-group-item list-group-item-action ${param.activeMenu eq 'categories' ? 'active' : ''}">
            <i class="fa-solid fa-list me-2"></i> Quản lý Danh mục
        </a>
        <a href="${pageContext.request.contextPath}/admin/order?action=list" 
           class="list-group-item list-group-item-action ${param.activeMenu eq 'orders' ? 'active' : ''}">
            <i class="fa-solid fa-cart-flatbed me-2"></i> Quản lý Đơn hàng
        </a>
        <a href="${pageContext.request.contextPath}/admin/user?action=list" 
           class="list-group-item list-group-item-action ${param.activeMenu eq 'users' ? 'active' : ''}">
            <i class="fa-solid fa-users me-2"></i> Quản lý Người dùng
        </a>
    </div>

    <!-- Quick External Links -->
    <div class="mt-4 p-3 bg-white border">
        <div class="small fw-bold text-uppercase text-muted mb-2" style="font-size: 0.7rem; letter-spacing: 0.5px;">Cửa Hàng</div>
        <a href="${pageContext.request.contextPath}/home" target="_blank" class="btn btn-outline-dark btn-sm rounded-0 w-100 mb-2 text-start">
            <i class="fa-solid fa-arrow-up-right-from-square me-1"></i> Xem Website
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm rounded-0 w-100 text-start">
            <i class="fa-solid fa-right-from-bracket me-1"></i> Đăng Xuất
        </a>
    </div>
</div>
