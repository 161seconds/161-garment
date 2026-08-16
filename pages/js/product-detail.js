/**
 * ONE61 GARMENTORY - Product Detail Page Script
 * Lookbook Gallery, Color/Size Selector, Stock Status, Wishlist & Add-To-Cart
 */

const PRODUCTS_DATA = [
    // MEN: Sơ Mi (MEN_01)
    { 
        id: "PROD01", name: "Áo Sơ Mi Oxford Nam Dài Tay", cat: "MEN_01", cateGroup: "MEN", price: 599000, 
        img: "../web/img-prj301/products/men/cover/cover-shirts-men-1.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-shirts-men-1-01.avif",
            "../web/img-prj301/products/men/content/content-shirts-men-1-02.avif",
            "../web/img-prj301/products/men/content/content-shirts-men-1-03.avif",
            "../web/img-prj301/products/men/content/content-shirts-men-1-04.avif"
        ],
        desc: "Chất vải cotton Oxford dệt chéo cao cấp, phom dáng chuẩn công sở và dạo phố." 
    },
    { 
        id: "PROD02", name: "Áo Sơ Mi Linen Cổ Tàu Thoáng Khí", cat: "MEN_01", cateGroup: "MEN", price: 699000, 
        img: "../web/img-prj301/products/men/cover/cover-shirts-men-2.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-shirts-men-2-01.avif",
            "../web/img-prj301/products/men/content/content-shirts-men-2-02.avif",
            "../web/img-prj301/products/men/content/content-shirts-men-2-03.avif",
            "../web/img-prj301/products/men/content/content-shirts-men-2-04.avif"
        ],
        desc: "Vải sợi lanh Linen 100% tự nhiên thoáng mát, mang lại cảm giác dễ chịu ngày hè." 
    },
    { 
        id: "PROD03", name: "Áo Sơ Mi Cộc Tay Phom Rộng", cat: "MEN_01", cateGroup: "MEN", price: 499000, 
        img: "../web/img-prj301/products/men/cover/cover-shirts-men-3.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-shirts-men-3-01.avif",
            "../web/img-prj301/products/men/content/content-shirts-men-3-02.avif",
            "../web/img-prj301/products/men/content/content-shirts-men-3-03.avif",
            "../web/img-prj301/products/men/content/content-shirts-men-3-04.avif"
        ],
        desc: "Thiết kế ngắn tay trẻ trung, phom suông rộng rãi thoải mái cho các hoạt động ngoài trời." 
    },

    // MEN: Áo Khoác (MEN_02)
    { 
        id: "PROD04", name: "Áo Khoác Gió Nam Chống Thấm Nước", cat: "MEN_02", cateGroup: "MEN", price: 799000, 
        img: "../web/img-prj301/products/men/cover/cover-outerwear-men-1.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-outerwear-men-1-01.avif",
            "../web/img-prj301/products/men/content/content-outerwear-men-1-02.avif",
            "../web/img-prj301/products/men/content/content-outerwear-men-1-03.avif",
            "../web/img-prj301/products/men/content/content-outerwear-men-1-04.avif"
        ],
        desc: "Công nghệ BlockTech cản gió và chống nước tối ưu, siêu nhẹ và dễ gấp gọn." 
    },
    { 
        id: "PROD05", name: "Áo Khoác Blazer Nam Công Sở", cat: "MEN_02", cateGroup: "MEN", price: 1299000, 
        img: "../web/img-prj301/products/men/cover/cover-outerwear-men-2.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-outerwear-men-2-01.avif",
            "../web/img-prj301/products/men/content/content-outerwear-men-2-02.avif",
            "../web/img-prj301/products/men/content/content-outerwear-men-2-03.avif",
            "../web/img-prj301/products/men/content/content-outerwear-men-2-04.avif"
        ],
        desc: "Thiết kế may đo tỉ mỉ, tôn dáng lịch lãm và sang trọng cho quý ông hiện đại." 
    },
    { 
        id: "PROD06", name: "Áo Khoác Bomber Kaki Dáng Trẻ", cat: "MEN_02", cateGroup: "MEN", price: 899000, 
        img: "../web/img-prj301/products/men/cover/cover-outerwear-men-3.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-outerwear-men-3-01.avif",
            "../web/img-prj301/products/men/content/content-outerwear-men-3-02.avif",
            "../web/img-prj301/products/men/content/content-outerwear-men-3-03.avif",
            "../web/img-prj301/products/men/content/content-outerwear-men-3-04.avif"
        ],
        desc: "Chất kaki cao cấp đứng phom, phong cách street-style năng động và cá tính." 
    },

    // MEN: Quần Dài (MEN_03)
    { 
        id: "PROD07", name: "Quần Smart Pants Co Giãn 2 Chiều", cat: "MEN_03", cateGroup: "MEN", price: 799000, 
        img: "../web/img-prj301/products/men/cover/cover-pants-men-1.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-pants-men-1-01.avif",
            "../web/img-prj301/products/men/content/content-pants-men-1-02.avif",
            "../web/img-prj301/products/men/content/content-pants-men-1-03.avif",
            "../web/img-prj301/products/men/content/content-pants-men-1-04.avif"
        ],
        desc: "Quần âu dáng slim fit với lưng thun ẩn thoải mái, không nhăn sau khi giặt." 
    },
    { 
        id: "PROD08", name: "Quần Kaki Chino Dáng Suông Nam", cat: "MEN_03", cateGroup: "MEN", price: 699000, 
        img: "../web/img-prj301/products/men/cover/cover-pants-men-2.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-pants-men-2-01.avif",
            "../web/img-prj301/products/men/content/content-pants-men-2-02.avif",
            "../web/img-prj301/products/men/content/content-pants-men-2-03.avif",
            "../web/img-prj301/products/men/content/content-pants-men-2-04.avif"
        ],
        desc: "Chất vải cotton pha spandex co giãn, phom regular fit chuẩn mực cho mọi dịp." 
    },
    { 
        id: "PROD09", name: "Quần Jogger Kaki Túi Hộp Năng Động", cat: "MEN_03", cateGroup: "MEN", price: 599000, 
        img: "../web/img-prj301/products/men/cover/cover-pants-men-3.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-pants-men-3-01.avif",
            "../web/img-prj301/products/men/content/content-pants-men-3-02.avif",
            "../web/img-prj301/products/men/content/content-pants-men-3-03.avif",
            "../web/img-prj301/products/men/content/content-pants-men-3-04.avif"
        ],
        desc: "Thiết kế túi hộp tiện dụng, ống bo thun thể thao khỏe khoắn." 
    },

    // MEN: Quần Jeans (MEN_04)
    { 
        id: "PROD10", name: "Quần Jeans Nam Slim Fit Co Giãn", cat: "MEN_04", cateGroup: "MEN", price: 899000, 
        img: "../web/img-prj301/products/men/cover/cover-jeans-men-1.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-jeans-men-1-01.avif",
            "../web/img-prj301/products/men/content/content-jeans-men-1-02.avif",
            "../web/img-prj301/products/men/content/content-jeans-men-1-03.avif"
        ],
        desc: "Denim Nhật Bản cao cấp dệt sợi đàn hồi, bền màu và mềm mại với làn da." 
    },
    { 
        id: "PROD11", name: "Quần Jeans Ống Suông Regular Vintage", cat: "MEN_04", cateGroup: "MEN", price: 949000, 
        img: "../web/img-prj301/products/men/cover/cover-jeans-men-2.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-jeans-men-2-01.avif",
            "../web/img-prj301/products/men/content/content-jeans-men-2-02.avif",
            "../web/img-prj301/products/men/content/content-jeans-men-2-03.avif",
            "../web/img-prj301/products/men/content/content-jeans-men-2-04.avif"
        ],
        desc: "Xử lý wash màu cổ điển thời thượng, tôn dáng chân dài và nam tính." 
    },
    { 
        id: "PROD12", name: "Quần Jeans Relaxed Fit Dáng Rộng", cat: "MEN_04", cateGroup: "MEN", price: 849000, 
        img: "../web/img-prj301/products/men/cover/cover-jeans-men-3.avif", 
        gallery: [
            "../web/img-prj301/products/men/content/content-jeans-men-3-01.avif",
            "../web/img-prj301/products/men/content/content-jeans-men-3-02.avif",
            "../web/img-prj301/products/men/content/content-jeans-men-3-03.avif",
            "../web/img-prj301/products/men/content/content-jeans-men-3-04.avif"
        ],
        desc: "Form ống rộng thoải mái tối đa cho ngày dài vận động." 
    },

    // WOMEN: Sơ Mi & Blouse (WOMEN_01)
    { 
        id: "PROD13", name: "Áo Sơ Mi Rayon Nữ Mềm Rủ", cat: "WOMEN_01", cateGroup: "WOMEN", price: 549000, 
        img: "../web/img-prj301/products/women/cover/cover-shirt-and-blouses-women-1.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-1-01.avif",
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-1-02.avif",
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-1-03.avif",
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-1-04.avif"
        ],
        desc: "Chất lụa Rayon cao cấp chống nhăn, rủ nhẹ nhàng tôn vẻ đẹp thanh tao." 
    },
    { 
        id: "PROD14", name: "Áo Blouse Cổ Thắt Nơ Nữ Tính", cat: "WOMEN_01", cateGroup: "WOMEN", price: 599000, 
        img: "../web/img-prj301/products/women/cover/cover-shirt-and-blouses-women-2.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-2-01.avif",
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-2-02.avif",
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-2-03.avif",
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-2-04.avif"
        ],
        desc: "Điểm nhấn cổ nơ duyên dáng, dễ dàng kết hợp cùng chân váy hoặc quần âu." 
    },
    { 
        id: "PROD15", name: "Áo Sơ Mi Vải Đũi Cổ Chữ V", cat: "WOMEN_01", cateGroup: "WOMEN", price: 499000, 
        img: "../web/img-prj301/products/women/cover/cover-shirt-and-blouses-women-3.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-3-01.avif",
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-3-02.avif",
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-3-03.avif",
            "../web/img-prj301/products/women/content/content-shirt-and-blouses-women-3-04.avif"
        ],
        desc: "Vải đũi tự nhiên mát lạnh, phom suông phóng khoáng chuẩn phong cách LifeWear." 
    },

    // WOMEN: Áo Khoác (WOMEN_02)
    { 
        id: "PROD16", name: "Áo Khoác Chống Tia UV AirSense Nữ", cat: "WOMEN_02", cateGroup: "WOMEN", price: 699000, 
        img: "../web/img-prj301/products/women/cover/cover-outerwear-women-1.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-outerwear-women-1-01.avif",
            "../web/img-prj301/products/women/content/content-outerwear-women-1-02.avif",
            "../web/img-prj301/products/women/content/content-outerwear-women-1-03.avif",
            "../web/img-prj301/products/women/content/content-outerwear-women-1-04.avif"
        ],
        desc: "Chỉ số chống nắng UPF 50+, công nghệ dệt siêu nhẹ bảo vệ làn da tuyệt đối." 
    },
    { 
        id: "PROD17", name: "Áo Khoác Dạ Tweed Sang Trọng", cat: "WOMEN_02", cateGroup: "WOMEN", price: 1399000, 
        img: "../web/img-prj301/products/women/cover/cover-outerwear-women-2.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-outerwear-women-2-01.avif",
            "../web/img-prj301/products/women/content/content-outerwear-women-2-02.avif",
            "../web/img-prj301/products/women/content/content-outerwear-women-2-03.avif",
            "../web/img-prj301/products/women/content/content-outerwear-women-2-04.avif"
        ],
        desc: "Vải dạ dệt kim ánh kim sang trọng, viền chỉ tỉ mỉ chuẩn phong cách Parisian." 
    },
    { 
        id: "PROD18", name: "Áo Khoác Trench Coat Dáng Dài", cat: "WOMEN_02", cateGroup: "WOMEN", price: 1599000, 
        img: "../web/img-prj301/products/women/cover/cover-outerwear-women-3.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-outerwear-women-3-01.avif",
            "../web/img-prj301/products/women/content/content-outerwear-women-3-02.avif",
            "../web/img-prj301/products/women/content/content-outerwear-women-3-03.avif",
            "../web/img-prj301/products/women/content/content-outerwear-women-3-04.avif"
        ],
        desc: "Phom dáng trench coat kinh điển, chống thấm nước nhẹ và cản gió tốt." 
    },

    // WOMEN: Quần & Váy (WOMEN_03)
    { 
        id: "PROD19", name: "Quần Ống Suông Xếp Ly Pleated Pants", cat: "WOMEN_03", cateGroup: "WOMEN", price: 799000, 
        img: "../web/img-prj301/products/women/cover/cover-bottom-women-1.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-bottom-women-1-01.avif",
            "../web/img-prj301/products/women/content/content-bottom-women-1-02.avif",
            "../web/img-prj301/products/women/content/content-bottom-women-1-03.avif",
            "../web/img-prj301/products/women/content/content-bottom-women-1-04.avif"
        ],
        desc: "Thiết kế xếp ly tinh tế tạo hiệu ứng kéo dài chân, chất vải rủ nhẹ nhàng." 
    },
    { 
        id: "PROD20", name: "Chân Váy Midi Dáng Chữ A Tôn Dáng", cat: "WOMEN_03", cateGroup: "WOMEN", price: 649000, 
        img: "../web/img-prj301/products/women/cover/cover-bottom-women-2.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-bottom-women-2-01.avif",
            "../web/img-prj301/products/women/content/content-bottom-women-2-02.avif",
            "../web/img-prj301/products/women/content/content-bottom-women-2-03.avif",
            "../web/img-prj301/products/women/content/content-bottom-women-2-04.avif"
        ],
        desc: "Phom chữ A nhẹ nhàng che khuyết điểm, cạp cao tôn vòng eo thon gọn." 
    },
    { 
        id: "PROD21", name: "Quần Tây Nữ Ống Đứng Ankle Pants", cat: "WOMEN_03", cateGroup: "WOMEN", price: 749000, 
        img: "../web/img-prj301/products/women/cover/cover-bottom-women-3.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-bottom-women-3-01.avif",
            "../web/img-prj301/products/women/content/content-bottom-women-3-02.avif",
            "../web/img-prj301/products/women/content/content-bottom-women-3-03.avif"
        ],
        desc: "Chiều dài ngang mắt cá chân thanh thoát, lưng co giãn tiện lợi cả ngày làm việc." 
    },

    // WOMEN: Shorts & Culottes (WOMEN_04)
    { 
        id: "PROD22", name: "Quần Shorts Kaki Lưng Cao Nữ", cat: "WOMEN_04", cateGroup: "WOMEN", price: 449000, 
        img: "../web/img-prj301/products/women/cover/cover-shorts-and-culott-1.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-shorts-and-culott-1-01.avif",
            "../web/img-prj301/products/women/content/content-shorts-and-culott-1-02.avif",
            "../web/img-prj301/products/women/content/content-shorts-and-culott-1-03.avif",
            "../web/img-prj301/products/women/content/content-shorts-and-culott-1-04.avif"
        ],
        desc: "Chất kaki co giãn nhẹ, cạp cao tôn dáng, năng động khi phối cùng áo thun và sơ mi." 
    },
    { 
        id: "PROD23", name: "Quần Giả Váy Xếp Nếp Thời Thượng", cat: "WOMEN_04", cateGroup: "WOMEN", price: 499000, 
        img: "../web/img-prj301/products/women/cover/cover-shorts-and-culott-2.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-shorts-and-culott-2-01.avif",
            "../web/img-prj301/products/women/content/content-shorts-and-culott-2-02.avif",
            "../web/img-prj301/products/women/content/content-shorts-and-culott-2-03.avif",
            "../web/img-prj301/products/women/content/content-shorts-and-culott-2-04.avif"
        ],
        desc: "Thiết kế xếp nếp trẻ trung, vừa kín đáo vừa phong cách cho phái đẹp." 
    },
    { 
        id: "PROD24", name: "Quần Culottes Ống Rộng Vải Linen", cat: "WOMEN_04", cateGroup: "WOMEN", price: 549000, 
        img: "../web/img-prj301/products/women/cover/cover-shorts-and-culott-3.avif", 
        gallery: [
            "../web/img-prj301/products/women/content/content-shorts-and-culott-3-01.avif",
            "../web/img-prj301/products/women/content/content-shorts-and-culott-3-02.avif",
            "../web/img-prj301/products/women/content/content-shorts-and-culott-3-03.avif",
            "../web/img-prj301/products/women/content/content-shorts-and-culott-3-04.avif"
        ],
        desc: "Ống rộng bay bổng, chất vải lanh tự nhiên mang lại sự thư thái tuyệt đối." 
    }
];

