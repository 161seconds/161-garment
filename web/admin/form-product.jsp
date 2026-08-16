<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Thêm Sản Phẩm Mới | ONE61 Garment Admin" />
    <jsp:param name="activeMenu" value="products" />
</jsp:include>

<div class="admin-card p-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
        <div>
            <h4 class="fw-bold m-0 text-uppercase tracking-wide">Thêm Sản Phẩm Mới</h4>
            <p class="text-muted small m-0">Điền thông tin chi tiết để thêm sản phẩm vào danh mục bán hàng</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/product?action=list" class="btn btn-outline-dark btn-sm rounded-0">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại danh sách
            </a>
        </div>
    </div>

    <!-- Product Form -->
    <form action="${pageContext.request.contextPath}/admin/product" method="POST" class="needs-validation">
        <input type="hidden" name="action" value="add_submit">
        
        <div class="row g-4">
            <!-- Left Column: Core Info -->
            <div class="col-lg-7">
                <div class="card admin-card p-3 mb-4">
                    <h6 class="fw-bold text-uppercase pb-2 border-bottom mb-3">
                        <i class="fa-solid fa-circle-info me-1 text-danger"></i> Thông Tin Chung
                    </h6>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-uppercase">Mã Sản Phẩm (ID) <span class="text-danger">*</span></label>
                            <input type="text" class="form-control rounded-0" name="productID" placeholder="VD: PROD01" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-uppercase">Danh Mục <span class="text-danger">*</span></label>
                            <select class="form-select rounded-0" name="categoryID" required>
                                <c:forEach var="cat" items="${CATEGORIES}">
                                    <option value="${cat.categoryID}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold small text-uppercase">Tên Sản Phẩm <span class="text-danger">*</span></label>
                            <input type="text" class="form-control rounded-0" name="name" placeholder="VD: Áo Thun Cổ Tròn Dry-EX" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold small text-uppercase">Mô Tả Sản Phẩm</label>
                            <textarea class="form-control rounded-0" name="description" rows="5" placeholder="Nhập chất liệu, kiểu dáng, điểm nổi bật..."></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Pricing, Inventory & Image -->
            <div class="col-lg-5">
                <div class="card admin-card p-3 mb-4">
                    <h6 class="fw-bold text-uppercase pb-2 border-bottom mb-3">
                        <i class="fa-solid fa-tag me-1 text-danger"></i> Giá Cả & Tồn Kho
                    </h6>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Giá Bán (VNĐ) <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <input type="number" class="form-control rounded-0 text-end fw-bold" name="price" placeholder="0" min="0" step="1000" required>
                            <span class="input-group-text rounded-0 bg-light">VNĐ</span>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Số Lượng Trong Kho <span class="text-danger">*</span></label>
                        <input type="number" class="form-control rounded-0" name="quantity" placeholder="0" min="0" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Đường Dẫn File Ảnh <span class="text-danger">*</span></label>
                        <input type="text" class="form-control rounded-0 font-monospace" name="image" placeholder="VD: products/men/cover/cover-shirts-men-1.avif" required>
                        <div class="form-text small">Đường dẫn tương đối trong thư mục <code>web/img-prj301/</code></div>
                    </div>
                </div>

                <!-- Submit Button Area -->
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-admin-primary flex-grow-1 py-2">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Sản Phẩm
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/product?action=list" class="btn btn-outline-dark rounded-0 px-3 py-2">
                        Hủy Bỏ
                    </a>
                </div>
            </div>
        </div>
    </form>
</div>

<jsp:include page="includes/footer.jsp" />
