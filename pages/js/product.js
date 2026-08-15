/**
 * ONE61 GARMENTORY - Catalog / Product Listing Script
 * Data, Multi-level Filtering, Sorting, Wishlist & Add-to-Cart
 */

const PRODUCTS_DATA = [
    { id: "PROD01", name: "Áo Thun Cổ Tròn Ngắn Tay", cat: "MEN_01", cateGroup: "MEN", price: 299000, img: "../web/img-prj301/ao-thun-01.avif", desc: "Chất liệu cotton 100% mềm mại, thoáng mát cả ngày, thấm hút mồ hôi tối ưu." },
    { id: "PROD02", name: "Áo Thun AIRism Trắng", cat: "WOMEN_01", cateGroup: "WOMEN", price: 249000, img: "../web/img-prj301/ao-thun-02.avif", desc: "Công nghệ sợi vải AIRism mượt mà, làm mát tức thì, chống tia UV hiệu quả." },
    { id: "PROD03", name: "Áo Thun Dáng Rộng", cat: "MEN_01", cateGroup: "MEN", price: 399000, img: "../web/img-prj301/ao-thun-03.avif", desc: "Form áo Oversize thời thượng, dễ dàng phối nhiều phong cách đường phố." },
    { id: "PROD04", name: "Áo Thun Vải Linen", cat: "MEN_01", cateGroup: "MEN", price: 599000, img: "../web/img-prj301/ao-thun-04.avif", desc: "Vải linen cao cấp tự nhiên, thấm hút mồ hôi, bề mặt mộc mạc tinh tế." },
    { id: "PROD05", name: "Áo Thun Thể Thao", cat: "MEN_01", cateGroup: "MEN", price: 599000, img: "../web/img-prj301/ao-thun-05.avif", desc: "Lịch lãm chốn công sở và năng động trên sân tập, co giãn tối đa." },
    { id: "PROD06", name: "Áo Khoác Chống UV Nữ", cat: "WOMEN_03", cateGroup: "WOMEN", price: 499000, img: "../web/img-prj301/ao-khoac-01.avif", desc: "Chống nắng hiệu quả UPF 50+, gấp gọn bỏ túi tiện lợi khi ra ngoài." },
    { id: "PROD07", name: "Áo Khoác Nỉ Có Nón", cat: "MEN_03", cateGroup: "MEN", price: 699000, img: "../web/img-prj301/ao-khoac-03.avif", desc: "Chất nỉ da cá dày dặn, phom rộng rãi thoải mái giữ ấm những ngày gió." },
    { id: "PROD08", name: "Áo Khoác Parka Chống Gió", cat: "WOMEN_03", cateGroup: "WOMEN", price: 899000, img: "../web/img-prj301/ao-khoac-04.avif", desc: "Kháng nước nhẹ và cản gió tối ưu, phối đồ phong cách thanh lịch." },
    { id: "PROD09", name: "Áo Khoác Blazer Nam", cat: "MEN_03", cateGroup: "MEN", price: 1290000, img: "../web/img-prj301/ao-khoac-05.avif", desc: "Thiết kế chuẩn may đo phong cách Tokyo hiện đại, đứng phom sang trọng." },
    { id: "PROD10", name: "Áo Sơ Mi Oxford Dài Tay", cat: "MEN_02", cateGroup: "MEN", price: 499000, img: "../web/img-prj301/ao-khoac-06.avif", desc: "Vải Oxford 100% bông chải kỹ, hạn chế nhăn xù, phong cách tối giản." },
    { id: "PROD11", name: "Áo Sơ Mi Cổ Mở Modal", cat: "WOMEN_02", cateGroup: "WOMEN", price: 449000, img: "../web/img-prj301/quan-dai-01.avif", desc: "Chất liệu Modal rũ nhẹ, thoáng mát tạo cảm giác bay bổng nữ tính." },
    { id: "PROD12", name: "Quần Jeans Dáng Suông", cat: "WOMEN_04", cateGroup: "WOMEN", price: 799000, img: "../web/img-prj301/quan-dai-02.avif", desc: "Denim cotton 100% bền màu, tôn dáng chân dài tự nhiên." },
    { id: "PROD13", name: "Quần Kaki Ống Đứng", cat: "MEN_04", cateGroup: "MEN", price: 649000, img: "../web/img-prj301/quan-dai-03.avif", desc: "Chất vải Chino Twill co giãn 2 chiều, phom đứng chuẩn mực đi làm." },
    { id: "PROD14", name: "Quần Short Thể Thao Nam", cat: "MEN_04", cateGroup: "MEN", price: 349000, img: "../web/img-prj301/quan-dai-04.avif", desc: "Chất liệu Dry-Ex khô nhanh, siêu nhẹ, lý tưởng cho tập luyện và ở nhà." },
    { id: "PROD15", name: "Áo Thun Trẻ Em In Hình", cat: "KIDS_01", cateGroup: "KIDS", price: 199000, img: "../web/img-prj301/quan-dai-05.avif", desc: "Cotton tự nhiên êm dịu, thấm hút mồ hôi tốt cho làn da nhạy cảm của bé." },
    { id: "PROD16", name: "Quần Jogger Trẻ Em Co Giãn", cat: "KIDS_03", cateGroup: "KIDS", price: 299000, img: "../web/img-prj301/quan-dai-06.avif", desc: "Lưng thun êm ái, co giãn đa chiều cho bé thoải mái vận động cả ngày." }
];

