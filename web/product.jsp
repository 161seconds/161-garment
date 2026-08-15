<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    .sidebar-cate-link.active {
        background-color: #FDF2F2;
        color: #ED1D24;
        font-weight: 700;
        border-left-color: #ED1D24;
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
<div class="container my-4 flex-grow-1">
    <!-- Header Banner -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center pb-3 mb-4 border-bottom gap-3">
        <div>
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
        </div>

        <div class="d-flex align-items-center gap-3">
            <span class="small text-muted text-nowrap">
                Hiển thị: <strong class="text-dark">${PRODUCTS.size()}</strong> sản phẩm
            </span>
            <div class="dropdown">
                <button class="btn btn-outline-dark btn-sm rounded-0 dropdown-toggle fw-semibold px-3" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 0.8rem;">
                    <i class="fa-solid fa-arrow-down-short-wide me-1"></i> Sắp xếp
                </button>
                <ul class="dropdown-menu dropdown-menu-end rounded-0 shadow-sm border border-dark-subtle">
                    <li><a class="dropdown-item small" href="product?sort=newest${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}">Mới nhất</a></li>
                    <li><a class="dropdown-item small" href="product?sort=price-asc${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}">Giá: Thấp đến Cao</a></li>
                    <li><a class="dropdown-item small" href="product?sort=price-desc${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}">Giá: Cao đến Thấp</a></li>
                    <li><a class="dropdown-item small" href="product?sort=popular${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}">Bán chạy nhất</a></li>
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

    <div class="row g-4">
        <!-- Left Sidebar: Categories & Filters -->
        <div class="col-lg-3 col-md-4">
            <div class="sticky-top" style="top: 80px; z-index: 10;">
                <!-- Category Filter Box -->
                <div class="card border border-dark-subtle rounded-0 mb-4 bg-white shadow-sm">
                    <div class="card-header bg-dark text-white rounded-0 py-3 d-flex align-items-center justify-content-between">
                        <span class="fw-bold text-uppercase small tracking-wider m-0">
                            <i class="fa-solid fa-bars-staggered me-2 text-danger"></i> DANH MỤC SẢN PHẨM
                        </span>
                    </div>

                    <!-- All Products Link -->
                    <div class="border-bottom">
                        <a href="product" class="sidebar-cate-link ${empty param.categoryID ? 'active' : ''}">
                            <span><i class="fa-solid fa-border-all me-2 text-muted"></i> Tất cả sản phẩm</span>
                            <i class="fa-solid fa-chevron-right small text-muted"></i>
                        </a>
                    </div>

                    <!-- Category Accordion -->
                    <div class="accordion accordion-flush" id="categoryAccordion">
                        <!-- 1. THỜI TRANG NAM -->
                        <div class="accordion-item rounded-0 border-bottom">
                            <h2 class="accordion-header" id="headingMen">
                                <button class="accordion-button rounded-0 fw-bold py-3 ${param.categoryID.startsWith('MEN') || param.categoryID eq 'CAT01' ? '' : 'collapsed'}"
                                        type="button" data-bs-toggle="collapse" data-bs-target="#collapseMen"
                                        aria-expanded="${param.categoryID.startsWith('MEN') || param.categoryID eq 'CAT01' ? 'true' : 'false'}"
                                        style="font-size: 0.88rem;">
                                    <i class="fa-solid fa-person me-2 text-danger"></i> THỜI TRANG NAM
                                </button>
                            </h2>
                            <div id="collapseMen" class="accordion-collapse collapse ${param.categoryID.startsWith('MEN') || param.categoryID eq 'CAT01' ? 'show' : ''}">
                                <div class="list-group list-group-flush rounded-0 bg-light">
                                    <c:forEach var="cat" items="${CATEGORIES}">
                                        <c:if test="${cat.categoryID.startsWith('MEN') || cat.name.contains('Nam') || cat.categoryID eq 'CAT01'}">
                                            <a href="product?categoryID=${cat.categoryID}"
                                               class="sidebar-cate-link ps-4 ${param.categoryID eq cat.categoryID ? 'active' : ''}">
                                                <span><i class="fa-solid fa-angle-right me-2 text-muted" style="font-size: 0.75rem;"></i> ${cat.name}</span>
                                            </a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- 2. THỜI TRANG NỮ -->
                        <div class="accordion-item rounded-0 border-bottom">
                            <h2 class="accordion-header" id="headingWomen">
                                <button class="accordion-button rounded-0 fw-bold py-3 ${param.categoryID.startsWith('WOMEN') || param.categoryID eq 'CAT02' || param.categoryID eq 'CAT03' ? '' : 'collapsed'}"
                                        type="button" data-bs-toggle="collapse" data-bs-target="#collapseWomen"
                                        aria-expanded="${param.categoryID.startsWith('WOMEN') || param.categoryID eq 'CAT02' || param.categoryID eq 'CAT03' ? 'true' : 'false'}"
                                        style="font-size: 0.88rem;">
                                    <i class="fa-solid fa-person-dress me-2 text-danger"></i> THỜI TRANG NỮ
                                </button>
                            </h2>
                            <div id="collapseWomen" class="accordion-collapse collapse ${param.categoryID.startsWith('WOMEN') || param.categoryID eq 'CAT02' || param.categoryID eq 'CAT03' ? 'show' : ''}">
                                <div class="list-group list-group-flush rounded-0 bg-light">
                                    <c:forEach var="cat" items="${CATEGORIES}">
                                        <c:if test="${cat.categoryID.startsWith('WOMEN') || cat.name.contains('Nữ') || cat.categoryID eq 'CAT02' || cat.categoryID eq 'CAT03'}">
                                            <a href="product?categoryID=${cat.categoryID}"
                                               class="sidebar-cate-link ps-4 ${param.categoryID eq cat.categoryID ? 'active' : ''}">
                                                <span><i class="fa-solid fa-angle-right me-2 text-muted" style="font-size: 0.75rem;"></i> ${cat.name}</span>
                                            </a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- 3. TRẺ EM -->
                        <div class="accordion-item rounded-0">
                            <h2 class="accordion-header" id="headingKids">
                                <button class="accordion-button rounded-0 fw-bold py-3 ${param.categoryID.startsWith('KIDS') || param.categoryID eq 'CAT04' ? '' : 'collapsed'}"
                                        type="button" data-bs-toggle="collapse" data-bs-target="#collapseKids"
                                        aria-expanded="${param.categoryID.startsWith('KIDS') || param.categoryID eq 'CAT04' ? 'true' : 'false'}"
                                        style="font-size: 0.88rem;">
                                    <i class="fa-solid fa-children me-2 text-danger"></i> TRẺ EM (KIDS)
                                </button>
                            </h2>
                            <div id="collapseKids" class="accordion-collapse collapse ${param.categoryID.startsWith('KIDS') || param.categoryID eq 'CAT04' ? 'show' : ''}">
                                <div class="list-group list-group-flush rounded-0 bg-light">
                                    <c:forEach var="cat" items="${CATEGORIES}">
                                        <c:if test="${cat.categoryID.startsWith('KIDS') || cat.name.contains('Trẻ Em') || param.categoryID eq 'CAT04'}">
                                            <a href="product?categoryID=${cat.categoryID}"
                                               class="sidebar-cate-link ps-4 ${param.categoryID eq cat.categoryID ? 'active' : ''}">
                                                <span><i class="fa-solid fa-angle-right me-2 text-muted" style="font-size: 0.75rem;"></i> ${cat.name}</span>
                                            </a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- VIP Promo Card -->
                <div class="p-3 bg-dark text-white rounded-0 border mb-4 text-center">
                    <span class="badge bg-danger rounded-0 px-2 py-1 mb-2 text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">MEMBER EXCLUSIVE</span>
                    <h6 class="fw-bold text-uppercase mb-1 text-white" style="font-size: 0.85rem;">ƯU ĐÃI THÀNH VIÊN</h6>
                    <p class="small text-secondary mb-3" style="font-size: 0.78rem;">Đăng ký tài khoản ngay để nhận mã giảm <strong>10%</strong> cho đơn hàng đầu tiên!</p>
                    <a href="register" class="btn btn-danger btn-sm rounded-0 w-100 fw-bold text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px; background-color: var(--color-primary);">
                        ĐĂNG KÝ NGAY
                    </a>
                </div>
            </div>
        </div>

        <!-- Right Side: Products Catalog Grid -->
        <div class="col-lg-9 col-md-8">
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
                    <!-- Products Grid -->
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-3 g-4">
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
                                        <h6 class="card-title fw-bold text-uppercase mb-1" style="font-size: 0.88rem; line-height: 1.35; height: 2.7em; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
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
                                       href="product?page=${currentPage - 1}${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}">
                                        <i class="fa-solid fa-chevron-left"></i>
                                    </a>
                                </li>
                                <c:forEach begin="1" end="${endPage}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link rounded-0 ${currentPage == i ? 'bg-danger border-danger text-white' : 'border-dark text-dark'}"
                                           href="product?page=${i}${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}">
                                            ${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${currentPage >= endPage ? 'disabled' : ''}">
                                    <a class="page-link rounded-0 border-dark text-dark"
                                       href="product?page=${currentPage + 1}${not empty param.categoryID ? '&categoryID='.concat(param.categoryID) : ''}">
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
        let wishlist = JSON.parse(localStorage.getItem('one61_wishlist') || '[]');
        const idx = wishlist.findIndex(item => item.id === id);
        const icon = btn.querySelector('i');
        
        if (idx === -1) {
            wishlist.push({ id, name, price, img });
            localStorage.setItem('one61_wishlist', JSON.stringify(wishlist));
            if (icon) {
                icon.className = 'fa-solid fa-heart text-danger';
            }
            if (typeof window.one61Toast === 'function') {
                window.one61Toast('Đã thêm [' + name + '] vào Yêu thích!', 'success');
            }
        } else {
            wishlist.splice(idx, 1);
            localStorage.setItem('one61_wishlist', JSON.stringify(wishlist));
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
</script>

<jsp:include page="includes/footer.jsp" />
