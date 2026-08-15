/**
 * ONE61 GARMENTORY - Home Page Script
 * Catalog Showcase, Live Category Filter, Slide Drawer Cart, Live VietQR Simulation
 */

// Sample Product Database
const PRODUCTS = [
    { id: "PROD01", name: "Áo Thun Cổ Tròn Cotton 100%", cate: "MEN_01", cateGroup: "MEN", price: 299000, img: "../web/img-prj301/ao-thun-01.avif" },
    { id: "PROD02", name: "Áo Thun AIRism Siêu Thoáng Mát", cate: "WOMEN_01", cateGroup: "WOMEN", price: 349000, img: "../web/img-prj301/ao-thun-02.avif" },
    { id: "PROD03", name: "Áo Thun Trơn Dáng Rộng Unisex", cate: "MEN_01", cateGroup: "MEN", price: 399000, img: "../web/img-prj301/ao-thun-03.avif" },
    { id: "PROD04", name: "Áo Thun Họa Tiết Graphic LifeWear", cate: "MEN_01", cateGroup: "MEN", price: 449000, img: "../web/img-prj301/ao-thun-04.avif" },
    { id: "PROD05", name: "Áo Thun Dài Tay Cổ Lọ Nữ", cate: "WOMEN_01", cateGroup: "WOMEN", price: 399000, img: "../web/img-prj301/ao-thun-05.avif" },
    { id: "PROD06", name: "Áo Khoác Parka Chống Nắng UV Protection", cate: "WOMEN_03", cateGroup: "WOMEN", price: 699000, img: "../web/img-prj301/ao-khoac-01.avif" },
    { id: "PROD07", name: "Áo Khoác Gió Siêu Nhẹ Pocketable", cate: "MEN_03", cateGroup: "MEN", price: 799000, img: "../web/img-prj301/ao-khoac-03.avif" },
    { id: "PROD08", name: "Áo Khoác Cardigan Len Mềm", cate: "WOMEN_03", cateGroup: "WOMEN", price: 899000, img: "../web/img-prj301/ao-khoac-04.avif" },
    { id: "PROD09", name: "Áo Khoác Bomber Thể Thao", cate: "MEN_03", cateGroup: "MEN", price: 999000, img: "../web/img-prj301/ao-khoac-05.avif" },
    { id: "PROD10", name: "Áo Khoác Nỉ Hoodie Có Mũ", cate: "KIDS_02", cateGroup: "KIDS", price: 549000, img: "../web/img-prj301/ao-khoac-06.avif" },
    { id: "PROD11", name: "Quần Barrel Pants Phom Rộng Nhật Bản", cate: "WOMEN_04", cateGroup: "WOMEN", price: 699000, img: "../web/img-prj301/quan-dai-01.avif" },
    { id: "PROD12", name: "Quần Smart Ankle Pants Co Giãn", cate: "MEN_04", cateGroup: "MEN", price: 799000, img: "../web/img-prj301/quan-dai-02.avif" },
    { id: "PROD13", name: "Quần Chino Ống Suông Cao Cấp", cate: "MEN_04", cateGroup: "MEN", price: 749000, img: "../web/img-prj301/quan-dai-03.avif" },
    { id: "PROD14", name: "Quần Jeans Dáng Suông Cổ Điển", cate: "WOMEN_04", cateGroup: "WOMEN", price: 899000, img: "../web/img-prj301/quan-dai-04.avif" },
    { id: "PROD15", name: "Quần Kaki Co Giãn Thoải Mái", cate: "KIDS_03", cateGroup: "KIDS", price: 449000, img: "../web/img-prj301/quan-dai-05.avif" },
    { id: "PROD16", name: "Quần Jogger Nỉ Thể Thao", cate: "MEN_04", cateGroup: "MEN", price: 599000, img: "../web/img-prj301/quan-dai-06.avif" }
];

let cart = [
    { product: PRODUCTS[0], quantity: 1 },
    { product: PRODUCTS[5], quantity: 1 }
];

function formatVND(n) {
    return new Intl.NumberFormat('vi-VN').format(n) + ' đ';
}

