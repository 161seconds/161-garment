/**
 * ONE61 GARMENTORY - Catalog / Product Listing Script
 * Data, Multi-level Filtering, Sorting, Wishlist & Add-to-Cart
 */

const PRODUCTS_DATA = [
    // MEN: Sơ Mi (MEN_01)
    { id: "PROD01", name: "Áo Sơ Mi Oxford Nam Dài Tay", cat: "MEN_01", cateGroup: "MEN", price: 599000, img: "../web/img-prj301/products/men/cover/cover-shirts-men-1.avif", desc: "Chất vải cotton Oxford dệt chéo cao cấp, phom dáng chuẩn công sở và dạo phố." },
    { id: "PROD02", name: "Áo Sơ Mi Linen Cổ Tàu Thoáng Khí", cat: "MEN_01", cateGroup: "MEN", price: 699000, img: "../web/img-prj301/products/men/cover/cover-shirts-men-2.avif", desc: "Vải sợi lanh Linen 100% tự nhiên thoáng mát, mang lại cảm giác dễ chịu ngày hè." },
    { id: "PROD03", name: "Áo Sơ Mi Cộc Tay Phom Rộng", cat: "MEN_01", cateGroup: "MEN", price: 499000, img: "../web/img-prj301/products/men/cover/cover-shirts-men-3.avif", desc: "Thiết kế ngắn tay trẻ trung, phom suông rộng rãi thoải mái cho các hoạt động ngoài trời." },

    // MEN: Áo Khoác (MEN_02)
    { id: "PROD04", name: "Áo Khoác Gió Nam Chống Thấm Nước", cat: "MEN_02", cateGroup: "MEN", price: 799000, img: "../web/img-prj301/products/men/cover/cover-outerwear-men-1.avif", desc: "Công nghệ BlockTech cản gió và chống nước tối ưu, siêu nhẹ và dễ gấp gọn." },
    { id: "PROD05", name: "Áo Khoác Blazer Nam Công Sở", cat: "MEN_02", cateGroup: "MEN", price: 1299000, img: "../web/img-prj301/products/men/cover/cover-outerwear-men-2.avif", desc: "Thiết kế may đo tỉ mỉ, tôn dáng lịch lãm và sang trọng cho quý ông hiện đại." },
    { id: "PROD06", name: "Áo Khoác Bomber Kaki Dáng Trẻ", cat: "MEN_02", cateGroup: "MEN", price: 899000, img: "../web/img-prj301/products/men/cover/cover-outerwear-men-3.avif", desc: "Chất kaki cao cấp đứng phom, phong cách street-style năng động và cá tính." },

    // MEN: Quần Dài (MEN_03)
    { id: "PROD07", name: "Quần Smart Pants Co Giãn 2 Chiều", cat: "MEN_03", cateGroup: "MEN", price: 799000, img: "../web/img-prj301/products/men/cover/cover-pants-men-1.avif", desc: "Quần âu dáng slim fit với lưng thun ẩn thoải mái, không nhăn sau khi giặt." },
    { id: "PROD08", name: "Quần Kaki Chino Dáng Suông Nam", cat: "MEN_03", cateGroup: "MEN", price: 699000, img: "../web/img-prj301/products/men/cover/cover-pants-men-2.avif", desc: "Chất vải cotton pha spandex co giãn, phom regular fit chuẩn mực cho mọi dịp." },
    { id: "PROD09", name: "Quần Jogger Kaki Túi Hộp Năng Động", cat: "MEN_03", cateGroup: "MEN", price: 599000, img: "../web/img-prj301/products/men/cover/cover-pants-men-3.avif", desc: "Thiết kế túi hộp tiện dụng, ống bo thun thể thao khỏe khoắn." },

    // MEN: Quần Jeans (MEN_04)
    { id: "PROD10", name: "Quần Jeans Nam Slim Fit Co Giãn", cat: "MEN_04", cateGroup: "MEN", price: 899000, img: "../web/img-prj301/products/men/cover/cover-jeans-men-1.avif", desc: "Denim Nhật Bản cao cấp dệt sợi đàn hồi, bền màu và mềm mại với làn da." },
    { id: "PROD11", name: "Quần Jeans Ống Suông Regular Vintage", cat: "MEN_04", cateGroup: "MEN", price: 949000, img: "../web/img-prj301/products/men/cover/cover-jeans-men-2.avif", desc: "Xử lý wash màu cổ điển thời thượng, tôn dáng chân dài và nam tính." },
    { id: "PROD12", name: "Quần Jeans Relaxed Fit Dáng Rộng", cat: "MEN_04", cateGroup: "MEN", price: 849000, img: "../web/img-prj301/products/men/cover/cover-jeans-men-3.avif", desc: "Form ống rộng thoải mái tối đa cho ngày dài vận động." },

    // WOMEN: Sơ Mi & Blouse (WOMEN_01)
    { id: "PROD13", name: "Áo Sơ Mi Rayon Nữ Mềm Rủ", cat: "WOMEN_01", cateGroup: "WOMEN", price: 549000, img: "../web/img-prj301/products/women/cover/cover-shirt-and-blouses-women-1.avif", desc: "Chất lụa Rayon cao cấp chống nhăn, rủ nhẹ nhàng tôn vẻ đẹp thanh tao." },
    { id: "PROD14", name: "Áo Blouse Cổ Thắt Nơ Nữ Tính", cat: "WOMEN_01", cateGroup: "WOMEN", price: 599000, img: "../web/img-prj301/products/women/cover/cover-shirt-and-blouses-women-2.avif", desc: "Điểm nhấn cổ nơ duyên dáng, dễ dàng kết hợp cùng chân váy hoặc quần âu." },
    { id: "PROD15", name: "Áo Sơ Mi Vải Đũi Cổ Chữ V", cat: "WOMEN_01", cateGroup: "WOMEN", price: 499000, img: "../web/img-prj301/products/women/cover/cover-shirt-and-blouses-women-3.avif", desc: "Vải đũi tự nhiên mát lạnh, phom suông phóng khoáng chuẩn phong cách LifeWear." },

    // WOMEN: Áo Khoác (WOMEN_02)
    { id: "PROD16", name: "Áo Khoác Chống Tia UV AirSense Nữ", cat: "WOMEN_02", cateGroup: "WOMEN", price: 699000, img: "../web/img-prj301/products/women/cover/cover-outerwear-women-1.avif", desc: "Chỉ số chống nắng UPF 50+, công nghệ dệt siêu nhẹ bảo vệ làn da tuyệt đối." },
    { id: "PROD17", name: "Áo Khoác Dạ Tweed Sang Trọng", cat: "WOMEN_02", cateGroup: "WOMEN", price: 1399000, img: "../web/img-prj301/products/women/cover/cover-outerwear-women-2.avif", desc: "Vải dạ dệt kim ánh kim sang trọng, viền chỉ tỉ mỉ chuẩn phong cách Parisian." },
    { id: "PROD18", name: "Áo Khoác Trench Coat Dáng Dài", cat: "WOMEN_02", cateGroup: "WOMEN", price: 1599000, img: "../web/img-prj301/products/women/cover/cover-outerwear-women-3.avif", desc: "Phom dáng trench coat kinh điển, chống thấm nước nhẹ và cản gió tốt." },

    // WOMEN: Quần & Váy (WOMEN_03)
    { id: "PROD19", name: "Quần Ống Suông Xếp Ly Pleated Pants", cat: "WOMEN_03", cateGroup: "WOMEN", price: 799000, img: "../web/img-prj301/products/women/cover/cover-bottom-women-1.avif", desc: "Thiết kế xếp ly tinh tế tạo hiệu ứng kéo dài chân, chất vải rủ nhẹ nhàng." },
    { id: "PROD20", name: "Chân Váy Midi Dáng Chữ A Tôn Dáng", cat: "WOMEN_03", cateGroup: "WOMEN", price: 649000, img: "../web/img-prj301/products/women/cover/cover-bottom-women-2.avif", desc: "Phom chữ A nhẹ nhàng che khuyết điểm, cạp cao tôn vòng eo thon gọn." },
    { id: "PROD21", name: "Quần Tây Nữ Ống Đứng Ankle Pants", cat: "WOMEN_03", cateGroup: "WOMEN", price: 749000, img: "../web/img-prj301/products/women/cover/cover-bottom-women-3.avif", desc: "Chiều dài ngang mắt cá chân thanh thoát, lưng co giãn tiện lợi cả ngày làm việc." },

    // WOMEN: Shorts & Culottes (WOMEN_04)
    { id: "PROD22", name: "Quần Shorts Kaki Lưng Cao Nữ", cat: "WOMEN_04", cateGroup: "WOMEN", price: 449000, img: "../web/img-prj301/products/women/cover/cover-shorts-and-culott-1.avif", desc: "Chất kaki co giãn nhẹ, cạp cao tôn dáng, năng động khi phối cùng áo thun và sơ mi." },
    { id: "PROD23", name: "Quần Giả Váy Xếp Nếp Thời Thượng", cat: "WOMEN_04", cateGroup: "WOMEN", price: 499000, img: "../web/img-prj301/products/women/cover/cover-shorts-and-culott-2.avif", desc: "Thiết kế xếp nếp trẻ trung, vừa kín đáo vừa phong cách cho phái đẹp." },
    { id: "PROD24", name: "Quần Culottes Ống Rộng Vải Linen", cat: "WOMEN_04", cateGroup: "WOMEN", price: 549000, img: "../web/img-prj301/products/women/cover/cover-shorts-and-culott-3.avif", desc: "Ống rộng bay bổng, chất vải lanh tự nhiên mang lại sự thư thái tuyệt đối." }
];

