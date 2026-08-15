<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp" />

<div class="row justify-content-center my-5">
    <div class="col-lg-7 col-md-9 text-center">
        <!-- Success Card -->
        <div class="card border border-dark-subtle rounded-0 p-4 p-md-5 bg-white shadow-sm">
            <!-- Animated Checkmark Icon -->
            <div class="mb-4">
                <div class="success-icon-circle mx-auto d-flex align-items-center justify-content-center">
                    <i class="fa-solid fa-check text-white fs-1"></i>
                </div>
            </div>

            <span class="badge bg-success-subtle text-success border border-success-subtle rounded-0 px-3 py-1 text-uppercase fw-bold mb-2 mx-auto" style="letter-spacing: 1px; width: fit-content;">
                Thanh toán & Đặt hàng thành công
            </span>

            <h2 class="fw-bold text-uppercase tracking-wide mt-2 mb-2">CẢM ƠN BẠN ĐÃ ĐẶT HÀNG!</h2>
            <p class="text-secondary small mb-4">
                Đơn hàng của bạn đã được tiếp nhận và đang được đội ngũ ONE61 Garment đóng gói chuẩn bị giao tới bạn.
            </p>

            <!-- Order Details Summary Box -->
            <div class="bg-light border p-4 text-start rounded-0 mb-4 small">
                <div class="row g-3">
                    <div class="col-sm-6">
                        <span class="text-muted d-block">Mã đơn hàng:</span>
                        <strong class="text-danger fs-6">#${not empty SUCCESS_ORDER_ID ? SUCCESS_ORDER_ID : param.orderID}</strong>
                    </div>
                    <div class="col-sm-6">
                        <span class="text-muted d-block">Phương thức thanh toán:</span>
                        <strong class="text-dark">
                            <c:choose>
                                <c:when test="${PAYMENT_METHOD eq 'QR_CODE' || param.method eq 'QR_CODE'}">
                                    <i class="fa-solid fa-qrcode text-danger me-1"></i> Chuyển khoản VietQR MB Bank (Đã nhận)
                                </c:when>
                                <c:otherwise>
                                    <i class="fa-solid fa-money-bill-wave text-success me-1"></i> Tiền mặt khi nhận hàng (COD)
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </div>
                    <div class="col-sm-6">
                        <span class="text-muted d-block">Thời gian đặt:</span>
                        <strong class="text-dark">Hôm nay (Giao dự kiến: 1 - 3 ngày)</strong>
                    </div>
                    <div class="col-sm-6">
                        <span class="text-muted d-block">Trạng thái đơn hàng:</span>
                        <span class="badge bg-success rounded-0">ĐANG XỬ LÝ (PROCESSING)</span>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex flex-column flex-sm-row gap-2 justify-content-center">
                <a href="home" class="btn btn-danger rounded-0 px-4 py-3 fw-bold text-uppercase small shadow-sm" style="background-color: var(--color-primary); letter-spacing: 0.5px;">
                    <i class="fa-solid fa-bag-shopping me-2"></i> TIẾP TỤC MUA SẮM
                </a>
                <a href="product" class="btn btn-outline-dark rounded-0 px-4 py-3 fw-bold text-uppercase small">
                    <i class="fa-solid fa-shirt me-2"></i> XEM BỘ SƯU TẬP MỚI
                </a>
            </div>
        </div>
    </div>
</div>

<style>
    .success-icon-circle {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background-color: #198754;
        box-shadow: 0 4px 20px rgba(25, 135, 84, 0.4);
        animation: scaleSuccess 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    @keyframes scaleSuccess {
        from { transform: scale(0); opacity: 0; }
        to { transform: scale(1); opacity: 1; }
    }
</style>

<jsp:include page="includes/footer.jsp" />
