<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="includes/header.jsp" />

<div class="row justify-content-center mt-4">
    <div class="col-md-6">
        <div class="card shadow border-0 rounded-3">
            <div class="card-body p-5">
                <h3 class="text-center fw-bold mb-4">ĐĂNG KÝ TÀI KHOẢN</h3>
                
                <c:if test="${not empty ERROR}">
                    <div class="alert alert-danger text-center">${ERROR}</div>
                </c:if>

                <form action="register" method="POST" id="registerForm">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="userID" name="userID" placeholder="Tên đăng nhập" required>
                                <label for="userID">Tên đăng nhập *</label>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Họ và tên" required>
                                <label for="fullName">Họ và tên *</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                        <label for="email">Email *</label>
                    </div>
                    
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="phone" name="phone" placeholder="Số điện thoại">
                        <label for="phone">Số điện thoại</label>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="form-floating">
                                <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>
                                <label for="password">Mật khẩu *</label>
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="form-floating">
                                <input type="password" class="form-control" id="confirm" name="confirm" placeholder="Xác nhận mật khẩu" required>
                                <label for="confirm">Xác nhận mật khẩu *</label>
                            </div>
                            <div id="passError" class="text-danger mt-1" style="display:none; font-size:0.875em;">Mật khẩu không khớp!</div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-dark w-100 py-3 fw-bold fs-5 mb-3">ĐĂNG KÝ</button>
                    <div class="text-center">
                        <span class="text-muted">Đã có tài khoản?</span> <a href="login" class="text-primary fw-bold text-decoration-none">Đăng nhập</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        var pass = document.getElementById('password').value;
        var confirm = document.getElementById('confirm').value;
        if (pass !== confirm) {
            e.preventDefault();
            document.getElementById('passError').style.display = 'block';
        }
    });
</script>

<jsp:include page="includes/footer.jsp" />