let selectedProduct = PRODUCTS_DATA[0];
let selectedColor = '32 BEIGE';
let selectedSize = 'M';

window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const id = urlParams.get('id') || 'PROD01';
    const found = PRODUCTS_DATA.find(x => x.id === id || x.id === 'PROD' + id.replace('P', ''));
    if (found) selectedProduct = found;

    const skuEl = document.getElementById('prodSKU');
    if (skuEl) skuEl.textContent = 'Mã SP: ' + selectedProduct.id;
    const nameEl = document.getElementById('prodName');
    if (nameEl) nameEl.textContent = selectedProduct.name;
    
    const CAT_NAMES = {
        'MEN_01': 'Áo Sơ Mi Nam',
        'MEN_02': 'Áo Khoác Nam',
        'MEN_03': 'Quần Dài Nam',
        'MEN_04': 'Quần Jeans Nam',
        'WOMEN_01': 'Áo Sơ Mi & Blouse Nữ',
        'WOMEN_02': 'Áo Khoác Nữ',
        'WOMEN_03': 'Quần & Váy Nữ',
        'WOMEN_04': 'Shorts & Culottes Nữ'
    };
    const catName = CAT_NAMES[selectedProduct.cat] || (selectedProduct.cat ? selectedProduct.cat.replace(/_/g, ' ') : 'Thời Trang');
    const bCatEl = document.getElementById('breadCat');
    if (bCatEl) bCatEl.textContent = catName;
    
    const priceEl = document.getElementById('prodPrice');
    if (priceEl) priceEl.textContent = selectedProduct.price.toLocaleString('vi-VN') + ' đ';
    
    const descEl = document.getElementById('prodDesc');
    if (descEl) descEl.innerHTML = selectedProduct.desc + '<ul class="mt-2 mb-0 ps-3"><li>Phong cách LifeWear tối giản chuẩn Nhật Bản.</li><li>Độ bền cao, hạn chế nhăn xù sau nhiều lần giặt.</li></ul>';

    // Dynamic Lookbook Rendering based on gallery size
    const lookbookGrid = document.querySelector('.lookbook-grid');
    if (lookbookGrid && selectedProduct) {
        const gallery = (selectedProduct.gallery && selectedProduct.gallery.length > 0) 
            ? selectedProduct.gallery 
            : [selectedProduct.img];
        const tags = ['Mặt trước', 'Phối đồ', 'Chi tiết vải', 'Form dáng'];

        lookbookGrid.innerHTML = gallery.map((gImg, idx) => `
            <div class="lookbook-item">
                <img ${idx === 0 ? 'id="mainProductImg"' : ''} src="${gImg}" 
                     alt="${selectedProduct.name} - Ảnh ${idx + 1}"
                     onerror="this.src='${selectedProduct.img}';">
                <span class="lookbook-tag">
                    <i class="fa-solid fa-camera"></i> ${tags[idx] || ('Góc chụp ' + (idx + 1))}
                </span>
            </div>
        `).join('');
    }

    if (typeof updateGlobalBadges === 'function') updateGlobalBadges();
    checkWishlistState();
});