// Render Catalog Products
function renderProducts(list) {
    const container = document.getElementById('productsContainer');
    if (!container) return;
    container.innerHTML = '';

    list.forEach(p => {
        const col = document.createElement('div');
        col.className = 'col-lg-4 col-md-6 col-6';
        col.innerHTML = `
            <div class="product-card h-100 p-2">
                <div class="product-img-wrapper mb-2">
                    <a href="product-detail.html?id=${p.id}">
                        <img src="${p.img}" alt="${p.name}" class="product-img" onerror="this.src='../web/img-prj301/ao-thun-01.avif'">
                    </a>
                </div>
                <div class="p-1">
                    <h6 class="small fw-bold mb-1 text-truncate" title="${p.name}">
                        <a href="product-detail.html?id=${p.id}" class="text-dark text-decoration-none">${p.name}</a>
                    </h6>
                    <div class="fw-bold text-danger mb-2">${formatVND(p.price)}</div>
                    <div class="d-flex gap-1">
                        <a href="product-detail.html?id=${p.id}" class="btn btn-light btn-sm rounded-0 border flex-grow-1 fw-bold small text-uppercase">
                            <i class="fa-regular fa-eye me-1"></i> Chi tiết
                        </a>
                        <button class="btn btn-dark btn-sm rounded-0 px-3 fw-bold small text-uppercase" onclick="addToCart('${p.id}')" title="Thêm vào giỏ">
                            <i class="fa-solid fa-cart-plus"></i>
                        </button>
                    </div>
                </div>
            </div>
        `;
        container.appendChild(col);
    });
    const lbl = document.getElementById('productCountLabel');
    if (lbl) lbl.textContent = 'Đang hiển thị ' + list.length + ' sản phẩm';
}

// Category Filter
function filterCategory(cat) {
    let filtered = PRODUCTS;
    if (cat === 'WOMEN') {
        filtered = PRODUCTS.filter(p => p.cateGroup === 'WOMEN');
        document.getElementById('catalogTitle').textContent = 'THỜI TRANG NỮ';
    } else if (cat === 'MEN') {
        filtered = PRODUCTS.filter(p => p.cateGroup === 'MEN');
        document.getElementById('catalogTitle').textContent = 'THỜI TRANG NAM';
    } else if (cat === 'KIDS') {
        filtered = PRODUCTS.filter(p => p.cateGroup === 'KIDS');
        document.getElementById('catalogTitle').textContent = 'THỜI TRANG TRẺ EM';
    } else if (cat !== 'ALL') {
        filtered = PRODUCTS.filter(p => p.cate === cat);
        document.getElementById('catalogTitle').textContent = 'BỘ SƯU TẬP ' + cat;
    } else {
        document.getElementById('catalogTitle').textContent = 'TẤT CẢ BỘ SƯU TẬP LIFEWEAR';
    }
    renderProducts(filtered);
    const badge = document.getElementById('activeFilterBadge');
    if (badge) badge.textContent = cat;
}

function handleSearch(q) {
    const query = q.toLowerCase().trim();
    const filtered = PRODUCTS.filter(p => p.name.toLowerCase().includes(query));
    renderProducts(filtered);
}

