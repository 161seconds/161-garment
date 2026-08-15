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

<c:choose>
    <c:when test="${empty sessionScope.CART}">
        <div class="row justify-content-center my-5 py-4">
            <div class="col-md-7 text-center py-5 border bg-white shadow-sm">
                <i class="fa-solid fa-cart-shopping fs-1 text-muted mb-3 d-block opacity-50"></i>
                <h4 class="mb-2 text-uppercase fw-bold">GIỎ HÀNG CỦA BẠN ĐANG TRỐNG!</h4>
                <p class="text-muted small mb-4">Vui lòng chọn ít nhất một sản phẩm trước khi tiến hành thanh toán.</p>
                <a href="product" class="btn btn-danger rounded-0 fw-bold px-4 py-2 text-uppercase" style="background-color: var(--color-primary);">
                    <i class="fa-solid fa-arrow-left me-1"></i> TIẾP TỤC MUA SẮM
                </a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <!-- Checkout Progress Stepper -->
        <div class="row justify-content-center mb-4">
            <div class="col-lg-10">
                <div class="d-flex align-items-center justify-content-center gap-2 gap-md-4 py-2">
                    <!-- Step 1 Indicator -->
                    <div class="d-flex align-items-center gap-2" id="step1Indicator">
                        <span class="stepper-badge active-step" id="badgeStep1">1</span>
                        <span class="small fw-bold text-uppercase" id="textStep1">Thông tin giao hàng</span>
                    </div>

                    <div class="stepper-line" id="stepperLine"></div>

                    <!-- Step 2 Indicator -->
                    <div class="d-flex align-items-center gap-2" id="step2Indicator">
                        <span class="stepper-badge" id="badgeStep2">2</span>
                        <span class="small fw-bold text-uppercase text-muted" id="textStep2">Thanh toán & Mã QR</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 my-2 mb-5">
            <!-- Left Column: Step 1 (Shipping Form) & Step 2 (Payment & QR) -->
            <div class="col-lg-7 col-md-12">
                <form id="checkoutForm" action="checkout" method="POST" novalidate>
                    <!-- ================= STEP 1: DELIVERY INFO ================= -->
                    <div class="card border border-dark-subtle rounded-0 p-4 bg-white shadow-sm" id="deliveryStepContainer">
                <div class="d-flex align-items-center justify-content-between pb-3 mb-4 border-bottom">
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-danger rounded-0 px-2 py-1 text-uppercase" style="letter-spacing: 0.5px;">BƯỚC 1</span>
                        <h5 class="fw-bold text-uppercase m-0">THÔNG TIN GIAO HÀNG</h5>
                    </div>
                    <small class="text-muted"><i class="fa-solid fa-truck-fast text-danger me-1"></i> Giao nhanh 1-3 ngày</small>
                </div>
                
                <c:if test="${not empty ERROR}">
                    <div class="alert alert-danger rounded-0 small py-2 mb-4">
                        <i class="fa-solid fa-circle-exclamation me-1"></i> ${ERROR}
                    </div>
                </c:if>

                <div class="alert alert-light border rounded-0 small py-2 mb-3 text-secondary">
                    <i class="fa-solid fa-circle-info text-primary me-1"></i> Vui lòng điền đầy đủ các thông tin bắt buộc <span class="text-danger">(*)</span> để tiếp tục đến bước thanh toán.
                </div>

                <!-- Customer Info -->
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-uppercase">Họ và tên người nhận <span class="text-danger">*</span></label>
                        <input type="text" class="form-control rounded-0 fw-semibold" id="inputFullName" name="fullName" 
                               value="${sessionScope.LOGIN_USER.fullName}" required placeholder="Nguyễn Văn A">
                        <div class="invalid-feedback small">Vui lòng nhập họ và tên người nhận hàng.</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-uppercase">Số điện thoại nhận hàng <span class="text-danger">*</span></label>
                        <input type="tel" class="form-control rounded-0 fw-semibold" id="inputPhone" name="phone" 
                               value="${sessionScope.LOGIN_USER.phone}" required pattern="[0-9]{10,11}" placeholder="0987654321">
                        <div class="invalid-feedback small">Vui lòng nhập số điện thoại hợp lệ (10-11 số).</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold small text-uppercase">Địa chỉ nhận hàng chi tiết <span class="text-danger">*</span></label>
                    <textarea class="form-control rounded-0" id="inputAddress" name="address" rows="3" required 
                              placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố..."></textarea>
                    <div class="invalid-feedback small">Vui lòng nhập địa chỉ giao hàng cụ thể.</div>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold small text-uppercase">Ghi chú giao hàng (Tùy chọn)</label>
                    <textarea class="form-control rounded-0" id="inputNote" name="note" rows="2" 
                              placeholder="Ví dụ: Giao giờ hành chính, gọi trước khi đến 15 phút..."></textarea>
                </div>

                <!-- Button to Go to Step 2 -->
                <div class="pt-2 d-flex flex-column gap-2">
                    <button type="button" class="btn btn-danger rounded-0 w-100 py-3 fw-bold text-uppercase fs-6 shadow-sm" 
                            style="background-color: var(--color-primary); letter-spacing: 1px;" 
                            onclick="goToPaymentStep()">
                        TIẾP TỤC ĐẾN THANH TOÁN <i class="fa-solid fa-arrow-right ms-2"></i>
                    </button>
                    <a href="cart" class="btn btn-outline-dark rounded-0 w-100 py-2 text-uppercase fw-bold small text-center">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại giỏ hàng
                    </a>
                </div>
            </div>

            <!-- ================= STEP 2: PAYMENT & QR ================= -->
            <div class="card border border-dark-subtle rounded-0 p-4 bg-white shadow-sm" id="paymentStepContainer" style="display: none;">
                <div class="d-flex align-items-center justify-content-between pb-3 mb-3 border-bottom">
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-success rounded-0 px-2 py-1 text-uppercase" style="letter-spacing: 0.5px;">BƯỚC 2</span>
                        <h5 class="fw-bold text-uppercase m-0">CHỌN PHƯƠNG THỨC THANH TOÁN</h5>
                    </div>
                    <small class="text-muted"><i class="fa-solid fa-lock text-success me-1"></i> Bảo mật SSL 256-bit</small>
                </div>

                <!-- Verified Delivery Summary Box -->
                <div class="bg-light p-3 border mb-4 position-relative">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <span class="badge bg-success rounded-0 text-uppercase mb-1" style="font-size: 0.65rem;">
                                <i class="fa-solid fa-check me-1"></i> Đã xác nhận giao hàng
                            </span>
                            <div class="fw-bold text-dark mt-1" id="summaryRecipient">Nguyễn Văn A - 0987654321</div>
                            <div class="text-muted small mt-1" id="summaryAddress">Địa chỉ nhận hàng</div>
                            <div class="text-muted small fst-italic mt-1" id="summaryNote" style="display: none;"></div>
                        </div>
                        <button type="button" class="btn btn-outline-dark btn-sm rounded-0 py-1 px-2 small fw-bold" onclick="goToDeliveryStep()">
                            <i class="fa-solid fa-pen-to-square me-1"></i> Sửa
                        </button>
                    </div>
                </div>

                <!-- Payment Methods Section -->
                <div class="mb-4">
                    <!-- Payment Option 1: VietQR Code Transfer -->
                    <div class="payment-card border p-3 mb-3 cursor-pointer selected-method" id="cardQR" onclick="selectPaymentMethod('QR_CODE')">
                        <div class="form-check d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center">
                                <input class="form-check-input me-3 my-0" type="radio" name="paymentMethod" id="payQR" value="QR_CODE" checked>
                                <label class="form-check-label fw-bold text-uppercase small cursor-pointer" for="payQR">
                                    <i class="fa-solid fa-qrcode text-danger fs-5 me-2 align-middle"></i>
                                    Chuyển khoản Ngân hàng qua mã VietQR
                                </label>
                            </div>
                            <span class="badge bg-success-subtle text-success border border-success-subtle rounded-0 px-2 py-1 small fw-bold">
                                Khuyên dùng • Tức thì
                            </span>
                        </div>
                        <p class="text-muted small ms-4 ps-2 mb-0 mt-1">
                            Quét mã QR qua mọi ứng dụng Ngân hàng (MB, VCB, Techcombank, BIDV...) hoặc ví MoMo, ZaloPay. Tự động điền số tiền và nội dung.
                        </p>

                        <!-- Expanded QR Code Box -->
                        <div id="qrDetailsBox" class="mt-3 pt-3 border-top bg-light p-3">
                            <div class="row align-items-center g-3">
                                <!-- QR Image Preview -->
                                <div class="col-md-5 text-center">
                                    <div class="bg-white p-2 border shadow-sm d-inline-block">
                                        <c:set var="qrAmount" value="${TOTAL != null ? TOTAL.intValue() : 0}" />
                                        <c:set var="qrContent" value="161GM ${sessionScope.LOGIN_USER.phone != null ? sessionScope.LOGIN_USER.phone : 'ORDER'}" />
                                        <img id="vietQrImg" src="https://img.vietqr.io/image/MB-08222216167810-compact2.png?amount=${qrAmount}&addInfo=${qrContent}&accountName=NGUYEN%20VAN%20QUOC%20BAO" 
                                             onerror="this.src='${pageContext.request.contextPath}/img-prj301/mb-bank-qr.png'"
                                             alt="Mã VietQR MB Bank 08222216167810" 
                                             class="img-fluid" 
                                             style="max-width: 180px; height: auto;" />
                                    </div>
                                    <div class="mt-1">
                                        <small class="text-muted fw-bold d-block" style="font-size: 0.72rem;">
                                            <i class="fa-solid fa-camera me-1"></i> Quét bằng App Ngân hàng bất kỳ
                                        </small>
                                    </div>
                                </div>

                                <!-- Bank Details -->
                                <div class="col-md-7 small">
                                    <div class="mb-2 pb-1 border-bottom d-flex justify-content-between align-items-center">
                                        <span class="text-muted">Ngân hàng:</span>
                                        <strong class="text-dark">MB Bank (Ngân hàng TMCP Quân Đội)</strong>
                                    </div>
                                    <div class="mb-2 pb-1 border-bottom d-flex justify-content-between align-items-center">
                                        <span class="text-muted">Chủ tài khoản:</span>
                                        <strong class="text-dark text-uppercase">NGUYEN VAN QUOC BAO</strong>
                                    </div>
                                    <div class="mb-2 pb-1 border-bottom d-flex justify-content-between align-items-center">
                                        <span class="text-muted">Số tài khoản:</span>
                                        <div class="d-flex align-items-center gap-2">
                                            <strong class="text-danger fs-6" id="bankAccNumber">08222216167810</strong>
                                            <button type="button" class="btn btn-outline-secondary btn-sm rounded-0 py-0 px-2" style="font-size: 0.7rem;" onclick="copyText('08222216167810', this)">
                                                <i class="fa-regular fa-copy me-1"></i> Sao chép
                                            </button>
                                        </div>
                                    </div>
                                    <div class="mb-2 pb-1 border-bottom d-flex justify-content-between align-items-center">
                                        <span class="text-muted">Số tiền:</span>
                                        <div class="d-flex align-items-center gap-2">
                                            <strong class="text-danger fw-bold"><fmt:formatNumber value="${TOTAL}" pattern="#,###"/> đ</strong>
                                            <button type="button" class="btn btn-outline-secondary btn-sm rounded-0 py-0 px-2" style="font-size: 0.7rem;" onclick="copyText('${qrAmount}', this)">
                                                <i class="fa-regular fa-copy me-1"></i> Sao chép
                                            </button>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-muted">Nội dung CK:</span>
                                        <div class="d-flex align-items-center gap-2">
                                            <strong class="text-primary" id="textQrContent">${qrContent}</strong>
                                            <button type="button" class="btn btn-outline-secondary btn-sm rounded-0 py-0 px-2" style="font-size: 0.7rem;" onclick="copyText(document.getElementById('textQrContent').innerText, this)">
                                                <i class="fa-regular fa-copy me-1"></i> Sao chép
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Option 2: Cash On Delivery (COD) -->
                    <div class="payment-card border p-3 cursor-pointer" id="cardCOD" onclick="selectPaymentMethod('COD')">
                        <div class="form-check d-flex align-items-center">
                            <input class="form-check-input me-3 my-0" type="radio" name="paymentMethod" id="payCOD" value="COD">
                            <label class="form-check-label fw-bold text-uppercase small cursor-pointer" for="payCOD">
                                <i class="fa-solid fa-money-bill-wave text-success fs-5 me-2 align-middle"></i>
                                Thanh toán tiền mặt khi nhận hàng (COD)
                            </label>
                        </div>
                        <p class="text-muted small ms-4 ps-2 mb-0 mt-1">
                            Thanh toán trực tiếp bằng tiền mặt cho shipper khi nhận được bưu kiện. Được kiểm tra hàng trước khi thanh toán.
                        </p>
                    </div>
                </div>

                <!-- Confirm Order Action -->
                <div class="pt-3 border-top d-flex flex-column gap-2">
                    <button type="submit" class="btn btn-danger rounded-0 w-100 py-3 fw-bold text-uppercase fs-6 shadow-sm" 
                            style="background-color: var(--color-primary); letter-spacing: 1px;">
                        <i class="fa-solid fa-shield-check me-2"></i> HOÀN TẤT & ĐẶT HÀNG
                    </button>
                    <button type="button" class="btn btn-outline-dark rounded-0 w-100 py-2 text-uppercase fw-bold small text-center" 
                            onclick="goToDeliveryStep()">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại sửa thông tin nhận hàng
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Right Column: Order Summary -->
    <div class="col-lg-5 col-md-12">
        <div class="card border border-dark-subtle rounded-0 bg-white shadow-sm p-4 sticky-top" style="top: 90px; z-index: 1000;">
            <div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
                <h5 class="fw-bold text-uppercase m-0" style="font-size: 0.95rem;">ĐƠN HÀNG CỦA BẠN</h5>
                <span class="badge bg-dark rounded-0">${sessionScope.CART != null ? sessionScope.CART.size() : 0} sản phẩm</span>
            </div>

            <!-- Item List -->
            <div class="order-items-scroll mb-3" style="max-height: 280px; overflow-y: auto;">
                <c:forEach var="item" items="${sessionScope.CART}">
                    <div class="d-flex align-items-center justify-content-between py-2 border-bottom">
                        <div class="d-flex align-items-center gap-3">
                            <div class="position-relative">
                                <img src="${pageContext.request.contextPath}/img-prj301/${item.product.image}" 
                                     alt="${item.product.name}" 
                                     width="50" height="50" 
                                     class="object-fit-cover border">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.65rem;">
                                    ${item.quantity}
                                </span>
                            </div>
                            <div>
                                <h6 class="small fw-bold mb-0 text-truncate" style="max-width: 170px;">${item.product.name}</h6>
                                <small class="text-muted"><fmt:formatNumber value="${item.product.price}" pattern="#,###"/> đ</small>
                            </div>
                        </div>
                        <div class="fw-bold small text-end">
                            <fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,###"/> đ
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Price Calculations -->
            <div class="d-flex justify-content-between mb-2 small">
                <span class="text-secondary">Tạm tính:</span>
                <span class="fw-bold"><fmt:formatNumber value="${TOTAL}" pattern="#,###"/> đ</span>
            </div>
            <div class="d-flex justify-content-between mb-3 small pb-3 border-bottom">
                <span class="text-secondary">Phí vận chuyển:</span>
                <span class="fw-bold text-success">MIỄN PHÍ</span>
            </div>
            <div class="d-flex justify-content-between align-items-center mb-3">
                <span class="fw-bold text-uppercase fs-6">TỔNG CỘNG:</span>
                <span class="fw-bold fs-4 text-danger"><fmt:formatNumber value="${TOTAL}" pattern="#,###"/> đ</span>
            </div>

            <!-- Guarantees -->
            <div class="bg-light p-3 border rounded-0 small text-secondary">
                <div class="d-flex align-items-center gap-2 mb-2">
                    <i class="fa-solid fa-truck-fast text-danger"></i>
                    <span>Giao hàng nhanh toàn quốc từ 1 - 3 ngày</span>
                </div>
                <div class="d-flex align-items-center gap-2 mb-2">
                    <i class="fa-solid fa-rotate-left text-danger"></i>
                    <span>Đổi trả miễn phí trong vòng 30 ngày</span>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <i class="fa-solid fa-circle-check text-danger"></i>
                    <span>Cam kết sản phẩm LifeWear 100% chính hãng</span>
                </div>
            </div>
        </div>
    </div>