function selectColor(colorName, el) {
    selectedColor = colorName;
    const clrNameEl = document.getElementById('selectedColorName');
    if (clrNameEl) clrNameEl.textContent = colorName;
    document.querySelectorAll('.color-swatch-btn').forEach(btn => btn.classList.remove('active'));
    el.classList.add('active');
}

function selectSize(sizeName, el) {
    selectedSize = sizeName;
    const szLbl = document.getElementById('selectedSizeLabel');
    if (szLbl) szLbl.textContent = sizeName;
    document.querySelectorAll('.size-btn').forEach(btn => btn.classList.remove('active'));
    el.classList.add('active');
}

function changeQuantity(delta) {
    const input = document.getElementById('productQuantity');
    if (!input) return;
    let val = parseInt(input.value) || 1;
    val += delta;
    if (val < 1) val = 1;
    if (val > 99) val = 99;
    input.value = val;
}

function handleAddToCart() {
    const qtyInput = document.getElementById('productQuantity');
    const qty = qtyInput ? (parseInt(qtyInput.value) || 1) : 1;
    let cart = JSON.parse(localStorage.getItem('one61_cart') || '[]');
    let exist = cart.find(x => x.id === selectedProduct.id && x.color === selectedColor && x.size === selectedSize);
    if (exist) {
        exist.qty += qty;
    } else {
        cart.push({
            id: selectedProduct.id,
            name: selectedProduct.name,
            price: selectedProduct.price,
            img: selectedProduct.img,
            qty: qty,
            color: selectedColor,
            size: selectedSize
        });
    }
    localStorage.setItem('one61_cart', JSON.stringify(cart));
    if (typeof updateGlobalBadges === 'function') updateGlobalBadges();
    if (typeof window.one61Toast === 'function') {
        window.one61Toast('Đã thêm ' + qty + ' sản phẩm [' + selectedProduct.name + '] vào giỏ hàng!', 'success');
    } else {
        alert('Đã thêm ' + qty + ' sản phẩm [' + selectedProduct.name + '] vào giỏ hàng!');
    }
}