let currentList = [...PRODUCTS_DATA];

function renderProducts(list) {
    const grid = document.getElementById('productsGrid');
    const countEl = document.getElementById('productCount');
    if (countEl) countEl.textContent = list.length;
    if (!grid) return;
    
    if (list.length === 0) {
        grid.innerHTML = '<div class="col-12 text-center py-5"><i class="fa-solid fa-box-open text-muted display-4 mb-3 d-block"></i><h5 class="text-muted">Không tìm thấy sản phẩm phù hợp</h5></div>';
        return;
    }

    grid.innerHTML = list.map(p => `
        <div class="col">
            <div class="card h-100 one61-catalog-card rounded-0">
                <div class="one61-img-box">
                    <a href="product-detail.html?id=${p.id}">
                        <img src="${p.img}" alt="${p.name}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=600&auto=format&fit=crop&q=80';">
                    </a>

                    <div class="position-absolute top-0 start-0 m-2 d-flex flex-column gap-1" style="z-index: 4;">
                        <span class="badge bg-danger rounded-0 px-2 py-1 text-uppercase" style="font-size: 0.65rem; letter-spacing: 0.5px;">NEW</span>
                    </div>

                    <button type="button" class="floating-wishlist-btn" onclick="toggleQuickWishlist('${p.id}', '${p.name}', ${p.price}, '${p.img}', this)" title="Lưu vào Yêu thích">
                        <i class="fa-regular fa-heart" style="font-size: 0.85rem;"></i>
                    </button>

                    <div class="card-quick-actions">
                        <a href="product-detail.html?id=${p.id}" class="btn-quick-view">
                            <i class="fa-regular fa-eye me-1"></i> Xem chi tiết
                        </a>
                        <button onclick="addToCart('${p.id}')" class="btn-quick-add" title="Thêm vào giỏ">
                            <i class="fa-solid fa-cart-plus"></i>
                        </button>
                    </div>
                </div>

                <div class="card-body p-3 d-flex flex-column">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <span class="text-uppercase text-muted font-monospace" style="font-size: 0.68rem; letter-spacing: 0.5px;">ONE61 ESSENTIALS</span>
                        <div class="d-flex gap-1">
                            <span class="color-swatch-dot" style="background-color: #222;"></span>
                            <span class="color-swatch-dot" style="background-color: #E8E5DF;"></span>
                            <span class="color-swatch-dot" style="background-color: #8C2B2B;"></span>
                        </div>
                    </div>

                    <h6 class="card-title fw-bold text-uppercase mb-1" style="font-size: 0.88rem; line-height: 1.35; height: 2.7em; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                        <a href="product-detail.html?id=${p.id}" class="text-dark text-decoration-none">
                            ${p.name}
                        </a>
                    </h6>

                    <p class="card-text text-muted small text-truncate mb-3" style="font-size: 0.78rem;">
                        ${p.desc}
                    </p>

                    <div class="mt-auto d-flex justify-content-between align-items-center pt-2 border-top">
                        <div class="fw-bold fs-6" style="color: var(--color-primary, #ED1D24); font-family: 'Be Vietnam Pro', sans-serif;">
                            ${p.price.toLocaleString('vi-VN')} đ
                        </div>
                        <a href="product-detail.html?id=${p.id}" class="btn btn-outline-dark btn-sm rounded-0 fw-bold px-2 py-1 text-uppercase" style="font-size: 0.72rem;">
                            <i class="fa-solid fa-bag-shopping me-1"></i> Mua
                        </a>
                    </div>
                </div>
            </div>
        </div>
    `).join('');
}