</div>
    </c:otherwise>
</c:choose>

<style>
    /* Stepper Styling */
    .stepper-badge {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        background-color: #E0E0E0;
        color: #666666;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 0.85rem;
        transition: all 0.3s ease;
    }
    .stepper-badge.active-step {
        background-color: var(--color-primary);
        color: #FFFFFF;
        box-shadow: 0 2px 8px rgba(255, 0, 0, 0.35);
    }
    .stepper-badge.completed-step {
        background-color: #198754;
        color: #FFFFFF;
    }
    .stepper-line {
        flex: 1;
        max-width: 80px;
        height: 2px;
        background-color: #E0E0E0;
        transition: all 0.3s ease;
    }
    .stepper-line.active-line {
        background-color: #198754;
    }

    .payment-card {
        transition: all 0.2s ease-in-out;
        border-color: #E5E5E5 !important;
        background-color: #FFFFFF;
    }
    .payment-card.selected-method {
        border-color: var(--color-primary) !important;
        background-color: #FFFDFD;
        box-shadow: 0 2px 10px rgba(255, 0, 0, 0.05);
    }
    .cursor-pointer {
        cursor: pointer;
    }
    .fade-in {
        animation: fadeInAnimation 0.3s ease-in-out;
    }
    @keyframes fadeInAnimation {
        from { opacity: 0; transform: translateY(8px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<script>
    function goToPaymentStep() {
        const fullName = document.getElementById('inputFullName');
        const phone = document.getElementById('inputPhone');
        const address = document.getElementById('inputAddress');
        const note = document.getElementById('inputNote');

        let isValid = true;

        // Reset previous validation
        fullName.classList.remove('is-invalid');
        phone.classList.remove('is-invalid');
        address.classList.remove('is-invalid');

        // Validate Full Name
        if (!fullName.value.trim()) {
            fullName.classList.add('is-invalid');
            if (isValid) fullName.focus();
            isValid = false;
        }

        // Validate Phone (10-11 digits)
        const phoneRegex = /^[0-9]{9,11}$/;
        const cleanPhone = phone.value.trim().replace(/\s+/g, '');
        if (!phoneRegex.test(cleanPhone)) {
            phone.classList.add('is-invalid');
            if (isValid) phone.focus();
            isValid = false;
        }

        // Validate Address
        if (!address.value.trim() || address.value.trim().length < 5) {
            address.classList.add('is-invalid');
            if (isValid) address.focus();
            isValid = false;
        }

        // Only proceed if all required fields are valid!
        if (!isValid) {
            return;
        }

        // Update Step 2 Summary text
        document.getElementById('summaryRecipient').textContent = fullName.value.trim() + ' • ' + cleanPhone;
        document.getElementById('summaryAddress').textContent = address.value.trim();
        if (note.value.trim()) {
            document.getElementById('summaryNote').textContent = 'Ghi chú: "' + note.value.trim() + '"';
            document.getElementById('summaryNote').style.display = 'block';
        } else {
            document.getElementById('summaryNote').style.display = 'none';
        }

        // Update dynamic VietQR content and image with the verified phone number
        const qrContentStr = '161GM ' + cleanPhone;
        document.getElementById('textQrContent').textContent = qrContentStr;
        const qrAmount = '${TOTAL != null ? TOTAL.intValue() : 0}';
        const newQrUrl = 'https://img.vietqr.io/image/MB-08222216167810-compact2.png?amount=' + qrAmount + '&addInfo=' + encodeURIComponent(qrContentStr) + '&accountName=NGUYEN%20VAN%20QUOC%20BAO';
        document.getElementById('vietQrImg').src = newQrUrl;

        // Transition UI: Hide Step 1, Show Step 2
        document.getElementById('deliveryStepContainer').style.display = 'none';
        const payContainer = document.getElementById('paymentStepContainer');
        payContainer.style.display = 'block';
        payContainer.classList.add('fade-in');

        // Start SePay real-time polling to auto-redirect on bank transfer
        startPaymentPolling(cleanPhone);

        // Update Stepper Badges
        document.getElementById('badgeStep1').className = 'stepper-badge completed-step';
        document.getElementById('badgeStep1').innerHTML = '<i class="fa-solid fa-check"></i>';
        document.getElementById('textStep1').className = 'small fw-bold text-uppercase text-success';
        document.getElementById('stepperLine').className = 'stepper-line active-line';

        document.getElementById('badgeStep2').className = 'stepper-badge active-step';
        document.getElementById('textStep2').className = 'small fw-bold text-uppercase text-dark';

        // Scroll to top of payment container smoothly
        window.scrollTo({ top: payContainer.offsetTop - 100, behavior: 'smooth' });
    }

    let paymentPollInterval = null;
    function startPaymentPolling(phone) {
        if (paymentPollInterval) clearInterval(paymentPollInterval);
        const cleanPhone = encodeURIComponent(phone.replace(/\s+/g, ''));
        
        paymentPollInterval = setInterval(function() {
            fetch('api/check-payment?phone=' + cleanPhone)
                .then(res => res.json())
                .then(data => {
                    if (data && data.paid) {
                        clearInterval(paymentPollInterval);
                        const qrBox = document.getElementById('qrDetailsBox');
                        if (qrBox) {
                            qrBox.innerHTML = '<div class="text-center py-4 bg-white border border-success"><i class="fa-solid fa-circle-check text-success fs-1 mb-2"></i><h5 class="fw-bold text-success mb-1">ĐÃ NHẬN TIỀN CHUYỂN KHOẢN TỪ SEPAY!</h5><p class="text-muted small mb-0">Hệ thống đang tự động hoàn tất đơn hàng...</p></div>';
                        }
                        setTimeout(function() {
                            document.getElementById('checkoutForm').submit();
                        }, 1200);
                    }
                })
                .catch(err => console.log('Checking payment...', err));
        }, 2500);
    }

    function goToDeliveryStep() {
        if (paymentPollInterval) clearInterval(paymentPollInterval);
        document.getElementById('paymentStepContainer').style.display = 'none';
        const deliveryContainer = document.getElementById('deliveryStepContainer');
        deliveryContainer.style.display = 'block';
        deliveryContainer.classList.add('fade-in');

        // Update Stepper Badges back to Step 1 active
        document.getElementById('badgeStep1').className = 'stepper-badge active-step';
        document.getElementById('badgeStep1').textContent = '1';
        document.getElementById('textStep1').className = 'small fw-bold text-uppercase text-dark';
        document.getElementById('stepperLine').className = 'stepper-line';

        document.getElementById('badgeStep2').className = 'stepper-badge';
        document.getElementById('textStep2').className = 'small fw-bold text-uppercase text-muted';

        window.scrollTo({ top: deliveryContainer.offsetTop - 100, behavior: 'smooth' });
    }

    function selectPaymentMethod(method) {
        const cardQR = document.getElementById('cardQR');
        const cardCOD = document.getElementById('cardCOD');
        const payQR = document.getElementById('payQR');
        const payCOD = document.getElementById('payCOD');
        const qrBox = document.getElementById('qrDetailsBox');

        if (method === 'QR_CODE') {
            payQR.checked = true;
            cardQR.classList.add('selected-method');
            cardCOD.classList.remove('selected-method');
            qrBox.style.display = 'block';
        } else {
            payCOD.checked = true;
            cardCOD.classList.add('selected-method');
            cardQR.classList.remove('selected-method');
            qrBox.style.display = 'none';
        }
    }

    function copyText(text, btnElement) {
        navigator.clipboard.writeText(text).then(function() {
            const originalHtml = btnElement.innerHTML;
            btnElement.innerHTML = '<i class="fa-solid fa-check text-success me-1"></i> Đã sao chép!';
            btnElement.classList.add('btn-success', 'text-white');
            btnElement.classList.remove('btn-outline-secondary');
            setTimeout(function() {
                btnElement.innerHTML = originalHtml;
                btnElement.classList.remove('btn-success', 'text-white');
                btnElement.classList.add('btn-outline-secondary');
            }, 1800);
        }).catch(function(err) {
            console.error('Không thể sao chép: ', err);
        });
    }
</script>

<jsp:include page="includes/footer.jsp" />
