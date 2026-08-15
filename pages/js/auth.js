/**
 * ONE61 GARMENTORY - Authentication Script (Login & Register)
 */

function handleLogin(e) {
    if (e) e.preventDefault();
    if (typeof window.one61Toast === 'function') {
        window.one61Toast('Đăng nhập thành công! Chào mừng bạn quay trở lại.', 'success');
    } else {
        alert('Đăng nhập thành công!');
    }
    setTimeout(() => {
        window.location.href = 'index.html';
    }, 1000);
}

function handleRegister(e) {
    if (e) e.preventDefault();
    const pass = document.getElementById('regPass').value;
    const confirm = document.getElementById('regConfirm').value;
    if (pass !== confirm) {
        if (typeof window.one61Alert === 'function') {
            window.one61Alert('LỖI ĐĂNG KÝ', 'Mật khẩu và xác nhận mật khẩu không khớp. Vui lòng thử lại!');
        } else {
            alert('Mật khẩu xác nhận không khớp!');
        }
        return;
    }
    if (typeof window.one61Toast === 'function') {
        window.one61Toast('Đăng ký tài khoản thành công! Đang chuyển hướng...', 'success');
    } else {
        alert('Đăng ký tài khoản thành công!');
    }
    setTimeout(() => {
        window.location.href = 'login.html';
    }, 1200);
}
