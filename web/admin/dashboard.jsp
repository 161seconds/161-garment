<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Admin Navbar -->
    <nav class="navbar navbar-dark bg-dark sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                <i class="fa-solid fa-shield-halved text-warning"></i> ADMIN PANEL
            </a>
            <div class="d-flex">
                <span class="text-white me-3 my-auto">Xin chào, ${sessionScope.LOGIN_USER.fullName}</span>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm me-2">Về trang khách</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2">
                <div class="list-group shadow-sm">
                    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="list-group-item list-group-item-action fw-bold active bg-dark border-dark">
                        <i class="fa-solid fa-chart-pie me-2"></i> Tổng quan
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/product?action=list" class="list-group-item list-group-item-action">
                        <i class="fa-solid fa-box me-2"></i> Quản lý Sản phẩm
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fa-solid fa-list me-2"></i> Quản lý Danh mục
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fa-solid fa-users me-2"></i> Quản lý Người dùng
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fa-solid fa-cart-flatbed me-2"></i> Quản lý Đơn hàng
                    </a>
                </div>
            </div>
            
            <!-- Main Content Area -->
            <div class="col-md-10">
                <div class="card shadow-sm border-0 p-4">
                    <h3 class="fw-bold mb-4">Tổng quan hệ thống</h3>
                    <div class="row g-4">
                        <div class="col-md-3">
                            <div class="card bg-primary text-white border-0 shadow">
                                <div class="card-body">
                                    <h5 class="card-title">Đơn hàng mới</h5>
                                    <h2 class="fw-bold">12</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-success text-white border-0 shadow">
                                <div class="card-body">
                                    <h5 class="card-title">Doanh thu tháng</h5>
                                    <h2 class="fw-bold">45.0M</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-warning text-dark border-0 shadow">
                                <div class="card-body">
                                    <h5 class="card-title">Sản phẩm</h5>
                                    <h2 class="fw-bold">120</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-danger text-white border-0 shadow">
                                <div class="card-body">
                                    <h5 class="card-title">Khách hàng</h5>
                                    <h2 class="fw-bold">350</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/@studio-freight/lenis@1.0.39/dist/lenis.min.js"></script>
    <script>
        const lenis = new Lenis({ duration: 1.2, smooth: true })
        function raf(time) { lenis.raf(time); requestAnimationFrame(raf) }
        requestAnimationFrame(raf)
    </script>
</body>
</html>
