<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Quản Lý Người Dùng | ONE61 Garment Admin" />
    <jsp:param name="activeMenu" value="users" />
</jsp:include>

<!-- Notification Messages -->
<c:if test="${param.success eq 'status_toggled'}">
    <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> Đã thay đổi trạng thái hoạt động của tài khoản!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success eq 'role_updated'}">
    <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> Đã cập nhật quyền hạn (Role) thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="admin-card p-4">
    <!-- Header -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-3 border-bottom gap-3">
        <div>
            <h4 class="fw-bold m-0 text-uppercase tracking-wide">Quản Lý Người Dùng & Khách Hàng</h4>
            <p class="text-muted small m-0">Danh sách tài khoản thành viên, quyền hạn truy cập và trạng thái kích hoạt</p>
        </div>
        <div>
            <span class="badge bg-light text-dark border px-3 py-2">
                <i class="fa-solid fa-users me-1 text-primary"></i> Tổng cộng: <strong>${totalUsers}</strong> tài khoản
            </span>
        </div>
    </div>

    <!-- Users Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle mb-0">
            <thead class="table-light">
                <tr class="text-center small text-uppercase">
                    <th style="width: 140px;">TÊN ĐĂNG NHẬP</th>
                    <th class="text-start">HỌ VÀ TÊN</th>
                    <th class="text-start" style="width: 220px;">EMAIL</th>
                    <th style="width: 120px;">SỐ ĐIỆN THOẠI</th>
                    <th style="width: 130px;">VAI TRÒ (ROLE)</th>
                    <th style="width: 120px;">TRẠNG THÁI</th>
                    <th style="width: 150px;">THAO TÁC</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${USERS}">
                    <tr>
                        <td class="text-center fw-bold font-monospace text-dark">${u.userID}</td>
                        <td class="fw-semibold">${u.fullName}</td>
                        <td class="text-secondary small">${u.email}</td>
                        <td class="text-center small">${not empty u.phone ? u.phone : '<span class="text-muted">--</span>'}</td>
                        <td class="text-center">
                            <form action="${pageContext.request.contextPath}/admin/user" method="POST" class="d-inline m-0">
                                <input type="hidden" name="action" value="update_role">
                                <input type="hidden" name="id" value="${u.userID}">
                                <select class="form-select form-select-sm rounded-0 fw-bold ${u.roleID eq 'ADMIN' ? 'text-danger border-danger-subtle' : 'text-primary'}" 
                                        name="roleID" 
                                        onchange="this.form.submit()" 
                                        ${u.userID eq sessionScope.LOGIN_USER.userID ? 'disabled title=\"Không thể tự đổi quyền chính mình\"' : ''}>
                                    <option value="ADMIN" ${u.roleID eq 'ADMIN' ? 'selected' : ''}>Quản trị viên (ADMIN)</option>
                                    <option value="CUS" ${u.roleID eq 'CUS' ? 'selected' : ''}>Khách hàng (CUS)</option>
                                </select>
                            </form>
                        </td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${u.status}">
                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 rounded-0">Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1 rounded-0">Bị khóa</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${u.userID eq sessionScope.LOGIN_USER.userID}">
                                    <span class="badge bg-light text-secondary border px-2 py-1">Tài khoản hiện tại</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/user?action=toggle_status&id=${u.userID}" 
                                       class="btn btn-sm ${u.status ? 'btn-outline-danger' : 'btn-outline-success'} rounded-0 px-2" 
                                       onclick="return confirm('Bạn có chắc muốn ${u.status ? 'khóa' : 'mở khóa'} tài khoản [${u.userID}]?');">
                                        <i class="fa-solid ${u.status ? 'fa-lock' : 'fa-lock-open'} me-1"></i>
                                        ${u.status ? 'Khóa' : 'Kích hoạt'}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty USERS}">
                    <tr>
                        <td colspan="7" class="text-center py-5 text-muted">Không có người dùng nào.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <c:if test="${endPage > 1}">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-3 mt-4 pt-3 border-top">
            <span class="small text-muted">
                Hiển thị trang <strong>${currentPage}</strong> / ${endPage} (Tổng cộng <strong>${totalUsers}</strong> tài khoản)
            </span>
            <nav aria-label="Page navigation">
                <ul class="pagination pagination-sm mb-0 rounded-0 gap-1">
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link rounded-0 fw-bold px-3 text-dark bg-white border"
                           href="${pageContext.request.contextPath}/admin/user?action=list&page=${currentPage - 1}">
                            <i class="fa-solid fa-chevron-left"></i>
                        </a>
                    </li>
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link rounded-0 fw-bold px-3 ${i == currentPage ? 'bg-danger border-danger text-white' : 'text-dark bg-white border'}"
                               href="${pageContext.request.contextPath}/admin/user?action=list&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage >= endPage ? 'disabled' : ''}">
                        <a class="page-link rounded-0 fw-bold px-3 text-dark bg-white border"
                           href="${pageContext.request.contextPath}/admin/user?action=list&page=${currentPage + 1}">
                            <i class="fa-solid fa-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:if>
</div>

<jsp:include page="includes/footer.jsp" />