const CATALOG_PAGE_SIZE = 10;
let catalogCurrentPage = 1;
let currentList = [...PRODUCTS_DATA];

function setCatalogPage(page) {
    catalogCurrentPage = page;
    renderProducts(currentList, page);
}

function renderProducts(list, page = 1) {
    const grid = document.getElementById('productsGrid');
    const countEl = document.getElementById('productCount');
    if (!grid) return;
    
    currentList = list;
    catalogCurrentPage = page;
    const total = list.length;
    const endPage = Math.ceil(total / CATALOG_PAGE_SIZE);
    const startIdx = (page - 1) * CATALOG_PAGE_SIZE;
    const paginatedItems = list.slice(startIdx, startIdx + CATALOG_PAGE_SIZE);

    if (countEl) countEl.textContent = total;
    
    if (list.length === 0) {
        grid.innerHTML = '<div class="col-12 text-center py-5"><i class="fa-solid fa-box-open text-muted display-4 mb-3 d-block"></i><h5 class="text-muted">Không tìm thấy sản phẩm phù hợp</h5></div>';
        renderCatalogPagination(0, 1);
        return;
    }

    grid.innerHTML = paginatedItems.map(p => `
        <div class="col">
            <div class="card h-100 one61-catalog-card rounded-0">
                <div class="one61-img-box">
                    <a href="product-detail.html?id=${p.id}">
                        <img src="${p.img}" alt="${p.name}" class="product-img" onerror="this.src='../web/img-prj301/products/men/cover/cover-shirts-men-1.avif'">
                    </a>
                    <button class="wishlist-btn" onclick="toggleWishlist('${p.id}', this)" title="Yêu thích">
                        <i class="fa-regular fa-heart"></i>
                    </button>
                    <span class="badge bg-danger rounded-0 position-absolute bottom-0 start-0 m-2" style="font-size: 0.65rem;">NEW</span>
                </div>
                <div class="card-body p-3 d-flex flex-column">
                    <div class="d-flex align-items-center justify-content-between mb-1">
                        <small class="text-muted text-uppercase" style="font-size: 0.7rem; letter-spacing: 0.5px;">${p.cat}</small>
                        <div class="d-flex gap-1">
                            <span class="color-swatch-dot" style="background-color: #333333;"></span>
                            <span class="color-swatch-dot" style="background-color: #888888;"></span>
                            <span class="color-swatch-dot" style="background-color: #E8E8E8;"></span>
                        </div>
                    </div>
                    <h6 class="card-title fw-bold mb-1" style="font-size: 0.92rem; line-height: 1.35;">
                        <a href="product-detail.html?id=${p.id}" class="text-dark text-decoration-none">${p.name}</a>
                    </h6>
                    <p class="text-muted small mb-2 flex-grow-1 text-truncate-2" style="font-size: 0.78rem;">${p.desc}</p>
                    <div class="d-flex align-items-center justify-content-between mt-auto pt-2 border-top">
                        <span class="fw-bold text-danger" style="font-size: 1.05rem;">${p.price.toLocaleString('vi-VN')} đ</span>
                        <button class="btn-quick-add" onclick="quickAddToCart('${p.id}')" title="Thêm vào giỏ">
                            <i class="fa-solid fa-cart-plus me-1"></i> Mua
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `).join('');

    renderCatalogPagination(endPage, page);
}

