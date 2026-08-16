<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Quản Lý Đơn Hàng | ONE61 Garment Admin" />
    <jsp:param name="activeMenu" value="orders" />
</jsp:include>

<!-- Notification Messages -->
<c:if test="${param.success eq 'status_updated'}">
    <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> Cập nhật trạng thái đơn hàng thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="admin-card p-4">
    <!-- Header -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-3 border-bottom gap-3">
        <div>
            <h4 class="fw-bold m-0 text-uppercase tracking-wide">Quản Lý Đơn Hàng</h4>
            <p class="text-muted small m-0">Theo dõi tiến trình xử lý, giao hàng và thanh toán của khách hàng</p>
        </div>
    </div>

    <!-- Status Filter Tabs -->
    <div class="mb-4">
        <ul class="nav nav-pills gap-2 border-bottom pb-3">
            <li class="nav-item">
                <a class="nav-link rounded-0 ${empty selectedStatus || selectedStatus eq 'ALL' ? 'active bg-dark text-white' : 'text-dark bg-light'}" 
                   href="${pageContext.request.contextPath}/admin/order?action=list&status=ALL">
                    Tất cả đơn hàng
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link rounded-0 ${selectedStatus eq 'PENDING' ? 'active bg-warning text-dark' : 'text-dark bg-light'}" 
                   href="${pageContext.request.contextPath}/admin/order?action=list&status=PENDING">
                    Chờ xử lý
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link rounded-0 ${selectedStatus eq 'PROCESSING' ? 'active bg-primary text-white' : 'text-dark bg-light'}" 
                   href="${pageContext.request.contextPath}/admin/order?action=list&status=PROCESSING">
                    Đang xử lý / Đã TT
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link rounded-0 ${selectedStatus eq 'SHIPPED' ? 'active bg-info text-white' : 'text-dark bg-light'}" 
                   href="${pageContext.request.contextPath}/admin/order?action=list&status=SHIPPED">
                    Đang giao hàng
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link rounded-0 ${selectedStatus eq 'DELIVERED' || selectedStatus eq 'SUCCESS' ? 'active bg-success text-white' : 'text-dark bg-light'}" 
                   href="${pageContext.request.contextPath}/admin/order?action=list&status=DELIVERED">
                    Hoàn tất
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link rounded-0 ${selectedStatus eq 'CANCELLED' ? 'active bg-danger text-white' : 'text-dark bg-light'}" 
                   href="${pageContext.request.contextPath}/admin/order?action=list&status=CANCELLED">
                    Đã hủy
                </a>
            </li>
        </ul>
    </div>

    <!-- Orders Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle mb-0">
            <thead class="table-light">
                <tr class="text-center small text-uppercase">
                    <th style="width: 130px;">MÃ ĐƠN</th>
                    <th style="width: 120px;">KHÁCH HÀNG</th>
                    <th style="width: 140px;">NGÀY ĐẶT</th>
                    <th class="text-start">ĐỊA CHỈ GIAO HÀNG</th>
                    <th style="width: 130px;">TỔNG TIỀN</th>
                    <th style="width: 160px;">TRẠNG THÁI</th>
                    <th style="width: 120px;">THAO TÁC</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${ORDERS}">
                    <tr>
                        <td class="text-center fw-bold font-monospace text-dark">${o.orderID}</td>
                        <td class="text-center fw-semibold">${o.userID}</td>
                        <td class="text-center small">
                            <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </td>
                        <td>
                            <div class="small text-truncate" style="max-width: 250px;">${o.shippingAddress}</div>
                            <c:if test="${not empty o.note}">
                                <small class="text-muted fst-italic text-truncate d-block" style="max-width: 250px;">Ghi chú: ${o.note}</small>
                            </c:if>
                        </td>
                        <td class="text-end fw-bold" style="color: var(--admin-red);">
                            <fmt:formatNumber value="${o.totalMoney}" pattern="#,###"/> đ
                        </td>
                        <td class="text-center">
                            <!-- Quick Status Update Dropdown Form -->
                            <form action="${pageContext.request.contextPath}/admin/order" method="POST" class="d-inline m-0">
                                <input type="hidden" name="action" value="update_status">
                                <input type="hidden" name="id" value="${o.orderID}">
                                <input type="hidden" name="currentFilter" value="${selectedStatus}">
                                <select class="form-select form-select-sm rounded-0 fw-semibold" 
                                        name="status" 
                                        onchange="this.form.submit()"
                                        style="font-size: 0.78rem;">
                                    <option value="PENDING" ${o.status eq 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="PROCESSING" ${o.status eq 'PROCESSING' ? 'selected' : ''}>Đang xử lý / Đã TT</option>
                                    <option value="SHIPPED" ${o.status eq 'SHIPPED' ? 'selected' : ''}>Đang giao</option>
                                    <option value="DELIVERED" ${o.status eq 'DELIVERED' || o.status eq 'SUCCESS' ? 'selected' : ''}>Hoàn tất</option>
                                    <option value="CANCELLED" ${o.status eq 'CANCELLED' ? 'selected' : ''}>Hủy đơn</option>
                                </select>
                            </form>
                        </td>
                        <td class="text-center">
                            <a href="${pageContext.request.contextPath}/admin/order?action=detail&id=${o.orderID}" 
                               class="btn btn-outline-dark btn-sm rounded-0 px-2" 
                               title="Xem chi tiết">
                                <i class="fa-solid fa-eye me-1"></i> Chi tiết
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty ORDERS}">
                    <tr>
                        <td colspan="7" class="text-center py-5 text-muted">
                            <i class="fa-solid fa-box-open fs-1 d-block mb-2 text-secondary opacity-50"></i>
                            Không có đơn hàng nào thuộc trạng thái này!
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <c:if test="${endPage > 1}">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-3 mt-4 pt-3 border-top">
            <span class="small text-muted">
                Hiển thị trang <strong>${currentPage}</strong> / ${endPage} (Tổng cộng <strong>${totalOrders}</strong> đơn hàng)
            </span>
            <nav aria-label="Page navigation">
                <ul class="pagination pagination-sm mb-0 rounded-0 gap-1">
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link rounded-0 fw-bold px-3 text-dark bg-white border"
                           href="${pageContext.request.contextPath}/admin/order?action=list&page=${currentPage - 1}&status=${selectedStatus}">
                            <i class="fa-solid fa-chevron-left"></i>
                        </a>
                    </li>
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link rounded-0 fw-bold px-3 ${i == currentPage ? 'bg-danger border-danger text-white' : 'text-dark bg-white border'}"
                               href="${pageContext.request.contextPath}/admin/order?action=list&page=${i}&status=${selectedStatus}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage >= endPage ? 'disabled' : ''}">
                        <a class="page-link rounded-0 fw-bold px-3 text-dark bg-white border"
                           href="${pageContext.request.contextPath}/admin/order?action=list&page=${currentPage + 1}&status=${selectedStatus}">
                            <i class="fa-solid fa-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:if>
</div>

<jsp:include page="includes/footer.jsp" />