const CAT_LABELS = {
    'ALL': 'TẤT CẢ SẢN PHẨM',
    'MEN': 'THỜI TRANG NAM',
    'MEN_01': 'ÁO THUN NAM',
    'MEN_02': 'ÁO SƠ MI NAM',
    'MEN_03': 'ÁO KHOÁC NAM',
    'MEN_04': 'QUẦN DÀI NAM',
    'WOMEN': 'THỜI TRANG NỮ',
    'WOMEN_01': 'ÁO THUN NỮ',
    'WOMEN_02': 'ÁO SƠ MI NỮ',
    'WOMEN_03': 'ÁO KHOÁC NỮ',
    'WOMEN_04': 'QUẦN & VÁY NỮ',
    'KIDS': 'TRẺ EM (KIDS)',
    'KIDS_01': 'ÁO TRẺ EM',
    'KIDS_02': 'ÁO KHOÁC TRẺ EM',
    'KIDS_03': 'QUẦN TRẺ EM'
};

function filterCategory(catPrefix) {
    document.querySelectorAll('.sidebar-cate-link').forEach(el => el.classList.remove('active'));
    if (catPrefix === 'ALL') {
        currentList = [...PRODUCTS_DATA];
        const titleEl = document.getElementById('catalogTitle');
        if (titleEl) titleEl.textContent = 'TẤT CẢ SẢN PHẨM';
        const bcEl = document.getElementById('breadcrumbCurrentCat');
        if (bcEl) bcEl.textContent = 'Tất cả sản phẩm';
        const allLink = document.getElementById('catLinkALL');
        if (allLink) allLink.classList.add('active');
    } else {
        currentList = PRODUCTS_DATA.filter(p => p.cat.startsWith(catPrefix) || p.cateGroup === catPrefix);
        const title = CAT_LABELS[catPrefix] || catPrefix;
        const titleEl = document.getElementById('catalogTitle');
        if (titleEl) titleEl.textContent = title;
        const bcEl = document.getElementById('breadcrumbCurrentCat');
        if (bcEl) bcEl.textContent = title;
    }

    // Sync Quick Filter Pills Active Class
    document.querySelectorAll('.category-pill-btn').forEach(btn => {
        const onclickAttr = btn.getAttribute('onclick') || '';
        if (onclickAttr.includes(`'${catPrefix}'`)) {
            btn.classList.add('active');
        } else {
            btn.classList.remove('active');
        }
    });

    renderProducts(currentList);
}

function sortProducts(type) {
    if (type === 'price-asc') currentList.sort((a, b) => a.price - b.price);
    else if (type === 'price-desc') currentList.sort((a, b) => b.price - a.price);
    else if (type === 'name') currentList.sort((a, b) => a.name.localeCompare(b.name));
    else currentList = [...PRODUCTS_DATA];
    renderProducts(currentList);
}

function addToCart(prodId) {
    let p = PRODUCTS_DATA.find(x => x.id === prodId);
    if (!p) return;
    let cart = JSON.parse(localStorage.getItem('one61_cart') || '[]');
    let exist = cart.find(x => x.id === prodId);
    if (exist) {
        exist.qty += 1;
    } else {
        cart.push({ id: p.id, name: p.name, price: p.price, img: p.img, qty: 1, color: '32 BEIGE', size: 'M' });
    }
    localStorage.setItem('one61_cart', JSON.stringify(cart));
    if (typeof updateGlobalBadges === 'function') updateGlobalBadges();
    if (typeof window.one61Toast === 'function') {
        window.one61Toast('Đã thêm [' + p.name + '] vào giỏ hàng!', 'success');
    } else {
        alert('Đã thêm sản phẩm [' + p.name + '] vào giỏ hàng!');
    }
}

function toggleQuickWishlist(id, name, price, img, btn) {
    let wishlist = JSON.parse(localStorage.getItem('one61_wishlist') || '[]');
    const idx = wishlist.findIndex(item => item.id === id);
    const icon = btn.querySelector('i');
    
    if (idx === -1) {
        wishlist.push({ id, name, price, img });
        localStorage.setItem('one61_wishlist', JSON.stringify(wishlist));
        if (icon) {
            icon.className = 'fa-solid fa-heart text-danger';
        }
        if (typeof window.one61Toast === 'function') {
            window.one61Toast('Đã lưu [' + name + '] vào Yêu thích!', 'success');
        }
    } else {
        wishlist.splice(idx, 1);
        localStorage.setItem('one61_wishlist', JSON.stringify(wishlist));
        if (icon) {
            icon.className = 'fa-regular fa-heart';
        }
        if (typeof window.one61Toast === 'function') {
            window.one61Toast('Đã xóa khỏi Yêu thích', 'info');
        }
    }
    if (typeof window.updateWishlistBadge === 'function') {
        window.updateWishlistBadge();
    }
}

