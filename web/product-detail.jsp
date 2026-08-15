<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="${PRODUCT.name} | ONE61 Garment" />
</jsp:include>

<style>
    /* Uniqlo Flagship Product Detail Styling */
    .product-detail-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 1.5rem 1rem 4rem 1rem;
    }

    /* Multi-Image Lookbook Gallery */
    .lookbook-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 8px;
    }

    @media (max-width: 768px) {
        .lookbook-grid {
            grid-template-columns: 1fr;
        }
    }

    .lookbook-item {
        position: relative;
        background-color: #f7f7f7;
        overflow: hidden;
        aspect-ratio: 3 / 4;
    }

    .lookbook-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.4s ease;
    }

    .lookbook-item:hover img {
        transform: scale(1.03);
    }

    .lookbook-tag {
        position: absolute;
        bottom: 12px;
        left: 12px;
        background: rgba(0, 0, 0, 0.6);
        color: #fff;
        font-size: 0.7rem;
        padding: 3px 8px;
        border-radius: 20px;
        display: flex;
        align-items: center;
        gap: 5px;
        backdrop-filter: blur(4px);
    }

    /* Right Sticky Product Info Box */
    .sticky-product-info {
        position: sticky;
        top: 90px;
        padding-left: 2rem;
    }

    @media (max-width: 991px) {
        .sticky-product-info {
            padding-left: 0;
            margin-top: 2rem;
            position: static;
        }
    }

    /* Color Swatches */
    .color-swatch-btn {
        width: 34px;
        height: 34px;
        border-radius: 50%;
        border: 2px solid #fff;
        outline: 1px solid #ddd;
        cursor: pointer;
        padding: 0;
        transition: all 0.2s ease;
    }

    .color-swatch-btn.active {
        outline: 2px solid #000;
        transform: scale(1.08);
    }

    /* Size Selector Buttons */
    .size-btn-group {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    .size-btn {
        min-width: 48px;
        height: 40px;
        padding: 0 12px;
        border: 1px solid #ccc;
        background: #fff;
        color: #111;
        font-weight: 600;
        font-size: 0.85rem;
        border-radius: 0;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.15s ease;
    }

    .size-btn:hover {
        border-color: #000;
    }

    .size-btn.active {
        background: #000;
        color: #fff;
        border-color: #000;
    }

    /* Quantity Stepper */
    .qty-stepper {
        display: inline-flex;
        border: 1px solid #111;
        height: 48px;
        align-items: center;
        background: #fff;
    }

    .qty-btn {
        width: 40px;
        height: 100%;
        border: none;
        background: transparent;
        font-size: 1.1rem;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background 0.15s ease;
    }

    .qty-btn:hover {
        background: #f0f0f0;
    }

    .qty-input {
        width: 45px;
        border: none;
        text-align: center;
        font-weight: 700;
        font-size: 0.95rem;
        background: transparent;
    }

    .qty-input:focus {
        outline: none;
    }

    /* Add To Cart Button */
    .btn-add-to-cart {
        background-color: #000000;
        color: #ffffff;
        font-weight: 700;
        font-size: 0.95rem;
        letter-spacing: 1px;
        height: 48px;
        border-radius: 0;
        border: none;
        transition: all 0.2s ease;
    }

    .btn-add-to-cart:hover {
        background-color: var(--color-primary, #ED1D24);
        color: #ffffff;
    }

    /* Wishlist Button */
    .btn-wishlist {
        border: 1px solid #ccc;
        background: #fff;
        color: #111;
        font-weight: 600;
        font-size: 0.85rem;
        height: 44px;
        border-radius: 0;
        transition: all 0.2s ease;
    }

    .btn-wishlist:hover {
        border-color: #000;
        background: #f8f8f8;
    }

    /* Accordion Details */
    .uniqlo-accordion .accordion-item {
        border-left: none;
        border-right: none;
        border-radius: 0;
    }

    .uniqlo-accordion .accordion-button {
        font-weight: 700;
        font-size: 0.9rem;
        padding: 1rem 0;
        background: transparent;
        box-shadow: none;
    }

    .uniqlo-accordion .accordion-button:not(.collapsed) {
        color: #000;
    }

    .uniqlo-accordion .accordion-body {
        padding: 0 0 1.25rem 0;
        font-size: 0.88rem;
        color: #555;
        line-height: 1.7;
    }
</style>

<!-- Breadcrumbs -->
<div class="border-bottom py-2 bg-white">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0 small text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px;">
                <li class="breadcrumb-item"><a href="home" class="text-secondary text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="product" class="text-secondary text-decoration-none">Sản phẩm</a></li>
                <li class="breadcrumb-item"><a href="product?categoryID=${PRODUCT.categoryID}" class="text-secondary text-decoration-none">${PRODUCT.categoryID}</a></li>
                <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">${PRODUCT.name}</li>
            </ol>
        </nav>
    </div>
</div>

<div class="product-detail-container">
    <div class="row g-4">
        <!-- Left: Lookbook Multi-Angle Gallery Grid (2 Columns) -->
        <div class="col-lg-7 col-md-12">
            <div class="lookbook-grid">
                <!-- Image 1: Main Front View -->
                <div class="lookbook-item">
                    <img id="mainProductImg" src="${pageContext.request.contextPath}/img-prj301/${PRODUCT.image}" 
                         alt="${PRODUCT.name} - Front View"
                         onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=800&auto=format&fit=crop&q=80';">
                    <span class="lookbook-tag"><i class="fa-solid fa-camera"></i> Mặt trước</span>
                </div>

                <!-- Image 2: Full Body Styling View -->
                <div class="lookbook-item">
                    <img src="${pageContext.request.contextPath}/img-prj301/${PRODUCT.image}" 
                         alt="${PRODUCT.name} - Full Body Look"
                         style="filter: brightness(0.98);"
                         onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=800&auto=format&fit=crop&q=80';">
                    <span class="lookbook-tag"><i class="fa-solid fa-person"></i> Phối đồ</span>
                </div>

                <!-- Image 3: Detail Texture Angle -->
                <div class="lookbook-item">
                    <img src="${pageContext.request.contextPath}/img-prj301/${PRODUCT.image}" 
                         alt="${PRODUCT.name} - Texture Detail"
                         style="filter: contrast(1.05);"
                         onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1509631179647-0177331693ae?w=800&auto=format&fit=crop&q=80';">
                    <span class="lookbook-tag"><i class="fa-solid fa-magnifying-glass"></i> Chi tiết vải</span>
                </div>

                <!-- Image 4: Alternate Angle / Lifestyle -->
                <div class="lookbook-item">
                    <img src="${pageContext.request.contextPath}/img-prj301/${PRODUCT.image}" 
                         alt="${PRODUCT.name} - Lifestyle"
                         onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800&auto=format&fit=crop&q=80';">
                    <span class="lookbook-tag"><i class="fa-solid fa-shirt"></i> Form dáng</span>
                </div>
            </div>
        </div>

        <!-- Right: Sticky Product Info & Purchase Form -->
        <div class="col-lg-5 col-md-12">
            <div class="sticky-product-info">
                <!-- Brand Badge -->
                <div class="d-flex align-items-center gap-2 mb-2">
                    <span class="badge bg-danger rounded-0 px-2 py-1 text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">
                        ONE61 LIFEWEAR
                    </span>
                    <span class="text-muted small font-monospace">Mã SP: ${PRODUCT.productID}</span>
                </div>

                <!-- Product Name -->
                <h1 class="fw-bold text-uppercase tracking-tight mb-2" style="font-size: 1.65rem; line-height: 1.3;">
                    ${PRODUCT.name}
                </h1>

                <!-- Rating & Review Count -->
                <div class="d-flex align-items-center gap-2 mb-3">
                    <div class="text-warning small">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star-half-stroke"></i>
                    </div>
                    <span class="small fw-bold text-dark">4.8</span>
                    <a href="#reviews" class="small text-muted text-decoration-underline">(319 đánh giá)</a>
                </div>

                <!-- Price -->
                <div class="mb-4">
                    <div class="fs-2 fw-bold text-dark font-monospace" style="letter-spacing: -0.5px;">
                        <fmt:formatNumber value="${PRODUCT.price}" pattern="#,###" /> đ
                    </div>
                    <div class="small text-success fw-semibold">
                        <i class="fa-solid fa-check-circle me-1"></i> Giá đã bao gồm thuế VAT
                    </div>
                </div>

                <hr class="my-3">

                <!-- 1. Color Selection (Uniqlo Style Swatches) -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="small fw-bold text-uppercase">Màu sắc: <span id="selectedColorName" class="text-secondary fw-normal">32 BEIGE</span></span>
                    </div>
                    <div class="d-flex gap-2" id="colorSwatchGroup">
                        <button type="button" class="color-swatch-btn active" style="background-color: #D1C2A5;" onclick="selectColor('32 BEIGE', this)" title="32 BEIGE"></button>
                        <button type="button" class="color-swatch-btn" style="background-color: #F5F2EB;" onclick="selectColor('01 OFF WHITE', this)" title="01 OFF WHITE"></button>
                        <button type="button" class="color-swatch-btn" style="background-color: #2B3448;" onclick="selectColor('69 NAVY', this)" title="69 NAVY"></button>
                        <button type="button" class="color-swatch-btn" style="background-color: #1A1A1A;" onclick="selectColor('09 BLACK', this)" title="09 BLACK"></button>
                    </div>
                </div>

                <!-- 2. Size Selection -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="small fw-bold text-uppercase">Kích thước: <span id="selectedSizeLabel" class="text-secondary fw-normal">M</span></span>
                        <a href="#" class="small text-dark fw-semibold text-decoration-underline" data-bs-toggle="modal" data-bs-target="#sizeGuideModal">
                            <i class="fa-solid fa-ruler-horizontal me-1"></i> Bảng quy đổi kích cỡ
                        </a>
                    </div>
                    <div class="size-btn-group" id="sizeButtonGroup">
                        <button type="button" class="size-btn" onclick="selectSize('XXS', this)">XXS</button>
                        <button type="button" class="size-btn" onclick="selectSize('XS', this)">XS</button>
                        <button type="button" class="size-btn" onclick="selectSize('S', this)">S</button>
                        <button type="button" class="size-btn active" onclick="selectSize('M', this)">M</button>
                        <button type="button" class="size-btn" onclick="selectSize('L', this)">L</button>
                        <button type="button" class="size-btn" onclick="selectSize('XL', this)">XL</button>
                        <button type="button" class="size-btn" onclick="selectSize('XXL', this)">XXL</button>
                    </div>
                </div>

                <!-- 3. Quantity & Add To Cart Form -->
                <form action="cart" method="POST" id="productPurchaseForm" class="mb-4">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productID" value="${PRODUCT.productID}">
                    <input type="hidden" name="color" id="inputColor" value="32 BEIGE">
                    <input type="hidden" name="size" id="inputSize" value="M">

                    <div class="d-flex gap-3 align-items-center mb-3">
                        <!-- Quantity Stepper -->
                        <div class="qty-stepper">
                            <button type="button" class="qty-btn" onclick="changeQuantity(-1)">-</button>
                            <input type="number" name="quantity" id="productQuantity" class="qty-input" value="1" min="1" max="${PRODUCT.quantity > 0 ? PRODUCT.quantity : 1}" readonly>
                            <button type="button" class="qty-btn" onclick="changeQuantity(1)">+</button>
                        </div>

                        <!-- Add to Cart Button -->
                        <div class="flex-grow-1">
                            <c:choose>
                                <c:when test="${PRODUCT.quantity > 0}">
                                    <button type="submit" class="btn btn-add-to-cart w-100 d-flex align-items-center justify-content-center gap-2">
                                        <i class="fa-solid fa-cart-shopping"></i> THÊM VÀO GIỎ HÀNG
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="btn btn-secondary w-100 rounded-0 py-3 fw-bold text-uppercase" disabled>
                                        TẠM HẾT HÀNG
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Secondary Actions: Wishlist & Share -->
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-wishlist flex-grow-1 d-flex align-items-center justify-content-center gap-2" onclick="toggleWishlist(this)">
                            <i class="fa-regular fa-heart"></i> THÊM VÀO YÊU THÍCH
                        </button>
                        <button type="button" class="btn btn-wishlist px-3" onclick="copyProductLink()" title="Chia sẻ sản phẩm">
                            <i class="fa-solid fa-arrow-up-from-bracket"></i>
                        </button>
                    </div>
                </form>

                <!-- Store Availability Box -->
                <div class="border p-3 bg-light mb-4 small">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <strong class="text-uppercase text-dark"><i class="fa-solid fa-store me-1 text-danger"></i> Tình trạng tại cửa hàng</strong>
                        <span class="badge ${PRODUCT.quantity > 0 ? 'bg-success' : 'bg-danger'} rounded-0">
                            ${PRODUCT.quantity > 0 ? 'Còn hàng' : 'Hết hàng'}
                        </span>
                    </div>
                    <p class="text-muted mb-2" style="font-size: 0.8rem;">Bạn có thể kiểm tra tồn kho tại các showroom ONE61 Garment gần nhất.</p>
                    <a href="#" class="fw-bold text-dark text-decoration-underline" onclick="alert('Hệ thống cửa hàng ONE61 Garment: \n1. Vincom Đồng Khởi, Q.1, TP.HCM\n2. Vincom Bà Triệu, Hai Bà Trưng, Hà Nội'); return false;">
                        Chọn cửa hàng để xem kho &gt;
                    </a>
                </div>

                <!-- Product Details Accordion -->
                <div class="accordion uniqlo-accordion border-top border-bottom mb-4" id="productDetailsAccordion">
                    <!-- Overview -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOverview">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOverview" aria-expanded="true" aria-controls="collapseOverview">
                                TỔNG QUAN SẢN PHẨM
                            </button>
                        </h2>
                        <div id="collapseOverview" class="accordion-collapse collapse show" aria-labelledby="headingOverview">
                            <div class="accordion-body">
                                ${PRODUCT.description}
                                <ul class="mt-2 mb-0 ps-3">
                                    <li>Phong cách LifeWear tối giản chuẩn Nhật Bản, tôn vinh phom dáng người mặc.</li>
                                    <li>Độ bền cao, hạn chế nhăn xù sau nhiều lần giặt.</li>
                                    <li>Phù hợp mặc đi làm, đi chơi và hoạt động hàng ngày.</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Material & Care -->
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingMaterial">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseMaterial" aria-expanded="false" aria-controls="collapseMaterial">
                                CHẤT LIỆU & HƯỚNG DẪN BẢO QUẢN
                            </button>
                        </h2>
                        <div id="collapseMaterial" class="accordion-collapse collapse" aria-labelledby="headingMaterial">
                            <div class="accordion-body">
                                <strong>Chất liệu:</strong> 100% Cotton hữu cơ cao cấp dệt sợi compact thoáng khí.<br>
                                <strong>Hướng dẫn bảo quản:</strong>
                                <ul class="mt-1 mb-0 ps-3">
                                    <li>Giặt máy ở chế độ nhẹ nhàng với nước lạnh.</li>
                                    <li>Không dùng chất tẩy có chứa clo.</li>
                                    <li>Ủi ở nhiệt độ trung bình dưới 150°C.</li>
                                    <li>Phơi trong bóng râm, tránh ánh nắng trực tiếp.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Size Guide Modal -->
<div class="modal fade" id="sizeGuideModal" tabindex="-1" aria-labelledby="sizeGuideModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content rounded-0">
            <div class="modal-header border-bottom">
                <h5 class="modal-title fw-bold text-uppercase small" id="sizeGuideModalLabel">
                    <i class="fa-solid fa-ruler-combined me-2 text-danger"></i> BẢNG HƯỚNG DẪN CHỌN SIZE CHUẨN
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <table class="table table-bordered text-center small mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Size</th>
                            <th>Chiều cao (cm)</th>
                            <th>Cân nặng (kg)</th>
                            <th>Vòng ngực (cm)</th>
                            <th>Vòng eo (cm)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td><strong>XS</strong></td><td>150 - 160</td><td>40 - 48</td><td>76 - 82</td><td>60 - 66</td></tr>
                        <tr><td><strong>S</strong></td><td>155 - 165</td><td>48 - 55</td><td>80 - 88</td><td>64 - 72</td></tr>
                        <tr class="table-active"><td><strong>M</strong></td><td>160 - 172</td><td>55 - 65</td><td>86 - 94</td><td>70 - 78</td></tr>
                        <tr><td><strong>L</strong></td><td>168 - 178</td><td>65 - 75</td><td>92 - 100</td><td>76 - 84</td></tr>
                        <tr><td><strong>XL</strong></td><td>175 - 185</td><td>75 - 85</td><td>98 - 108</td><td>82 - 92</td></tr>
                        <tr><td><strong>XXL</strong></td><td>180 - 190</td><td>85 - 95</td><td>106 - 116</td><td>90 - 100</td></tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer border-top">
                <button type="button" class="btn btn-dark rounded-0 px-4 small fw-bold text-uppercase" data-bs-dismiss="modal">ĐÓNG</button>
            </div>
        </div>
    </div>
</div>

<script>
    function selectColor(colorName, el) {
        document.getElementById('selectedColorName').textContent = colorName;
        document.getElementById('inputColor').value = colorName;
        document.querySelectorAll('.color-swatch-btn').forEach(btn => btn.classList.remove('active'));
        el.classList.add('active');
    }

    function selectSize(sizeName, el) {
        document.getElementById('selectedSizeLabel').textContent = sizeName;
        document.getElementById('inputSize').value = sizeName;
        document.querySelectorAll('.size-btn').forEach(btn => btn.classList.remove('active'));
        el.classList.add('active');
    }

    function changeQuantity(delta) {
        const input = document.getElementById('productQuantity');
        let val = parseInt(input.value) || 1;
        const max = parseInt(input.max) || 99;
        val += delta;
        if (val < 1) val = 1;
        if (val > max) val = max;
        input.value = val;
    }

    function toggleWishlist(btn) {
        const icon = btn.querySelector('i');
        if (icon.classList.contains('fa-regular')) {
            icon.className = 'fa-solid fa-heart text-danger';
            btn.innerHTML = '<i class="fa-solid fa-heart text-danger"></i> ĐÃ THÊM VÀO YÊU THÍCH';
        } else {
            icon.className = 'fa-regular fa-heart';
            btn.innerHTML = '<i class="fa-regular fa-heart"></i> THÊM VÀO YÊU THÍCH';
        }
    }

    function copyProductLink() {
        navigator.clipboard.writeText(window.location.href).then(() => {
            alert('Đã sao chép liên kết sản phẩm vào bộ nhớ tạm!');
        });
    }
</script>

<jsp:include page="includes/footer.jsp" />
