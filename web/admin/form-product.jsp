<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="isEdit" value="${not empty PRODUCT}" />
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="${isEdit ? 'Chỉnh Sửa Sản Phẩm' : 'Thêm Sản Phẩm Mới'} | ONE61 Garment Admin" />
    <jsp:param name="activeMenu" value="products" />
</jsp:include>

<!-- Notification Error Banner -->
<c:if test="${not empty ERROR}">
    <div class="alert alert-danger alert-dismissible fade show rounded-0 mb-4" role="alert">
        <i class="fa-solid fa-circle-exclamation me-2"></i> ${ERROR}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="admin-card p-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
        <div>
            <h4 class="fw-bold m-0 text-uppercase tracking-wide">
                <c:choose>
                    <c:when test="${isEdit}">
                        <i class="fa-solid fa-pen-to-square text-danger me-2"></i>Chỉnh Sửa Sản Phẩm [${PRODUCT.productID}]
                    </c:when>
                    <c:otherwise>
                        <i class="fa-solid fa-plus-circle text-danger me-2"></i>Thêm Sản Phẩm Mới
                    </c:otherwise>
                </c:choose>
            </h4>
            <p class="text-muted small m-0">
                ${isEdit ? 'Cập nhật thông tin chi tiết, giá bán và hình ảnh sản phẩm trong hệ thống' : 'Điền thông tin chi tiết và tải ảnh sản phẩm lên hệ thống'}
            </p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/product?action=list" class="btn btn-outline-dark btn-sm rounded-0">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại danh sách
            </a>
        </div>
    </div>

    <!-- Product Form (enctype multipart/form-data for file upload) -->
    <form action="${pageContext.request.contextPath}/admin/product" method="POST" enctype="multipart/form-data" class="needs-validation" onsubmit="return validateProductForm()">
        <input type="hidden" name="action" value="${isEdit ? 'update_submit' : 'add_submit'}">
        <input type="hidden" name="image" id="imagePathHidden" value="${PRODUCT.image}">
        
        <div class="row g-4">
            <!-- Left Column: Core Info -->
            <div class="col-lg-7">
                <div class="card admin-card p-3 mb-4">
                    <h6 class="fw-bold text-uppercase pb-2 border-bottom mb-3">
                        <i class="fa-solid fa-circle-info me-1 text-danger"></i> Thông Tin Chung
                    </h6>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-uppercase d-flex justify-content-between align-items-center">
                                <span>Mã Sản Phẩm (ID) <span class="text-danger">*</span></span>
                                <c:if test="${!isEdit}">
                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-0 px-2" style="font-size: 0.7rem;">Tự động tạo</span>
                                </c:if>
                            </label>
                            <input type="text" class="form-control rounded-0 font-monospace fw-bold" name="productID" value="${isEdit ? PRODUCT.productID : NEXT_PRODUCT_ID}" readonly style="background-color: #f1f3f5; color: #111111;" required>
                            <div class="form-text small" style="font-size: 0.72rem;">
                                ${isEdit ? 'Mã sản phẩm cố định không thể thay đổi' : 'Hệ thống tự động sinh mã kế tiếp trong cơ sở dữ liệu'}
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-uppercase">Danh Mục <span class="text-danger">*</span></label>
                            <select class="form-select rounded-0" name="categoryID" required>
                                <c:forEach var="cat" items="${CATEGORIES}">
                                    <option value="${cat.categoryID}" ${PRODUCT.categoryID eq cat.categoryID ? 'selected' : ''}>${cat.name} (${cat.categoryID})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold small text-uppercase">Tên Sản Phẩm <span class="text-danger">*</span></label>
                            <input type="text" class="form-control rounded-0" name="name" value="${PRODUCT.name}" placeholder="VD: Áo Sơ Mi Linen Cổ Tàu" required maxlength="255">
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold small text-uppercase">Mô Tả Sản Phẩm</label>
                            <textarea class="form-control rounded-0" name="description" rows="5" placeholder="Nhập chất liệu, kiểu dáng, tính năng LifeWear...">${PRODUCT.description}</textarea>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Pricing, Inventory & Image Upload -->
            <div class="col-lg-5">
                <div class="card admin-card p-3 mb-4">
                    <h6 class="fw-bold text-uppercase pb-2 border-bottom mb-3">
                        <i class="fa-solid fa-tag me-1 text-danger"></i> Giá Cả & Tồn Kho
                    </h6>
                    
                    <!-- Selling Price -->
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase d-flex justify-content-between align-items-center">
                            <span>Giá Bán (VNĐ) <span class="text-danger">*</span></span>
                            <span id="priceFormattedBadge" class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-0 px-2" style="font-size: 0.72rem;">
                                <c:if test="${PRODUCT.price != null}">
                                    <fmt:formatNumber value="${PRODUCT.price}" pattern="#,###"/> đ
                                </c:if>
                            </span>
                        </label>
                        <div class="input-group">
                            <input type="number" 
                                   class="form-control rounded-0 text-end fw-bold" 
                                   name="price" 
                                   id="productPriceInput"
                                   value="${PRODUCT.price != null ? PRODUCT.price.intValue() : ''}" 
                                   placeholder="0" 
                                   min="1000" 
                                   max="100000000" 
                                   step="1000" 
                                   required
                                   onkeydown="preventInvalidNumKeys(event)"
                                   oninput="formatPricePreview(this)">
                            <span class="input-group-text rounded-0 bg-light">VNĐ</span>
                        </div>
                        <div class="form-text small" style="font-size: 0.72rem;">
                            Từ 1.000đ đến 100.000.000đ (Không nhập số âm, ký tự đặc biệt)
                        </div>
                    </div>

                    <!-- Inventory Quantity -->
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Số Lượng Tồn Kho <span class="text-danger">*</span></label>
                        <input type="number" 
                               class="form-control rounded-0 text-end fw-bold" 
                               name="quantity" 
                               id="productQuantityInput"
                               value="${PRODUCT.quantity != null ? PRODUCT.quantity : 0}" 
                               placeholder="0" 
                               min="0" 
                               max="100000" 
                               step="1" 
                               required
                               onkeydown="preventInvalidNumKeys(event, false)"
                               oninput="sanitizeQuantity(this)">
                        <div class="form-text small" style="font-size: 0.72rem;">
                            Số lượng nguyên từ 0 đến 100.000 chiếc (Không nhập số âm hoặc số thập phân)
                        </div>
                    </div>

                    <!-- Image Upload Section -->
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase d-flex justify-content-between align-items-center">
                            <span>Tải Ảnh Sản Phẩm <span class="text-danger">*</span></span>
                            <small class="text-muted text-lowercase fw-normal">(JPG, PNG, WEBP, AVIF)</small>
                        </label>
                        
                        <!-- File Upload Input -->
                        <div class="input-group">
                            <input type="file" class="form-control rounded-0" name="imageFile" id="imageFileInput" accept="image/*" onchange="handleFileSelect(this)">
                        </div>
                    </div>

                    <!-- Image Preview Box -->
                    <div class="mt-3 p-3 bg-light text-center border">
                        <div class="small text-muted fw-bold text-uppercase mb-2" style="font-size: 0.75rem;">
                            <i class="fa-regular fa-image me-1"></i> Xem trước hình ảnh:
                        </div>
                        <div style="width: 140px; height: 170px; margin: 0 auto; background: #FFFFFF; border: 1px solid #E5E5E5; display: flex; align-items: center; justify-content: center; overflow: hidden;">
                            <img id="imgPreview" 
                                 src="${not empty PRODUCT.image ? pageContext.request.contextPath.concat('/img-prj301/').concat(PRODUCT.image) : pageContext.request.contextPath.concat('/img-prj301/products/men/cover/cover-shirts-men-1.avif')}" 
                                 alt="Product Preview" 
                                 style="max-width: 100%; max-height: 100%; object-fit: contain;"
                                 onerror="this.src='${pageContext.request.contextPath}/img-prj301/products/men/cover/cover-shirts-men-1.avif'">
                        </div>
                        <div id="imgFileNameDisplay" class="small text-muted text-truncate mt-2 font-monospace" style="font-size: 0.75rem;">
                            ${not empty PRODUCT.image ? PRODUCT.image : 'Chưa chọn file mới'}
                        </div>
                    </div>
                </div>

                <!-- Submit Button Area -->
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-admin-primary flex-grow-1 py-2">
                        <i class="fa-solid fa-floppy-disk me-1"></i> ${isEdit ? 'Lưu Thay Đổi' : 'Lưu Sản Phẩm Mới'}
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/product?action=list" class="btn btn-outline-dark rounded-0 px-3 py-2">
                        Hủy Bỏ
                    </a>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    // Prevent typing of invalid numeric characters (-, +, e, E, ., ,)
    function preventInvalidNumKeys(e, allowDecimals = false) {
        const invalidKeys = ['-', '+', 'e', 'E'];
        if (!allowDecimals) {
            invalidKeys.push('.', ',');
        }
        if (invalidKeys.includes(e.key)) {
            e.preventDefault();
        }
    }

    // Real-time formatted currency badge
    function formatPricePreview(input) {
        // Strip any non-digit
        let val = input.value.replace(/[^0-9]/g, '');
        if (val === '') {
            document.getElementById('priceFormattedBadge').textContent = '0 đ';
            return;
        }
        let num = parseInt(val, 10);
        if (num > 100000000) {
            num = 100000000;
            input.value = num;
        }
        document.getElementById('priceFormattedBadge').textContent = num.toLocaleString('vi-VN') + ' đ';
    }

    // Sanitize quantity to non-negative whole integer
    function sanitizeQuantity(input) {
        let val = input.value.replace(/[^0-9]/g, '');
        if (val === '') {
            input.value = '0';
            return;
        }
        let num = parseInt(val, 10);
        if (num > 100000) {
            num = 100000;
            input.value = num;
        }
    }

    // Form submit validation
    function validateProductForm() {
        const priceInput = document.getElementById('productPriceInput');
        const qtyInput = document.getElementById('productQuantityInput');
        
        const price = parseFloat(priceInput.value);
        const qty = parseInt(qtyInput.value, 10);

        if (isNaN(price) || price < 1000 || price > 100000000) {
            alert('Giá bán không hợp lệ! Vui lòng nhập trong khoảng từ 1.000 VNĐ đến 100.000.000 VNĐ.');
            priceInput.focus();
            return false;
        }

        if (isNaN(qty) || qty < 0 || qty > 100000) {
            alert('Số lượng tồn kho không hợp lệ! Vui lòng nhập số nguyên từ 0 đến 100.000.');
            qtyInput.focus();
            return false;
        }

        return true;
    }

    function handleFileSelect(input) {
        if (input.files && input.files[0]) {
            const file = input.files[0];
            const reader = new FileReader();
            reader.onload = function (e) {
                const preview = document.getElementById('imgPreview');
                if (preview) {
                    preview.src = e.target.result;
                }
                const label = document.getElementById('imgFileNameDisplay');
                if (label) {
                    label.textContent = 'File đã chọn: ' + file.name + ' (' + Math.round(file.size / 1024) + ' KB)';
                }
            };
            reader.readAsDataURL(file);
        }
    }
</script>

<jsp:include page="includes/footer.jsp" />
