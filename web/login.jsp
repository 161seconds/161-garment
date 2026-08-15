<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="includes/header.jsp" />

<div class="row justify-content-center mt-5">
    <div class="col-md-5">
        <div class="card shadow-lg border-0 rounded-3">
            <div class="card-body p-5">
                <h3 class="text-center fw-bold mb-4">ĐĂNG NHẬP</h3>
                
                <c:if test="${not empty ERROR}">
                    <div class="alert alert-danger text-center">${ERROR}</div>
                </c:if>
                <c:if test="${not empty SUCCESS}">
                    <div class="alert alert-success text-center">${SUCCESS}</div>
                </c:if>

                <form action="login" method="POST">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="userID" name="userID" placeholder="Tên đăng nhập" required>
                        <label for="userID">Tên đăng nhập</label>
                    </div>
                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>
                        <label for="password">Mật khẩu</label>
                    </div>
                    <button type="submit" class="btn btn-dark w-100 py-3 fw-bold fs-5 mb-3">ĐĂNG NHẬP</button>
                    <div class="text-center">
                        <span class="text-muted">Chưa có tài khoản?</span> <a href="register" class="text-primary text-decoration-none fw-bold">Đăng ký ngay</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