function renderCatalogPagination(endPage, currentPage) {
    let pagContainer = document.getElementById('catalogPaginationContainer');
    if (!pagContainer) {
        const prodGrid = document.getElementById('productsGrid');
        if (prodGrid && prodGrid.parentElement) {
            pagContainer = document.createElement('div');
            pagContainer.id = 'catalogPaginationContainer';
            pagContainer.className = 'd-flex justify-content-center align-items-center gap-2 mt-5 pb-3';
            prodGrid.parentElement.appendChild(pagContainer);
        }
    }
    if (!pagContainer) return;
    if (endPage <= 1) {
        pagContainer.innerHTML = '';
        return;
    }

    let html = '<ul class="pagination mb-0 rounded-0 gap-1">';
    html += '<li class="page-item ' + (currentPage <= 1 ? 'disabled' : '') + '">' +
            '<a class="page-link rounded-0 fw-bold px-3 py-2 text-dark bg-white border" href="javascript:void(0)" onclick="setCatalogPage(' + (currentPage - 1) + ')">' +
            '<i class="fa-solid fa-chevron-left"></i></a></li>';

    for (let i = 1; i <= endPage; i++) {
        html += '<li class="page-item ' + (i === currentPage ? 'active' : '') + '">' +
                '<a class="page-link rounded-0 fw-bold px-3 py-2 ' + (i === currentPage ? 'bg-danger border-danger text-white' : 'text-dark bg-white border') + '" href="javascript:void(0)" onclick="setCatalogPage(' + i + ')">' + i + '</a></li>';
    }

    html += '<li class="page-item ' + (currentPage >= endPage ? 'disabled' : '') + '">' +
            '<a class="page-link rounded-0 fw-bold px-3 py-2 text-dark bg-white border" href="javascript:void(0)" onclick="setCatalogPage(' + (currentPage + 1) + ')">' +
            '<i class="fa-solid fa-chevron-right"></i></a></li>';
    html += '</ul>';
    pagContainer.innerHTML = html;
}

