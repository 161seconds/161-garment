/**
 * ONE61 GARMENTORY - Product Detail Page Script
 * Lookbook Gallery, Color/Size Selector, Stock Status, Wishlist & Add-To-Cart
 */

const PRODUCTS_DATA = [
    { id: "P01", name: "Áo Thun Cổ Tròn Ngắn Tay Siêu Mịn", cat: "MEN_01", cateGroup: "MEN", price: 299000, img: "../web/img-prj301/ao-thun-01.avif", desc: "Chất liệu cotton 100% mềm mại, thoáng mát cả ngày, thấm hút mồ hôi tối ưu." },
    { id: "P02", name: "Áo Thun AIRism Trắng Thoáng Khí", cat: "WOMEN_01", cateGroup: "WOMEN", price: 249000, img: "../web/img-prj301/ao-thun-02.avif", desc: "Công nghệ sợi vải AIRism mượt mà, làm mát tức thì, chống tia UV hiệu quả." },
    { id: "P03", name: "Áo Thun Trơn Dáng Rộng Unisex", cat: "MEN_01", cateGroup: "MEN", price: 399000, img: "../web/img-prj301/ao-thun-03.avif", desc: "Form áo Oversize thời thượng, dễ dàng phối nhiều phong cách đường phố." },
    { id: "P04", name: "Áo Thun Họa Tiết Graphic LifeWear", cat: "MEN_01", cateGroup: "MEN", price: 449000, img: "../web/img-prj301/ao-thun-04.avif", desc: "Họa tiết nghệ thuật đương đại phong cách Tokyo, công nghệ in bền màu." },
    { id: "P05", name: "Áo Thun Dài Tay Cổ Lọ Nữ", cat: "WOMEN_01", cateGroup: "WOMEN", price: 399000, img: "../web/img-prj301/ao-thun-05.avif", desc: "Thiết kế cổ lọ ấm áp, ôm dáng nhẹ nhàng, chất vải co giãn 4 chiều mềm mại." },
    { id: "P06", name: "Áo Khoác Parka Chống Nắng UV Protection", cat: "WOMEN_03", cateGroup: "WOMEN", price: 699000, img: "../web/img-prj301/ao-khoac-01.avif", desc: "Chỉ số chống nắng UPF 50+, chất liệu chống thấm nước bền bỉ, gấp gọn bỏ túi." },
    { id: "P07", name: "Áo Khoác Gió Siêu Nhẹ Pocketable", cat: "MEN_03", cateGroup: "MEN", price: 799000, img: "../web/img-prj301/ao-khoac-03.avif", desc: "Trọng lượng siêu nhẹ, cản gió và mưa phùn hiệu quả, tiện lợi mang theo hàng ngày." },
    { id: "P08", name: "Áo Khoác Cardigan Len Mềm", cat: "WOMEN_03", cateGroup: "WOMEN", price: 899000, img: "../web/img-prj301/ao-khoac-04.avif", desc: "Chất len dệt cao cấp mềm mịn không ngứa, phom suông thanh lịch chuẩn công sở." },
    { id: "P09", name: "Áo Khoác Bomber Thể Thao", cat: "MEN_03", cateGroup: "MEN", price: 999000, img: "../web/img-prj301/ao-khoac-05.avif", desc: "Thiết kế bo gấu năng động, chất vải gió dày dặn giữ nhiệt và cản gió tốt." },
    { id: "P10", name: "Áo Khoác Nỉ Hoodie Có Mũ", cat: "KIDS_02", cateGroup: "KIDS", price: 549000, img: "../web/img-prj301/ao-khoac-06.avif", desc: "Chất nỉ bông mềm êm ái, an toàn cho làn da nhạy cảm của bé, giữ ấm ngày lạnh." },
    { id: "P11", name: "Quần Barrel Pants Phom Rộng Nhật Bản", cat: "WOMEN_04", cateGroup: "WOMEN", price: 699000, img: "../web/img-prj301/quan-dai-01.avif", desc: "Thiết kế ống cong Barrel tạo điểm nhấn thời thượng, tôn dáng chân dài tự nhiên." },
    { id: "P12", name: "Quần Smart Ankle Pants Co Giãn", cat: "MEN_04", cateGroup: "MEN", price: 799000, img: "../web/img-prj301/quan-dai-02.avif", desc: "Co giãn 2 chiều cực thoải mái, phom đứng chuẩn mực cho quý ông công sở." },
    { id: "P13", name: "Quần Chino Ống Suông Cao Cấp", cat: "MEN_04", cateGroup: "MEN", price: 749000, img: "../web/img-prj301/quan-dai-03.avif", desc: "Chất vải cotton Twill dày dặn, đứng phom, phong cách vintage lịch lãm." },
    { id: "P14", name: "Quần Jeans Dáng Suông Cổ Điển", cat: "WOMEN_04", cateGroup: "WOMEN", price: 899000, img: "../web/img-prj301/quan-dai-04.avif", desc: "Chất liệu denim 100% cotton chải mềm, màu sắc wash tự nhiên không bai dão." },
    { id: "P15", name: "Quần Kaki Co Giãn Thoải Mái", cat: "KIDS_03", cateGroup: "KIDS", price: 449000, img: "../web/img-prj301/quan-dai-05.avif", desc: "Lưng thun co giãn mềm mại, thoải mái cho bé chạy nhảy vận động cả ngày." },
    { id: "P16", name: "Quần Jogger Nỉ Thể Thao", cat: "MEN_04", cateGroup: "MEN", price: 599000, img: "../web/img-prj301/quan-dai-06.avif", desc: "Bo gấu thể thao khỏe khoắn, chất nỉ da cá thoáng khí thích hợp tập luyện và dạo phố." }
];

