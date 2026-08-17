<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="includes/header.jsp">
    <jsp:param name="title" value="Cài Đặt Tài Khoản | ONE61 Garmentory" />
</jsp:include>

<div class="container py-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small text-uppercase fw-semibold mb-0" style="letter-spacing: 0.5px;">
            <li class="breadcrumb-item"><a href="home" class="text-decoration-none text-dark">Trang Chủ</a></li>
            <li class="breadcrumb-item active text-danger" aria-current="page">Tài Khoản & Cài Đặt</li>
        </ol>
    </nav>

    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-end mb-4 pb-3 border-bottom">
        <div>
            <h3 class="fw-bold m-0 text-uppercase" style="letter-spacing: 1px; font-family: 'Outfit', sans-serif;">
                CÀI ĐẶT TÀI KHOẢN
            </h3>
            <p class="text-muted small m-0 mt-1">
                Quản lý thông tin hồ sơ cá nhân, bảo mật mật khẩu và thống kê mua sắm của bạn
            </p>
        </div>
        <a href="my-orders" class="btn btn-outline-dark btn-sm rounded-0 fw-bold text-uppercase px-3 py-2" style="font-size: 0.78rem;">
            <i class="fa-solid fa-box-archive me-1"></i> Xem Đơn Hàng Của Tôi
        </a>
    </div>

    <div class="row g-4 mb-5">
        <!-- Left Sidebar: User Card & Navigation Tabs -->
        <div class="col-lg-4 col-md-5">
            <!-- User Summary Box -->
            <div class="card rounded-0 border p-4 bg-white text-center mb-3 shadow-sm">
                <div class="mb-3">
                    <div style="width: 75px; height: 75px; margin: 0 auto; background: #F8F9FA; border-radius: 50%; display: flex; align-items: center; justify-content: center; border: 2px solid #E5E5E5;">
                        <i class="fa-solid fa-user fs-2 text-danger"></i>
                    </div>
                </div>
                <h5 class="fw-bold m-0 mb-1" style="font-family: 'Outfit', sans-serif;">${sessionScope.LOGIN_USER.fullName}</h5>
                <div class="text-muted small mb-2">@${sessionScope.LOGIN_USER.userID}</div>
                <div>
                    <span class="badge ${sessionScope.LOGIN_USER.roleID eq 'ADMIN' ? 'bg-danger' : 'bg-dark'} rounded-0 px-2 py-1 small text-uppercase fw-bold">
                        ${sessionScope.LOGIN_USER.roleID eq 'ADMIN' ? 'Quản Trị Viên' : 'Khách Hàng Thân Thiết'}
                    </span>
                </div>
            </div>

            <!-- Tab Navigation Menu -->
            <div class="list-group rounded-0 shadow-sm border mb-3">
                <button type="button" class="list-group-item list-group-item-action py-3 fw-bold small text-uppercase d-flex align-items-center justify-content-between ${empty ACTIVE_TAB or ACTIVE_TAB eq 'profile' ? 'active bg-danger border-danger text-white' : 'text-dark'}" 
                        onclick="switchTab('profile', this)">
                    <span><i class="fa-regular fa-id-card me-2"></i> Thông Tin Cá Nhân</span>
                    <i class="fa-solid fa-chevron-right small"></i>
                </button>
                <button type="button" class="list-group-item list-group-item-action py-3 fw-bold small text-uppercase d-flex align-items-center justify-content-between ${ACTIVE_TAB eq 'security' ? 'active bg-danger border-danger text-white' : 'text-dark'}" 
                        onclick="switchTab('security', this)">
                    <span><i class="fa-solid fa-shield-halved me-2"></i> Đổi Mật Khẩu</span>
                    <i class="fa-solid fa-chevron-right small"></i>
                </button>
                <button type="button" class="list-group-item list-group-item-action py-3 fw-bold small text-uppercase d-flex align-items-center justify-content-between ${ACTIVE_TAB eq 'overview' ? 'active bg-danger border-danger text-white' : 'text-dark'}" 
                        onclick="switchTab('overview', this)">
                    <span><i class="fa-solid fa-chart-pie me-2"></i> Tổng Quan Mua Sắm</span>
                    <i class="fa-solid fa-chevron-right small"></i>
                </button>
                <a href="my-orders" class="list-group-item list-group-item-action py-3 fw-bold small text-uppercase text-dark d-flex align-items-center justify-content-between">
                    <span><i class="fa-solid fa-box-open me-2 text-muted"></i> Lịch Sử Đơn Hàng</span>
                    <i class="fa-solid fa-arrow-up-right-from-square small text-muted"></i>
                </a>
                <a href="logout" class="list-group-item list-group-item-action py-3 fw-bold small text-uppercase text-danger d-flex align-items-center justify-content-between">
                    <span><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng Xuất</span>
                </a>
            </div>
        </div>

        <!-- Right Content Panel -->
        <div class="col-lg-8 col-md-7">
            <!-- TAB 1: PROFILE INFO -->
            <div class="card rounded-0 border p-4 bg-white shadow-sm tab-content-panel" id="tabPanelProfile" style="${ACTIVE_TAB eq 'security' or ACTIVE_TAB eq 'overview' ? 'display: none;' : 'display: block;'}">
                <div class="d-flex align-items-center justify-content-between pb-3 mb-4 border-bottom">
                    <h5 class="fw-bold text-uppercase m-0" style="font-family: 'Outfit', sans-serif;">
                        <i class="fa-regular fa-user text-danger me-2"></i> THÔNG TIN HỒ SƠ
                    </h5>
                    <span class="badge bg-light text-muted border rounded-0 font-monospace">ID: ${sessionScope.LOGIN_USER.userID}</span>
                </div>

                <c:if test="${not empty SUCCESS_PROFILE}">
                    <div class="alert alert-success alert-dismissible fade show rounded-0 small mb-4" role="alert">
                        <i class="fa-solid fa-circle-check me-2"></i> ${SUCCESS_PROFILE}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty ERROR_PROFILE}">
                    <div class="alert alert-danger alert-dismissible fade show rounded-0 small mb-4" role="alert">
                        <i class="fa-solid fa-circle-exclamation me-2"></i> ${ERROR_PROFILE}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="profile" method="POST">
                    <input type="hidden" name="action" value="update-info">

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Mã Thành Viên (Mã ID Định Danh)</label>
                        <input type="text" class="form-control rounded-0 bg-light fw-bold font-monospace text-danger" value="${sessionScope.LOGIN_USER.userID}" readonly disabled>
                        <div class="form-text small text-muted">Mã thành viên được hệ thống tự động cấp phát cố định. Bạn có thể dùng <strong>Email</strong> hoặc <strong>Số điện thoại</strong> để đăng nhập.</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control rounded-0 fw-semibold" name="fullName" value="${sessionScope.LOGIN_USER.fullName}" required placeholder="Nhập họ và tên...">
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-uppercase">Số điện thoại <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control rounded-0 fw-semibold" name="phone" value="${sessionScope.LOGIN_USER.phone}" required pattern="[0-9]{9,11}" placeholder="0987654321">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-uppercase">Địa chỉ Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control rounded-0 fw-semibold" name="email" value="${sessionScope.LOGIN_USER.email}" required placeholder="name@example.com">
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold small text-uppercase">Ngày đăng ký tài khoản</label>
                        <input type="text" class="form-control rounded-0 bg-light small" value="<fmt:formatDate value='${sessionScope.LOGIN_USER.createDate}' pattern='dd/MM/yyyy HH:mm:ss'/>" readonly disabled>
                    </div>

                    <div class="pt-2 border-top d-flex justify-content-end">
                        <button type="submit" class="btn btn-danger rounded-0 px-4 py-2 fw-bold text-uppercase" style="background-color: var(--color-primary, #ED1D24); font-size: 0.82rem; letter-spacing: 0.5px;">
                            <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Thay Đổi
                        </button>
                    </div>
                </form>
            </div>

            <!-- TAB 2: SECURITY & PASSWORD -->
            <div class="card rounded-0 border p-4 bg-white shadow-sm tab-content-panel" id="tabPanelSecurity" style="${ACTIVE_TAB eq 'security' ? 'display: block;' : 'display: none;'}">
                <div class="d-flex align-items-center justify-content-between pb-3 mb-4 border-bottom">
                    <h5 class="fw-bold text-uppercase m-0" style="font-family: 'Outfit', sans-serif;">
                        <i class="fa-solid fa-key text-danger me-2"></i> ĐỔI MẬT KHẨU
                    </h5>
                    <small class="text-muted"><i class="fa-solid fa-shield-halved text-success me-1"></i> Mã hóa SHA-256</small>
                </div>

                <c:if test="${not empty SUCCESS_PASSWORD}">
                    <div class="alert alert-success alert-dismissible fade show rounded-0 small mb-4" role="alert">
                        <i class="fa-solid fa-circle-check me-2"></i> ${SUCCESS_PASSWORD}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty ERROR_PASSWORD}">
                    <div class="alert alert-danger alert-dismissible fade show rounded-0 small mb-4" role="alert">
                        <i class="fa-solid fa-circle-exclamation me-2"></i> ${ERROR_PASSWORD}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="profile" method="POST">
                    <input type="hidden" name="action" value="change-password">

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <input type="password" class="form-control rounded-0" id="oldPassword" name="oldPassword" required placeholder="Nhập mật khẩu đang dùng...">
                            <button class="btn btn-outline-secondary rounded-0" type="button" onclick="togglePasswordVisibility('oldPassword', this)">
                                <i class="fa-regular fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-uppercase">Mật khẩu mới <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <input type="password" class="form-control rounded-0" id="newPassword" name="newPassword" required minlength="6" placeholder="Tối thiểu 6 ký tự...">
                            <button class="btn btn-outline-secondary rounded-0" type="button" onclick="togglePasswordVisibility('newPassword', this)">
                                <i class="fa-regular fa-eye"></i>
                            </button>
                        </div>
                        <div class="form-text small text-muted">Mật khẩu nên kết hợp chữ hoa, chữ thường, chữ số để tăng độ an toàn.</div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold small text-uppercase">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <input type="password" class="form-control rounded-0" id="confirmPassword" name="confirmPassword" required minlength="6" placeholder="Nhập lại mật khẩu mới...">
                            <button class="btn btn-outline-secondary rounded-0" type="button" onclick="togglePasswordVisibility('confirmPassword', this)">
                                <i class="fa-regular fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="pt-2 border-top d-flex justify-content-end">
                        <button type="submit" class="btn btn-danger rounded-0 px-4 py-2 fw-bold text-uppercase" style="background-color: var(--color-primary, #ED1D24); font-size: 0.82rem; letter-spacing: 0.5px;">
                            <i class="fa-solid fa-lock me-1"></i> Cập Nhật Mật Khẩu
                        </button>
                    </div>
                </form>
            </div>

            <!-- TAB 3: ACCOUNT OVERVIEW & STATS -->
            <div class="card rounded-0 border p-4 bg-white shadow-sm tab-content-panel" id="tabPanelOverview" style="${ACTIVE_TAB eq 'overview' ? 'display: block;' : 'display: none;'}">
                <div class="d-flex align-items-center justify-content-between pb-3 mb-4 border-bottom">
                    <h5 class="fw-bold text-uppercase m-0" style="font-family: 'Outfit', sans-serif;">
                        <i class="fa-solid fa-chart-pie text-danger me-2"></i> TỔNG QUAN HOẠT ĐỘNG
                    </h5>
                    <span class="text-muted small">Cập nhật tự động</span>
                </div>

                <!-- 3 Metric Cards -->
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="p-3 border bg-light text-center">
                            <div class="text-muted small text-uppercase fw-bold mb-1" style="font-size: 0.72rem;">Tổng đơn hàng</div>
                            <div class="fw-bold fs-3 text-dark" style="font-family: 'Outfit', sans-serif;">
                                ${USER_STATS.totalOrders != null ? USER_STATS.totalOrders : 0}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 border bg-light text-center">
                            <div class="text-muted small text-uppercase fw-bold mb-1" style="font-size: 0.72rem;">Đang chuẩn bị / Giao</div>
                            <div class="fw-bold fs-3 text-primary" style="font-family: 'Outfit', sans-serif;">
                                ${USER_STATS.processingOrders != null ? USER_STATS.processingOrders : 0}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 border bg-light text-center">
                            <div class="text-muted small text-uppercase fw-bold mb-1" style="font-size: 0.72rem;">Tổng chi tiêu</div>
                            <div class="fw-bold fs-4 text-danger" style="font-family: 'Outfit', sans-serif;">
                                <fmt:formatNumber value="${USER_STATS.totalSpent != null ? USER_STATS.totalSpent : 0}" pattern="#,###"/> đ
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions Banner -->
                <div class="p-4 border bg-light">
                    <h6 class="fw-bold text-uppercase mb-2">Thao Tác Nhanh</h6>
                    <p class="text-muted small mb-3">Truy cập nhanh danh sách đơn hàng đã mua hoặc tiếp tục khám phá các bộ sưu tập LifeWear mới nhất.</p>
                    <div class="d-flex flex-wrap gap-2">
                        <a href="my-orders" class="btn btn-dark rounded-0 fw-bold text-uppercase px-4 py-2" style="font-size: 0.8rem;">
                            <i class="fa-solid fa-box-archive me-1"></i> Quản Lý Đơn Hàng
                        </a>
                        <a href="product" class="btn btn-outline-dark rounded-0 fw-bold text-uppercase px-4 py-2" style="font-size: 0.8rem;">
                            <i class="fa-solid fa-shirt me-1"></i> Khám Phá Sản Phẩm
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function switchTab(tabName, clickedBtn) {
        // Hide all tab panels
        document.querySelectorAll('.tab-content-panel').forEach(panel => {
            panel.style.display = 'none';
        });

        // Show target tab panel
        if (tabName === 'profile') {
            document.getElementById('tabPanelProfile').style.display = 'block';
        } else if (tabName === 'security') {
            document.getElementById('tabPanelSecurity').style.display = 'block';
        } else if (tabName === 'overview') {
            document.getElementById('tabPanelOverview').style.display = 'block';
        }

        // Reset and highlight active button in menu
        document.querySelectorAll('.list-group-item').forEach(btn => {
            btn.classList.remove('active', 'bg-danger', 'border-danger', 'text-white');
            btn.classList.add('text-dark');
        });
        clickedBtn.classList.remove('text-dark');
        clickedBtn.classList.add('active', 'bg-danger', 'border-danger', 'text-white');
    }

    function togglePasswordVisibility(inputId, btn) {
        const input = document.getElementById(inputId);
        const icon = btn.querySelector('i');
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }
</script>

<jsp:include page="includes/footer.jsp" />
