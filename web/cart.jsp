<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Giỏ Hàng Của Bạn | ONE61 Garmentory" />
</jsp:include>

<div class="container py-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small text-uppercase fw-semibold mb-0" style="letter-spacing: 0.5px;">
            <li class="breadcrumb-item"><a href="home" class="text-decoration-none text-dark">Trang Chủ</a></li>
            <li class="breadcrumb-item active text-danger" aria-current="page">Giỏ Hàng (${TOTAL_ITEMS != null ? TOTAL_ITEMS : sessionScope.CART.size()})</li>
        </ol>
    </nav>

    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-end mb-4 pb-3 border-bottom">
        <div>
            <h3 class="fw-bold m-0 text-uppercase" style="letter-spacing: 1px; font-family: 'Outfit', sans-serif;">
                GIỎ HÀNG CỦA BẠN
            </h3>
            <p class="text-muted small m-0 mt-1">
                Tất cả sản phẩm LifeWear được áp dụng chính sách giao hàng miễn phí và đổi trả 30 ngày
            </p>
        </div>
        <c:if test="${not empty sessionScope.CART}">
            <a href="cart?action=clear" class="btn btn-outline-secondary btn-sm rounded-0 text-uppercase fw-bold" onclick="return confirm('Bạn có chắc muốn xóa toàn bộ sản phẩm khỏi giỏ hàng?');" style="font-size: 0.75rem;">
                <i class="fa-solid fa-trash-can me-1"></i> Xóa tất cả
            </a>
        </c:if>
    </div>

    <!-- Main Content -->
    <c:choose>
        <c:when test="${empty sessionScope.CART}">
            <!-- Empty Cart State -->
            <div class="text-center py-5 my-5 bg-white border">
                <div class="mb-4">
                    <div style="width: 90px; height: 90px; margin: 0 auto; background: #F8F9FA; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-bag-shopping fs-1 text-muted"></i>
                    </div>
                </div>
                <h4 class="fw-bold text-uppercase mb-2" style="letter-spacing: 1px;">Giỏ hàng của bạn đang trống</h4>
                <p class="text-muted small mb-4">Hãy khám phá các thiết kế LifeWear tối giản và thêm sản phẩm yêu thích vào giỏ nhé.</p>
                <a href="product" class="btn btn-danger rounded-0 px-5 py-3 fw-bold text-uppercase" style="background-color: var(--color-primary, #ED1D24); border-color: var(--color-primary, #ED1D24); letter-spacing: 1px; font-size: 0.85rem;">
                    <i class="fa-solid fa-arrow-right me-2"></i> Khám Phá Bộ Sưu Tập
                </a>
            </div>
        </c:when>
        
        <c:otherwise>
            <div class="row g-4">
                <!-- Left: Items List -->
                <div class="col-lg-8">
                    <div class="card rounded-0 border mb-4">
                        <div class="table-responsive">
                            <table class="table align-middle mb-0">
                                <thead class="table-light">
                                    <tr class="small text-uppercase fw-bold text-secondary" style="font-size: 0.75rem; letter-spacing: 0.5px;">
                                        <th class="ps-4 py-3" style="width: 45%;">SẢN PHẨM</th>
                                        <th class="text-end py-3" style="width: 18%;">ĐƠN GIÁ</th>
                                        <th class="text-center py-3" style="width: 18%;">SỐ LƯỢNG</th>
                                        <th class="text-end py-3 pe-4" style="width: 19%;">THÀNH TIỀN</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${sessionScope.CART}">
                                        <tr class="border-bottom">
                                            <!-- Product Info -->
                                            <td class="ps-4 py-3">
                                                <div class="d-flex align-items-center gap-3">
                                                    <a href="product-detail?id=${item.product.productID}" class="d-block flex-shrink-0 border" style="width: 75px; height: 95px; overflow: hidden; background: #f8f9fa;">
                                                        <img src="${pageContext.request.contextPath}/img-prj301/${item.product.image}" 
                                                             alt="${item.product.name}" 
                                                             class="w-100 h-100" 
                                                             style="object-fit: cover;"
                                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img-prj301/products/men/cover/cover-shirts-men-1.avif';">
                                                    </a>
                                                    <div>
                                                        <span class="badge bg-light text-muted border rounded-0 font-monospace mb-1" style="font-size: 0.68rem;">${item.product.productID}</span>
                                                        <h6 class="fw-bold m-0 mb-1" style="font-size: 0.92rem;">
                                                            <a href="product-detail?id=${item.product.productID}" class="text-dark text-decoration-none hover-red">
                                                                ${item.product.name}
                                                            </a>
                                                        </h6>
                                                        <a href="cart?action=remove&id=${item.product.productID}" 
                                                           class="text-muted small text-decoration-none d-inline-flex align-items-center gap-1 mt-1 hover-danger"
                                                           onclick="return confirm('Xóa [${item.product.name}] khỏi giỏ hàng?');"
                                                           style="font-size: 0.75rem;">
                                                            <i class="fa-regular fa-trash-can"></i> Xóa
                                                        </a>
                                                    </div>
                                                </div>
                                            </td>

                                            <!-- Unit Price -->
                                            <td class="text-end py-3 fw-semibold" style="font-size: 0.95rem;">
                                                <fmt:formatNumber value="${item.product.price}" pattern="#,###"/> đ
                                            </td>

                                            <!-- Quantity Controls -->
                                            <td class="text-center py-3">
                                                <div class="d-inline-flex align-items-center border bg-white" style="height: 34px;">
                                                    <a href="cart?action=dec&id=${item.product.productID}" class="btn btn-sm btn-link text-dark text-decoration-none px-2 py-0 border-0" style="font-size: 0.9rem;">
                                                        <i class="fa-solid fa-minus"></i>
                                                    </a>
                                                    <form action="cart" method="POST" class="m-0 d-inline">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="id" value="${item.product.productID}">
                                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.quantity > 0 ? item.product.quantity : 99}" 
                                                               class="form-control form-control-sm text-center border-0 fw-bold p-0 shadow-none" 
                                                               style="width: 40px; font-size: 0.9rem;" 
                                                               onchange="this.form.submit()">
                                                    </form>
                                                    <a href="cart?action=inc&id=${item.product.productID}" class="btn btn-sm btn-link text-dark text-decoration-none px-2 py-0 border-0 ${item.quantity >= item.product.quantity ? 'disabled text-muted' : ''}" style="font-size: 0.9rem;">
                                                        <i class="fa-solid fa-plus"></i>
                                                    </a>
                                                </div>
                                                <c:if test="${item.product.quantity > 0 && item.quantity >= item.product.quantity}">
                                                    <div class="text-danger small mt-1" style="font-size: 0.68rem;">Đã đạt giới hạn tồn kho</div>
                                                </c:if>
                                            </td>

                                            <!-- Line Total -->
                                            <td class="text-end py-3 pe-4 fw-bold" style="font-size: 1rem; color: var(--color-primary, #ED1D24);">
                                                <fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,###"/> đ
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Bottom Nav -->
                    <div class="d-flex justify-content-between align-items-center">
                        <a href="product" class="btn btn-outline-dark rounded-0 fw-bold text-uppercase px-4 py-2" style="font-size: 0.8rem; letter-spacing: 0.5px;">
                            <i class="fa-solid fa-arrow-left me-1"></i> Tiếp tục mua sắm
                        </a>
                    </div>
                </div>

                <!-- Right: Order Summary Sidebar -->
                <div class="col-lg-4">
                    <div class="card rounded-0 border p-4 bg-light position-sticky" style="top: 100px;">
                        <h5 class="fw-bold text-uppercase border-bottom pb-3 mb-3" style="font-family: 'Outfit', sans-serif; letter-spacing: 0.5px; font-size: 1rem;">
                            TỔNG QUAN ĐƠN HÀNG
                        </h5>

                        <div class="d-flex justify-content-between align-items-center mb-2 small">
                            <span class="text-muted">Tổng số lượng:</span>
                            <strong class="text-dark">${TOTAL_ITEMS} sản phẩm</strong>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-2 small">
                            <span class="text-muted">Tạm tính:</span>
                            <strong class="text-dark"><fmt:formatNumber value="${TOTAL}" pattern="#,###"/> đ</strong>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom small">
                            <span class="text-muted">Phí vận chuyển:</span>
                            <span class="badge bg-success-subtle text-success border border-success-subtle rounded-0 px-2">MIỄN PHÍ</span>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="fw-bold text-uppercase" style="font-size: 0.95rem;">TỔNG THANH TOÁN:</span>
                            <span class="fw-bold fs-4" style="color: var(--color-primary, #ED1D24); font-family: 'Outfit', sans-serif;">
                                <fmt:formatNumber value="${TOTAL}" pattern="#,###"/> đ
                            </span>
                        </div>

                        <a href="checkout" class="btn btn-danger w-100 py-3 rounded-0 fw-bold text-uppercase mb-3" style="background-color: var(--color-primary, #ED1D24); border-color: var(--color-primary, #ED1D24); letter-spacing: 1px; font-size: 0.9rem;">
                            TIẾN HÀNH THANH TOÁN <i class="fa-solid fa-arrow-right ms-2"></i>
                        </a>

                        <!-- Value Props -->
                        <div class="pt-3 border-top mt-2">
                            <div class="d-flex align-items-center gap-2 mb-2 text-muted small" style="font-size: 0.78rem;">
                                <i class="fa-solid fa-truck-fast text-danger"></i>
                                <span>Giao hàng miễn phí toàn quốc</span>
                            </div>
                            <div class="d-flex align-items-center gap-2 mb-2 text-muted small" style="font-size: 0.78rem;">
                                <i class="fa-solid fa-rotate-left text-danger"></i>
                                <span>Đổi trả linh hoạt trong vòng 30 ngày</span>
                            </div>
                            <div class="d-flex align-items-center gap-2 text-muted small" style="font-size: 0.78rem;">
                                <i class="fa-solid fa-shield-check text-danger"></i>
                                <span>Bảo mật thanh toán VietQR SePay & COD</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="includes/footer.jsp" />
