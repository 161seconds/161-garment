<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Đăng Ký Thành Viên | ONE61 Garmentory" />
</jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-5">
            <div class="card border border-dark-subtle rounded-0 p-4 shadow-sm bg-white">
                <div class="card-body p-2">
                    <div class="text-center mb-4">
                        <span class="badge bg-danger rounded-0 px-2 py-1 mb-2 text-uppercase" style="letter-spacing: 1px;">ONE61 Garmentory</span>
                        <h3 class="fw-bold text-uppercase tracking-wide m-0" style="font-family: 'Outfit', sans-serif;">ĐĂNG KÝ TÀI KHOẢN</h3>
                        <p class="text-muted small mt-1">Trở thành thành viên LifeWear để nhận nhiều ưu đãi</p>
                    </div>
                    
                    <c:if test="${not empty ERROR}">
                        <div class="alert alert-danger rounded-0 small py-2 text-center mb-3">
                            <i class="fa-solid fa-circle-exclamation me-1"></i> ${ERROR}
                        </div>
                    </c:if>

                    <form action="register" method="POST" id="registerForm">
                        <div class="mb-3">
                            <label for="fullName" class="form-label fw-bold small text-uppercase">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control rounded-0 fw-semibold" id="fullName" name="fullName" value="${not empty fullName ? fullName : ''}" placeholder="VD: Nguyễn Văn A" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="email" class="form-label fw-bold small text-uppercase">Địa chỉ Gmail / Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control rounded-0 fw-semibold" id="email" name="email" value="${not empty email ? email : ''}" placeholder="VD: name@gmail.com" required>
                            <div class="form-text small text-muted">Dùng để nhận thông báo đơn hàng và đăng nhập tài khoản.</div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="phone" class="form-label fw-bold small text-uppercase">Số điện thoại <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control rounded-0 fw-semibold" id="phone" name="phone" value="${not empty phone ? phone : ''}" pattern="[0-9]{9,11}" placeholder="09xxxxxxxx" required>
                        </div>

                        <div class="row g-3 mb-2">
                            <div class="col-md-6">
                                <label for="password" class="form-label fw-bold small text-uppercase">Mật khẩu <span class="text-danger">*</span></label>
                                <input type="password" class="form-control rounded-0" id="password" name="password" minlength="6" placeholder="Tối thiểu 6 ký tự" required>
                            </div>
                            <div class="col-md-6">
                                <label for="confirm" class="form-label fw-bold small text-uppercase">Xác nhận <span class="text-danger">*</span></label>
                                <input type="password" class="form-control rounded-0" id="confirm" name="confirm" minlength="6" placeholder="Nhập lại mật khẩu" required>
                            </div>
                        </div>

                        <div class="p-2 mb-3 bg-light border border-dark-subtle small">
                            <div class="fw-bold text-dark mb-1" style="font-size: 0.75rem;">
                                <i class="fa-solid fa-shield-halved text-danger me-1"></i> TIÊU CHUẨN MẬT KHẨU BẢO MẬT:
                            </div>
                            <ul class="mb-0 ps-3 text-muted" style="font-size: 0.75rem; line-height: 1.4;">
                                <li>Độ dài tối thiểu từ <strong>6 ký tự</strong></li>
                                <li>Có ít nhất <strong>1 chữ cái in hoa (A-Z)</strong></li>
                                <li>Có ít nhất <strong>1 chữ số (0-9)</strong></li>
                                <li>Có ít nhất <strong>1 ký tự đặc biệt</strong> (VD: @, #, $, %, !, *, ?, &amp;...)</li>
                            </ul>
                        </div>

                        <div id="passError" class="alert alert-danger rounded-0 small py-2 text-center mb-3" style="display:none;"></div>

                        <button type="submit" class="btn btn-danger rounded-0 w-100 py-3 fw-bold text-uppercase mb-3" style="background-color: var(--color-primary, #ED1D24); border-color: var(--color-primary, #ED1D24); letter-spacing: 1px;">
                            ĐĂNG KÝ TÀI KHOẢN
                        </button>
                        
                        <div class="text-center pt-2 border-top">
                            <span class="text-muted small">Đã có tài khoản?</span> 
                            <a href="login" class="text-danger text-decoration-none fw-bold small text-uppercase ms-1">Đăng nhập ngay</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var regForm = document.getElementById('registerForm');
    if (regForm) {
        regForm.addEventListener('submit', function(e) {
            var pass = document.getElementById('password')?.value || '';
            var confirm = document.getElementById('confirm')?.value || '';
            var passError = document.getElementById('passError');

            var hasUpper = /[A-Z]/.test(pass);
            var hasDigit = /[0-9]/.test(pass);
            var hasSpecial = /[^A-Za-z0-9\s]/.test(pass);

            if (pass.length < 6 || !hasUpper || !hasDigit || !hasSpecial) {
                e.preventDefault();
                if (passError) {
                    passError.textContent = 'Mật khẩu phải từ 6 ký tự, gồm ít nhất 1 chữ hoa, 1 chữ số và 1 ký tự đặc biệt!';
                    passError.style.display = 'block';
                }
                return;
            }

            if (pass !== confirm) {
                e.preventDefault();
                if (passError) {
                    passError.textContent = 'Mật khẩu xác nhận không khớp!';
                    passError.style.display = 'block';
                }
                return;
            }

            if (passError) passError.style.display = 'none';
        });
    }
</script>

<jsp:include page="includes/footer.jsp" />
