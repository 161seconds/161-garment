<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Đăng Nhập | ONE61 Garmentory" />
</jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            <div class="card border border-dark-subtle rounded-0 p-4 shadow-sm bg-white">
                <div class="card-body p-2">
                    <div class="text-center mb-4">
                        <span class="badge bg-danger rounded-0 px-2 py-1 mb-2 text-uppercase" style="letter-spacing: 1px;">ONE61 Garmentory</span>
                        <h3 class="fw-bold text-uppercase tracking-wide m-0" style="font-family: 'Outfit', sans-serif;">ĐĂNG NHẬP</h3>
                        <p class="text-muted small mt-1">Đăng nhập tài khoản để tiếp tục mua sắm</p>
                    </div>
                    
                    <c:if test="${not empty ERROR}">
                        <div class="alert alert-danger rounded-0 small py-2 text-center mb-3">
                            <i class="fa-solid fa-circle-exclamation me-1"></i> ${ERROR}
                        </div>
                    </c:if>
                    <c:if test="${not empty SUCCESS}">
                        <div class="alert alert-success rounded-0 small py-2 text-center mb-3">
                            <i class="fa-solid fa-circle-check me-1"></i> ${SUCCESS}
                        </div>
                    </c:if>

                    <form action="login" method="POST">
                        <div class="mb-3">
                            <label for="email" class="form-label fw-bold small text-uppercase">
                                <i class="fa-solid fa-envelope me-1 text-danger"></i> Địa chỉ Gmail / Email <span class="text-danger">*</span>
                            </label>
                            <input type="email" class="form-control rounded-0 fw-semibold" id="email" name="email" value="${not empty enteredEmail ? enteredEmail : ''}" placeholder="VD: customer@gmail.com" autocomplete="email" required>
                        </div>
                        <div class="mb-4">
                            <label for="password" class="form-label fw-bold small text-uppercase">
                                <i class="fa-solid fa-lock me-1 text-danger"></i> Mật khẩu <span class="text-danger">*</span>
                            </label>
                            <input type="password" class="form-control rounded-0" id="password" name="password" placeholder="Nhập mật khẩu" autocomplete="current-password" required>
                        </div>
                        <button type="submit" class="btn btn-danger rounded-0 w-100 py-3 fw-bold text-uppercase mb-3" style="background-color: var(--color-primary, #ED1D24); border-color: var(--color-primary, #ED1D24); letter-spacing: 1px;">
                            ĐĂNG NHẬP
                        </button>
                        <div class="text-center pt-2 border-top">
                            <span class="text-muted small">Chưa có tài khoản?</span> 
                            <a href="register" class="text-danger text-decoration-none fw-bold small text-uppercase ms-1">Đăng ký ngay</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
