/**
 * ONE61 GARMENTORY - Cart Page Logic
 * LocalStorage sync, item CRUD, Quantity increment/decrement, Total calculation
 */

function getCart() {
    return JSON.parse(localStorage.getItem('one61_cart') || '[]');
}

function saveCart(cart) {
    localStorage.setItem('one61_cart', JSON.stringify(cart));
    renderCart();
    if (typeof updateGlobalBadges === 'function') updateGlobalBadges();
}

function updateQuantity(index, delta) {
    let cart = getCart();
    if (!cart[index]) return;
    cart[index].qty += delta;
    if (cart[index].qty <= 0) {
        cart.splice(index, 1);
    }
    saveCart(cart);
}

function removeItem(index) {
    let cart = getCart();
    if (confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
        cart.splice(index, 1);
        saveCart(cart);
    }
}

function renderCart() {
    const cart = getCart();
    const container = document.getElementById('cartContent');
    const totalItemsBadge = document.getElementById('cartTotalItemsCount');
    const count = cart.reduce((sum, item) => sum + item.qty, 0);
    if (totalItemsBadge) totalItemsBadge.textContent = count + ' sản phẩm';
    if (!container) return;

    if (cart.length === 0) {
        container.innerHTML = `
            <div class="text-center py-5 border bg-light">
                <i class="fa-solid fa-cart-shopping fs-1 text-muted mb-3 d-block"></i>
                <h5 class="mb-3 text-muted">Giỏ hàng của bạn đang trống!</h5>
                <p class="small text-secondary mb-4">Hãy khám phá bộ sưu tập LifeWear mới nhất từ ONE61 Garmentory.</p>
                <a href="product.html" class="btn btn-dark rounded-0 px-4 py-2 fw-bold text-uppercase small">TIẾP TỤC MUA SẮM</a>
            </div>
        `;
        return;
    }

    const subtotal = cart.reduce((sum, item) => sum + (item.price * item.qty), 0);
    const shipping = subtotal >= 499000 ? 0 : 30000;
    const total = subtotal + shipping;

    container.innerHTML = `
        <div class="row g-4">
            <div class="col-lg-8">
                <div class="border">
                    <table class="table align-middle mb-0">
                        <thead class="table-light small text-uppercase fw-bold">
                            <tr>
                                <th class="ps-3 py-3">Sản phẩm</th>
                                <th class="text-center py-3">Đơn giá</th>
                                <th class="text-center py-3" style="width: 140px;">Số lượng</th>
                                <th class="text-center py-3">Thành tiền</th>
                                <th class="text-center py-3">Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${cart.map((item, idx) => `
                                <tr>
                                    <td class="ps-3 py-3">
                                        <div class="d-flex align-items-center gap-3">
                                            <img src="${item.img}" width="70" class="border rounded-0 object-fit-cover" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=200';">
                                            <div>
                                                <a href="product-detail.html?id=${item.id}" class="fw-bold text-dark text-decoration-none small d-block mb-1">${item.name}</a>
                                                <div class="text-muted small" style="font-size: 0.75rem;">
                                                    Màu: <strong>${item.color || '32 BEIGE'}</strong> | Size: <strong>${item.size || 'M'}</strong>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center fw-bold small">${item.price.toLocaleString('vi-VN')} đ</td>
                                    <td class="text-center">
                                        <div class="qty-stepper mx-auto">
                                            <button type="button" class="qty-btn" onclick="updateQuantity(${idx}, -1)">-</button>
                                            <input type="number" class="qty-input" value="${item.qty}" readonly>
                                            <button type="button" class="qty-btn" onclick="updateQuantity(${idx}, 1)">+</button>
                                        </div>
                                    </td>
                                    <td class="text-center fw-bold text-danger small">${(item.price * item.qty).toLocaleString('vi-VN')} đ</td>
                                    <td class="text-center">
                                        <button type="button" class="btn btn-link text-muted p-0" onclick="removeItem(${idx})" title="Xóa">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </button>
                                    </td>
                                </tr>
                            `).join('')}
                        </tbody>
                    </table>
                </div>
                <div class="mt-3">
                    <a href="product.html" class="text-dark small fw-bold text-decoration-none"><i class="fa-solid fa-arrow-left me-1"></i> TIẾP TỤC MUA SẮM</a>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card border rounded-0 p-4 bg-light">
                    <h5 class="fw-bold text-uppercase border-bottom pb-3 mb-3">TỔNG ĐƠN HÀNG</h5>
                    <div class="d-flex justify-content-between mb-2 small">
                        <span class="text-secondary">Tạm tính:</span>
                        <strong class="text-dark">${subtotal.toLocaleString('vi-VN')} đ</strong>
                    </div>
                    <div class="d-flex justify-content-between mb-3 small">
                        <span class="text-secondary">Phí vận chuyển:</span>
                        <strong class="${shipping === 0 ? 'text-success' : 'text-dark'}">
                            ${shipping === 0 ? 'MIỄN PHÍ' : shipping.toLocaleString('vi-VN') + ' đ'}
                        </strong>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fw-bold fs-6">TỔNG CỘNG:</span>
                        <span class="fs-4 fw-bold text-danger font-monospace">${total.toLocaleString('vi-VN')} đ</span>
                    </div>
                    <a href="checkout.html" class="btn btn-danger btn-lg rounded-0 w-100 fw-bold text-uppercase py-3 small shadow-sm" style="background-color: var(--color-primary); letter-spacing: 1px;">
                        TIẾN HÀNH ĐẶT HÀNG <i class="fa-solid fa-arrow-right ms-2"></i>
                    </a>
                </div>
            </div>
        </div>
    `;
}

window.addEventListener('DOMContentLoaded', () => {
    renderCart();
});
