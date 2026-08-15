<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <jsp:include page="includes/header.jsp">
                <jsp:param name="transparentHeader" value="true" />
            </jsp:include>

            <!-- Full Width Edge-to-Edge Hero Video Carousel (100vw) Behind Transparent Header -->
            <div id="heroVideoCarousel" class="carousel slide carousel-fade position-relative w-100 overflow-hidden"
                data-bs-ride="carousel" data-bs-interval="12000"
                style="height: 100vh; min-height: 100vh; background-color: #000; margin-top: 0;">
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

            <!-- Featured Category Collections Showcase (4 Visual Lookbook Cards) -->
            <section class="container my-5 pt-3">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end mb-4 pb-2 border-bottom">
                    <div>
                        <span class="badge bg-danger rounded-0 px-2 py-1 text-uppercase fw-bold mb-2" style="font-size: 0.68rem; letter-spacing: 1px;">LIFEWEAR COLLECTIONS</span>
                        <h2 class="fw-bold text-uppercase m-0 tracking-tight" style="font-size: 1.75rem;">DANH MỤC NỔI BẬT</h2>
                        <p class="text-muted small mb-0 mt-1">Khám phá các phong cách trang phục tối giản chuẩn Nhật Bản được yêu thích nhất.</p>
                    </div>
                    <a href="product" class="btn btn-outline-dark btn-sm rounded-0 fw-bold text-uppercase mt-3 mt-md-0 px-3" style="font-size: 0.75rem;">
                        Xem toàn bộ danh mục <i class="fa-solid fa-arrow-right ms-1"></i>
                    </a>
                </div>

                <div class="row g-3 g-lg-4">
                    <!-- 1. WOMEN COLLECTION -->
                    <div class="col-6 col-lg-3">
                        <a href="product?categoryID=WOMEN_03" class="one61-category-card">
                            <div class="category-img-box">
                                <img src="${pageContext.request.contextPath}/img-prj301/ao-khoac-01.avif" alt="Thời Trang Nữ" class="category-img">
                                <span class="category-floating-badge">BST NỮ 2026</span>
                            </div>
                            <div class="category-info-box">
                                <h5 class="category-title">THỜI TRANG NỮ</h5>
                                <p class="category-subtitle">Thanh lịch, dịu mát & tôn dáng tối ưu</p>
                                <div class="category-action-link">
                                    <span>Khám phá ngay</span>
                                    <i class="fa-solid fa-arrow-right"></i>
                                </div>
                            </div>
                        </a>
                    </div>

                    <!-- 2. MEN COLLECTION -->
                    <div class="col-6 col-lg-3">
                        <a href="product?categoryID=MEN_03" class="one61-category-card">
                            <div class="category-img-box">
                                <img src="${pageContext.request.contextPath}/img-prj301/ao-khoac-03.avif" alt="Thời Trang Nam" class="category-img">
                                <span class="category-floating-badge">BST NAM 2026</span>
                            </div>
                            <div class="category-info-box">
                                <h5 class="category-title">THỜI TRANG NAM</h5>
                                <p class="category-subtitle">Phóng khoáng, chỉn chu & năng động</p>
                                <div class="category-action-link">
                                    <span>Khám phá ngay</span>
                                    <i class="fa-solid fa-arrow-right"></i>
                                </div>
                            </div>
                        </a>
                    </div>

                    <!-- 3. KIDS COLLECTION -->
                    <div class="col-6 col-lg-3">
                        <a href="product?categoryID=KIDS_02" class="one61-category-card">
                            <div class="category-img-box">
                                <img src="${pageContext.request.contextPath}/img-prj301/ao-khoac-06.avif" alt="Thời Trang Trẻ Em" class="category-img">
                                <span class="category-floating-badge">TRẺ EM (KIDS)</span>
                            </div>
                            <div class="category-info-box">
                                <h5 class="category-title">TRẺ EM</h5>
                                <p class="category-subtitle">Chất liệu 100% an toàn, mềm mại</p>
                                <div class="category-action-link">
                                    <span>Khám phá ngay</span>
                                    <i class="fa-solid fa-arrow-right"></i>
                                </div>
                            </div>
                        </a>
                    </div>

                    <!-- 4. BARREL PANTS / OUTERWEAR -->
                    <div class="col-6 col-lg-3">
                        <a href="product?categoryID=WOMEN_04" class="one61-category-card">
                            <div class="category-img-box">
                                <img src="${pageContext.request.contextPath}/img-prj301/quan-dai-01.avif" alt="Quần Barrel & Dài" class="category-img">
                                <span class="category-floating-badge" style="background-color: var(--color-primary, #ED1D24);">HOT TREND</span>
                            </div>
                            <div class="category-info-box">
                                <h5 class="category-title">QUẦN BARREL</h5>
                                <p class="category-subtitle">Thiết kế phom cong thời thượng</p>
                                <div class="category-action-link">
                                    <span>Khám phá ngay</span>
                                    <i class="fa-solid fa-arrow-right"></i>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </section>

            <!-- Re-open container for page content -->
            <div class="container mb-5 flex-grow-1" id="storeSection">
                <!-- UNIQLO-Style Visual Category Icons Showcase Section -->
                <div class="uniqlo-category-section shadow-sm rounded-0 mb-4">
                    <!-- Category Group Tabs -->
                    <div class="category-tab-nav">
                        <a href="home?categoryID=WOMEN_01#storeSection" class="category-tab-btn ${param.categoryID.startsWith('WOMEN') ? 'active' : ''}">NỮ (WOMEN)</a>
                        <a href="home?categoryID=MEN_01#storeSection" class="category-tab-btn ${param.categoryID.startsWith('MEN') || empty param.categoryID ? 'active' : ''}">NAM (MEN)</a>
                        <a href="home?categoryID=KIDS_01#storeSection" class="category-tab-btn ${param.categoryID.startsWith('KIDS') ? 'active' : ''}">TRẺ EM (KIDS)</a>
                    </div>

                    <!-- Category Icons Grid -->
                    <div class="uniqlo-category-grid">
                        <c:choose>
                            <c:when test="${param.categoryID.startsWith('WOMEN')}">
                                <!-- WOMEN CATEGORIES -->
                                <a href="product?categoryID=WOMEN_01" class="uniqlo-cat-item ${param.categoryID eq 'WOMEN_01' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/women/t-shirt-icon-women.avif" alt="Áo Thun Nữ">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Thun & Nỉ</span>
                                </a>
                                <a href="product?categoryID=WOMEN_02" class="uniqlo-cat-item ${param.categoryID eq 'WOMEN_02' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/women/shirt-and-blouses-icon-women.avif" alt="Áo Sơ Mi & Blouse">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Sơ Mi & Blouse</span>
                                </a>
                                <a href="product?categoryID=WOMEN_03" class="uniqlo-cat-item ${param.categoryID eq 'WOMEN_03' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/women/sweaters-icon-women.avif" alt="Áo Len & Cardigan">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Len</span>
                                </a>
                                <a href="product?categoryID=WOMEN_03" class="uniqlo-cat-item">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/women/outerwear-icon-women.avif" alt="Áo Khoác Nữ">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Khoác</span>
                                </a>
                                <a href="product?categoryID=WOMEN_04" class="uniqlo-cat-item ${param.categoryID eq 'WOMEN_04' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/women/bottom-icon-women.jpg" alt="Quần & Váy">
                                    </div>
                                    <span class="uniqlo-cat-title">Quần & Váy</span>
                                </a>
                                <a href="product?categoryID=WOMEN_04" class="uniqlo-cat-item">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/women/shorts-and-culottes-icon.avif" alt="Shorts & Culottes">
                                    </div>
                                    <span class="uniqlo-cat-title">Shorts & Culottes</span>
                                </a>
                            </c:when>

                            <c:when test="${param.categoryID.startsWith('KIDS')}">
                                <!-- KIDS CATEGORIES -->
                                <a href="product?categoryID=KIDS_01" class="uniqlo-cat-item ${param.categoryID eq 'KIDS_01' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/kids/t-shirt-icon-kids.avif" alt="Áo Thun Trẻ Em">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Thun</span>
                                </a>
                                <a href="product?categoryID=KIDS_01" class="uniqlo-cat-item">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/kids/shirts-icon-kids.avif" alt="Áo Sơ Mi Trẻ Em">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Sơ Mi</span>
                                </a>
                                <a href="product?categoryID=KIDS_02" class="uniqlo-cat-item ${param.categoryID eq 'KIDS_02' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/kids/outerwear-icon-kids.avif" alt="Áo Khoác Trẻ Em">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Khoác</span>
                                </a>
                                <a href="product?categoryID=KIDS_03" class="uniqlo-cat-item ${param.categoryID eq 'KIDS_03' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/kids/dresses-icon-kids.avif" alt="Đầm & Váy">
                                    </div>
                                    <span class="uniqlo-cat-title">Đầm & Váy</span>
                                </a>
                                <a href="product?categoryID=KIDS_03" class="uniqlo-cat-item">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/kids/bottoms-icon-kids.avif" alt="Quần Dài Trẻ Em">
                                    </div>
                                    <span class="uniqlo-cat-title">Quần Dài</span>
                                </a>
                                <a href="product?categoryID=KIDS_03" class="uniqlo-cat-item">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/kids/shorts-kids.avif" alt="Quần Shorts Trẻ Em">
                                    </div>
                                    <span class="uniqlo-cat-title">Quần Shorts</span>
                                </a>
                            </c:when>

                            <c:otherwise>
                                <!-- MEN CATEGORIES (Default) -->
                                <a href="product?categoryID=MEN_01" class="uniqlo-cat-item ${param.categoryID eq 'MEN_01' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/men/t-shirt-icon-men.avif" alt="Áo Thun">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Thun & Nỉ</span>
                                </a>
                                <a href="product?categoryID=MEN_01" class="uniqlo-cat-item">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/men/polos-icon-men.avif" alt="Áo Polo">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Polo</span>
                                </a>
                                <a href="product?categoryID=MEN_02" class="uniqlo-cat-item ${param.categoryID eq 'MEN_02' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/men/shirts-icon-men.avif" alt="Áo Sơ Mi">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Sơ Mi</span>
                                </a>
                                <a href="product?categoryID=MEN_03" class="uniqlo-cat-item ${param.categoryID eq 'MEN_03' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/men/sweaters-icon-men.avif" alt="Áo Len & Cardigan">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Len</span>
                                </a>
                                <a href="product?categoryID=MEN_03" class="uniqlo-cat-item">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/men/outerwear-icon-men.avif" alt="Áo Khoác">
                                    </div>
                                    <span class="uniqlo-cat-title">Áo Khoác</span>
                                </a>
                                <a href="product?categoryID=MEN_04" class="uniqlo-cat-item ${param.categoryID eq 'MEN_04' ? 'fw-bold text-danger' : ''}">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/men/pants-men.avif" alt="Quần Dài">
                                    </div>
                                    <span class="uniqlo-cat-title">Quần Dài</span>
                                </a>
                                <a href="product?categoryID=MEN_04" class="uniqlo-cat-item">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/men/jeans-men.png" alt="Quần Jeans">
                                    </div>
                                    <span class="uniqlo-cat-title">Quần Jeans</span>
                                </a>
                                <a href="product?categoryID=MEN_04" class="uniqlo-cat-item">
                                    <div class="uniqlo-cat-thumb">
                                        <img src="${pageContext.request.contextPath}/img-prj301/categories/men/short-men.avif" alt="Quần Shorts">
                                    </div>
                                    <span class="uniqlo-cat-title">Quần Shorts</span>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>


                <div class="row mt-4">
                    <div class="col-12">
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

                        <div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-lg-5 row-cols-xl-5 g-3 g-md-4 justify-content-center">
                            <c:forEach var="p" items="${PRODUCTS}">
                                <div class="col">
                                    <div class="card h-100 one61-catalog-card rounded-0">
                                        <!-- Full-Bleed Product Image -->
                                        <div class="one61-img-box">
                                            <a href="product?action=detail&id=${p.productID}">
                                                <img src="${pageContext.request.contextPath}/img-prj301/${p.image}"
                                                    alt="${p.name}"
                                                    onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=600&auto=format&fit=crop&q=80';">
                                            </a>
                                            <!-- Badge -->
                                            <div class="position-absolute top-0 start-0 m-2" style="z-index: 4;">
                                                <span class="badge bg-danger rounded-0 px-2 py-1 text-uppercase" style="font-size: 0.65rem; letter-spacing: 0.5px;">NEW</span>
                                            </div>
                                        </div>

                                        <!-- Product Body -->
                                        <div class="card-body p-3 d-flex flex-column">
                                            <span class="text-muted small text-uppercase font-monospace"
                                                style="font-size: 0.68rem; letter-spacing: 0.5px;">ONE61 ESSENTIALS</span>
                                            <h6 class="card-title fw-bold fs-6 mb-1 text-truncate mt-1">
                                                <a href="product?action=detail&id=${p.productID}"
                                                    class="text-dark text-decoration-none">${p.name}</a>
                                            </h6>
                                            <p class="card-text text-muted small mb-3 text-truncate"
                                                style="font-size: 0.8rem;">${p.description}</p>

                                            <div
                                                class="mt-auto pt-2 border-top d-flex justify-content-between align-items-center">
                                                <span class="fw-bold fs-6" style="color: var(--color-primary); font-family: 'Be Vietnam Pro', sans-serif;">
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