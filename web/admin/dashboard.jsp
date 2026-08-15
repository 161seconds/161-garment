<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Bảng Điều Khiển | 161 Garment Admin" />
    <jsp:param name="activeMenu" value="dashboard" />
</jsp:include>

<!-- Dashboard Main Card -->
<div class="admin-card p-4 mb-4">
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <h4 class="fw-bold m-0 text-uppercase tracking-wide">Tổng Quan Hệ Thống</h4>
            <p class="text-muted small m-0">Chào mừng trở lại, ${sessionScope.LOGIN_USER.fullName}!</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/product?action=add" class="btn btn-admin-primary btn-sm px-3">
                <i class="fa-solid fa-plus me-1"></i> Thêm sản phẩm mới
            </a>
        </div>
    </div>

    <!-- Stat Widgets Grid -->
    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="card admin-card stat-card red-border h-100 p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Đơn Hàng Mới</span>
                        <h2 class="fw-bold mt-2 mb-0" style="color: var(--admin-red);">12</h2>
                        <span class="badge bg-light text-success border border-success-subtle mt-2">
                            <i class="fa-solid fa-arrow-trend-up"></i> +8.5% hôm nay
                        </span>
                    </div>
                    <div class="p-3 bg-light text-danger fs-3">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="card admin-card stat-card dark-border h-100 p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Doanh Thu Tháng</span>
                        <h2 class="fw-bold mt-2 mb-0" style="color: var(--admin-dark);">45.8M</h2>
                        <span class="badge bg-light text-success border border-success-subtle mt-2">
                            <i class="fa-solid fa-arrow-trend-up"></i> +14.2% so với tháng trước
                        </span>
                    </div>
                    <div class="p-3 bg-light text-dark fs-3">
                        <i class="fa-solid fa-money-bill-trend-up"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="card admin-card stat-card gray-border h-100 p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Tổng Sản Phẩm</span>
                        <h2 class="fw-bold mt-2 mb-0">120</h2>
                        <span class="badge bg-light text-dark border mt-2">
                            <i class="fa-solid fa-boxes-stacked"></i> Đang kinh doanh
                        </span>
                    </div>
                    <div class="p-3 bg-light text-secondary fs-3">
                        <i class="fa-solid fa-shirt"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="card admin-card stat-card gray-border h-100 p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Khách Hàng</span>
                        <h2 class="fw-bold mt-2 mb-0">350</h2>
                        <span class="badge bg-light text-primary border border-primary-subtle mt-2">
                            <i class="fa-solid fa-user-plus"></i> +24 người dùng mới
                        </span>
                    </div>
                    <div class="p-3 bg-light text-primary fs-3">
                        <i class="fa-solid fa-users"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Operations & Recent Activity -->
    <div class="row g-4">
        <!-- Quick Operations -->
        <div class="col-lg-4">
            <div class="card admin-card p-3 h-100">
                <h6 class="fw-bold text-uppercase mb-3 pb-2 border-bottom">
                    <i class="fa-solid fa-bolt me-1 text-warning"></i> Thao Tác Nhanh
                </h6>
                <div class="d-grid gap-2">
                    <a href="${pageContext.request.contextPath}/admin/product?action=add" class="btn btn-outline-dark btn-sm rounded-0 text-start py-2 fw-semibold">
                        <i class="fa-solid fa-plus-circle me-2 text-danger"></i> Thêm sản phẩm mới
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/product?action=list" class="btn btn-outline-dark btn-sm rounded-0 text-start py-2 fw-semibold">
                        <i class="fa-solid fa-box-open me-2 text-primary"></i> Quản lý kho hàng
                    </a>
                    <a href="#" class="btn btn-outline-dark btn-sm rounded-0 text-start py-2 fw-semibold">
                        <i class="fa-solid fa-receipt me-2 text-success"></i> Xem báo cáo doanh thu
                    </a>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-dark btn-sm rounded-0 text-start py-2 fw-semibold">
                        <i class="fa-solid fa-arrow-up-right-from-square me-2 text-secondary"></i> Đi đến cửa hàng
                    </a>
                </div>
            </div>
        </div>

        <!-- Recent Status -->
        <div class="col-lg-8">
            <div class="card admin-card p-3 h-100">
                <h6 class="fw-bold text-uppercase mb-3 pb-2 border-bottom">
                    <i class="fa-solid fa-clock-rotate-left me-1 text-secondary"></i> Trạng Thái Hoạt Động
                </h6>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 small">
                        <thead>
                            <tr>
                                <th>Thời gian</th>
                                <th>Nội dung</th>
                                <th>Người thực hiện</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>10:45 AM</td>
                                <td>Đơn hàng mới <strong>#ORD-8921</strong></td>
                                <td>Khách vãng lai</td>
                                <td><span class="badge bg-warning text-dark rounded-0">Chờ xử lý</span></td>
                            </tr>
                            <tr>
                                <td>09:12 AM</td>
                                <td>Cập nhật số lượng áo khoác gió</td>
                                <td>${sessionScope.LOGIN_USER.fullName}</td>
                                <td><span class="badge bg-success rounded-0">Hoàn tất</span></td>
                            </tr>
                            <tr>
                                <td>Hôm qua</td>
                                <td>Đăng ký tài khoản mới</td>
                                <td>user_testing</td>
                                <td><span class="badge bg-info text-dark rounded-0">Thành viên</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
