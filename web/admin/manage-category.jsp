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
<c:if test="${param.success eq 'featured_updated'}">
    <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> Cập nhật Danh mục nổi bật Trang chủ thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success eq 'deleted'}">
    <div class="alert alert-warning alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-eye-slash me-2"></i> Đã ẩn danh mục khỏi hệ thống!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success eq 'status_toggled'}">
    <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i> Đã cập nhật trạng thái hiển thị của danh mục!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Navigation Sub-Tabs -->
<ul class="nav nav-tabs border-bottom-0 mb-3" id="categoryTabs" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link rounded-0 fw-bold px-4 py-2 ${param.tab ne 'featured' ? 'active text-danger border-bottom-0' : 'text-dark'}" 
                id="store-cat-tab" data-bs-toggle="tab" data-bs-target="#store-cat" type="button" role="tab" style="font-size: 0.88rem;">
            <i class="fa-solid fa-list me-2"></i> 1. Danh Mục Phân Loại Sản Phẩm
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link rounded-0 fw-bold px-4 py-2 ${param.tab eq 'featured' ? 'active text-danger border-bottom-0' : 'text-dark'}" 
                id="featured-cat-tab" data-bs-toggle="tab" data-bs-target="#featured-cat" type="button" role="tab" style="font-size: 0.88rem;">
            <i class="fa-solid fa-star me-2 text-warning"></i> 2. Danh Mục Nổi Bật Trang Chủ (Showcase)
        </button>
    </li>
</ul>

<div class="tab-content" id="categoryTabContent">
    <!-- TAB 1: STORE CATEGORIES -->
    <div class="tab-pane fade ${param.tab ne 'featured' ? 'show active' : ''}" id="store-cat" role="tabpanel">
        <div class="admin-card p-4">
            <!-- Header with Action -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-3 border-bottom gap-3">
                <div>
                    <h4 class="fw-bold m-0 text-uppercase tracking-wide">Quản Lý Danh Mục Phân Loại</h4>
                    <p class="text-muted small m-0">Danh sách phân loại sản phẩm Nam / Nữ và nhóm hàng thời trang trong Catalog</p>
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
                                        <c:choose>
                                            <c:when test="${cat.status}">
                                                <a href="${pageContext.request.contextPath}/admin/category?action=toggle_status&id=${cat.categoryID}" 
                                                   class="btn btn-outline-danger rounded-0 px-2" 
                                                   onclick="return confirm('Bạn có chắc chắn muốn ẩn danh mục [${cat.name}] không?');" 
                                                   title="Ẩn danh mục">
                                                    <i class="fa-solid fa-eye-slash"></i> Ẩn
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/admin/category?action=toggle_status&id=${cat.categoryID}" 
                                                   class="btn btn-outline-success rounded-0 px-2" 
                                                   onclick="return confirm('Bạn có muốn kích hoạt hiển thị lại danh mục [${cat.name}] không?');" 
                                                   title="Hiện danh mục">
                                                    <i class="fa-solid fa-eye"></i> Hiện
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
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
    </div>

    <!-- TAB 2: HOME FEATURED CATEGORIES SHOWCASE -->
    <div class="tab-pane fade ${param.tab eq 'featured' ? 'show active' : ''}" id="featured-cat" role="tabpanel">
        <div class="admin-card p-4">
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-3 border-bottom gap-3">
                <div>
                    <h4 class="fw-bold m-0 text-uppercase tracking-wide">
                        <i class="fa-solid fa-images text-danger me-2"></i>Chỉnh Sửa Danh Mục Nổi Bật Trang Chủ
                    </h4>
                    <p class="text-muted small m-0">Quản lý 3 khung ảnh bộ sưu tập LifeWear Collection hiển thị nổi bật ở Trang chủ (Home Page)</p>
                </div>
                <a href="${pageContext.request.contextPath}/home" target="_blank" class="btn btn-outline-dark btn-sm rounded-0 px-3">
                    <i class="fa-solid fa-arrow-up-right-from-square me-1"></i> Xem Trang Chủ
                </a>
            </div>

            <!-- 3 Featured Category Cards Grid -->
            <div class="row g-4">
                <c:forEach var="feat" items="${FEATURED_CATEGORIES}">
                    <div class="col-lg-4 col-md-6 col-12">
                        <div class="card h-100 rounded-0 border shadow-sm">
                            <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center py-2 px-3">
                                <span class="fw-bold small text-uppercase font-monospace">VỊ TRÍ BỘ SƯU TẬP #${feat.id}</span>
                                <c:choose>
                                    <c:when test="${feat.status}">
                                        <span class="badge bg-success rounded-0" style="font-size: 0.65rem;">HIỂN THỊ</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary rounded-0" style="font-size: 0.65rem;">ĐANG ẨN</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div style="height: 240px; position: relative; background: #F8F9FA; overflow: hidden; border-bottom: 1px solid #E5E5E5;">
                                <img src="${pageContext.request.contextPath}/img-prj301/${feat.image}" 
                                     alt="${feat.title}" 
                                     style="width: 100%; height: 100%; object-fit: cover;"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img-prj301/products/men/cover/cover-shirts-men-1.avif';">
                                <c:if test="${not empty feat.badge}">
                                    <span class="position-absolute top-0 start-0 m-3 badge bg-danger text-white rounded-0 px-2 py-1 shadow-sm" style="font-size: 0.7rem; letter-spacing: 0.5px;">
                                        ${feat.badge}
                                    </span>
                                </c:if>
                            </div>

                            <div class="card-body p-3 d-flex flex-column justify-content-between">
                                <div>
                                    <h5 class="fw-bold text-dark text-uppercase mb-1" style="font-size: 1.05rem;">${feat.title}</h5>
                                    <p class="text-muted small mb-2" style="font-size: 0.82rem;">${feat.subtitle}</p>
                                    <div class="small text-secondary mb-3">
                                        <i class="fa-solid fa-link me-1"></i> Điều hướng đến: 
                                        <strong class="text-dark font-monospace">${feat.categoryID}</strong>
                                    </div>
                                </div>

                                <button class="btn btn-outline-dark btn-sm rounded-0 w-100 fw-bold py-2 text-uppercase" 
                                        onclick="openEditFeaturedModal(${feat.id}, '${feat.title}', '${feat.subtitle}', '${feat.badge}', '${feat.categoryID}', '${feat.image}', ${feat.status})"
                                        style="font-size: 0.8rem;">
                                    <i class="fa-solid fa-pen-to-square me-1"></i> Chỉnh sửa bộ sưu tập
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
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

