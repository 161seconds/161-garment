/**
 * ONE61 GARMENTORY - Native Pure JS Global Modal & Toast System
 * 100% Independent, Zero-Dependency, Instant Load & Reliable
 */

(function () {
    // 1. Inject Styles
    const style = document.createElement('style');
    style.id = 'one61-alert-styles';
    style.innerHTML = `
        /* Overlay Backdrop */
        .one61-modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(0, 0, 0, 0.65);
            backdrop-filter: blur(4px);
            z-index: 99999;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            visibility: hidden;
            transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            padding: 1rem;
        }

        .one61-modal-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        /* Modal Box */
        .one61-modal-box {
            background: #ffffff;
            border: 2px solid #111111;
            max-width: 520px;
            width: 100%;
            padding: 2rem;
            transform: translateY(-20px) scale(0.96);
            transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            font-family: 'Be Vietnam Pro', 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: #111111;
        }

        .one61-modal-overlay.active .one61-modal-box {
            transform: translateY(0) scale(1);
        }

        .one61-modal-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 1rem;
            border-bottom: 1px solid #E5E5E5;
            margin-bottom: 1.25rem;
        }

        .one61-modal-title {
            font-family: 'Be Vietnam Pro', sans-serif;
            font-weight: 800;
            font-size: 1.15rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .one61-modal-close-btn {
            background: transparent;
            border: none;
            font-size: 1.4rem;
            line-height: 1;
            cursor: pointer;
            color: #666;
            transition: color 0.15s ease;
            padding: 0;
        }

        .one61-modal-close-btn:hover {
            color: #ED1D24;
        }

        .one61-modal-body {
            font-size: 0.92rem;
            color: #333333;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        .one61-modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 8px;
            padding-top: 1rem;
            border-top: 1px solid #E5E5E5;
        }

        .one61-btn-primary {
            background: #111111;
            color: #ffffff;
            border: none;
            font-weight: 700;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 10px 24px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .one61-btn-primary:hover {
            background: #ED1D24;
            color: #ffffff;
        }

        /* Toast Container */
        .one61-toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 100000;
            display: flex;
            flex-direction: column;
            gap: 10px;
            pointer-events: none;
        }

        .one61-toast-item {
            background: #ffffff;
            border: 2px solid #111111;
            padding: 12px 18px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            font-family: 'Be Vietnam Pro', 'Inter', -apple-system, sans-serif;
            font-size: 0.9rem;
            font-weight: 600;
            color: #111111;
            display: flex;
            align-items: center;
            gap: 10px;
            transform: translateX(100%);
            opacity: 0;
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            pointer-events: auto;
            max-width: 380px;
        }

        .one61-toast-item.show {
            transform: translateX(0);
            opacity: 1;
        }

        .one61-toast-item.toast-success { border-left: 5px solid #28a745; }
        .one61-toast-item.toast-danger { border-left: 5px solid #ED1D24; }
        .one61-toast-item.toast-info { border-left: 5px solid #111111; }
    `;
    if (!document.getElementById('one61-alert-styles')) {
        document.head.appendChild(style);
    }

    // 2. Helper DOM Builder
    function getOrCreateOverlay() {
        let overlay = document.getElementById('one61GlobalOverlay');
        if (!overlay) {
            overlay = document.createElement('div');
            overlay.id = 'one61GlobalOverlay';
            overlay.className = 'one61-modal-overlay';
            overlay.innerHTML = `
                <div class="one61-modal-box">
                    <div class="one61-modal-header">
                        <h4 class="one61-modal-title" id="one61ModalTitle">ONE61 GARMENTORY</h4>
                        <button type="button" class="one61-modal-close-btn" onclick="window.closeOne61Modal()">&times;</button>
                    </div>
                    <div class="one61-modal-body" id="one61ModalBody"></div>
                    <div class="one61-modal-footer">
                        <button type="button" class="one61-btn-primary" onclick="window.closeOne61Modal()">&#272;&Atilde; HI&#7874;U</button>
                    </div>
                </div>
            `;
            document.body.appendChild(overlay);

            // Close on clicking backdrop
            overlay.addEventListener('click', function (e) {
                if (e.target === overlay) window.closeOne61Modal();
            });
        }
        return overlay;
    }

    function getOrCreateToastContainer() {
        let container = document.getElementById('one61ToastContainer');
        if (!container) {
            container = document.createElement('div');
            container.id = 'one61ToastContainer';
            container.className = 'one61-toast-container';
            document.body.appendChild(container);
        }
        return container;
    }

    // 3. Public API
    window.closeOne61Modal = function () {
        const overlay = document.getElementById('one61GlobalOverlay');
        if (overlay) overlay.classList.remove('active');
    };

    window.one61Alert = function (title, htmlContent) {
        const overlay = getOrCreateOverlay();
        document.getElementById('one61ModalTitle').innerHTML = title || 'TH&Ocirc;NG B&Aacute;O';
        document.getElementById('one61ModalBody').innerHTML = htmlContent || '';
        overlay.classList.add('active');
    };

    window.one61Toast = function (message, type = 'success') {
        const container = getOrCreateToastContainer();
        const toast = document.createElement('div');
        toast.className = 'one61-toast-item toast-' + type;

        let iconHtml = '<i class="fa-solid fa-circle-check text-success fs-5"></i>';
        if (type === 'danger') iconHtml = '<i class="fa-solid fa-circle-exclamation text-danger fs-5"></i>';
        else if (type === 'info') iconHtml = '<i class="fa-solid fa-circle-info text-dark fs-5"></i>';

        toast.innerHTML = `
            ${iconHtml}
            <span style="flex-grow: 1;">${message}</span>
        `;
        container.appendChild(toast);

        // Animate entrance
        setTimeout(() => toast.classList.add('show'), 20);

        // Auto remove after 2.8s
        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => toast.remove(), 300);
        }, 2800);
    };

    window.showStoreLocator = function () {
        window.one61Alert(
            '<i class="fa-solid fa-store text-danger me-1"></i> H&#7878; TH&#7888;NG SHOWROOM ONE61',
            `
            <div style="text-align: left; font-size: 0.9rem;">
                <div style="background: #F8F9FA; border: 1px solid #E5E5E5; padding: 14px; margin-bottom: 12px;">
                    <strong style="color: #ED1D24; display: block; margin-bottom: 4px;">
                        <i class="fa-solid fa-location-dot me-1"></i> SHOWROOM 1: TP. H&#7890; CH&Iacute; MINH
                    </strong>
                    <div style="font-weight: 700; color: #111;">Vincom Center &#272;&#7891;ng Kh&#7903;i</div>
                    <div style="color: #555; font-size: 0.85rem;">T&#7847;ng 2, 72 L&ecirc; Th&aacute;nh T&ocirc;n, P. B&#7871;n Ngh&eacute;, Qu&#7853;n 1, TP.HCM</div>
                    <div style="color: #777; font-size: 0.8rem; margin-top: 4px;">
                        <i class="fa-regular fa-clock me-1"></i> 09:30 - 22:00 (H&agrave;ng ng&agrave;y)
                    </div>
                </div>

                <div style="background: #F8F9FA; border: 1px solid #E5E5E5; padding: 14px; margin-bottom: 12px;">
                    <strong style="color: #ED1D24; display: block; margin-bottom: 4px;">
                        <i class="fa-solid fa-location-dot me-1"></i> SHOWROOM 2: H&Agrave; N&#7896;I
                    </strong>
                    <div style="font-weight: 700; color: #111;">Vincom Center B&agrave; Tri&#7879;u</div>
                    <div style="color: #555; font-size: 0.85rem;">T&#7847;ng 1, 191 B&agrave; Tri&#7879;u, P. L&ecirc; &#272;&#7841;i H&agrave;nh, Q. Hai B&agrave; Tr&#432;ng, H&agrave; N&#7896;i</div>
                    <div style="color: #777; font-size: 0.8rem; margin-top: 4px;">
                        <i class="fa-regular fa-clock me-1"></i> 09:30 - 22:00 (H&agrave;ng ng&agrave;y)
                    </div>
                </div>

                <div style="text-align: center; color: #666; font-size: 0.85rem; margin-top: 10px;">
                    <i class="fa-solid fa-headset text-danger me-1"></i> Hotline h&#7895; tr&#7907;: <strong style="color: #111;">1900 161 161</strong>
                </div>
            </div>
            `
        );
    };

    // 4. Wishlist Modal & Helpers
    window.getOne61Wishlist = function () {
        return JSON.parse(localStorage.getItem('one61_wishlist') || '[]');
    };

    window.updateWishlistBadge = function () {
        const list = window.getOne61Wishlist();
        const badges = document.querySelectorAll('.wishlist-badge, #headerWishlistCount');
        badges.forEach(b => {
            b.textContent = list.length;
            b.style.display = list.length > 0 ? 'inline-block' : 'none';
        });
    };

    window.removeFromWishlist = function (prodId) {
        let list = window.getOne61Wishlist();
        list = list.filter(item => item.id !== prodId);
        localStorage.setItem('one61_wishlist', JSON.stringify(list));
        window.updateWishlistBadge();
        if (typeof checkWishlistState === 'function') checkWishlistState();
        window.showWishlistModal();
        window.one61Toast('&#272;&atilde; x&oacute;a s&#7843;n ph&#7849;m kh&#7887;i Danh s&aacute;ch Y&ecirc;u th&iacute;ch', 'info');
    };

    window.showWishlistModal = function () {
        const list = window.getOne61Wishlist();
        if (!list || list.length === 0) {
            window.one61Alert(
                '<i class="fa-solid fa-heart text-danger me-2"></i> DANH S&Aacute;CH Y&Ecirc;U TH&Iacute;CH (0)',
                `
                <div class="text-center py-4">
                    <div class="mb-3 text-muted" style="font-size: 3rem;">
                        <i class="fa-regular fa-heart"></i>
                    </div>
                    <h6 class="fw-bold text-dark text-uppercase">Danh s&aacute;ch y&ecirc;u th&iacute;ch tr&#7889;ng</h6>
                    <p class="text-muted small mb-4">B&#7841;n ch&#432;a l&#432;u s&#7843;n ph&#7849;m n&agrave;o v&agrave;o danh s&aacute;ch y&ecirc;u th&iacute;ch c&#7843;a m&igrave;nh.</p>
                    <a href="${window.location.pathname.includes('pages/') ? 'product.html' : 'product'}" class="one61-btn-primary text-decoration-none d-inline-block">KH&Aacute;M PH&Aacute; S&#7842;N PH&#7848;M NGAY</a>
                </div>
                `
            );
            return;
        }

        let itemsHtml = `
            <div class="table-responsive" style="max-height: 380px; overflow-y: auto;">
                <table class="table align-middle mb-0">
                    <tbody class="small">
        `;

        list.forEach(item => {
            const priceFormatted = Number(item.price || 0).toLocaleString('vi-VN') + ' đ';
            const detailUrl = (window.location.pathname.includes('pages/')) 
                ? 'product-detail.html?id=' + item.id 
                : 'product?action=detail&id=' + item.id;
            const imgSrc = item.img || '../web/img-prj301/products/men/cover/cover-shirts-men-1.avif';

            itemsHtml += `
                <tr class="border-bottom">
                    <td style="width: 55px; padding: 8px 4px;">
                        <img src="${imgSrc}" alt="${item.name}" style="width: 48px; height: 48px; object-fit: cover; border: 1px solid #ddd;">
                    </td>
                    <td style="padding: 8px 8px;">
                        <a href="${detailUrl}" class="fw-bold text-dark text-decoration-none d-block text-truncate" style="max-width: 230px;" title="${item.name}">
                            ${item.name}
                        </a>
                        <span class="text-danger fw-bold">${priceFormatted}</span>
                    </td>
                    <td class="text-end text-nowrap" style="padding: 8px 4px;">
                        <a href="${detailUrl}" class="btn btn-dark btn-sm rounded-0 fw-bold px-2 py-1 me-1 text-uppercase" style="font-size: 0.72rem;">
                            Xem
                        </a>
                        <button type="button" class="btn btn-outline-danger btn-sm rounded-0 px-2 py-1" onclick="window.removeFromWishlist('${item.id}')" title="X&oacute;a">
                            <i class="fa-solid fa-trash-can"></i>
                        </button>
                    </td>
                </tr>
            `;
        });

        itemsHtml += `
                    </tbody>
                </table>
            </div>
            <div class="d-flex justify-content-between align-items-center mt-3 pt-2 border-top">
                <span class="small text-muted">T&#7893;ng c&#7897;ng: <strong>${list.length}</strong> s&#7843;n ph&#7849;m</span>
                <button type="button" class="btn btn-sm btn-outline-secondary rounded-0" style="font-size: 0.75rem;" onclick="localStorage.removeItem('one61_wishlist'); window.updateWishlistBadge(); if (typeof checkWishlistState === 'function') checkWishlistState(); window.showWishlistModal();">
                    X&oacute;a t&#7845;t c&#7843;
                </button>
            </div>
        `;

        window.one61Alert(
            `<i class="fa-solid fa-heart text-danger me-2"></i> DANH S&Aacute;CH Y&Ecirc;U TH&Iacute;CH (${list.length})`,
            itemsHtml
        );
    };

    // Override native alert globally
    window.alert = function (msg) {
        if (typeof msg === 'string' && (msg.includes('cửa hàng') || msg.includes('showroom') || msg.includes('c&#7843;a h&agrave;ng'))) {
            window.showStoreLocator();
            return;
        }
        if (typeof msg === 'string' && (msg.includes('giỏ hàng') || msg.includes('sao chép') || msg.includes('thành công') || msg.includes('Yêu thích') || msg.includes('Y&ecirc;u th&iacute;ch'))) {
            window.one61Toast(msg, 'success');
            return;
        }
        window.one61Alert('ONE61 GARMENTORY', msg);
    };

    // Auto initialize badge on page load
    window.addEventListener('DOMContentLoaded', () => {
        window.updateWishlistBadge();
    });
})();
