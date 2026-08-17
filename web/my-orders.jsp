<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Đơn Hàng Của Tôi | ONE61 Garmentory" />
</jsp:include>

<div class="container py-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small text-uppercase fw-semibold mb-0" style="letter-spacing: 0.5px;">
            <li class="breadcrumb-item"><a href="home" class="text-decoration-none text-dark">Trang Chủ</a></li>
            <li class="breadcrumb-item active text-danger" aria-current="page">Đơn Hàng Của Tôi</li>
        </ol>
    </nav>

    <!-- Page Header -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-3 border-bottom gap-3">
        <div>
            <h3 class="fw-bold m-0 text-uppercase" style="letter-spacing: 1px; font-family: 'Outfit', sans-serif;">
                LỊCH SỬ ĐƠN HÀNG
            </h3>
            <p class="text-muted small m-0 mt-1">
                Theo dõi tiến độ vận chuyển và lịch sử mua sắm của tài khoản <strong>${sessionScope.LOGIN_USER.fullName}</strong>
            </p>
        </div>
        <div>
            <a href="product" class="btn btn-outline-dark btn-sm rounded-0 fw-bold text-uppercase px-3 py-2" style="font-size: 0.78rem;">
                <i class="fa-solid fa-store me-1"></i> Khám Phá Thêm Sản Phẩm
            </a>
        </div>
    </div>

    <!-- Notification -->
    <c:if test="${param.success eq 'cancelled'}">
        <div class="alert alert-warning alert-dismissible fade show rounded-0 mb-4" role="alert">
            <i class="fa-solid fa-circle-info me-2"></i> Đã hủy đơn hàng thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Status Tabs Navigation -->
    <div class="d-flex flex-nowrap overflow-x-auto pb-2 mb-4 border-bottom gap-2" style="scrollbar-width: thin;">
        <a href="my-orders?status=ALL" class="btn btn-sm rounded-0 fw-bold px-3 py-2 text-uppercase ${SELECTED_STATUS eq 'ALL' ? 'btn-dark' : 'btn-outline-secondary'}" style="font-size: 0.78rem; white-space: nowrap;">
            Tất Cả Đơn (${TOTAL_USER_ORDERS})
        </a>
        <a href="my-orders?status=PENDING" class="btn btn-sm rounded-0 fw-bold px-3 py-2 text-uppercase ${SELECTED_STATUS eq 'PENDING' ? 'btn-warning text-dark' : 'btn-outline-secondary'}" style="font-size: 0.78rem; white-space: nowrap;">
            Chờ Xử Lý
        </a>
        <a href="my-orders?status=PROCESSING" class="btn btn-sm rounded-0 fw-bold px-3 py-2 text-uppercase ${SELECTED_STATUS eq 'PROCESSING' ? 'btn-primary' : 'btn-outline-secondary'}" style="font-size: 0.78rem; white-space: nowrap;">
            Đã TT / Đang Chuẩn Bị
        </a>
        <a href="my-orders?status=SHIPPED" class="btn btn-sm rounded-0 fw-bold px-3 py-2 text-uppercase ${SELECTED_STATUS eq 'SHIPPED' ? 'btn-info text-white' : 'btn-outline-secondary'}" style="font-size: 0.78rem; white-space: nowrap;">
            Đang Giao Hàng
        </a>
        <a href="my-orders?status=DELIVERED" class="btn btn-sm rounded-0 fw-bold px-3 py-2 text-uppercase ${SELECTED_STATUS eq 'DELIVERED' ? 'btn-success' : 'btn-outline-secondary'}" style="font-size: 0.78rem; white-space: nowrap;">
            Giao Thành Công
        </a>
        <a href="my-orders?status=CANCELLED" class="btn btn-sm rounded-0 fw-bold px-3 py-2 text-uppercase ${SELECTED_STATUS eq 'CANCELLED' ? 'btn-danger' : 'btn-outline-secondary'}" style="font-size: 0.78rem; white-space: nowrap;">
            Đã Hủy
        </a>
    </div>

    <!-- Orders Content -->
    <c:choose>
        <c:when test="${empty ORDERS}">
            <div class="text-center py-5 my-4 bg-white border">
                <div class="mb-3">
                    <div style="width: 80px; height: 80px; margin: 0 auto; background: #F8F9FA; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-box-open fs-2 text-muted"></i>
                    </div>
                </div>
                <h5 class="fw-bold text-uppercase mb-2">Chưa Có Đơn Hàng Nào</h5>
                <p class="text-muted small mb-4">Bạn chưa có đơn hàng nào ở trạng thái này.</p>
                <a href="product" class="btn btn-danger rounded-0 px-4 py-2 fw-bold text-uppercase" style="background-color: var(--color-primary, #ED1D24); border-color: var(--color-primary, #ED1D24); font-size: 0.8rem;">
                    Bắt đầu mua sắm ngay
                </a>
            </div>
        </c:when>
        
        <c:otherwise>
            <div class="d-flex flex-column gap-4">
                <c:forEach var="order" items="${ORDERS}">
                    <div class="card rounded-0 border bg-white shadow-sm overflow-hidden">
                        <!-- Order Card Header -->
                        <div class="card-header bg-light border-bottom px-4 py-3 d-flex flex-wrap justify-content-between align-items-center gap-2">
                            <div class="d-flex flex-wrap align-items-center gap-3">
                                <span class="fw-bold text-uppercase small" style="font-family: 'Outfit', sans-serif;">
                                    ĐƠN HÀNG <span class="text-danger font-monospace">#${order.orderID}</span>
                                </span>
                                <span class="text-muted small">|</span>
                                <span class="text-muted small">
                                    <i class="fa-regular fa-calendar me-1"></i>
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${order.status eq 'PENDING'}">
                                        <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle rounded-0 px-3 py-2 small fw-bold">
                                            <i class="fa-solid fa-clock me-1"></i> Chờ Xử Lý
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status eq 'PROCESSING'}">
                                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-0 px-3 py-2 small fw-bold">
                                            <i class="fa-solid fa-circle-check me-1"></i> Đã Thanh Toán / Đang Chuẩn Bị
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status eq 'SHIPPED'}">
                                        <span class="badge bg-info-subtle text-info-emphasis border border-info-subtle rounded-0 px-3 py-2 small fw-bold">
                                            <i class="fa-solid fa-truck-fast me-1"></i> Đang Giao Hàng
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status eq 'DELIVERED' || order.status eq 'SUCCESS'}">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle rounded-0 px-3 py-2 small fw-bold">
                                            <i class="fa-solid fa-circle-check me-1"></i> Giao Hàng Thành Công
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status eq 'CANCELLED'}">
                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-0 px-3 py-2 small fw-bold">
                                            <i class="fa-solid fa-circle-xmark me-1"></i> Đã Hủy
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary-subtle text-secondary border rounded-0 px-3 py-2 small fw-bold">
                                            ${order.status}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Order Card Body: Items List -->
                        <div class="card-body p-4">
                            <c:set var="items" value="${ORDER_DETAILS_MAP[order.orderID]}" />
                            <div class="d-flex flex-column gap-3">
                                <c:forEach var="item" items="${items}">
                                    <div class="d-flex align-items-center justify-content-between pb-3 border-bottom gap-3">
                                        <div class="d-flex align-items-center gap-3">
                                            <a href="product-detail?id=${item.productID}" class="border d-block flex-shrink-0" style="width: 60px; height: 75px; overflow: hidden; background: #f8f9fa;">
                                                <img src="${pageContext.request.contextPath}/img-prj301/${item.productImage}" 
                                                     alt="${item.productName}" 
                                                     class="w-100 h-100" 
                                                     style="object-fit: cover;"
                                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img-prj301/products/men/cover/cover-shirts-men-1.avif';">
                                            </a>
                                            <div>
                                                <h6 class="fw-bold m-0 mb-1" style="font-size: 0.9rem;">
                                                    <a href="product-detail?id=${item.productID}" class="text-dark text-decoration-none hover-red">
                                                        ${not empty item.productName ? item.productName : item.productID}
                                                    </a>
                                                </h6>
                                                <div class="text-muted small">
                                                    Mã SP: <span class="font-monospace">${item.productID}</span> | Số lượng: <strong>x${item.quantity}</strong>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="text-end flex-shrink-0">
                                            <div class="fw-bold text-dark" style="font-size: 0.95rem;">
                                                <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> đ
                                            </div>
                                            <div class="text-muted small" style="font-size: 0.75rem;">
                                                (<fmt:formatNumber value="${item.price}" pattern="#,###"/> đ / chiếc)
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Delivery Info & Note -->
                            <div class="mt-3 p-3 bg-light border small text-muted">
                                <div class="mb-1">
                                    <i class="fa-solid fa-location-dot me-1 text-danger"></i>
                                    <strong>Địa chỉ nhận hàng:</strong> ${order.shippingAddress}
                                </div>
                                <c:if test="${not empty order.note}">
                                    <div>
                                        <i class="fa-solid fa-pen-to-square me-1 text-secondary"></i>
                                        <strong>Ghi chú:</strong> ${order.note}
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Order Card Footer -->
                        <div class="card-footer bg-white border-top px-4 py-3 d-flex flex-wrap justify-content-between align-items-center gap-3">
                            <div class="d-flex align-items-baseline gap-2">
                                <span class="text-muted small text-uppercase">Tổng Giá Trị:</span>
                                <span class="fw-bold fs-5" style="color: var(--color-primary, #ED1D24); font-family: 'Outfit', sans-serif;">
                                    <fmt:formatNumber value="${order.totalMoney}" pattern="#,###"/> đ
                                </span>
                            </div>
                            <div class="d-flex gap-2">
                                <c:if test="${order.status eq 'PENDING'}">
                                    <a href="my-orders?action=cancel&id=${order.orderID}" 
                                       class="btn btn-outline-danger btn-sm rounded-0 fw-bold px-3 py-2"
                                       onclick="return confirm('Bạn có chắc muốn hủy đơn hàng #${order.orderID}?');"
                                       style="font-size: 0.78rem;">
                                        <i class="fa-solid fa-ban me-1"></i> Hủy Đơn
                                    </a>
                                </c:if>
                                <a href="product" class="btn btn-outline-dark btn-sm rounded-0 fw-bold px-3 py-2" style="font-size: 0.78rem;">
                                    <i class="fa-solid fa-bag-shopping me-1"></i> Tiếp Tục Mua Sắm
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="includes/footer.jsp" />