// Cart Drawer Management
function renderCart() {
    const container = document.getElementById('cartItemsList');
    const headerCount = document.getElementById('headerCartCount');
    const totalPriceEl = document.getElementById('cartTotalPrice');
    const btnCheckout = document.getElementById('btnProceedCheckout');
    if (!container || !headerCount || !totalPriceEl) return;

    let total = 0;
    let count = 0;
    container.innerHTML = '';

    if (cart.length === 0) {
        container.innerHTML = `
            <div class="text-center py-5 my-auto text-muted">
                <i class="fa-solid fa-cart-shopping fs-1 mb-3 text-secondary opacity-50 d-block"></i>
                <h6 class="fw-bold text-uppercase text-dark mb-1">Giỏ hàng của bạn đang trống</h6>
                <p class="small text-muted mb-4">Bạn chưa chọn sản phẩm nào để thanh toán.</p>
                <button class="btn btn-outline-dark btn-sm rounded-0 fw-bold text-uppercase px-3" data-bs-dismiss="offcanvas" onclick="location.href='#storeSection'">
                    <i class="fa-solid fa-bag-shopping me-1"></i> Mua sắm ngay
                </button>
            </div>
        `;
        if (btnCheckout) {
            btnCheckout.disabled = true;
            btnCheckout.classList.add('disabled');
            btnCheckout.style.opacity = '0.5';
            btnCheckout.style.cursor = 'not-allowed';
        }
    } else {
        if (btnCheckout) {
            btnCheckout.disabled = false;
            btnCheckout.classList.remove('disabled');
            btnCheckout.style.opacity = '1';
            btnCheckout.style.cursor = 'pointer';
        }

        cart.forEach((item, idx) => {
            total += item.product.price * item.quantity;
            count += item.quantity;

            const itemRow = document.createElement('div');
            itemRow.className = 'd-flex align-items-center justify-content-between pb-2 border-bottom';
            itemRow.innerHTML = `
                <div class="d-flex align-items-center gap-2">
                    <img src="${item.product.img}" width="45" height="45" class="border object-fit-cover">
                    <div>
                        <h6 class="small fw-bold mb-0 text-truncate" style="max-width: 140px;">${item.product.name}</h6>
                        <small class="text-danger fw-bold">${formatVND(item.product.price)} x ${item.quantity}</small>
                    </div>
                </div>
                <div class="d-flex align-items-center gap-1">
                    <button class="btn btn-sm btn-outline-secondary py-0 px-2" onclick="changeQty(${idx}, -1)">-</button>
                    <span class="small fw-bold px-1">${item.quantity}</span>
                    <button class="btn btn-sm btn-outline-secondary py-0 px-2" onclick="changeQty(${idx}, 1)">+</button>
                    <button class="btn btn-sm text-danger ms-1" onclick="removeItem(${idx})"><i class="fa-solid fa-trash"></i></button>
                </div>
            `;
            container.appendChild(itemRow);
        });
    }

    headerCount.textContent = count;
    totalPriceEl.textContent = formatVND(total);
    const qrAmount = document.getElementById('mQrAmountLabel');
    if (qrAmount) qrAmount.textContent = formatVND(total);

    // Update QR image in checkout modal
    const phoneInput = document.getElementById('mInputPhone');
    const phone = phoneInput ? phoneInput.value : '0822221616';
    const qrImg = document.getElementById('mQrImage');
    if (qrImg) {
        qrImg.src = 'https://img.vietqr.io/image/MB-08222216167810-compact2.png?amount=' + total + '&addInfo=161GM%20' + encodeURIComponent(phone || '0822221616') + '&accountName=NGUYEN%20VAN%20QUOC%20BAO';
    }
}

function resetCheckoutModal() {
    if (typeof stopPaymentPolling === 'function') stopPaymentPolling();
    const deliveryStep = document.getElementById('mDeliveryStep');
    const paymentStep = document.getElementById('mPaymentStep');
    const successStep = document.getElementById('mSuccessStep');

    if (deliveryStep) deliveryStep.style.display = 'block';
    if (paymentStep) paymentStep.style.display = 'none';
    if (successStep) successStep.style.display = 'none';

    const b1 = document.getElementById('mBadgeStep1');
    if (b1) {
        b1.className = 'stepper-badge active-step';
        b1.textContent = '1';
    }
    const t1 = document.getElementById('mTextStep1');
    if (t1) t1.className = 'small fw-bold text-uppercase';

    const line = document.getElementById('mStepperLine');
    if (line) line.className = 'stepper-line';

    const b2 = document.getElementById('mBadgeStep2');
    if (b2) {
        b2.className = 'stepper-badge';
        b2.textContent = '2';
    }
    const t2 = document.getElementById('mTextStep2');
    if (t2) t2.className = 'small fw-bold text-uppercase text-muted';
}

function openCheckoutModal() {
    if (!cart || cart.length === 0) {
        alert('Giỏ hàng của bạn đang trống! Vui lòng chọn ít nhất 1 sản phẩm trước khi tiến hành thanh toán.');
        const cartOffcanvasEl = document.getElementById('cartOffcanvas');
        if (cartOffcanvasEl) {
            const bsOffcanvas = new bootstrap.Offcanvas(cartOffcanvasEl);
            bsOffcanvas.show();
        }
        return;
    }
    const cartOffcanvasEl = document.getElementById('cartOffcanvas');
    if (cartOffcanvasEl) {
        const offcanvasInstance = bootstrap.Offcanvas.getInstance(cartOffcanvasEl);
        if (offcanvasInstance) offcanvasInstance.hide();
    }

    resetCheckoutModal();

    const checkoutModalEl = document.getElementById('checkoutModal');
    if (checkoutModalEl) {
        const modalInstance = new bootstrap.Modal(checkoutModalEl);
        modalInstance.show();
    }
}