let selectedProduct = PRODUCTS_DATA[0];
let selectedColor = '32 BEIGE';
let selectedSize = 'M';

window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const id = urlParams.get('id') || 'P01';
    const found = PRODUCTS_DATA.find(x => x.id === id || x.id === 'PROD' + id.replace('P', ''));
    if (found) selectedProduct = found;

    const skuEl = document.getElementById('prodSKU');
    if (skuEl) skuEl.textContent = 'Mã SP: ' + selectedProduct.id;
    const nameEl = document.getElementById('prodName');
    if (nameEl) nameEl.textContent = selectedProduct.name;
    
    const CAT_NAMES = {
        'MEN_01': 'Áo Thun Nam',
        'MEN_02': 'Áo Sơ Mi Nam',
        'MEN_03': 'Áo Khoác Nam',
        'MEN_04': 'Quần Dài Nam',
        'WOMEN_01': 'Áo Thun Nữ',
        'WOMEN_02': 'Áo Sơ Mi Nữ',
        'WOMEN_03': 'Áo Khoác Nữ',
        'WOMEN_04': 'Quần & Váy Nữ',
        'KIDS_01': 'Áo Trẻ Em',
        'KIDS_02': 'Áo Khoác Trẻ Em',
        'KIDS_03': 'Quần Trẻ Em',
        'CAT01': 'Áo Thun Nam'
    };
    const catName = CAT_NAMES[selectedProduct.cat] || (selectedProduct.cat ? selectedProduct.cat.replace(/_/g, ' ') : 'Thời Trang');
    const bCatEl = document.getElementById('breadCat');
    if (bCatEl) bCatEl.textContent = catName;
    
    const priceEl = document.getElementById('prodPrice');
    if (priceEl) priceEl.textContent = selectedProduct.price.toLocaleString('vi-VN') + ' đ';
    
    const descEl = document.getElementById('prodDesc');
    if (descEl) descEl.innerHTML = selectedProduct.desc + '<ul class="mt-2 mb-0 ps-3"><li>Phong cách LifeWear tối giản chuẩn Nhật Bản.</li><li>Độ bền cao, hạn chế nhăn xù sau nhiều lần giặt.</li></ul>';

    ['img1', 'img2', 'img3', 'img4'].forEach(imgId => {
        const el = document.getElementById(imgId);
        if (el) el.src = selectedProduct.img;
    });

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
