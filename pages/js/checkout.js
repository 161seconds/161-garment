/**
 * ONE61 GARMENTORY - Checkout Page Script
 * Cart Summary, Stepper Validation, Real-time VietQR Polling
 */

const SEPAY_API_TOKEN = atob('SkhOSklQVk1UWEpCWjFKWklDRU9ETEw4QVVWVjBaQUdNR1FSUFZTNTJNNVJPV1VZSVJUMlAzRUY2VUQ4OUFPTg==');
let pollingInterval = null;

function getCart() {
    return JSON.parse(localStorage.getItem('one61_cart') || '[]');
}

function calculateTotals() {
    const cart = getCart();
    const subtotal = cart.reduce((sum, i) => sum + (i.price * i.qty), 0);
    const shipping = subtotal >= 499000 || subtotal === 0 ? 0 : 30000;
    const total = subtotal + shipping;
    return { subtotal, shipping, total, cart };
}

function renderCheckoutSummary() {
    const { subtotal, shipping, total, cart } = calculateTotals();
    const mini = document.getElementById('checkoutMiniCart');
    
    if (mini) {
        if (cart.length === 0) {
            mini.innerHTML = '<p class="small text-muted">Giỏ hàng trống.</p>';
        } else {
            mini.innerHTML = cart.map(i => `
                <div class="d-flex justify-content-between align-items-center mb-2 small">
                    <div>
                        <span class="fw-bold text-dark">${i.name}</span>
                        <div class="text-muted" style="font-size: 0.75rem;">SL: ${i.qty} | ${i.color} - ${i.size}</div>
                    </div>
                    <span class="fw-semibold">${(i.price * i.qty).toLocaleString('vi-VN')} đ</span>
                </div>
            `).join('');
        }
    }

    const subtotalEl = document.getElementById('coSubtotal');
    if (subtotalEl) subtotalEl.textContent = subtotal.toLocaleString('vi-VN') + ' đ';
    const shippingEl = document.getElementById('coShipping');
    if (shippingEl) shippingEl.textContent = shipping === 0 ? 'MIỄN PHÍ' : shipping.toLocaleString('vi-VN') + ' đ';
    const totalEl = document.getElementById('coTotal');
    if (totalEl) totalEl.textContent = total.toLocaleString('vi-VN') + ' đ';
    const qrAmountEl = document.getElementById('qrAmount');
    if (qrAmountEl) qrAmountEl.textContent = total.toLocaleString('vi-VN') + ' đ';
    const sumFinalEl = document.getElementById('sumFinalTotal');
    if (sumFinalEl) sumFinalEl.textContent = total.toLocaleString('vi-VN') + ' đ';
}

function goToStepPayment() {
    const name = document.getElementById('custName').value.trim();
    const phone = document.getElementById('custPhone').value.trim();
    const addr = document.getElementById('custAddress').value.trim();

    if (!name || !phone || !addr) {
        alert('Vui lòng điền đầy đủ Họ tên, Số điện thoại và Địa chỉ giao hàng!');
        return;
    }

    const { total } = calculateTotals();
    if (total <= 0) {
        alert('Giỏ hàng của bạn đang trống. Vui lòng thêm sản phẩm!');
        window.location.href = 'product.html';
        return;
    }

    const cleanPhone = phone.replace(/[^0-9]/g, '');
    const transferContent = '161GM ' + cleanPhone;

    document.getElementById('sumName').textContent = name;
    document.getElementById('sumPhone').textContent = phone;
    document.getElementById('sumAddress').textContent = addr;
    document.getElementById('qrContent').textContent = transferContent;

    const qrUrl = 'https://qr.sepay.vn/img?acc=08222216167810&bank=MBBank&amount=' + total + '&des=' + encodeURIComponent(transferContent) + '&template=compact';
    document.getElementById('vietQrImg').src = qrUrl;

    document.getElementById('stepDelivery').style.display = 'none';
    document.getElementById('stepPayment').style.display = 'block';

    document.getElementById('badgeStep1').className = 'stepper-badge completed';
    document.getElementById('badgeStep1').innerHTML = '<i class="fa-solid fa-check"></i>';
    document.getElementById('stepperLine').className = 'stepper-line active';
    document.getElementById('badgeStep2').className = 'stepper-badge active';
    document.getElementById('textStep2').className = 'small fw-bold text-uppercase text-dark';

    startPaymentPolling(cleanPhone);
}

function backToStepDelivery() {
    if (pollingInterval) clearInterval(pollingInterval);
    document.getElementById('stepPayment').style.display = 'none';
    document.getElementById('stepDelivery').style.display = 'block';

    document.getElementById('badgeStep1').className = 'stepper-badge active';
    document.getElementById('badgeStep1').textContent = '1';
    document.getElementById('stepperLine').className = 'stepper-line';
    document.getElementById('badgeStep2').className = 'stepper-badge';
    document.getElementById('textStep2').className = 'small fw-semibold text-uppercase text-muted';
}

function startPaymentPolling(phone) {
    if (pollingInterval) clearInterval(pollingInterval);
    const { total } = calculateTotals();

    pollingInterval = setInterval(async () => {
        try {
            const res = await fetch('https://my.sepay.vn/userapi/transactions/list', {
                headers: { 'Authorization': 'Bearer ' + SEPAY_API_TOKEN }
            });
            if (!res.ok) return;
            const data = await res.json();
            if (!data.transactions) return;

            const match = data.transactions.find(tx => {
                const amountMatch = parseFloat(tx.amount_in || tx.transferAmount || 0) >= total;
                const content = (tx.transaction_content || tx.content || tx.description || '').toUpperCase();
                return amountMatch && (content.includes('161GM') || content.includes(phone));
            });

            if (match) {
                clearInterval(pollingInterval);
                confirmPaymentSuccess(match.id);
            }
        } catch (e) {
            console.log('Polling check:', e);
        }
    }, 3000);
}

function confirmPaymentSuccess(txId) {
    if (pollingInterval) clearInterval(pollingInterval);
    const orderId = txId || 'ORD' + Date.now().toString().slice(-6);
    localStorage.removeItem('one61_cart');
    window.location.href = 'order-success.html?orderID=' + orderId + '&method=QR_CODE';
}

window.addEventListener('DOMContentLoaded', () => {
    renderCheckoutSummary();
});