function addToCart(pid) {
    const p = PRODUCTS.find(x => x.id === pid);
    if (!p) return;
    const exist = cart.find(x => x.product.id === pid);
    if (exist) {
        exist.quantity++;
    } else {
        cart.push({ product: p, quantity: 1 });
    }
    renderCart();
    const offcanvasEl = document.getElementById('cartOffcanvas');
    if (offcanvasEl) {
        const bsOffcanvas = new bootstrap.Offcanvas(offcanvasEl);
        bsOffcanvas.show();
    }
}

function changeQty(idx, delta) {
    cart[idx].quantity += delta;
    if (cart[idx].quantity <= 0) cart.splice(idx, 1);
    renderCart();
}

function removeItem(idx) {
    cart.splice(idx, 1);
    renderCart();
}

// Modal Step Validation
function handleModalStep1() {
    const name = document.getElementById('mInputFullName');
    const phone = document.getElementById('mInputPhone');
    const addr = document.getElementById('mInputAddress');

    let valid = true;
    document.getElementById('mErrName').classList.add('d-none');
    document.getElementById('mErrPhone').classList.add('d-none');
    document.getElementById('mErrAddress').classList.add('d-none');

    if (!name.value.trim()) {
        document.getElementById('mErrName').classList.remove('d-none');
        valid = false;
    }
    if (!phone.value.trim() || phone.value.trim().length < 9) {
        document.getElementById('mErrPhone').classList.remove('d-none');
        valid = false;
    }
    if (!addr.value.trim()) {
        document.getElementById('mErrAddress').classList.remove('d-none');
        valid = false;
    }

    if (!valid) return;

    // Update Summary
    document.getElementById('mSummaryRecipient').textContent = name.value.trim() + ' • ' + phone.value.trim();
    document.getElementById('mSummaryAddress').textContent = addr.value.trim();
    document.getElementById('mQrContentText').textContent = '161GM ' + phone.value.trim();

    renderCart();

    // Transition to Step 2
    document.getElementById('mDeliveryStep').style.display = 'none';
    document.getElementById('mPaymentStep').style.display = 'block';

    document.getElementById('mBadgeStep1').className = 'stepper-badge completed-step';
    document.getElementById('mBadgeStep1').innerHTML = '<i class="fa-solid fa-check"></i>';
    document.getElementById('mStepperLine').className = 'stepper-line active-line';
    document.getElementById('mBadgeStep2').className = 'stepper-badge active-step';
    document.getElementById('mTextStep2').className = 'small fw-bold text-uppercase text-dark';

    // Start Real-time Auto Payment Detection
    startPaymentPolling(phone.value.trim());
}

const SEPAY_API_TOKEN = atob('SkhOSklQVk1UWEpCWjFKWklDRU9ETEw4QVVWVjBaQUdNR1FSUFZTNTJNNVJPV1VZSVJUMlAzRUY2VUQ4OUFPTg==');
let paymentPollingInterval = null;

function startPaymentPolling(phone) {
    if (paymentPollingInterval) clearInterval(paymentPollingInterval);
    const cleanPhone = phone.replace(/\s+/g, '');

    const badge = document.getElementById('paymentWaitingBadge');
    if (badge) {
        badge.className = 'badge bg-light text-dark border border-secondary-subtle py-2 px-3 d-inline-flex align-items-center gap-2';
        badge.innerHTML = '<span class="spinner-grow spinner-grow-sm text-danger" role="status" style="width: 0.7rem; height: 0.7rem;"></span><span id="paymentWaitingText">Đang chờ nhận chuyển khoản từ MB Bank...</span>';
    }

    paymentPollingInterval = setInterval(async () => {
        try {
            const res = await fetch('https://my.sepay.vn/userapi/transactions/list', {
                headers: {
                    'Authorization': 'Bearer ' + SEPAY_API_TOKEN,
                    'Content-Type': 'application/json'
                }
            });

            if (res.ok) {
                const data = await res.json();
                if (data && data.transactions && Array.isArray(data.transactions)) {
                    const found = data.transactions.slice(0, 15).some(tx => {
                        const content = ((tx.transaction_content || '') + ' ' + (tx.code || '')).toUpperCase();
                        const target = cleanPhone.toUpperCase();
                        return (tx.amount_in && parseFloat(tx.amount_in) > 0) && (content.includes(target) || content.includes('161GM ' + target) || content.includes('161GM'));
                    });

                    if (found) {
                        onPaymentSuccess();
                        return;
                    }
                }
            }
        } catch (e) {
            console.log('[SePay Polling Check]:', e);
        }
    }, 2000);
}