// Category Icons Dataset (UNIQLO Style)
const CATEGORY_ICONS_DATA = {
    MEN: [
        { name: 'Áo Thun & Nỉ', icon: '../web/img-prj301/categories/men/t-shirt-icon-men.avif', cat: 'MEN_01' },
        { name: 'Áo Polo', icon: '../web/img-prj301/categories/men/polos-icon-men.avif', cat: 'MEN_01' },
        { name: 'Áo Sơ Mi', icon: '../web/img-prj301/categories/men/shirts-icon-men.avif', cat: 'MEN_02' },
        { name: 'Áo Len', icon: '../web/img-prj301/categories/men/sweaters-icon-men.avif', cat: 'MEN_03' },
        { name: 'Áo Khoác', icon: '../web/img-prj301/categories/men/outerwear-icon-men.avif', cat: 'MEN_03' },
        { name: 'Quần Dài', icon: '../web/img-prj301/categories/men/pants-men.avif', cat: 'MEN_04' },
        { name: 'Quần Jeans', icon: '../web/img-prj301/categories/men/jeans-men.png', cat: 'MEN_04' },
        { name: 'Quần Shorts', icon: '../web/img-prj301/categories/men/short-men.avif', cat: 'MEN_04' }
    ],
    WOMEN: [
        { name: 'Áo Thun & Nỉ', icon: '../web/img-prj301/categories/women/t-shirt-icon-women.avif', cat: 'WOMEN_01' },
        { name: 'Sơ Mi & Blouse', icon: '../web/img-prj301/categories/women/shirt-and-blouses-icon-women.avif', cat: 'WOMEN_02' },
        { name: 'Áo Len', icon: '../web/img-prj301/categories/women/sweaters-icon-women.avif', cat: 'WOMEN_03' },
        { name: 'Áo Khoác', icon: '../web/img-prj301/categories/women/outerwear-icon-women.avif', cat: 'WOMEN_03' },
        { name: 'Quần & Váy', icon: '../web/img-prj301/categories/women/bottom-icon-women.jpg', cat: 'WOMEN_04' },
        { name: 'Shorts & Culottes', icon: '../web/img-prj301/categories/women/shorts-and-culottes-icon.avif', cat: 'WOMEN_04' }
    ],
    KIDS: [
        { name: 'Áo Thun', icon: '../web/img-prj301/categories/kids/t-shirt-icon-kids.avif', cat: 'KIDS_01' },
        { name: 'Áo Sơ Mi', icon: '../web/img-prj301/categories/kids/shirts-icon-kids.avif', cat: 'KIDS_01' },
        { name: 'Áo Khoác', icon: '../web/img-prj301/categories/kids/outerwear-icon-kids.avif', cat: 'KIDS_02' },
        { name: 'Đầm & Váy', icon: '../web/img-prj301/categories/kids/dresses-icon-kids.avif', cat: 'KIDS_03' },
        { name: 'Quần Dài', icon: '../web/img-prj301/categories/kids/bottoms-icon-kids.avif', cat: 'KIDS_03' },
        { name: 'Quần Shorts', icon: '../web/img-prj301/categories/kids/shorts-kids.avif', cat: 'KIDS_03' }
    ]
};

function renderCategoryGrid(group = 'MEN') {
    const grid = document.getElementById('uniqloCategoryGrid');
    if (!grid) return;

    const items = CATEGORY_ICONS_DATA[group] || CATEGORY_ICONS_DATA.MEN;

    grid.innerHTML = items.map(it => `
        <a href="javascript:void(0)" onclick="filterCategory('${it.cat}')" class="uniqlo-cat-item">
            <div class="uniqlo-cat-thumb">
                <img src="${it.icon}" alt="${it.name}" onerror="this.src='../web/img-prj301/ao-thun-01.avif'">
            </div>
            <span class="uniqlo-cat-title">${it.name}</span>
        </a>
    `).join('');
}

function switchCategoryTab(group, btn) {
    document.querySelectorAll('.category-tab-btn').forEach(b => b.classList.remove('active'));
    if (btn) btn.classList.add('active');
    renderCategoryGrid(group);
    filterCategory(group);
}

window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const cat = urlParams.get('cat');
    const defaultGroup = (cat && cat.startsWith('WOMEN')) ? 'WOMEN' : ((cat && cat.startsWith('KIDS')) ? 'KIDS' : 'MEN');
    renderCategoryGrid(defaultGroup);
    if (cat) filterCategory(cat);
    else renderProducts(currentList);
});
