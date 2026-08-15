<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp" />

<div class="row mt-4 mb-4">
    <div class="col-12">
        <h3 class="fw-bold fs-4 text-uppercase">GIỎ HÀNG CỦA BẠN</h3>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <c:choose>
            <c:when test="${empty sessionScope.CART}">
                <div class="text-center py-5 border">
                    <h5 class="mb-3 text-muted">Giỏ hàng trống!</h5>
                    <a href="product" class="btn btn-outline-dark rounded-0 fw-bold px-4">TIẾP TỤC MUA SẮM</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card border-0 rounded-0 mb-4">
                    <div class="card-body p-0">
                        <table class="table align-middle mb-0 border-top">
                            <thead>
                                <tr>
                                    <th class="ps-4">Sản phẩm</th>
                                    <th class="text-center">Đơn giá</th>
                                    <th class="text-center" style="width: 150px;">Số lượng</th>
                                    <th class="text-center">Thành tiền</th>
                                    <th class="text-center">Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${sessionScope.CART}">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="d-flex align-items-center">
                                                <img src="${pageContext.request.contextPath}/img-prj301/${item.product.image}" width="60" class="rounded-0 me-3 border">
                                                <span class="fw-bold">${item.product.name}</span>
                                            </div>
                                        </td>
                                        <td class="text-center fw-bold">
                                            <fmt:formatNumber value="${item.product.price}" pattern="#,###"/> đ
                                        </td>
                                        <td class="text-center">
                                            <form action="cart" method="POST" class="d-flex justify-content-center">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="id" value="${item.product.productID}">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.quantity}" class="form-control form-control-sm text-center rounded-0" style="width: 60px;" onchange="this.form.submit()">
                                            </form>
                                        </td>
                                        <td class="text-center fw-bold">
                                            <fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,###"/> đ
                                        </td>
                                        <td class="text-center">
                                            <a href="cart?action=remove&id=${item.product.productID}" class="btn btn-sm btn-outline-dark rounded-0"><i class="fa-solid fa-trash"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <c:if test="${not empty sessionScope.CART}">
        <div class="col-md-4">
            <div class="card border-0 rounded-0 bg-light">
                <div class="card-body p-4">
                    <h5 class="fw-bold border-bottom pb-3 mb-3 text-uppercase fs-6">TỔNG ĐƠN HÀNG</h5>
                    <div class="d-flex justify-content-between mb-3 fs-6">
                        <span class="text-dark">Tạm tính:</span>
                        <span class="fw-bold"><fmt:formatNumber value="${TOTAL}" pattern="#,###"/> đ</span>
                    </div>
                    <div class="d-flex justify-content-between mb-4 border-bottom pb-3 fs-6">
                        <span class="text-dark">Phí vận chuyển:</span>
                        <span class="fw-bold">0 đ</span>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                        <span class="fw-bold fs-5 text-uppercase">TỔNG CỘNG:</span>
                        <span class="fw-bold fs-4" style="color: var(--color-accent);"><fmt:formatNumber value="${TOTAL}" pattern="#,###"/> đ</span>
                    </div>
                    <a href="checkout" class="btn btn-accent w-100 py-3 fw-bold fs-6">TIẾN HÀNH THANH TOÁN</a>
                </div>
            </div>
        </div>
    </c:if>
</div>

<jsp:include page="includes/footer.jsp" />