function stopPaymentPolling() {
    if (paymentPollingInterval) {
        clearInterval(paymentPollingInterval);
        paymentPollingInterval = null;
    }
}

function onPaymentSuccess() {
    stopPaymentPolling();
    const badge = document.getElementById('paymentWaitingBadge');
    if (badge) {
        badge.className = 'badge bg-success text-white py-2 px-3 mb-3 d-inline-flex align-items-center gap-2 animate__animated animate__bounceIn';
        badge.innerHTML = '<i class="fa-solid fa-circle-check fs-6"></i> ĐÃ NHẬN TIỀN MB BANK THÀNH CÔNG! ĐANG CHUYỂN TRANG...';
    }
    setTimeout(() => {
        finishOrderDemo();
    }, 1200);
}

function handleModalStepBack() {
    stopPaymentPolling();
    document.getElementById('mPaymentStep').style.display = 'none';
    document.getElementById('mDeliveryStep').style.display = 'block';

    document.getElementById('mBadgeStep1').className = 'stepper-badge active-step';
    document.getElementById('mBadgeStep1').textContent = '1';
    document.getElementById('mStepperLine').className = 'stepper-line';
    document.getElementById('mBadgeStep2').className = 'stepper-badge';
    document.getElementById('mTextStep2').className = 'small fw-bold text-uppercase text-muted';
}

function finishOrderDemo() {
    stopPaymentPolling();
    document.getElementById('mPaymentStep').style.display = 'none';
    document.getElementById('mSuccessStep').style.display = 'block';
    cart = [];
    renderCart();
}

function copyDemo(text, btn) {
    navigator.clipboard.writeText(text);
    const orig = btn.innerText;
    btn.innerText = 'Đã chép!';
    btn.classList.add('btn-success', 'text-white');
    setTimeout(() => {
        btn.innerText = orig;
        btn.classList.remove('btn-success', 'text-white');
    }, 1500);
}

// Magic Gliding Nav Underline
function initSlidingUnderline() {
    const nav = document.getElementById('mainCategoryNav');
    const indicator = document.getElementById('slidingNavIndicator');
    if (!nav || !indicator) return;

    const navLinks = nav.querySelectorAll('.main-nav-link');
    let activeLink = nav.querySelector('.main-nav-link.active-cate') || navLinks[0];

    function moveTo(element) {
        if (!element) return;
        const navRect = nav.getBoundingClientRect();
        const elemRect = element.getBoundingClientRect();
        const padding = 24;
        const left = (elemRect.left - navRect.left) + (padding / 2);
        const width = Math.max(elemRect.width - padding, 18);

        indicator.style.left = left + 'px';
        indicator.style.width = width + 'px';
        indicator.style.opacity = '1';
    }

    setTimeout(() => moveTo(activeLink), 100);

    navLinks.forEach(link => {
        link.addEventListener('mouseenter', function () { moveTo(this); });
    });
    nav.addEventListener('mouseleave', function () { if (activeLink) moveTo(activeLink); });
}

// Navbar Scroll Background Toggle
window.addEventListener('scroll', function () {
    const navbar = document.getElementById('siteNavbar');
    if (navbar) {
        if (window.scrollY > 80) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    }
});

// Initialize on DOM load
document.addEventListener('DOMContentLoaded', function () {
    renderProducts(PRODUCTS);
    renderCart();
    initSlidingUnderline();
    document.getElementById('checkoutModal')?.addEventListener('hidden.bs.modal', function () {
        resetCheckoutModal();
    });
});
