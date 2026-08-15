<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp" />

<div class="row justify-content-center mt-4">
    <div class="col-md-8">
        <div class="card shadow-sm border-0">
            <div class="card-body p-5">
                <h3 class="fw-bold mb-4 border-bottom pb-3">THÔNG TIN GIAO HÀNG</h3>
                
                <c:if test="${not empty ERROR}">
                    <div class="alert alert-danger">${ERROR}</div>
                </c:if>

                <form action="checkout" method="POST">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Người nhận</label>
                        <input type="text" class="form-control bg-light" value="${sessionScope.LOGIN_USER.fullName}" readonly>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Số điện thoại</label>
                        <input type="text" class="form-control bg-light" value="${sessionScope.LOGIN_USER.phone}" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Địa chỉ giao hàng chi tiết *</label>
                        <textarea class="form-control" name="address" rows="3" required placeholder="Nhập địa chỉ nhà, phường/xã, quận/huyện..."></textarea>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-bold">Ghi chú (Tùy chọn)</label>
                        <textarea class="form-control" name="note" rows="2" placeholder="Ghi chú về đơn hàng..."></textarea>
                    </div>

                    <div class="alert alert-warning mb-4">
                        <strong>Hình thức thanh toán:</strong> Thanh toán khi nhận hàng (COD).
                    </div>

                    <button type="submit" class="btn btn-danger w-100 py-3 fw-bold fs-5">XÁC NHẬN ĐẶT HÀNG</button>
                    <a href="cart" class="btn btn-outline-secondary w-100 mt-2">Quay lại giỏ hàng</a>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
