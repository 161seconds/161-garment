<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Quản Lý Sản Phẩm | 161 Garment Admin" />
    <jsp:param name="activeMenu" value="products" />
</jsp:include>

<!-- Notification Messages -->
<c:if test="${not empty SUCCESS}">
    <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> ${SUCCESS}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${not empty ERROR}">
    <div class="alert alert-danger alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-exclamation me-2"></i> ${ERROR}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="admin-card p-4">
    <!-- Header with Action -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-3 border-bottom gap-3">
        <div>
            <h4 class="fw-bold m-0 text-uppercase tracking-wide">Danh Sách Sản Phẩm</h4>
            <p class="text-muted small m-0">Quản lý kho hàng, thông tin và giá niêm yết</p>
        </div>
        <div class="d-flex gap-2">
            <div class="input-group input-group-sm" style="width: 250px;">
                <input type="text" class="form-control rounded-0" placeholder="Tìm tên hoặc mã SP...">
                <button class="btn btn-outline-dark rounded-0" type="button">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </div>
            <a href="${pageContext.request.contextPath}/admin/product?action=add" class="btn btn-admin-primary btn-sm px-3">
                <i class="fa-solid fa-plus me-1"></i> Thêm sản phẩm
            </a>
        </div>
    </div>

    <!-- Product Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle mb-0">
            <thead>
                <tr class="text-center">
                    <th style="width: 80px;">MÃ SP</th>
                    <th style="width: 90px;">HÌNH ẢNH</th>
                    <th class="text-start">TÊN SẢN PHẨM</th>
                    <th style="width: 140px;">GIÁ NIÊM YẾT</th>
                    <th style="width: 100px;">TỒN KHO</th>
                    <th style="width: 140px;">THAO TÁC</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${PRODUCTS}">
                    <tr>
                        <td class="text-center fw-bold text-secondary font-monospace">${p.productID}</td>
                        <td class="text-center p-2">
                            <div style="background: #F4F4F4; width: 60px; height: 60px; display: inline-flex; align-items: center; justify-content: center;">
                                <img src="${pageContext.request.contextPath}/img-prj301/${p.image}" alt="${p.name}" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                            </div>
                        </td>
                        <td>
                            <div class="fw-bold">${p.name}</div>
                            <small class="text-muted text-truncate d-inline-block" style="max-width: 350px;">${p.description}</small>
                        </td>
                        <td class="text-end fw-bold" style="color: var(--admin-red);">
                            <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                        </td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${p.quantity > 10}">
                                    <span class="badge bg-light text-success border border-success-subtle px-2 py-1">${p.quantity} cái</span>
                                </c:when>
                                <c:when test="${p.quantity > 0}">
                                    <span class="badge bg-light text-warning border border-warning-subtle px-2 py-1">Sắp hết: ${p.quantity}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger px-2 py-1">Hết hàng</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center">
                            <div class="btn-group btn-group-sm">
                                <a href="#" class="btn btn-outline-dark rounded-0 px-2" title="Chỉnh sửa">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/product?action=delete&id=${p.productID}" 
                                   class="btn btn-outline-danger rounded-0 px-2" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xoá sản phẩm [${p.name}] không?');" 
                                   title="Xoá">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty PRODUCTS}">
                    <tr>
                        <td colspan="6" class="text-center py-5 text-muted">
                            <i class="fa-solid fa-box-open fs-1 d-block mb-2 text-secondary opacity-50"></i>
                            Không có sản phẩm nào trong cơ sở dữ liệu!
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
