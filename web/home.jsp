<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp" />

<!-- Promotional Banner -->
<div class="mb-4 text-center p-5" style="background-color: var(--color-primary); color: white;">
    <h2 class="fw-bold mb-2" style="letter-spacing: 2px;">CỘT MỐC MỚI. PHONG CÁCH MỚI.</h2>
    <p class="fs-5 mb-0">Khám phá bộ sưu tập Thu Đông mới nhất</p>
</div>

<div class="row">
    <!-- Sidebar Categories -->
    <div class="col-md-2 mb-4">
        <div class="list-group border-0 rounded-0">
            <a href="product" class="list-group-item list-group-item-action fw-bold border-0 px-0 ${empty param.categoryID ? 'text-danger' : 'text-dark'}">
                TẤT CẢ SẢN PHẨM
            </a>
            <c:forEach var="cat" items="${CATEGORIES}">
                <a href="product?categoryID=${cat.categoryID}" 
                   class="list-group-item list-group-item-action border-0 px-0 ${param.categoryID eq cat.categoryID ? 'text-danger fw-bold' : 'text-dark'}">
                    ${cat.name}
                </a>
            </c:forEach>
        </div>
    </div>

    <!-- Product Grid -->
    <div class="col-md-10">
        <c:if test="${not empty SUCCESS}">
            <div class="alert alert-success alert-dismissible fade show rounded-0" role="alert">
                ${SUCCESS}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row row-cols-2 row-cols-md-4 g-3">
            <c:forEach var="p" items="${PRODUCTS}">
                <div class="col">
                    <div class="card h-100 border-0 rounded-0 product-card">
                        <a href="product?action=detail&id=${p.productID}" class="text-decoration-none">
                            <div class="image-wrapper" style="background-color: #F4F4F4; padding: 20px;">
                                <img src="${pageContext.request.contextPath}/img-prj301/${p.image}" class="card-img-top rounded-0" alt="${p.name}" style="height: 250px; object-fit: contain;">
                            </div>
                        </a>
                        <div class="card-body px-0 py-3 d-flex flex-column">
                            <h5 class="card-title fw-bold fs-6 mb-1 text-truncate" style="color: var(--color-foreground);">${p.name}</h5>
                            <p class="card-text text-muted small mb-2 text-truncate">${p.description}</p>
                            <div class="mt-auto d-flex justify-content-between align-items-center">
                                <span class="fw-bold fs-6" style="color: var(--color-foreground);">
                                    <fmt:formatNumber value="${p.price}" pattern="#,###"/> đ
                                </span>
                                <a href="cart?action=add&id=${p.productID}" class="btn btn-outline-dark btn-sm rounded-0 fw-bold" style="font-size: 0.8rem; text-transform: uppercase;">
                                    <i class="fa-solid fa-plus"></i> Thêm
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty PRODUCTS}">
                <div class="col-12 py-5">
                    <h5 class="text-muted">Không tìm thấy sản phẩm nào!</h5>
                </div>
            </c:if>
        </div>

        <!-- Pagination -->
        <c:if test="${endPage > 1}">
            <nav aria-label="Page navigation" class="mt-5">
                <ul class="pagination justify-content-center rounded-0">
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link rounded-0 ${i == currentPage ? 'bg-danger border-danger text-white' : 'text-dark'}" 
                               href="product?categoryID=${param.categoryID}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>
</div>

<style>
    .product-card .image-wrapper { transition: opacity 0.2s ease; }
    .product-card:hover .image-wrapper { opacity: 0.8; }
</style>

<jsp:include page="includes/footer.jsp" />
