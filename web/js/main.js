/**
 * ONE61 GARMENTORY - Shared Global Scripts
 * Cart & Wishlist Sync, Navbar Scroll State
 */

function updateGlobalBadges() {
    // 1. Cart Badge
    try {
        const cart = JSON.parse(localStorage.getItem('one61_cart') || '[]');
        const count = cart.reduce((sum, item) => sum + (item.qty || 1), 0);
        const cartBadges = document.querySelectorAll('.cart-badge, #navCartCount');
        cartBadges.forEach(b => {
            b.textContent = count;
        });
    } catch (e) {
        console.error('Error reading cart:', e);
    }

    // 2. Wishlist Badge
    if (typeof window.updateWishlistBadge === 'function') {
        window.updateWishlistBadge();
    }
}

// Global Quick Add-To-Cart function
function globalAddToCart(prod) {
    if (!prod || !prod.id) return;
    try {
        let cart = JSON.parse(localStorage.getItem('one61_cart') || '[]');
        let exist = cart.find(x => x.id === prod.id);
        if (exist) {
            exist.qty = (exist.qty || 1) + 1;
        } else {
            cart.push({
                id: prod.id,
                name: prod.name,
                price: prod.price,
                img: prod.img,
                qty: 1,
                color: prod.color || '32 BEIGE',
                size: prod.size || 'M'
            });
        }
        localStorage.setItem('one61_cart', JSON.stringify(cart));
        updateGlobalBadges();
        if (typeof window.one61Toast === 'function') {
            window.one61Toast('Đã thêm [' + prod.name + '] vào giỏ hàng!', 'success');
        } else {
            alert('Đã thêm sản phẩm [' + prod.name + '] vào giỏ hàng!');
        }
    } catch (e) {
        console.error('Error adding to cart:', e);
    }
}

// Init Back to Top button
function initBackToTop() {
    let btn = document.getElementById('backToTopBtn');
    if (!btn) {
        btn = document.createElement('button');
        btn.id = 'backToTopBtn';
        btn.className = 'back-to-top-btn';
        btn.title = 'Lên đầu trang';
        btn.setAttribute('aria-label', 'Lên đầu trang');
        btn.innerHTML = '<i class="fa-solid fa-arrow-up"></i><span class="back-to-top-text">TOP</span>';
        document.body.appendChild(btn);
    }

    const toggleBtn = () => {
        const scrollY = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
        if (scrollY > 250) {
            btn.classList.add('show');
        } else {
            btn.classList.remove('show');
        }
    };

    window.addEventListener('scroll', toggleBtn, { passive: true });
    toggleBtn();

    btn.addEventListener('click', (e) => {
        e.preventDefault();
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
}

window.addEventListener('DOMContentLoaded', () => {
    updateGlobalBadges();
    initBackToTop();
});

