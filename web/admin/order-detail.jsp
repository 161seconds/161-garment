<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Chi Tiết Đơn Hàng #${ORDER.orderID} | ONE61 Garment Admin" />
    <jsp:param name="activeMenu" value="orders" />
</jsp:include>

<div class="admin-card p-4">
    <!-- Header -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-3 border-bottom gap-3">
        <div>
            <h4 class="fw-bold m-0 text-uppercase tracking-wide">
                Chi Tiết Đơn Hàng <span class="text-danger font-monospace">#${ORDER.orderID}</span>
            </h4>
            <p class="text-muted small m-0">Ngày đặt: <fmt:formatDate value="${ORDER.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/></p>
        </div>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin/order?action=list" class="btn btn-outline-dark btn-sm rounded-0">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại danh sách
            </a>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <!-- Customer & Delivery Info -->
        <div class="col-lg-6">
            <div class="card admin-card p-3 h-100">
                <h6 class="fw-bold text-uppercase pb-2 border-bottom mb-3">
                    <i class="fa-solid fa-user me-2 text-danger"></i> Thông Tin Khách Hàng & Giao Nhận
                </h6>
                <table class="table table-borderless small mb-0">
                    <tr>
                        <td class="text-muted" style="width: 140px;">Tài khoản đặt:</td>
                        <td class="fw-bold">${ORDER.userID}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Địa chỉ nhận hàng:</td>
                        <td class="fw-semibold">${ORDER.shippingAddress}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Ghi chú từ khách:</td>
                        <td>${not empty ORDER.note ? ORDER.note : '<em class="text-muted">Không có ghi chú</em>'}</td>
                    </tr>
                </table>
            </div>
        </div>

        <!-- Order Status & Update -->
        <div class="col-lg-6">
            <div class="card admin-card p-3 h-100">
                <h6 class="fw-bold text-uppercase pb-2 border-bottom mb-3">
                    <i class="fa-solid fa-clock-rotate-left me-2 text-danger"></i> Trạng Thái Đơn Hàng
                </h6>
                <form action="${pageContext.request.contextPath}/admin/order" method="POST">
                    <input type="hidden" name="action" value="update_status">
                    <input type="hidden" name="id" value="${ORDER.orderID}">
                    
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-uppercase">Cập nhật trạng thái:</label>
                        <select class="form-select rounded-0 fw-bold" name="status">
                            <option value="PENDING" ${ORDER.status eq 'PENDING' ? 'selected' : ''}>Chờ xử lý (PENDING)</option>
                            <option value="PROCESSING" ${ORDER.status eq 'PROCESSING' ? 'selected' : ''}>Đang xử lý / Đã TT (PROCESSING)</option>
                            <option value="SHIPPED" ${ORDER.status eq 'SHIPPED' ? 'selected' : ''}>Đang giao hàng (SHIPPED)</option>
                            <option value="DELIVERED" ${ORDER.status eq 'DELIVERED' || ORDER.status eq 'SUCCESS' ? 'selected' : ''}>Giao thành công (DELIVERED)</option>
                            <option value="CANCELLED" ${ORDER.status eq 'CANCELLED' ? 'selected' : ''}>Đã hủy (CANCELLED)</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-admin-primary btn-sm px-4">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Lưu thay đổi trạng thái
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Order Items Breakdown -->
    <div class="card admin-card p-3 mb-4">
        <h6 class="fw-bold text-uppercase pb-2 border-bottom mb-3">
            <i class="fa-solid fa-box-open me-2 text-danger"></i> Danh Sách Mặt Hàng Trong Đơn
        </h6>
        <div class="table-responsive">
            <table class="table table-bordered align-middle mb-0">
                <thead class="table-light">
                    <tr class="text-center small text-uppercase">
                        <th style="width: 50px;">STT</th>
                        <th style="width: 120px;">MÃ SP</th>
                        <th class="text-end" style="width: 150px;">ĐƠN GIÁ</th>
                        <th style="width: 100px;">SỐ LƯỢNG</th>
                        <th class="text-end" style="width: 160px;">THÀNH TIỀN</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${DETAILS}" varStatus="loop">
                        <tr>
                            <td class="text-center text-muted">${loop.count}</td>
                            <td class="text-center fw-bold font-monospace">${item.productID}</td>
                            <td class="text-end">
                                <fmt:formatNumber value="${item.price}" pattern="#,###"/> đ
                            </td>
                            <td class="text-center fw-bold">${item.quantity}</td>
                            <td class="text-end fw-bold text-dark">
                                <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> đ
                            </td>
                        </tr>
                    </c:forEach>
                    <tr class="table-light">
                        <td colspan="4" class="text-end fw-bold text-uppercase">Tổng Giá Trị Đơn Hàng:</td>
                        <td class="text-end fw-bold fs-5" style="color: var(--admin-red);">
                            <fmt:formatNumber value="${ORDER.totalMoney}" pattern="#,###"/> đ
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
