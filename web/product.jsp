<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    if (request.getAttribute("PRODUCTS") == null) {
        String qs = request.getQueryString();
        response.sendRedirect(request.getContextPath() + "/product" + (qs != null ? "?" + qs : ""));
        return;
    }
%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Tất Cả Sản Phẩm | ONE61 Garmentory" />
</jsp:include>

<!-- Custom Styling for Catalog -->
<style>
    /* Product Card Luxury Aesthetics */
    .one61-catalog-card {
        border: 1px solid #E5E5E5;
        background: #ffffff;
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        position: relative;
    }
    .one61-catalog-card:hover {
        border-color: #111111;
        box-shadow: 0 12px 30px rgba(0,0,0,0.08);
        transform: translateY(-3px);
    }
    .one61-img-box {
        position: relative;
        overflow: hidden;
        background-color: #f7f7f7;
        padding-top: 115%; /* 3:3.5 Fashion Aspect Ratio */
    }
    .one61-img-box img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s cubic-bezier(0.16, 1, 0.3, 1);
    }
    .one61-catalog-card:hover .one61-img-box img {
        transform: scale(1.05);
    }
    .card-quick-actions {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        padding: 10px;
        background: linear-gradient(to top, rgba(0,0,0,0.6), transparent);
        transform: translateY(100%);
        opacity: 0;
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        display: flex;
        gap: 6px;
        z-index: 5;
    }
    .one61-catalog-card:hover .card-quick-actions {
        transform: translateY(0);
        opacity: 1;
    }
    .btn-quick-view {
        background: #ffffff;
        color: #111111;
        font-weight: 700;
        font-size: 0.75rem;
        letter-spacing: 0.5px;
        border-radius: 0;
        flex-grow: 1;
        padding: 8px 12px;
        text-transform: uppercase;
        border: none;
        transition: all 0.2s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }
    .btn-quick-view:hover {
        background: #111111;
        color: #ffffff;
    }
    .btn-quick-add {
        background: var(--color-primary, #ED1D24);
        color: #ffffff;
        border: none;
        border-radius: 0;
        padding: 8px 14px;
        font-size: 0.85rem;
        cursor: pointer;
        transition: background 0.2s ease;
    }
    .btn-quick-add:hover {
        background: #c7141a;
    }
    .floating-wishlist-btn {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 32px;
        height: 32px;
        background: rgba(255,255,255,0.9);
        border: 1px solid rgba(0,0,0,0.1);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #111111;
        cursor: pointer;
        z-index: 6;
        transition: all 0.2s ease;
    }
    .floating-wishlist-btn:hover {
        background: #ffffff;
        color: #ED1D24;
        transform: scale(1.1);
    }
    .color-swatch-dot {
        width: 10px;
        height: 10px;
        border-radius: 50%;
        display: inline-block;
        border: 1px solid rgba(0,0,0,0.15);
    }
    /* Sidebar Navigation Link */
    .sidebar-cate-link {
        padding: 10px 14px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        color: #333333;
        text-decoration: none;
        font-size: 0.88rem;
        font-weight: 600;
        transition: all 0.2s ease;
        border-left: 3px solid transparent;
    }
    .sidebar-cate-link:hover {
        background-color: #F8F9FA;
        color: #ED1D24;
        border-left-color: #ED1D24;
    }
    /* Uniqlo Category Icons Clean Flat Aesthetics (No Lifting) */
    .uniqlo-category-section {
        background-color: #FFFFFF;
        border-bottom: 1px solid #EEEEEE;
        padding: 1.25rem 0 1.5rem;
        margin-bottom: 2rem;
    }
    .category-tab-btn {
        font-family: 'Be Vietnam Pro', sans-serif;
        font-weight: 800;
        font-size: 1rem;
        text-transform: uppercase;
        letter-spacing: 0.8px;
        color: #888888;
        background: none;
        border: none;
        padding: 0.35rem 0.6rem;
        cursor: pointer;
        position: relative;
        transition: color 0.2s ease;
        text-decoration: none !important;
        white-space: nowrap;
        display: inline-block;
    }
    .category-tab-btn:hover {
        color: #111111;
    }
    .category-tab-btn.active {
        color: #111111;
        font-weight: 900;
    }
    .category-tab-btn.active::after {
        content: '';
        position: absolute;
        bottom: -0.95rem;
        left: 0;
        width: 100%;
        height: 3px;
        background-color: #111111;
    }
    .uniqlo-category-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(110px, 1fr));
        gap: 1.5rem 0.75rem;
        justify-items: center;
        align-items: start;
    }
    .uniqlo-cat-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        text-decoration: none !important;
        color: #111111 !important;
        padding: 0.5rem 0.25rem;
        background: transparent !important;
        width: 100%;
        max-width: 135px;
        cursor: pointer;
        position: relative;
        transition: none;
    }
    .uniqlo-cat-item:hover {
        transform: none !important;
        background: transparent !important;
        box-shadow: none !important;
    }
    .uniqlo-cat-thumb {
        width: 90px;
        height: 90px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 0.65rem;
        background: transparent !important;
        border-radius: 0 !important;
        padding: 0 !important;
    }
    .uniqlo-cat-thumb img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
        transition: transform 0.25s ease, opacity 0.25s ease;
    }
    .uniqlo-cat-item:hover .uniqlo-cat-thumb img {
        transform: scale(1.06);
        opacity: 0.88;
    }
    .uniqlo-cat-title {
        font-family: 'Be Vietnam Pro', sans-serif;
        font-size: 0.84rem;
        font-weight: 700;
        line-height: 1.3;
        color: #222222;
        margin: 0;
        transition: color 0.2s ease;
        letter-spacing: -0.2px;
    }
    .uniqlo-cat-item:hover .uniqlo-cat-title,
    .uniqlo-cat-item.active-item .uniqlo-cat-title {
        color: var(--color-primary, #ED1D24) !important;
        text-decoration: underline;
    }
</style>

<!-- Breadcrumb Navigation -->
<div class="bg-white border-bottom py-2">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0 small text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px;">
                <li class="breadcrumb-item"><a href="home" class="text-secondary text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="product" class="text-secondary text-decoration-none">Sản phẩm</a></li>
                <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">
                    <c:choose>
                        <c:when test="${not empty param.categoryID}">
                            <c:forEach var="c" items="${CATEGORIES}">
                                <c:if test="${c.categoryID eq param.categoryID}">${c.name}</c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>TẤT CẢ SẢN PHẨM</c:otherwise>
                    </c:choose>
                </li>
            </ol>
        </nav>
    </div>
</div>

<!-- Main Catalog Container -->
<div class="container my-4 flex-grow-1" id="catalogSection">
    <!-- Header Banner -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center pb-3 mb-4 border-bottom gap-3">
        <div>
            <c:choose>
                <c:when test="${not empty param.keyword}">
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <span class="badge bg-danger rounded-0 px-2 py-1 text-uppercase" style="font-size: 0.7rem; letter-spacing: 0.5px;">TÌM KIẾM</span>
                        <span class="text-muted small">Từ khóa: "<strong>${param.keyword}</strong>"</span>
                    </div>
                    <h2 class="fw-bold text-uppercase tracking-tight m-0" style="font-family: 'Outfit', sans-serif;">
                        KẾT QUẢ TÌM KIẾM (${totalProducts != null ? totalProducts : PRODUCTS.size()})
                    </h2>
                    <p class="text-muted small m-0 mt-1">
                        Hiển thị các sản phẩm phù hợp với từ khóa "<strong>${param.keyword}</strong>". 
                        <a href="product" class="text-danger text-decoration-none fw-bold ms-2"><i class="fa-solid fa-xmark me-1"></i>Xóa bộ lọc tìm kiếm</a>
                    </p>
                </c:when>
                <c:otherwise>
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <span class="badge bg-danger rounded-0 px-2 py-1 text-uppercase" style="font-size: 0.7rem; letter-spacing: 0.5px;">ONE61 LifeWear</span>
                        <span class="text-muted small">Bộ sưu tập 2026</span>
                    </div>
                    <h2 class="fw-bold text-uppercase tracking-tight m-0" style="font-family: 'Outfit', sans-serif;">
                        <c:choose>
                            <c:when test="${not empty param.categoryID}">
                                <c:forEach var="c" items="${CATEGORIES}">
                                    <c:if test="${c.categoryID eq param.categoryID}">${c.name}</c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>TẤT CẢ SẢN PHẨM</c:otherwise>
                        </c:choose>
                    </h2>
                    <p class="text-muted small m-0 mt-1">Trang phục tối giản, thiết kế tinh tế với chất liệu sợi dệt cao cấp chuẩn Nhật Bản.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="d-flex align-items-center gap-3">
            <span class="small text-muted text-nowrap">
                Hiển thị: <strong class="text-dark">${PRODUCTS.size()}</strong> sản phẩm
            </span>
            <div class="dropdown">
                <button class="btn btn-sm rounded-0 dropdown-toggle fw-semibold px-3 border border-dark bg-white text-dark shadow-none" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 0.8rem;">
                    <i class="fa-solid fa-arrow-down-short-wide me-1 text-secondary"></i> 
                    <c:choose>
                        <c:when test="${param.sort eq 'price-asc'}"><span class="text-danger fw-bold">Giá: Thấp đến Cao</span></c:when>
                        <c:when test="${param.sort eq 'price-desc'}"><span class="text-danger fw-bold">Giá: Cao đến Thấp</span></c:when>
                        <c:when test="${param.sort eq 'newest'}"><span class="text-danger fw-bold">Mới nhất</span></c:when>
                        <c:when test="${param.sort eq 'popular'}"><span class="text-danger fw-bold">Bán chạy nhất</span></c:when>
                        <c:otherwise>Sắp xếp</c:otherwise>
                    </c:choose>
                </button>
                <ul class="dropdown-menu dropdown-menu-end rounded-0 shadow-sm border border-dark-subtle py-1" style="min-width: 190px;">
                    <li>
                        <a class="dropdown-item small d-flex align-items-center justify-content-between py-2 ${param.sort eq 'newest' ? 'fw-bold text-danger bg-light' : 'text-dark'}" 
                           href="product?sort=newest${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                            <span>Mới nhất</span>
                            <c:if test="${param.sort eq 'newest'}"><i class="fa-solid fa-check text-danger ms-2"></i></c:if>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item small d-flex align-items-center justify-content-between py-2 ${param.sort eq 'price-asc' ? 'fw-bold text-danger bg-light' : 'text-dark'}" 
                           href="product?sort=price-asc${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                            <span>Giá: Thấp đến Cao</span>
                            <c:if test="${param.sort eq 'price-asc'}"><i class="fa-solid fa-check text-danger ms-2"></i></c:if>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item small d-flex align-items-center justify-content-between py-2 ${param.sort eq 'price-desc' ? 'fw-bold text-danger bg-light' : 'text-dark'}" 
                           href="product?sort=price-desc${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                            <span>Giá: Cao đến Thấp</span>
                            <c:if test="${param.sort eq 'price-desc'}"><i class="fa-solid fa-check text-danger ms-2"></i></c:if>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item small d-flex align-items-center justify-content-between py-2 ${param.sort eq 'popular' ? 'fw-bold text-danger bg-light' : 'text-dark'}" 
                           href="product?sort=popular${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                            <span>Bán chạy nhất</span>
                            <c:if test="${param.sort eq 'popular'}"><i class="fa-solid fa-check text-danger ms-2"></i></c:if>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Alert Notifications -->
    <c:if test="${not empty sessionScope.SUCCESS_MSG}">
        <div class="alert alert-success alert-dismissible fade show rounded-0 small py-2 d-flex align-items-center mb-4" role="alert">
            <i class="fa-solid fa-circle-check me-2 fs-5"></i>
            <div>${sessionScope.SUCCESS_MSG}</div>
            <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="SUCCESS_MSG" scope="session" />
    </c:if>

    <!-- UNIQLO-Style Visual Category Icons Showcase Section -->
    <div class="uniqlo-category-section shadow-sm rounded-0 mb-4">
        <!-- Category Group Tabs -->
        <div class="category-tab-nav">
            <a href="product?categoryID=WOMEN_01" class="category-tab-btn ${param.categoryID.startsWith('WOMEN') ? 'active' : ''}">NỮ (WOMEN)</a>
            <a href="product?categoryID=MEN_01" class="category-tab-btn ${param.categoryID.startsWith('MEN') || empty param.categoryID ? 'active' : ''}">NAM (MEN)</a>
        </div>

        <!-- Category Icons Grid -->
        <div class="uniqlo-category-grid">
            <c:choose>
                <c:when test="${param.categoryID.startsWith('WOMEN')}">
                    <!-- WOMEN CATEGORIES -->
                    <a href="product?categoryID=WOMEN_01" class="uniqlo-cat-item ${param.categoryID eq 'WOMEN_01' ? 'fw-bold text-danger' : ''}">
                        <div class="uniqlo-cat-thumb">
                            <img src="${pageContext.request.contextPath}/img-prj301/categories/women/shirt-and-blouses-icon-women.avif" alt="Áo Sơ Mi & Blouse">
                        </div>
                        <span class="uniqlo-cat-title">Sơ Mi & Blouse</span>
                    </a>
                    <a href="product?categoryID=WOMEN_02" class="uniqlo-cat-item ${param.categoryID eq 'WOMEN_02' ? 'fw-bold text-danger' : ''}">
                        <div class="uniqlo-cat-thumb">
                            <img src="${pageContext.request.contextPath}/img-prj301/categories/women/outerwear-icon-women.avif" alt="Áo Khoác Nữ">
                        </div>
                        <span class="uniqlo-cat-title">Áo Khoác</span>
                    </a>
                    <a href="product?categoryID=WOMEN_03" class="uniqlo-cat-item ${param.categoryID eq 'WOMEN_03' ? 'fw-bold text-danger' : ''}">
                        <div class="uniqlo-cat-thumb">
                            <img src="${pageContext.request.contextPath}/img-prj301/categories/women/bottom-icon-women.jpg" alt="Quần & Váy">
                        </div>
                        <span class="uniqlo-cat-title">Quần & Váy</span>
                    </a>
                    <a href="product?categoryID=WOMEN_04" class="uniqlo-cat-item ${param.categoryID eq 'WOMEN_04' ? 'fw-bold text-danger' : ''}">
                        <div class="uniqlo-cat-thumb">
                            <img src="${pageContext.request.contextPath}/img-prj301/categories/women/shorts-and-culottes-icon.avif" alt="Shorts & Culottes">
                        </div>
                        <span class="uniqlo-cat-title">Shorts & Culottes</span>
                    </a>
                </c:when>

                <c:otherwise>
                    <!-- MEN CATEGORIES (Default) -->
                    <a href="product?categoryID=MEN_01" class="uniqlo-cat-item ${param.categoryID eq 'MEN_01' || empty param.categoryID ? 'fw-bold text-danger' : ''}">
                        <div class="uniqlo-cat-thumb">
                            <img src="${pageContext.request.contextPath}/img-prj301/categories/men/shirts-icon-men.avif" alt="Áo Sơ Mi">
                        </div>
                        <span class="uniqlo-cat-title">Áo Sơ Mi</span>
                    </a>
                    <a href="product?categoryID=MEN_02" class="uniqlo-cat-item ${param.categoryID eq 'MEN_02' ? 'fw-bold text-danger' : ''}">
                        <div class="uniqlo-cat-thumb">
                            <img src="${pageContext.request.contextPath}/img-prj301/categories/men/outerwear-icon-men.avif" alt="Áo Khoác">
                        </div>
                        <span class="uniqlo-cat-title">Áo Khoác</span>
                    </a>
                    <a href="product?categoryID=MEN_03" class="uniqlo-cat-item ${param.categoryID eq 'MEN_03' ? 'fw-bold text-danger' : ''}">
                        <div class="uniqlo-cat-thumb">
                            <img src="${pageContext.request.contextPath}/img-prj301/categories/men/pants-men.avif" alt="Quần Dài">
                        </div>
                        <span class="uniqlo-cat-title">Quần Dài</span>
                    </a>
                    <a href="product?categoryID=MEN_04" class="uniqlo-cat-item ${param.categoryID eq 'MEN_04' ? 'fw-bold text-danger' : ''}">
                        <div class="uniqlo-cat-thumb">
                            <img src="${pageContext.request.contextPath}/img-prj301/categories/men/jeans-men.png" alt="Quần Jeans">
                        </div>
                        <span class="uniqlo-cat-title">Quần Jeans</span>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="row g-4">
        <!-- Full Width Products Catalog Grid (5 Columns) -->
        <div class="col-12">
            <c:choose>
                <c:when test="${empty PRODUCTS}">
                    <div class="text-center py-5 bg-white border border-dark-subtle p-5">
                        <i class="fa-solid fa-box-open text-muted display-3 mb-3"></i>
                        <h4 class="fw-bold text-uppercase text-secondary">Không có sản phẩm nào</h4>
                        <p class="text-muted small">Hiện chưa có sản phẩm nào thuộc danh mục này hoặc đang được cập nhật.</p>
                        <a href="product" class="btn btn-dark rounded-0 px-4 py-2 text-uppercase fw-bold small mt-2">
                            Xem tất cả sản phẩm
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Products Grid (5 Columns) -->
                    <div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-lg-5 row-cols-xl-5 g-3 g-md-4">
                        <c:forEach var="p" items="${PRODUCTS}">
                            <div class="col">
                                <div class="card h-100 one61-catalog-card rounded-0">
                                    <!-- Image Container -->
                                    <div class="one61-img-box">
                                        <a href="product?action=detail&id=${p.productID}">
                                            <img src="${pageContext.request.contextPath}/img-prj301/${p.image}"
                                                 alt="${p.name}"
                                                 onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=600&auto=format&fit=crop&q=80';">
                                        </a>

                                        <!-- Top Status Badge -->
                                        <div class="position-absolute top-0 start-0 m-2 d-flex flex-column gap-1" style="z-index: 4;">
                                            <span class="badge bg-danger rounded-0 px-2 py-1 text-uppercase" style="font-size: 0.65rem; letter-spacing: 0.5px;">NEW</span>
                                            <c:if test="${p.quantity le 5}">
                                                <span class="badge bg-warning text-dark rounded-0 px-2 py-1 text-uppercase" style="font-size: 0.65rem;">SẮP HẾT</span>
                                            </c:if>
                                        </div>

                                        <!-- Floating Wishlist Button -->
                                        <button type="button" class="floating-wishlist-btn"
                                                onclick="toggleQuickWishlist('${p.productID}', '${p.name}', '${p.price}', '${pageContext.request.contextPath}/img-prj301/${p.image}', this)"
                                                title="Lưu vào Yêu thích">
                                            <i class="fa-regular fa-heart" style="font-size: 0.85rem;"></i>
                                        </button>

                                        <!-- Quick Action Overlay on Hover -->
                                        <div class="card-quick-actions">
                                            <a href="product?action=detail&id=${p.productID}" class="btn-quick-view">
                                                <i class="fa-regular fa-eye me-1"></i> Xem chi tiết
                                            </a>
                                            <form action="cart" method="POST" class="m-0 d-inline">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="productID" value="${p.productID}">
                                                <input type="hidden" name="quantity" value="1">
                                                <button type="submit" class="btn-quick-add" title="Thêm vào giỏ">
                                                    <i class="fa-solid fa-cart-plus"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- Card Content -->
                                    <div class="card-body p-3 d-flex flex-column">
                                        <!-- Brand & Color dots -->
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="text-uppercase text-muted font-monospace" style="font-size: 0.68rem; letter-spacing: 0.5px;">ONE61 ESSENTIALS</span>
                                            <div class="d-flex gap-1">
                                                <span class="color-swatch-dot" style="background-color: #222;"></span>
                                                <span class="color-swatch-dot" style="background-color: #E8E5DF;"></span>
                                                <span class="color-swatch-dot" style="background-color: #8C2B2B;"></span>
                                            </div>
                                        </div>

                                        <!-- Product Title -->
                                        <h6 class="card-title fw-bold text-uppercase mb-1" style="font-size: 0.88rem; line-height: 1.35; height: 2.7em; overflow: hidden; display: -webkit-box; line-clamp: 2; -webkit-box-orient: vertical;">
                                            <a href="product?action=detail&id=${p.productID}" class="text-dark text-decoration-none">
                                                ${p.name}
                                            </a>
                                        </h6>

                                        <!-- Description snippet -->
                                        <p class="card-text text-muted small text-truncate mb-3" style="font-size: 0.78rem;">
                                            ${p.description}
                                        </p>

                                        <!-- Price & Buy Action -->
                                        <div class="mt-auto d-flex justify-content-between align-items-center pt-2 border-top">
                                            <div class="fw-bold fs-6" style="color: var(--color-primary, #ED1D24); font-family: 'Outfit', sans-serif;">
                                                <fmt:formatNumber value="${p.price}" pattern="#,###" /> đ
                                            </div>
                                            <a href="product?action=detail&id=${p.productID}" class="btn btn-outline-dark btn-sm rounded-0 fw-bold px-2 py-1 text-uppercase" style="font-size: 0.72rem;">
                                                <i class="fa-solid fa-bag-shopping me-1"></i> Mua
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${endPage > 1}">
                        <nav aria-label="Page navigation" class="mt-5">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                    <a class="page-link rounded-0 border-dark text-dark"
                                       href="product?page=${currentPage - 1}${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}#catalogSection">
                                        <i class="fa-solid fa-chevron-left"></i>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${endPage}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link rounded-0 ${currentPage == i ? 'bg-danger border-danger text-white' : 'border-dark text-dark'}"
                                           href="product?page=${i}${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}#catalogSection">
                                            ${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage >= endPage ? 'disabled' : ''}">
                                    <a class="page-link rounded-0 border-dark text-dark"
                                       href="product?page=${currentPage + 1}${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sort ? '&sort='.concat(param.sort) : ''}#catalogSection">
                                        <i class="fa-solid fa-chevron-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
    function toggleQuickWishlist(id, name, price, img, btn) {
        let wishlist = (typeof window.getOne61Wishlist === 'function') 
            ? window.getOne61Wishlist() 
            : JSON.parse(localStorage.getItem('one61_wishlist_' + (window.CURRENT_USER_ID || 'guest')) || '[]');
            
        const idx = wishlist.findIndex(item => item.id === id);
        const icon = btn.querySelector('i');
        
        if (idx === -1) {
            wishlist.push({ id, name, price, img });
            if (typeof window.saveOne61Wishlist === 'function') {
                window.saveOne61Wishlist(wishlist);
            } else {
                localStorage.setItem('one61_wishlist_' + (window.CURRENT_USER_ID || 'guest'), JSON.stringify(wishlist));
            }
            if (icon) {
                icon.className = 'fa-solid fa-heart text-danger';
            }
            if (typeof window.one61Toast === 'function') {
                window.one61Toast('Đã thêm [' + name + '] vào Yêu thích!', 'success');
            }
        } else {
            wishlist.splice(idx, 1);
            if (typeof window.saveOne61Wishlist === 'function') {
                window.saveOne61Wishlist(wishlist);
            } else {
                localStorage.setItem('one61_wishlist_' + (window.CURRENT_USER_ID || 'guest'), JSON.stringify(wishlist));
            }
            if (icon) {
                icon.className = 'fa-regular fa-heart';
            }
            if (typeof window.one61Toast === 'function') {
                window.one61Toast('Đã xóa khỏi Yêu thích', 'info');
            }
        }
        if (typeof window.updateWishlistBadge === 'function') {
            window.updateWishlistBadge();
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        if (typeof window.updateWishlistBadge === 'function') {
            window.updateWishlistBadge();
        }
        const wishlist = (typeof window.getOne61Wishlist === 'function') ? window.getOne61Wishlist() : [];
        const wishIds = new Set(wishlist.map(w => w.id));
        document.querySelectorAll('.floating-wishlist-btn').forEach(btn => {
            const onclickAttr = btn.getAttribute('onclick') || '';
            const match = onclickAttr.match(/toggleQuickWishlist\('([^']+)'/);
            if (match && wishIds.has(match[1])) {
                const icon = btn.querySelector('i');
                if (icon) icon.className = 'fa-solid fa-heart text-danger';
            }
        });
    });
</script>

<jsp:include page="includes/footer.jsp" />
