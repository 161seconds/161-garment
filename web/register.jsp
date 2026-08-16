<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="includes/header.jsp" />

<div class="row justify-content-center my-5">
    <div class="col-md-7 col-lg-6">
        <div class="card border border-dark-subtle rounded-0 p-4 shadow-sm bg-white">
            <div class="card-body p-2">
                <div class="text-center mb-4">
                    <span class="badge bg-danger rounded-0 px-2 py-1 mb-2 text-uppercase" style="letter-spacing: 1px;">ONE61 Garmentory</span>
                    <h3 class="fw-bold text-uppercase tracking-wide m-0">ĐĂNG KÝ TÀI KHOẢN</h3>
                    <p class="text-muted small mt-1">Tạo tài khoản thành viên để nhận nhiều ưu đãi</p>
                </div>
                
                <c:if test="${not empty ERROR}">
                    <div class="alert alert-danger rounded-0 small py-2 text-center mb-3">
                        <i class="fa-solid fa-circle-exclamation me-1"></i> ${ERROR}
                    </div>
                </c:if>

                <form action="register" method="POST" id="registerForm">
                    <div class="row g-3">
                        <div class="col-md-6 mb-3">
                            <label for="userID" class="form-label fw-bold small text-uppercase">Tên đăng nhập <span class="text-danger">*</span></label>
                            <input type="text" class="form-control rounded-0" id="userID" name="userID" placeholder="VD: user123" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="fullName" class="form-label fw-bold small text-uppercase">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control rounded-0" id="fullName" name="fullName" placeholder="VD: Nguyễn Văn A" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label fw-bold small text-uppercase">Địa chỉ Email <span class="text-danger">*</span></label>
                        <input type="email" class="form-control rounded-0" id="email" name="email" placeholder="name@example.com" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="phone" class="form-label fw-bold small text-uppercase">Số điện thoại</label>
                        <input type="text" class="form-control rounded-0" id="phone" name="phone" placeholder="09xxxxxxxx">
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label fw-bold small text-uppercase">Mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" class="form-control rounded-0" id="password" name="password" placeholder="Nhập mật khẩu" required>
                        </div>
                        <div class="col-md-6 mb-4">
                            <label for="confirm" class="form-label fw-bold small text-uppercase">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" class="form-control rounded-0" id="confirm" name="confirm" placeholder="Nhập lại mật khẩu" required>
                            <div id="passError" class="text-danger mt-1 small" style="display:none;">Mật khẩu xác nhận không khớp!</div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-danger rounded-0 w-100 py-3 fw-bold text-uppercase mb-3" style="background-color: var(--color-primary); border-color: var(--color-primary); letter-spacing: 1px;">
                        ĐĂNG KÝ TÀI KHOẢN
                    </button>
                    <div class="text-center pt-2 border-top">
                        <span class="text-muted small">Đã có tài khoản?</span> 
                        <a href="login" class="text-danger text-decoration-none fw-bold small text-uppercase ms-1">Đăng nhập</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    var regForm = document.getElementById('registerForm');
    if (regForm) {
        regForm.addEventListener('submit', function(e) {
            var pass = document.getElementById('password')?.value;
            var confirm = document.getElementById('confirm')?.value;
            if (pass && confirm && pass !== confirm) {
                e.preventDefault();
                var passError = document.getElementById('passError');
                if (passError) passError.style.display = 'block';
            }
        });
    }
</script>

<jsp:include page="includes/footer.jsp" />