function checkWishlistState() {
    const list = JSON.parse(localStorage.getItem('one61_wishlist') || '[]');
    const exists = list.some(item => item.id === selectedProduct.id);
    const btn = document.getElementById('btnWishlistToggle');
    if (btn) {
        if (exists) {
            btn.innerHTML = '<i class="fa-solid fa-heart text-danger"></i> ĐÃ THÊM VÀO YÊU THÍCH';
            btn.classList.add('border-danger', 'text-danger');
        } else {
            btn.innerHTML = '<i class="fa-regular fa-heart"></i> THÊM VÀO YÊU THÍCH';
            btn.classList.remove('border-danger', 'text-danger');
        }
    }
}

function toggleWishlist(btn) {
    let wishlist = JSON.parse(localStorage.getItem('one61_wishlist') || '[]');
    const index = wishlist.findIndex(item => item.id === selectedProduct.id);
    if (index === -1) {
        wishlist.push({
            id: selectedProduct.id,
            name: selectedProduct.name,
            price: selectedProduct.price,
            img: selectedProduct.img,
            cat: selectedProduct.cat
        });
        localStorage.setItem('one61_wishlist', JSON.stringify(wishlist));
        btn.innerHTML = '<i class="fa-solid fa-heart text-danger"></i> ĐÃ THÊM VÀO YÊU THÍCH';
        btn.classList.add('border-danger', 'text-danger');
        if (typeof window.one61Toast === 'function') {
            window.one61Toast('Đã lưu [' + selectedProduct.name + '] vào Danh sách Yêu thích!', 'success');
        }
    } else {
        wishlist.splice(index, 1);
        localStorage.setItem('one61_wishlist', JSON.stringify(wishlist));
        btn.innerHTML = '<i class="fa-regular fa-heart"></i> THÊM VÀO YÊU THÍCH';
        btn.classList.remove('border-danger', 'text-danger');
        if (typeof window.one61Toast === 'function') {
            window.one61Toast('Đã xóa khỏi Danh sách Yêu thích', 'info');
        }
    }
    if (typeof window.updateWishlistBadge === 'function') {
        window.updateWishlistBadge();
    }
}

function copyLink() {
    navigator.clipboard.writeText(window.location.href).then(() => {
        if (typeof window.one61Toast === 'function') {
            window.one61Toast('Đã sao chép liên kết sản phẩm vào bộ nhớ tạm!', 'success');
        }
    });
}
