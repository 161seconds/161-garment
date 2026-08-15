<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp" />

<!-- Breadcrumbs -->
<nav aria-label="breadcrumb" class="my-3">
    <ol class="breadcrumb small text-uppercase fw-bold">
        <li class="breadcrumb-item"><a href="home" class="text-decoration-none text-dark">Trang chủ</a></li>
        <li class="breadcrumb-item"><a href="product" class="text-decoration-none text-dark">Sản phẩm</a></li>
        <li class="breadcrumb-item active text-danger" aria-current="page">${PRODUCT.name}</li>
    </ol>
</nav>

<div class="card border border-dark-subtle rounded-0 p-4 p-md-5 bg-white mb-5">
    <div class="row g-5">
        <!-- Product Image -->
        <div class="col-md-5 text-center">
            <div class="p-4" style="background-color: #F8F8F8;">
                <img src="${pageContext.request.contextPath}/img-prj301/${PRODUCT.image}" 
                     class="img-fluid rounded-0" 
                     alt="${PRODUCT.name}" 
                     style="max-height: 420px; object-fit: contain;">
            </div>
        </div>
        
        <!-- Product Details -->
        <div class="col-md-7 d-flex flex-column">
            <span class="badge bg-danger rounded-0 px-2 py-1 mb-2 align-self-start text-uppercase" style="letter-spacing: 1px;">
                161 Garment Collection
            </span>
            <h2 class="fw-bold text-uppercase tracking-tight mb-2">${PRODUCT.name}</h2>
            <div class="text-muted small mb-3">Mã sản phẩm: <strong class="font-monospace text-dark">${PRODUCT.productID}</strong></div>
            
            <div class="py-3 border-top border-bottom mb-4">
                <span class="fs-6 text-muted me-2">Giá niêm yết:</span>
                <span class="fs-3 fw-bold" style="color: var(--color-primary);">
                    <fmt:formatNumber value="${PRODUCT.price}" pattern="#,###"/> đ
                </span>
            </div>
            
            <div class="mb-4">
                <h6 class="fw-bold text-uppercase small mb-2">Mô Tả Sản Phẩm:</h6>
                <p class="text-secondary" style="line-height: 1.7;">${PRODUCT.description}</p>
            </div>
            
            <div class="mb-4">
                <h6 class="fw-bold text-uppercase small mb-2">Tình Trạng Kho Hàng:</h6>
                <c:choose>
                    <c:when test="${PRODUCT.quantity > 0}">
                        <span class="badge bg-light text-success border border-success-subtle rounded-0 px-3 py-2 fw-bold">
                            <i class="fa-solid fa-circle-check me-1"></i> Còn hàng (${PRODUCT.quantity} sản phẩm có sẵn)
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-danger rounded-0 px-3 py-2 fw-bold">
                            <i class="fa-solid fa-circle-xmark me-1"></i> Tạm hết hàng
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="mt-auto pt-3">
                <c:if test="${PRODUCT.quantity > 0}">
                    <form action="cart" method="POST" class="d-flex gap-3">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="id" value="${PRODUCT.productID}">
                        <button type="submit" class="btn btn-danger btn-lg rounded-0 fw-bold px-5 py-3 text-uppercase flex-grow-1" style="background-color: var(--color-primary); letter-spacing: 1px;">
                            <i class="fa-solid fa-cart-plus me-2"></i> THÊM VÀO GIỎ HÀNG
                        </button>
                    </form>
                </c:if>
                <c:if test="${PRODUCT.quantity <= 0}">
                    <button class="btn btn-secondary btn-lg rounded-0 fw-bold px-5 py-3 text-uppercase w-100" disabled>
                        TẠM HẾT HÀNG
                    </button>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
