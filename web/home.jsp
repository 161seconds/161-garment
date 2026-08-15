<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <jsp:include page="includes/header.jsp">
                <jsp:param name="transparentHeader" value="true" />
            </jsp:include>

            <!-- Full Width Edge-to-Edge Hero Video Carousel (100vw) Behind Transparent Header -->
            <div id="heroVideoCarousel" class="carousel slide carousel-fade position-relative w-100 overflow-hidden"
                data-bs-ride="carousel" data-bs-interval="12000"
                style="height: 85vh; min-height: 550px; max-height: 850px; background-color: #000; margin-top: 0;">
                <!-- Carousel Indicators (Uniqlo Minimalist Lines) -->
                <div class="carousel-indicators mb-4" style="z-index: 3;">
                    <button type="button" data-bs-target="#heroVideoCarousel" data-bs-slide-to="0" class="active"
                        aria-current="true" aria-label="Slide 1"
                        style="width: 35px; height: 3px; border-radius: 0;"></button>
                    <button type="button" data-bs-target="#heroVideoCarousel" data-bs-slide-to="1" aria-label="Slide 2"
                        style="width: 35px; height: 3px; border-radius: 0;"></button>
                </div>

                <!-- Carousel Items -->
                <div class="carousel-inner h-100">
                    <!-- Slide 1 -->
                    <div class="carousel-item active h-100 position-relative">
                        <video autoplay loop muted playsinline class="w-100 h-100"
                            style="object-fit: cover; object-position: center; display: block;">
                            <source src="${pageContext.request.contextPath}/img-prj301/uniqlo-video.mp4"
                                type="video/mp4">
                            <source src="${pageContext.request.contextPath}/uniqlo-video-01.mp4" type="video/mp4">
                            Trình duyệt của bạn không hỗ trợ video HTML5.
                        </video>
                        <!-- Bottom Left Overlay Slide 1 -->
                        <div class="position-absolute bottom-0 start-0 p-4 p-md-5 text-white"
                            style="z-index: 2; max-width: 650px; pointer-events: none;">
                            <span class="badge bg-black text-white px-3 py-1 text-uppercase mb-3 rounded-pill fw-bold"
                                style="font-size: 0.75rem; letter-spacing: 1px; border: 1px solid rgba(255,255,255,0.3); pointer-events: auto;">
                                TRENDING
                            </span>
                            <h1 class="fw-bold mb-2 text-uppercase text-white tracking-tight"
                                style="font-size: 2.3rem; letter-spacing: 0.5px; text-shadow: 0 2px 8px rgba(0,0,0,0.8);">
                                Bí Mật là? Quần Ống Cong Barrel.
                            </h1>
                            <p class="fs-6 mb-0 text-white"
                                style="text-shadow: 0 1px 6px rgba(0,0,0,0.9); line-height: 1.5; opacity: 0.95;">
                                Thiết kế bo tròn hiện đại, thoải mái khi vận động, dễ phối nhiều phong cách.
                            </p>
                        </div>
                    </div>

                    <!-- Slide 2 -->
                    <div class="carousel-item h-100 position-relative">
                        <video autoplay loop muted playsinline class="w-100 h-100"
                            style="object-fit: cover; object-position: center; display: block;">
                            <source src="${pageContext.request.contextPath}/img-prj301/uniqlo-video-02.mp4"
                                type="video/mp4">
                            <source src="${pageContext.request.contextPath}/uniqlo-video-02.mp4" type="video/mp4">
                            Trình duyệt của bạn không hỗ trợ video HTML5.
                        </video>
                        <!-- Bottom Left Overlay Slide 2 -->
                        <div class="position-absolute bottom-0 start-0 p-4 p-md-5 text-white"
                            style="z-index: 2; max-width: 650px; pointer-events: none;">
                            <span class="badge bg-danger text-white px-3 py-1 text-uppercase mb-3 rounded-pill fw-bold"
                                style="font-size: 0.75rem; letter-spacing: 1px; pointer-events: auto;">
                                NEW COLLECTION
                            </span>
                            <h1 class="fw-bold mb-2 text-uppercase text-white tracking-tight"
                                style="font-size: 2.3rem; letter-spacing: 0.5px; text-shadow: 0 2px 8px rgba(0,0,0,0.8);">
                                LifeWear 2026: Sắc Màu Mới.
                            </h1>
                            <p class="fs-6 mb-0 text-white"
                                style="text-shadow: 0 1px 6px rgba(0,0,0,0.9); line-height: 1.5; opacity: 0.95;">
                                Chất liệu cao cấp thoáng khí, chuẩn phom dáng cho cuộc sống năng động mỗi ngày.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Carousel Controls (Prev/Next Arrows) -->
                <button class="carousel-control-prev" type="button" data-bs-target="#heroVideoCarousel"
                    data-bs-slide="prev" style="width: 6%; z-index: 3;">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Trước</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#heroVideoCarousel"
                    data-bs-slide="next" style="width: 6%; z-index: 3;">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Tiếp</span>
                </button>
            </div>

            <!-- Re-open container for page content -->
            <div class="container my-5 flex-grow-1">

                <!-- Promo Strip -->
                <div
                    class="row g-2 mb-4 text-center small text-uppercase fw-bold text-muted border-top border-bottom py-2 bg-light">
                    <div class="col-md-4 py-1">
                        <i class="fa-solid fa-truck-fast text-danger me-1"></i> Miễn phí vận chuyển từ 499.000 đ
                    </div>
                    <div class="col-md-4 py-1">
                        <i class="fa-solid fa-rotate-left text-danger me-1"></i> Đổi trả dễ dàng trong 30 ngày
                    </div>
                    <div class="col-md-4 py-1">
                        <i class="fa-solid fa-shield-halved text-danger me-1"></i> Cam kết 100% chất lượng chính hãng
                    </div>
                </div>

                <div class="row mt-4">
                    <!-- Sidebar Categories -->
                    <div class="col-lg-3 col-md-4 mb-4">
                        <div class="sticky-top" style="top: 80px; z-index: 10;">
                            <div class="card border border-dark-subtle rounded-0 mb-4 bg-white">
                                <div class="card-header bg-dark text-white rounded-0 py-3">
                                    <h6 class="fw-bold m-0 text-uppercase tracking-wide">
                                        <i class="fa-solid fa-layer-group me-2 text-danger"></i> DANH MỤC SẢN PHẨM
                                    </h6>
                                </div>
                                <!-- All Products Link -->
                                <div class="border-bottom">
                                    <a href="product"
                                        class="d-flex justify-content-between align-items-center p-3 fw-bold text-decoration-none ${empty param.categoryID ? 'text-danger bg-light border-start border-danger border-4 ps-3' : 'text-dark'}">
                                        <span><i class="fa-solid fa-border-all me-2 text-muted"></i> TẤT CẢ SẢN
                                            PHẨM</span>
                                        <i class="fa-solid fa-chevron-right small text-muted"></i>
                                    </a>
                                </div>

                                <!-- Category Accordion -->
                                <div class="accordion accordion-flush" id="categoryAccordion">
                                    <!-- 1. MEN SECTION -->
                                    <div class="accordion-item rounded-0 border-bottom">
                                        <h2 class="accordion-header" id="headingMen">
                                            <button
                                                class="accordion-button rounded-0 fw-bold py-3 ${param.categoryID.startsWith('MEN') || param.categoryID eq 'CAT01' ? '' : 'collapsed'}"
                                                type="button" data-bs-toggle="collapse" data-bs-target="#collapseMen"
                                                aria-expanded="${param.categoryID.startsWith('MEN') || param.categoryID eq 'CAT01' ? 'true' : 'false'}"
                                                aria-controls="collapseMen" style="font-size: 0.9rem;">
                                                <i class="fa-solid fa-person me-2 text-danger"></i> THỜI TRANG NAM
                                            </button>
                                        </h2>
                                        <div id="collapseMen"
                                            class="accordion-collapse collapse ${param.categoryID.startsWith('MEN') || param.categoryID eq 'CAT01' ? 'show' : ''}"
                                            aria-labelledby="headingMen">
                                            <div class="list-group list-group-flush rounded-0 bg-light">
                                                <c:forEach var="cat" items="${CATEGORIES}">
                                                    <c:if
                                                        test="${cat.categoryID.startsWith('MEN') || cat.name.contains('Nam') || cat.categoryID eq 'CAT01'}">
                                                        <a href="product?categoryID=${cat.categoryID}"
                                                            class="list-group-item list-group-item-action border-0 py-2 ps-4 small fw-semibold bg-transparent ${param.categoryID eq cat.categoryID ? 'text-danger fw-bold ps-4 border-start border-danger border-3' : 'text-secondary'}">
                                                            <i class="fa-solid fa-angle-right me-2 text-muted"
                                                                style="font-size: 0.75rem;"></i> ${cat.name}
                                                        </a>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 2. WOMEN SECTION -->
                                    <div class="accordion-item rounded-0 border-bottom">
                                        <h2 class="accordion-header" id="headingWomen">
                                            <button
                                                class="accordion-button rounded-0 fw-bold py-3 ${param.categoryID.startsWith('WOMEN') || param.categoryID eq 'CAT02' || param.categoryID eq 'CAT03' ? '' : 'collapsed'}"
                                                type="button" data-bs-toggle="collapse" data-bs-target="#collapseWomen"
                                                aria-expanded="${param.categoryID.startsWith('WOMEN') || param.categoryID eq 'CAT02' || param.categoryID eq 'CAT03' ? 'true' : 'false'}"
                                                aria-controls="collapseWomen" style="font-size: 0.9rem;">
                                                <i class="fa-solid fa-person-dress me-2 text-danger"></i> THỜI TRANG NỮ
                                            </button>
                                        </h2>
                                        <div id="collapseWomen"
                                            class="accordion-collapse collapse ${param.categoryID.startsWith('WOMEN') || param.categoryID eq 'CAT02' || param.categoryID eq 'CAT03' ? 'show' : ''}"
                                            aria-labelledby="headingWomen">
                                            <div class="list-group list-group-flush rounded-0 bg-light">
                                                <c:forEach var="cat" items="${CATEGORIES}">
                                                    <c:if
                                                        test="${cat.categoryID.startsWith('WOMEN') || cat.name.contains('Nữ') || cat.categoryID eq 'CAT02' || cat.categoryID eq 'CAT03'}">
                                                        <a href="product?categoryID=${cat.categoryID}"
                                                            class="list-group-item list-group-item-action border-0 py-2 ps-4 small fw-semibold bg-transparent ${param.categoryID eq cat.categoryID ? 'text-danger fw-bold ps-4 border-start border-danger border-3' : 'text-secondary'}">
                                                            <i class="fa-solid fa-angle-right me-2 text-muted"
                                                                style="font-size: 0.75rem;"></i> ${cat.name}
                                                        </a>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 3. KIDS SECTION -->
                                    <div class="accordion-item rounded-0">
                                        <h2 class="accordion-header" id="headingKids">
                                            <button
                                                class="accordion-button rounded-0 fw-bold py-3 ${param.categoryID.startsWith('KIDS') || param.categoryID eq 'CAT04' ? '' : 'collapsed'}"
                                                type="button" data-bs-toggle="collapse" data-bs-target="#collapseKids"
                                                aria-expanded="${param.categoryID.startsWith('KIDS') || param.categoryID eq 'CAT04' ? 'true' : 'false'}"
                                                aria-controls="collapseKids" style="font-size: 0.9rem;">
                                                <i class="fa-solid fa-children me-2 text-danger"></i> TRẺ EM (KIDS)
                                            </button>
                                        </h2>
                                        <div id="collapseKids"
                                            class="accordion-collapse collapse ${param.categoryID.startsWith('KIDS') || param.categoryID eq 'CAT04' ? 'show' : ''}"
                                            aria-labelledby="headingKids">
                                            <div class="list-group list-group-flush rounded-0 bg-light">
                                                <c:forEach var="cat" items="${CATEGORIES}">
                                                    <c:if
                                                        test="${cat.categoryID.startsWith('KIDS') || cat.name.contains('Trẻ Em') || param.categoryID eq 'CAT04'}">
                                                        <a href="product?categoryID=${cat.categoryID}"
                                                            class="list-group-item list-group-item-action border-0 py-2 ps-4 small fw-semibold bg-transparent ${param.categoryID eq cat.categoryID ? 'text-danger fw-bold ps-4 border-start border-danger border-3' : 'text-secondary'}">
                                                            <i class="fa-solid fa-angle-right me-2 text-muted"
                                                                style="font-size: 0.75rem;"></i> ${cat.name}
                                                        </a>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Mini Promo Box -->
                            <div class="p-3 bg-light border text-center d-none d-md-block">
                                <h6 class="fw-bold text-uppercase text-danger mb-1">MEMBER DISCOUNT</h6>
                                <p class="small text-muted mb-2">Đăng ký thành viên để nhận ngay voucher giảm 10% cho
                                    đơn hàng đầu tiên!</p>
                                <a href="register"
                                    class="btn btn-outline-dark btn-sm rounded-0 fw-bold w-100 text-uppercase">Đăng ký
                                    ngay</a>
                            </div>
                        </div>
                    </div>

                    <!-- Product Grid -->
                    <div class="col-lg-9 col-md-8">
                        <!-- Success Alert -->
                        <c:if test="${not empty SUCCESS}">
                            <div class="alert alert-success alert-dismissible fade show rounded-0 mb-4" role="alert">
                                <i class="fa-solid fa-circle-check me-2"></i> ${SUCCESS}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Product Grid Header -->
                        <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                            <span class="fw-bold text-uppercase text-muted small">
                                Danh sách hiển thị: <strong class="text-dark">${PRODUCTS.size()} sản phẩm</strong>
                            </span>
                            <span class="small text-muted">
                                Trang <strong>${currentPage != null ? currentPage : 1}</strong> / ${endPage != null &&
                                endPage > 0 ? endPage : 1}
                            </span>
                        </div>

                        <div class="row row-cols-2 row-cols-md-3 row-cols-xl-3 g-3 justify-content-center">
                            <c:forEach var="p" items="${PRODUCTS}">
                                <div class="col">
                                    <div class="card h-100 border rounded-0 product-card bg-white position-relative">
                                        <!-- Product Image -->
                                        <a href="product?action=detail&id=${p.productID}"
                                            class="text-decoration-none d-block overflow-hidden">
                                            <div class="image-wrapper text-center p-3"
                                                style="background-color: #F8F8F8; height: 260px; display: flex; align-items: center; justify-content: center;">
                                                <img src="${pageContext.request.contextPath}/img-prj301/${p.image}"
                                                    class="card-img-top rounded-0" alt="${p.name}"
                                                    style="max-height: 100%; max-width: 100%; object-fit: contain; transition: transform 0.3s ease;">
                                            </div>
                                        </a>

                                        <!-- Product Body -->
                                        <div class="card-body p-3 d-flex flex-column">
                                            <span class="text-muted small text-uppercase"
                                                style="font-size: 0.7rem; letter-spacing: 0.5px;">161 Essentials</span>
                                            <h6 class="card-title fw-bold fs-6 mb-1 text-truncate mt-1">
                                                <a href="product?action=detail&id=${p.productID}"
                                                    class="text-dark text-decoration-none">${p.name}</a>
                                            </h6>
                                            <p class="card-text text-muted small mb-3 text-truncate"
                                                style="font-size: 0.8rem;">${p.description}</p>

                                            <div
                                                class="mt-auto pt-2 border-top d-flex justify-content-between align-items-center">
                                                <span class="fw-bold fs-6" style="color: var(--color-primary);">
                                                    <fmt:formatNumber value="${p.price}" pattern="#,###" /> đ
                                                </span>
                                                <a href="cart?action=add&id=${p.productID}"
                                                    class="btn btn-outline-dark btn-sm rounded-0 fw-bold px-2 py-1"
                                                    title="Thêm vào giỏ"
                                                    style="font-size: 0.75rem; text-transform: uppercase;">
                                                    <i class="fa-solid fa-cart-plus me-1"></i> Mua
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <c:if test="${empty PRODUCTS}">
                                <div class="col-12 py-5 text-center my-4 border">
                                    <i class="fa-solid fa-box-open fs-1 text-muted mb-2 d-block opacity-50"></i>
                                    <h5 class="text-muted fw-bold">Không tìm thấy sản phẩm nào!</h5>
                                    <p class="small text-muted mb-3">Vui lòng thử chọn danh mục khác hoặc quay lại sau.
                                    </p>
                                    <a href="product" class="btn btn-dark rounded-0 fw-bold px-4 btn-sm">Xem tất cả</a>
                                </div>
                            </c:if>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${endPage > 1}">
                            <div
                                class="d-flex flex-column flex-md-row justify-content-center align-items-center gap-3 mt-5 pb-3">
                                <!-- Page Navigation Controls -->
                                <nav aria-label="Page navigation">
                                    <ul class="pagination mb-0 rounded-0 gap-1">
                                        <!-- Prev Button -->
                                        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                            <a class="page-link rounded-0 fw-bold px-3 py-2 text-dark bg-white border"
                                                href="product?categoryID=${param.categoryID}&page=${currentPage - 1}"
                                                aria-label="Previous">
                                                <i class="fa-solid fa-chevron-left"></i>
                                            </a>
                                        </li>

                                        <!-- Page Numbers -->
                                        <c:forEach begin="1" end="${endPage}" var="i">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link rounded-0 fw-bold px-3 py-2 ${i == currentPage ? 'bg-danger border-danger text-white' : 'text-dark bg-white border'}"
                                                    href="product?categoryID=${param.categoryID}&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- Next Button -->
                                        <li class="page-item ${currentPage >= endPage ? 'disabled' : ''}">
                                            <a class="page-link rounded-0 fw-bold px-3 py-2 text-dark bg-white border"
                                                href="product?categoryID=${param.categoryID}&page=${currentPage + 1}"
                                                aria-label="Next">
                                                <i class="fa-solid fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>

                                <!-- Direct Page Jump Input -->
                                <form action="product" method="GET" class="d-flex align-items-center gap-2 small">
                                    <c:if test="${not empty param.categoryID}">
                                        <input type="hidden" name="categoryID" value="${param.categoryID}">
                                    </c:if>
                                    <span class="text-muted fw-semibold">Đến trang:</span>
                                    <input type="number" name="page" min="1" max="${endPage}" value="${currentPage}"
                                        class="form-control form-control-sm text-center rounded-0 border-dark-subtle fw-bold no-spin"
                                        style="width: 55px;" required>
                                    <button type="submit" class="btn btn-dark btn-sm rounded-0 fw-bold px-2 py-1"
                                        style="font-size: 0.8rem;">
                                        GO
                                    </button>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>

                <style>
                    .accordion-button:not(.collapsed) {
                        color: var(--color-primary);
                        background-color: #F8F8F8;
                        box-shadow: none;
                    }

                    .accordion-button:focus {
                        box-shadow: none;
                        border-color: rgba(0, 0, 0, .125);
                    }

                    .no-spin::-webkit-inner-spin-button,
                    .no-spin::-webkit-outer-spin-button {
                        -webkit-appearance: none;
                        margin: 0;
                    }

                    .no-spin {
                        -moz-appearance: textfield;
                        appearance: textfield;
                    }

                    .product-card {
                        transition: border-color 0.2s ease, box-shadow 0.2s ease;
                    }

                    .product-card:hover {
                        border-color: #111111 !important;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
                    }

                    .product-card:hover img {
                        transform: scale(1.04);
                    }
                </style>

                <jsp:include page="includes/footer.jsp" />