function filterCategory(cat) {
    let filtered;
    if (cat === 'MEN') {
        filtered = PRODUCTS_DATA.filter(p => p.cateGroup === 'MEN');
    } else if (cat === 'WOMEN') {
        filtered = PRODUCTS_DATA.filter(p => p.cateGroup === 'WOMEN');
    } else if (cat !== 'ALL') {
        filtered = PRODUCTS_DATA.filter(p => p.cat === cat);
    } else {
        filtered = [...PRODUCTS_DATA];
    }
    currentList = filtered;
    renderProducts(filtered);
    
    // Update active state in sidebar
    document.querySelectorAll('.sidebar-cate-link').forEach(link => {
        const onclickAttr = link.getAttribute('onclick') || '';
        if (onclickAttr.includes(`'${cat}'`)) {
            link.style.borderLeftColor = '#ED1D24';
            link.style.color = '#ED1D24';
            link.style.backgroundColor = '#F8F9FA';
        } else {
            link.style.borderLeftColor = 'transparent';
            link.style.color = '#333333';
            link.style.backgroundColor = 'transparent';
        }
    });

    // Update active state in icon items
    document.querySelectorAll('.uniqlo-cat-item').forEach(item => {
        const onclickAttr = item.getAttribute('onclick') || '';
        if (onclickAttr.includes(`'${cat}'`)) {
            item.classList.add('active-item');
        } else {
            item.classList.remove('active-item');
        }
    });
}

function filterGender(group) {
    if (group === 'ALL') {
        currentList = [...PRODUCTS_DATA];
    } else {
        currentList = PRODUCTS_DATA.filter(p => p.cateGroup === group);
    }
    renderProducts(currentList);
}

