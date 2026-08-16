<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Quản Lý Danh Mục | ONE61 Garment Admin" />
    <jsp:param name="activeMenu" value="categories" />
</jsp:include>

<!-- Notification Messages -->
<c:if test="${param.success eq 'added'}">
    <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> Thêm danh mục mới thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success eq 'updated'}">
    <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> Cập nhật thông tin danh mục thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success eq 'deleted'}">
    <div class="alert alert-warning alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-eye-slash me-2"></i> Đã ẩn danh mục khỏi hệ thống!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="admin-card p-4">
    <!-- Header with Action -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-3 border-bottom gap-3">
        <div>
            <h4 class="fw-bold m-0 text-uppercase tracking-wide">Quản Lý Danh Mục Sản Phẩm</h4>
            <p class="text-muted small m-0">Danh sách phân loại sản phẩm Nam / Nữ và nhóm hàng thời trang</p>
        </div>
        <div>
            <button class="btn btn-admin-primary btn-sm px-3" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                <i class="fa-solid fa-plus me-1"></i> Thêm danh mục mới
            </button>
        </div>
    </div>

    <!-- Category Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle mb-0">
            <thead class="table-light">
                <tr class="text-center small text-uppercase">
                    <th style="width: 140px;">MÃ DANH MỤC</th>
                    <th class="text-start">TÊN DANH MỤC</th>
                    <th style="width: 160px;">SỐ LƯỢNG SP</th>
                    <th style="width: 140px;">TRẠNG THÁI</th>
                    <th style="width: 160px;">THAO TÁC</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="cat" items="${CATEGORIES}">
                    <tr>
                        <td class="text-center fw-bold text-secondary font-monospace">${cat.categoryID}</td>
                        <td class="fw-bold text-dark">${cat.name}</td>
                        <td class="text-center">
                            <span class="badge bg-light text-dark border px-2 py-1">
                                <i class="fa-solid fa-shirt me-1 text-secondary"></i>
                                ${PRODUCT_COUNTS[cat.categoryID] != null ? PRODUCT_COUNTS[cat.categoryID] : 0} sản phẩm
                            </span>
                        </td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${cat.status}">
                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 rounded-0">Đang hiển thị</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2 py-1 rounded-0">Đang ẩn</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center">
                            <div class="btn-group btn-group-sm">
                                <button class="btn btn-outline-dark rounded-0 px-2" 
                                        onclick="openEditCategory('${cat.categoryID}', '${cat.name}', ${cat.status})"
                                        title="Chỉnh sửa">
                                    <i class="fa-solid fa-pen-to-square"></i> Sửa
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/category?action=delete&id=${cat.categoryID}" 
                                   class="btn btn-outline-danger rounded-0 px-2" 
                                   onclick="return confirm('Bạn có chắc chắn muốn ẩn danh mục [${cat.name}] không?');" 
                                   title="Ẩn">
                                    <i class="fa-solid fa-eye-slash"></i> Ẩn
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty CATEGORIES}">
                    <tr>
                        <td colspan="5" class="text-center py-5 text-muted">Chưa có danh mục nào trong hệ thống.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal Add Category -->
<div class="modal fade" id="addCategoryModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-0">
            <form action="${pageContext.request.contextPath}/admin/category" method="POST">
                <input type="hidden" name="action" value="add">
                <div class="modal-header border-bottom">
                    <h5 class="modal-title fw-bold text-uppercase">Thêm Danh Mục Mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Mã Danh Mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control rounded-0 font-monospace" name="categoryID" placeholder="VD: MEN_05 hoặc WOMEN_05" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Tên Danh Mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control rounded-0" name="name" placeholder="VD: Áo Khoác Phao Siêu Nhẹ" required>
                    </div>
                    <div class="form-check form-switch mt-3">
                        <input class="form-check-input" type="checkbox" name="status" id="addCatStatus" checked>
                        <label class="form-check-label small fw-bold" for="addCatStatus">Hiển thị danh mục trên Storefront</label>
                    </div>
                </div>
                <div class="modal-footer border-top bg-light">
                    <button type="button" class="btn btn-outline-dark btn-sm rounded-0" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-admin-primary btn-sm px-3">Lưu danh mục</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal Edit Category -->
<div class="modal fade" id="editCategoryModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-0">
            <form action="${pageContext.request.contextPath}/admin/category" method="POST">
                <input type="hidden" name="action" value="update">
                <div class="modal-header border-bottom">
                    <h5 class="modal-title fw-bold text-uppercase">Chỉnh Sửa Danh Mục</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Mã Danh Mục</label>
                        <input type="text" class="form-control rounded-0 font-monospace" id="editCategoryID" name="categoryID" readonly style="background-color: #e9ecef;">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Tên Danh Mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control rounded-0" id="editCategoryName" name="name" required>
                    </div>
                    <div class="form-check form-switch mt-3">
                        <input class="form-check-input" type="checkbox" name="status" id="editCatStatus">
                        <label class="form-check-label small fw-bold" for="editCatStatus">Hiển thị danh mục trên Storefront</label>
                    </div>
                </div>
                <div class="modal-footer border-top bg-light">
                    <button type="button" class="btn btn-outline-dark btn-sm rounded-0" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-admin-primary btn-sm px-3">Cập nhật</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function openEditCategory(id, name, status) {
        document.getElementById('editCategoryID').value = id;
        document.getElementById('editCategoryName').value = name;
        document.getElementById('editCatStatus').checked = (status === true || status === 'true');
        new bootstrap.Modal(document.getElementById('editCategoryModal')).show();
    }
</script>

<jsp:include page="includes/footer.jsp" />