<!-- Modal Edit Featured Category (Showcase) -->
<div class="modal fade" id="editFeaturedModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content rounded-0">
            <form action="${pageContext.request.contextPath}/admin/category" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="action" value="update_featured">
                <input type="hidden" name="id" id="featId">
                <input type="hidden" name="currentImage" id="featCurrentImage">

                <div class="modal-header border-bottom bg-dark text-white">
                    <h5 class="modal-title fw-bold text-uppercase" id="featModalTitle">
                        <i class="fa-solid fa-pen-to-square me-2 text-warning"></i> Chỉnh Sửa Danh Mục Nổi Bật
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body p-4">
                    <div class="row g-4">
                        <!-- Left: Form Inputs -->
                        <div class="col-md-7">
                            <div class="mb-3">
                                <label class="form-label fw-bold small text-uppercase">Tiêu Đề Bộ Sưu Tập <span class="text-danger">*</span></label>
                                <input type="text" class="form-control rounded-0" name="title" id="featTitle" placeholder="VD: THỜI TRANG NỮ" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold small text-uppercase">Mô Tả Ngắn / Phụ Đề <span class="text-danger">*</span></label>
                                <input type="text" class="form-control rounded-0" name="subtitle" id="featSubtitle" placeholder="VD: Thanh lịch, dịu mát & tôn dáng tối ưu" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold small text-uppercase">Nhãn Nổi Bật (Badge)</label>
                                <input type="text" class="form-control rounded-0" name="badge" id="featBadge" placeholder="VD: BST NỮ 2026 hoặc HOT TREND">
                                <small class="text-muted" style="font-size: 0.72rem;">Nhãn dán góc trên ảnh bìa thẻ bộ sưu tập</small>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold small text-uppercase">Liên Kết Danh Mục Điều Hướng <span class="text-danger">*</span></label>
                                <select class="form-select rounded-0" name="categoryID" id="featCategoryID" required>
                                    <c:forEach var="c" items="${CATEGORIES}">
                                        <option value="${c.categoryID}">${c.categoryID} - ${c.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-check form-switch mt-3">
                                <input class="form-check-input" type="checkbox" name="status" id="featStatus">
                                <label class="form-check-label small fw-bold" for="featStatus">Hiển thị thẻ này trên Trang chủ</label>
                            </div>
                        </div>

                        <!-- Right: Image Upload & Preview -->
                        <div class="col-md-5">
                            <label class="form-label fw-bold small text-uppercase">Ảnh Bìa Bộ Sưu Tập</label>
                            <div style="width: 100%; height: 210px; background: #f8f9fa; border: 1px solid #E5E5E5; display: flex; align-items: center; justify-content: center; overflow: hidden; margin-bottom: 10px;">
                                <img id="featImagePreview" src="" alt="Preview" style="max-width: 100%; max-height: 100%; object-fit: cover;" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img-prj301/products/men/cover/cover-shirts-men-1.avif';">
                            </div>
                            <input type="file" class="form-control form-control-sm rounded-0 mb-1" name="imageFile" accept="image/*" onchange="previewFeatImage(this)">
                            <div id="featImageName" class="text-muted font-monospace text-truncate" style="font-size: 0.72rem;"></div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer border-top bg-light">
                    <button type="button" class="btn btn-outline-dark btn-sm rounded-0" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-admin-primary btn-sm px-3">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Thay Đổi
                    </button>
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

    function openEditFeaturedModal(id, title, subtitle, badge, categoryID, image, status) {
        document.getElementById('featId').value = id;
        document.getElementById('featModalTitle').innerHTML = '<i class="fa-solid fa-pen-to-square me-2 text-warning"></i> Chỉnh Sửa Bộ Sưu Tập Vị Trí #' + id;
        document.getElementById('featTitle').value = title;
        document.getElementById('featSubtitle').value = subtitle;
        document.getElementById('featBadge').value = badge;
        document.getElementById('featCategoryID').value = categoryID;
        document.getElementById('featCurrentImage').value = image;
        document.getElementById('featStatus').checked = (status === true || status === 'true');

        const preview = document.getElementById('featImagePreview');
        preview.src = '${pageContext.request.contextPath}/img-prj301/' + image;
        document.getElementById('featImageName').innerText = 'File hiện tại: ' + image;

        new bootstrap.Modal(document.getElementById('editFeaturedModal')).show();
    }

    function previewFeatImage(input) {
        if (input.files && input.files[0]) {
            const file = input.files[0];
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('featImagePreview').src = e.target.result;
                document.getElementById('featImageName').innerText = 'Đã chọn: ' + file.name;
            };
            reader.readAsDataURL(file);
        }
    }
</script>

<jsp:include page="includes/footer.jsp" />
