<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp" />

<!-- Breadcrumbs -->
<nav aria-label="breadcrumb" class="my-3">
    <ol class="breadcrumb small text-uppercase fw-bold">
        <li class="breadcrumb-item"><a href="home" class="text-decoration-none text-dark">Trang chủ</a></li>
        <li class="breadcrumb-item"><a href="cart" class="text-decoration-none text-dark">Giỏ hàng</a></li>
        <li class="breadcrumb-item active text-danger" aria-current="page">Thanh toán</li>
    </ol>
</nav>

<div class="row justify-content-center my-4">
    <div class="col-lg-8 col-md-10">
        <div class="card border border-dark-subtle rounded-0 p-4 p-md-5 bg-white shadow-sm">
            <div class="text-center mb-4 pb-2 border-bottom">
                <span class="badge bg-danger rounded-0 px-2 py-1 mb-2 text-uppercase" style="letter-spacing: 1px;">Checkout</span>
                <h3 class="fw-bold text-uppercase tracking-wide m-0">THÔNG TIN GIAO HÀNG</h3>
                <p class="text-muted small mt-1">Vui lòng kiểm tra và xác nhận địa chỉ nhận hàng của bạn</p>
            </div>
            
            <c:if test="${not empty ERROR}">
                <div class="alert alert-danger rounded-0 small py-2 text-center mb-4">
                    <i class="fa-solid fa-circle-exclamation me-1"></i> ${ERROR}
                </div>
            </c:if>

            <form action="checkout" method="POST">
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-uppercase">Họ và tên người nhận</label>
                        <input type="text" class="form-control rounded-0 bg-light fw-bold" value="${sessionScope.LOGIN_USER.fullName}" readonly>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-uppercase">Số điện thoại</label>
                        <input type="text" class="form-control rounded-0 bg-light fw-bold" value="${sessionScope.LOGIN_USER.phone}" readonly>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small text-uppercase">Địa chỉ giao hàng chi tiết <span class="text-danger">*</span></label>
                    <textarea class="form-control rounded-0" name="address" rows="3" required placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố..."></textarea>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold small text-uppercase">Ghi chú đơn hàng (Tùy chọn)</label>
                    <textarea class="form-control rounded-0" name="note" rows="2" placeholder="Ghi chú giao hàng (ví dụ: giao giờ hành chính, gọi trước khi giao)..."></textarea>
                </div>

                <div class="p-3 bg-light border mb-4">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-money-bill-wave text-success fs-4 me-3"></i>
                        <div>
                            <span class="fw-bold d-block text-uppercase small">Hình thức thanh toán:</span>
                            <span class="text-muted small">Thanh toán tiền mặt khi nhận hàng (COD). Kiểm tra hàng trước khi thanh toán.</span>
                        </div>
                    </div>
                </div>

                <div class="d-flex flex-column gap-2">
                    <button type="submit" class="btn btn-danger rounded-0 w-100 py-3 fw-bold text-uppercase fs-6" style="background-color: var(--color-primary); letter-spacing: 1px;">
                        XÁC NHẬN ĐẶT HÀNG
                    </button>
                    <a href="cart" class="btn btn-outline-dark rounded-0 w-100 py-2 text-uppercase fw-bold small text-center">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại giỏ hàng
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
