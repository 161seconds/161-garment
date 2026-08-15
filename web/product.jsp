<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Tất Cả Sản Phẩm | ONE61 Garment" />
</jsp:include>

<!-- Breadcrumb Navigation -->
<div class="bg-light border-bottom py-2">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0 small">
                <li class="breadcrumb-item"><a href="home" class="text-secondary text-decoration-none"><i class="fa-solid fa-house me-1"></i>Trang chủ</a></li>
                <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">
                    <c:choose>
                        <c:when test="${not empty param.categoryID}">
                            <c:forEach var="c" items="${CATEGORIES}">
                                <c:if test="${c.categoryID eq param.categoryID}">${c.name}</c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>Tất cả sản phẩm</c:otherwise>
                    </c:choose>
                </li>
            </ol>
        </nav>
    </div>
</div>

<!-- Main Products Content -->
<div class="container my-4 flex-grow-1">
    <!-- Catalog Header Banner -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center pb-3 mb-4 border-bottom gap-3">
        <div>
            <span class="badge bg-danger rounded-0 px-2 py-1 mb-1 text-uppercase" style="letter-spacing: 1px;">ONE61 Garment</span>
            <h2 class="fw-bold text-uppercase tracking-tight m-0">
                <c:choose>
                    <c:when test="${not empty param.categoryID}">
                        <c:forEach var="c" items="${CATEGORIES}">
                            <c:if test="${c.categoryID eq param.categoryID}">${c.name}</c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>TẤT CẢ SẢN PHẨM</c:otherwise>
                </c:choose>
            </h2>
            <p class="text-muted small m-0 mt-1">Khám phá phong cách thời trang tối giản LifeWear chuẩn Nhật Bản</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <span class="small text-muted text-nowrap">Tổng cộng: <strong class="text-dark">${PRODUCTS.size()}</strong> sản phẩm</span>
        </div>
    </div>

    <!-- Alert Notifications -->
    <c:if test="${not empty sessionScope.SUCCESS_MSG}">
        <div class="alert alert-success alert-dismissible fade show rounded-0 small py-2 d-flex align-items-center" role="alert">
            <i class="fa-solid fa-circle-check me-2 fs-5"></i>
            <div>${sessionScope.SUCCESS_MSG}</div>
            <button type="button" class="btn-close py-2" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="SUCCESS_MSG" scope="session" />
    </c:if>

    <div class="row g-4">
        <!-- Left Sidebar: Category Filters -->
        <div class="col-lg-3 col-md-4">
            <div class="sticky-top" style="top: 80px; z-index: 10;">
                <div class="card border border-dark-subtle rounded-0 mb-4 bg-white shadow-sm">
                    <div class="card-header bg-dark text-white rounded-0 py-3 d-flex align-items-center justify-content-between">
                        <span class="fw-bold text-uppercase small tracking-wider m-0">
                            <i class="fa-solid fa-filter me-2 text-danger"></i> DANH MỤC SẢN PHẨM
                        </span>
                    </div>
                    
                    <!-- All Products Link -->
                    <div class="border-bottom">
                        <a href="product"
                           class="d-flex justify-content-between align-items-center p-3 fw-bold text-decoration-none ${empty param.categoryID ? 'text-danger bg-light border-start border-danger border-4 ps-3' : 'text-dark'}">
                            <span><i class="fa-solid fa-border-all me-2 text-muted"></i> TẤT CẢ SẢN PHẨM</span>
                            <i class="fa-solid fa-chevron-right small text-muted"></i>
                        </a>
                    </div>

                    <!-- Category Accordion -->
                    <div class="accordion accordion-flush" id="categoryAccordion">
                        <!-- 1. MEN SECTION -->
                        <div class="accordion-item rounded-0 border-bottom">
                            <h2 class="accordion-header" id="headingMen">
                                <button class="accordion-button rounded-0 fw-bold py-3 ${param.categoryID.startsWith('MEN') || param.categoryID eq 'CAT01' ? '' : 'collapsed'}"
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
                                        <c:if test="${cat.categoryID.startsWith('MEN') || cat.name.contains('Nam') || cat.categoryID eq 'CAT01'}">
                                            <a href="product?categoryID=${cat.categoryID}"
                                               class="list-group-item list-group-item-action border-0 py-2 ps-4 small fw-semibold bg-transparent ${param.categoryID eq cat.categoryID ? 'text-danger fw-bold ps-4 border-start border-danger border-3' : 'text-secondary'}">
                                                <i class="fa-solid fa-angle-right me-2 text-muted" style="font-size: 0.75rem;"></i> ${cat.name}
                                            </a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- 2. WOMEN SECTION -->
                        <div class="accordion-item rounded-0 border-bottom">
                            <h2 class="accordion-header" id="headingWomen">
                                <button class="accordion-button rounded-0 fw-bold py-3 ${param.categoryID.startsWith('WOMEN') || param.categoryID eq 'CAT02' || param.categoryID eq 'CAT03' ? '' : 'collapsed'}"
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
                                        <c:if test="${cat.categoryID.startsWith('WOMEN') || cat.name.contains('Nữ') || cat.categoryID eq 'CAT02' || cat.categoryID eq 'CAT03'}">
                                            <a href="product?categoryID=${cat.categoryID}"
                                               class="list-group-item list-group-item-action border-0 py-2 ps-4 small fw-semibold bg-transparent ${param.categoryID eq cat.categoryID ? 'text-danger fw-bold ps-4 border-start border-danger border-3' : 'text-secondary'}">
                                                <i class="fa-solid fa-angle-right me-2 text-muted" style="font-size: 0.75rem;"></i> ${cat.name}
                                            </a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- 3. KIDS SECTION -->
                        <div class="accordion-item rounded-0">
                            <h2 class="accordion-header" id="headingKids">
                                <button class="accordion-button rounded-0 fw-bold py-3 ${param.categoryID.startsWith('KIDS') || param.categoryID eq 'CAT04' ? '' : 'collapsed'}"
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
                                        <c:if test="${cat.categoryID.startsWith('KIDS') || cat.name.contains('Trẻ Em') || param.categoryID eq 'CAT04'}">
                                            <a href="product?categoryID=${cat.categoryID}"
                                               class="list-group-item list-group-item-action border-0 py-2 ps-4 small fw-semibold bg-transparent ${param.categoryID eq cat.categoryID ? 'text-danger fw-bold ps-4 border-start border-danger border-3' : 'text-secondary'}">
                                                <i class="fa-solid fa-angle-right me-2 text-muted" style="font-size: 0.75rem;"></i> ${cat.name}
                                            </a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Info Box -->
                <div class="p-3 bg-light border text-center d-none d-md-block">
                    <span class="badge bg-danger rounded-0 px-2 py-1 mb-2 text-uppercase">ONE61 LifeWear</span>
                    <p class="small text-muted mb-0">Chất lượng vượt trội, thiết kế tinh giản cho cuộc sống hàng ngày.</p>
                </div>
            </div>
        </div>

        <!-- Right Side: Product Catalog Grid -->
        <div class="col-lg-9 col-md-8">
            <c:choose>
                <c:when test="${empty PRODUCTS}">
                    <div class="text-center py-5 bg-white border border-dark-subtle p-5">
                        <i class="fa-solid fa-box-open text-muted display-3 mb-3"></i>
                        <h4 class="fw-bold text-uppercase text-secondary">Không có sản phẩm nào</h4>
                        <p class="text-muted small">Hiện chưa có sản phẩm nào thuộc danh mục này hoặc đang cập nhật.</p>
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
                                <div class="card h-100 product-card border border-dark-subtle rounded-0 bg-white">
                                    <div class="product-img-wrapper position-relative overflow-hidden" style="padding-top: 100%;">
                                        <a href="product?action=detail&id=${p.productID}">
                                            <img src="${pageContext.request.contextPath}/img-prj301/${p.image}"
                                                 class="card-img-top position-absolute top-0 start-0 w-100 h-100 object-fit-cover"
                                                 alt="${p.name}"
                                                 onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=600&auto=format&fit=crop&q=80';">
                                        </a>
                                        
                                        <!-- Badges -->
                                        <div class="position-absolute top-0 start-0 m-2 d-flex flex-column gap-1">
                                            <span class="badge bg-danger rounded-0 px-2 py-1 text-uppercase" style="font-size: 0.65rem; letter-spacing: 0.5px;">NEW</span>
                                            <c:if test="${p.quantity le 5}">
                                                <span class="badge bg-warning text-dark rounded-0 px-2 py-1 text-uppercase" style="font-size: 0.65rem;">SẮP HẾT</span>
                                            </c:if>
                                        </div>

                                        <!-- Quick Action Overlay -->
                                        <div class="product-action-overlay position-absolute bottom-0 start-0 w-100 p-2 d-flex gap-1">
                                            <a href="product?action=detail&id=${p.productID}" class="btn btn-light btn-sm rounded-0 flex-grow-1 fw-bold text-uppercase small shadow-sm">
                                                <i class="fa-regular fa-eye me-1"></i> Chi tiết
                                            </a>
                                            <form action="cart" method="POST" class="m-0">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="productID" value="${p.productID}">
                                                <input type="hidden" name="quantity" value="1">
                                                <button type="submit" class="btn btn-danger btn-sm rounded-0 fw-bold px-3 shadow-sm" style="background-color: var(--color-primary);" title="Thêm vào giỏ hàng">
                                                    <i class="fa-solid fa-cart-plus"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>

                                    <div class="card-body p-3 d-flex flex-column">
                                        <!-- Category Tag -->
                                        <div class="text-uppercase text-muted mb-1 font-monospace" style="font-size: 0.7rem; letter-spacing: 0.5px;">
                                            ${p.categoryID}
                                        </div>

                                        <!-- Product Title -->
                                        <h6 class="card-title fw-bold text-uppercase mb-2" style="font-size: 0.9rem; line-height: 1.4;">
                                            <a href="product?action=detail&id=${p.productID}" class="text-dark text-decoration-none product-title-link">
                                                ${p.name}
                                            </a>
                                        </h6>

                                        <p class="card-text text-muted small text-truncate mb-3" style="font-size: 0.8rem;">
                                            ${p.description}
                                        </p>

                                        <!-- Price & Stock -->
                                        <div class="mt-auto d-flex justify-content-between align-items-center pt-2 border-top">
                                            <div class="fw-bold fs-6" style="color: var(--color-primary);">
                                                <fmt:formatNumber value="${p.price}" pattern="#,###" /> đ
                                            </div>
                                            <div class="small text-muted">
                                                Kho: <strong>${p.quantity}</strong>
                                            </div>
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

<jsp:include page="includes/footer.jsp" />
