<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Bảng Điều Khiển | ONE61 Garment Admin" />
    <jsp:param name="activeMenu" value="dashboard" />
</jsp:include>

<!-- Dashboard Main Card -->
<div class="admin-card p-4 mb-4">
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <h4 class="fw-bold m-0 text-uppercase tracking-wide">Tổng Quan Hệ Thống</h4>
            <p class="text-muted small m-0">Chào mừng trở lại, <strong>${sessionScope.LOGIN_USER.fullName}</strong>!</p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin/product?action=add" class="btn btn-admin-primary btn-sm px-3">
                <i class="fa-solid fa-plus me-1"></i> Thêm sản phẩm
            </a>
            <a href="${pageContext.request.contextPath}/admin/order?action=list" class="btn btn-outline-dark btn-sm rounded-0 px-3">
                <i class="fa-solid fa-cart-flatbed me-1"></i> Xem đơn hàng
            </a>
        </div>
    </div>

    <!-- Stat Widgets Grid -->
    <div class="row g-4 mb-4">
        <!-- Revenue Card -->
        <div class="col-xl-3 col-md-6">
            <div class="card admin-card stat-card red-border h-100 p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Tổng Doanh Thu</span>
                        <h3 class="fw-bold mt-2 mb-0" style="color: var(--admin-red);">
                            <fmt:formatNumber value="${STAT_REVENUE}" pattern="#,###"/> đ
                        </h3>
                        <span class="badge bg-light text-success border border-success-subtle mt-2">
                            <i class="fa-solid fa-circle-check"></i> Đã thanh toán / giao
                        </span>
                    </div>
                    <div class="p-3 bg-light text-danger fs-3">
                        <i class="fa-solid fa-money-bill-trend-up"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Orders Card -->
        <div class="col-xl-3 col-md-6">
            <div class="card admin-card stat-card dark-border h-100 p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Tổng Đơn Hàng</span>
                        <h2 class="fw-bold mt-2 mb-0" style="color: var(--admin-dark);">${STAT_ORDERS}</h2>
                        <a href="${pageContext.request.contextPath}/admin/order?action=list" class="badge bg-light text-dark border text-decoration-none mt-2">
                            <i class="fa-solid fa-arrow-right me-1"></i> Quản lý đơn
                        </a>
                    </div>
                    <div class="p-3 bg-light text-dark fs-3">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Products Card -->
        <div class="col-xl-3 col-md-6">
            <div class="card admin-card stat-card gray-border h-100 p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Sản Phẩm Đang Bán</span>
                        <h2 class="fw-bold mt-2 mb-0">${STAT_PRODUCTS}</h2>
                        <c:choose>
                            <c:when test="${STAT_LOW_STOCK > 0}">
                                <span class="badge bg-warning-subtle text-warning-emphasis border border-warning mt-2">
                                    <i class="fa-solid fa-triangle-exclamation"></i> ${STAT_LOW_STOCK} SP sắp hết hàng
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-light text-success border border-success-subtle mt-2">
                                    <i class="fa-solid fa-check"></i> Kho hàng ổn định
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="p-3 bg-light text-secondary fs-3">
                        <i class="fa-solid fa-shirt"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Users Card -->
        <div class="col-xl-3 col-md-6">
            <div class="card admin-card stat-card gray-border h-100 p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted small fw-bold text-uppercase">Tài Khoản Người Dùng</span>
                        <h2 class="fw-bold mt-2 mb-0">${STAT_USERS}</h2>
                        <a href="${pageContext.request.contextPath}/admin/user?action=list" class="badge bg-light text-primary border border-primary-subtle text-decoration-none mt-2">
                            <i class="fa-solid fa-users-gear me-1"></i> Quản lý User
                        </a>
                    </div>
                    <div class="p-3 bg-light text-primary fs-3">
                        <i class="fa-solid fa-users"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Operations & Recent Orders Table -->
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
                        <i class="fa-solid fa-box-open me-2 text-primary"></i> Quản lý kho hàng (${STAT_PRODUCTS} SP)
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/category?action=list" class="btn btn-outline-dark btn-sm rounded-0 text-start py-2 fw-semibold">
                        <i class="fa-solid fa-list me-2 text-success"></i> Quản lý danh mục
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/order?action=list" class="btn btn-outline-dark btn-sm rounded-0 text-start py-2 fw-semibold">
                        <i class="fa-solid fa-receipt me-2 text-info"></i> Danh sách đơn hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/home" target="_blank" class="btn btn-outline-dark btn-sm rounded-0 text-start py-2 fw-semibold">
                        <i class="fa-solid fa-arrow-up-right-from-square me-2 text-secondary"></i> Xem trang bán hàng
                    </a>
                </div>
            </div>
        </div>

        <!-- Recent Orders -->
        <div class="col-lg-8">
            <div class="card admin-card p-3 h-100">
                <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                    <h6 class="fw-bold text-uppercase m-0">
                        <i class="fa-solid fa-clock-rotate-left me-1 text-secondary"></i> Đơn Hàng Gần Đây
                    </h6>
                    <a href="${pageContext.request.contextPath}/admin/order?action=list" class="small text-danger text-decoration-none fw-bold">
                        Xem tất cả <i class="fa-solid fa-chevron-right ms-1"></i>
                    </a>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0 small">
                        <thead>
                            <tr class="text-secondary">
                                <th>MÃ ĐƠN</th>
                                <th>KHÁCH HÀNG</th>
                                <th>NGÀY ĐẶT</th>
                                <th>TỔNG TIỀN</th>
                                <th>TRẠNG THÁI</th>
                                <th>THAO TÁC</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${RECENT_ORDERS}">
                                <tr>
                                    <td class="fw-bold font-monospace text-dark">${o.orderID}</td>
                                    <td>
                                        <div class="fw-bold">${o.userID}</div>
                                        <small class="text-muted text-truncate d-inline-block" style="max-width: 150px;">${o.shippingAddress}</small>
                                    </td>
                                    <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td class="fw-bold text-danger">
                                        <fmt:formatNumber value="${o.totalMoney}" pattern="#,###"/> đ
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${o.status eq 'SUCCESS' || o.status eq 'DELIVERED'}">
                                                <span class="badge bg-success-subtle text-success border border-success-subtle rounded-0 px-2 py-1">Hoàn tất</span>
                                            </c:when>
                                            <c:when test="${o.status eq 'PROCESSING'}">
                                                <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-0 px-2 py-1">Đang xử lý</span>
                                            </c:when>
                                            <c:when test="${o.status eq 'SHIPPED'}">
                                                <span class="badge bg-info-subtle text-info-emphasis border border-info-subtle rounded-0 px-2 py-1">Đang giao</span>
                                            </c:when>
                                            <c:when test="${o.status eq 'CANCELLED'}">
                                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-0 px-2 py-1">Đã hủy</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle rounded-0 px-2 py-1">Chờ xử lý</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/order?action=detail&id=${o.orderID}" class="btn btn-outline-dark btn-sm rounded-0 py-0 px-2" title="Chi tiết">
                                            <i class="fa-solid fa-eye"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty RECENT_ORDERS}">
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">Chưa có đơn hàng nào trong hệ thống.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
