<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp" />

<div class="card shadow-sm border-0 p-4 mt-3">
    <div class="row">
        <!-- Ảnh Sản Phẩm -->
        <div class="col-md-5 text-center mb-4 mb-md-0">
            <img src="assets/images/${PRODUCT.image}" class="img-fluid rounded" alt="${PRODUCT.name}" style="max-height: 400px; object-fit: contain;">
        </div>
        
        <!-- Thông Tin Sản Phẩm -->
        <div class="col-md-7">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="home" class="text-decoration-none text-muted">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="product" class="text-decoration-none text-muted">Sản phẩm</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Chi tiết</li>
                </ol>
            </nav>
            <h2 class="fw-bold">${PRODUCT.name}</h2>
            <hr>
            <h3 class="text-danger fw-bold mb-4"><fmt:formatNumber value="${PRODUCT.price}" pattern="#,###"/> đ</h3>
            
            <div class="mb-4">
                <p class="fw-bold mb-1">Mô tả sản phẩm:</p>
                <p class="text-muted" style="line-height: 1.6;">${PRODUCT.description}</p>
            </div>
            
            <div class="mb-4">
                <span class="badge ${PRODUCT.quantity > 0 ? 'bg-success' : 'bg-danger'} p-2">
                    ${PRODUCT.quantity > 0 ? 'Còn hàng' : 'Hết hàng'} (${PRODUCT.quantity})
                </span>
            </div>

            <c:if test="${PRODUCT.quantity > 0}">
                <form action="cart" method="POST" class="d-flex gap-3 align-items-center">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="${PRODUCT.productID}">
                    <button type="submit" class="btn btn-warning btn-lg fw-bold px-5">
                        <i class="fa-solid fa-cart-plus"></i> CHỌN MUA
                    </button>
                </form>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
