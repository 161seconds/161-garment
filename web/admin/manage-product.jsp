<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Quản Lý Sản Phẩm | ONE61 Garment Admin" />
    <jsp:param name="activeMenu" value="products" />
</jsp:include>

<!-- Notification Messages -->
<c:if test="${param.success eq 'added'}">
    <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> Thêm sản phẩm mới thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success eq 'updated'}">
    <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> Cập nhật thông tin sản phẩm thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success eq 'deleted'}">
    <div class="alert alert-warning alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-trash-can me-2"></i> Đã xóa sản phẩm khỏi danh mục kinh doanh!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="admin-card p-4">
    <!-- Header with Search & Filter -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-3 border-bottom gap-3">
        <div>
            <h4 class="fw-bold m-0 text-uppercase tracking-wide">Danh Sách Sản Phẩm</h4>
            <p class="text-muted small m-0">Quản lý danh mục hàng hóa, số lượng tồn và giá niêm yết</p>
        </div>
        <div class="d-flex flex-wrap gap-2 align-items-center">
            <!-- Search & Filter Form -->
            <form action="${pageContext.request.contextPath}/admin/product" method="GET" class="d-flex gap-2 m-0">
                <input type="hidden" name="action" value="list">
                
                <select class="form-select form-select-sm rounded-0" name="categoryID" onchange="this.form.submit()" style="width: 160px;">
                    <option value="">-- Tất cả danh mục --</option>
                    <c:forEach var="c" items="${CATEGORIES}">
                        <option value="${c.categoryID}" ${categoryID eq c.categoryID ? 'selected' : ''}>${c.name}</option>
                    </c:forEach>
                </select>

                <div class="input-group input-group-sm" style="width: 220px;">
                    <input type="text" class="form-control rounded-0" name="keyword" value="${keyword}" placeholder="Tìm tên hoặc mã SP...">
                    <button class="btn btn-dark rounded-0" type="submit">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </div>
            </form>

            <a href="${pageContext.request.contextPath}/admin/product?action=add" class="btn btn-admin-primary btn-sm px-3">
                <i class="fa-solid fa-plus me-1"></i> Thêm sản phẩm
            </a>
        </div>
    </div>

    <!-- Product Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle mb-0">
            <thead class="table-light">
                <tr class="text-center small text-uppercase">
                    <th style="width: 80px;">MÃ SP</th>
                    <th style="width: 80px;">ẢNH BÌA</th>
                    <th class="text-start">TÊN SẢN PHẨM & MÔ TẢ</th>
                    <th style="width: 130px;">DANH MỤC</th>
                    <th style="width: 130px;">GIÁ NIÊM YẾT</th>
                    <th style="width: 100px;">TỒN KHO</th>
                    <th style="width: 120px;">THAO TÁC</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${PRODUCTS}">
                    <tr>
                        <td class="text-center fw-bold text-secondary font-monospace">${p.productID}</td>
                        <td class="text-center p-2">
                            <div style="background: #F4F4F4; width: 55px; height: 55px; display: inline-flex; align-items: center; justify-content: center; overflow: hidden;">
                                <img src="${pageContext.request.contextPath}/img-prj301/${p.image}" alt="${p.name}" style="max-width: 100%; max-height: 100%; object-fit: contain;" onerror="this.src='${pageContext.request.contextPath}/img-prj301/products/men/cover/cover-shirts-men-1.avif'">
                            </div>
                        </td>
                        <td>
                            <div class="fw-bold text-dark">${p.name}</div>
                            <small class="text-muted text-truncate d-inline-block" style="max-width: 320px;">${p.description}</small>
                        </td>
                        <td class="text-center small fw-semibold text-secondary">
                            ${p.categoryID}
                        </td>
                        <td class="text-end fw-bold" style="color: var(--admin-red);">
                            <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                        </td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${p.quantity > 10}">
                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">${p.quantity} cái</span>
                                </c:when>
                                <c:when test="${p.quantity > 0}">
                                    <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle px-2 py-1">Sắp hết: ${p.quantity}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger px-2 py-1">Hết hàng</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center">
                            <div class="btn-group btn-group-sm">
                                <a href="${pageContext.request.contextPath}/admin/product?action=edit&id=${p.productID}" class="btn btn-outline-dark rounded-0 px-2" title="Chỉnh sửa">
                                    <i class="fa-solid fa-pen-to-square"></i> Sửa
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
                        <td colspan="7" class="text-center py-5 text-muted">
                            <i class="fa-solid fa-box-open fs-1 d-block mb-2 text-secondary opacity-50"></i>
                            Không tìm thấy sản phẩm nào phù hợp với bộ lọc!
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
                Hiển thị trang <strong>${currentPage}</strong> / ${endPage} (Tổng cộng <strong>${totalProducts}</strong> sản phẩm)
            </span>
            <nav aria-label="Page navigation">
                <ul class="pagination pagination-sm mb-0 rounded-0 gap-1">
                    <!-- Prev Button -->
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link rounded-0 fw-bold px-3 text-dark bg-white border"
                           href="${pageContext.request.contextPath}/admin/product?action=list&page=${currentPage - 1}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty categoryID ? '&categoryID='.concat(categoryID) : ''}">
                            <i class="fa-solid fa-chevron-left"></i>
                        </a>
                    </li>

                    <!-- Page Numbers -->
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link rounded-0 fw-bold px-3 ${i == currentPage ? 'bg-danger border-danger text-white' : 'text-dark bg-white border'}"
                               href="${pageContext.request.contextPath}/admin/product?action=list&page=${i}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty categoryID ? '&categoryID='.concat(categoryID) : ''}">${i}</a>
                        </li>
                    </c:forEach>

                    <!-- Next Button -->
                    <li class="page-item ${currentPage >= endPage ? 'disabled' : ''}">
                        <a class="page-link rounded-0 fw-bold px-3 text-dark bg-white border"
                           href="${pageContext.request.contextPath}/admin/product?action=list&page=${currentPage + 1}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty categoryID ? '&categoryID='.concat(categoryID) : ''}">
                            <i class="fa-solid fa-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:if>
</div>

<jsp:include page="includes/footer.jsp" />
