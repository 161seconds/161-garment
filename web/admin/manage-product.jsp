<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản Lý Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-dark sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/dashboard.jsp"><i class="fa-solid fa-shield-halved text-warning"></i> ADMIN PANEL</a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm">Về trang khách</a>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2">
                <div class="list-group shadow-sm">
                    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="list-group-item list-group-item-action">Tổng quan</a>
                    <a href="${pageContext.request.contextPath}/admin/product?action=list" class="list-group-item list-group-item-action active bg-dark border-dark fw-bold">Quản lý Sản phẩm</a>
                </div>
            </div>
            
            <!-- Main -->
            <div class="col-md-10">
                <div class="card shadow-sm border-0 p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3 class="fw-bold m-0">DANH SÁCH SẢN PHẨM</h3>
                        <a href="${pageContext.request.contextPath}/admin/product?action=add" class="btn btn-success fw-bold"><i class="fa-solid fa-plus"></i> Thêm sản phẩm mới</a>
                    </div>
                    
                    <table class="table table-bordered table-hover align-middle">
                        <thead class="table-dark text-center">
                            <tr>
                                <th>ID</th>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${PRODUCTS}">
                                <tr>
                                    <td class="text-center fw-bold">${p.productID}</td>
                                    <td class="text-center"><img src="${pageContext.request.contextPath}/img-prj301/${p.image}" width="50" class="rounded"></td>
                                    <td>${p.name}</td>
                                    <td class="text-center text-danger fw-bold"><fmt:formatNumber value="${p.price}" pattern="#,###"/> đ</td>
                                    <td class="text-center">${p.quantity}</td>
                                    <td class="text-center">
                                        <a href="#" class="btn btn-sm btn-primary"><i class="fa-solid fa-pen-to-square"></i> Sửa</a>
                                        <a href="${pageContext.request.contextPath}/admin/product?action=delete&id=${p.productID}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xoá sản phẩm này?');"><i class="fa-solid fa-trash"></i> Xoá</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://unpkg.com/@studio-freight/lenis@1.0.39/dist/lenis.min.js"></script>
    <script>
        const lenis = new Lenis({ duration: 1.2, smooth: true })
        function raf(time) { lenis.raf(time); requestAnimationFrame(raf) }
        requestAnimationFrame(raf)
    </script>
</body>
</html>