function sortProducts(sortBy) {
    let sorted = [...currentList];
    if (sortBy === 'price-asc') {
        sorted.sort((a, b) => a.price - b.price);
    } else if (sortBy === 'price-desc') {
        sorted.sort((a, b) => b.price - a.price);
    } else if (sortBy === 'newest') {
        sorted.reverse();
    }
    currentList = sorted;
    renderProducts(sorted);
}

function quickAddToCart(productId) {
    const product = PRODUCTS_DATA.find(p => p.id === productId);
    if (!product) return;
    
    let cart = JSON.parse(localStorage.getItem('one61_cart') || '[]');
    const existing = cart.find(item => item.product.id === productId);
    if (existing) {
        existing.quantity += 1;
    } else {
        cart.push({ product, quantity: 1, color: 'Mặc định', size: 'M' });
    }
    localStorage.setItem('one61_cart', JSON.stringify(cart));
    
    if (typeof window.one61Toast === 'function') {
        window.one61Toast(`Đã thêm <strong>${product.name}</strong> vào giỏ hàng!`, 'success');
    }
    if (typeof window.updateCartBadge === 'function') {
        window.updateCartBadge();
    }
}

function toggleWishlist(productId, btn) {
    let wishlist = JSON.parse(localStorage.getItem('one61_wishlist') || '[]');
    const idx = wishlist.indexOf(productId);
    const icon = btn ? btn.querySelector('i') : null;
    
    if (idx === -1) {
        wishlist.push(productId);
        localStorage.setItem('one61_wishlist', JSON.stringify(wishlist));
        if (icon) {
            icon.className = 'fa-solid fa-heart text-danger';
        }
        if (typeof window.one61Toast === 'function') {
            window.one61Toast('Đã thêm vào danh sách Yêu thích ❤️', 'success');
        }
    } else {
        wishlist.splice(idx, 1);
        localStorage.setItem('one61_wishlist', JSON.stringify(wishlist));
        if (icon) {
            icon.className = 'fa-regular fa-heart';
        }
    }
}

// Category Icons Dataset (UNIQLO Style)
const CATEGORY_ICONS_DATA = {
    MEN: [
        { name: 'Áo Sơ Mi', icon: '../web/img-prj301/categories/men/shirts-icon-men.avif', cat: 'MEN_01' },
        { name: 'Áo Khoác', icon: '../web/img-prj301/categories/men/outerwear-icon-men.avif', cat: 'MEN_02' },
        { name: 'Quần Dài', icon: '../web/img-prj301/categories/men/pants-men.avif', cat: 'MEN_03' },
        { name: 'Quần Jeans', icon: '../web/img-prj301/categories/men/jeans-men.png', cat: 'MEN_04' }
    ],
    WOMEN: [
        { name: 'Sơ Mi & Blouse', icon: '../web/img-prj301/categories/women/shirt-and-blouses-icon-women.avif', cat: 'WOMEN_01' },
        { name: 'Áo Khoác', icon: '../web/img-prj301/categories/women/outerwear-icon-women.avif', cat: 'WOMEN_02' },
        { name: 'Quần & Váy', icon: '../web/img-prj301/categories/women/bottom-icon-women.jpg', cat: 'WOMEN_03' },
        { name: 'Shorts & Culottes', icon: '../web/img-prj301/categories/women/shorts-and-culottes-icon.avif', cat: 'WOMEN_04' }
    ]
};

function renderCategoryGrid(group = 'MEN') {
    const grid = document.getElementById('uniqloCategoryGrid');
    if (!grid) return;

    const items = CATEGORY_ICONS_DATA[group] || CATEGORY_ICONS_DATA.MEN;

    grid.innerHTML = items.map(it => `
        <a href="javascript:void(0)" onclick="filterCategory('${it.cat}')" class="uniqlo-cat-item">
            <div class="uniqlo-cat-thumb">
                <img src="${it.icon}" alt="${it.name}" onerror="this.src='../web/img-prj301/categories/men/shirts-icon-men.avif'">
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
    const defaultGroup = (cat && cat.startsWith('WOMEN')) ? 'WOMEN' : 'MEN';
    renderCategoryGrid(defaultGroup);
    if (cat) filterCategory(cat);
    else renderProducts(currentList);
});
