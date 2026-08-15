<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>ONE61 Garment | Thời Trang Tối Giản Cao Cấp</title>
            <!-- Bootstrap 5 CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- FontAwesome 6 -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
            <!-- Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Helvetica+Neue:wght@400;500;700&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --color-primary: #E00000;
                    /* Uniqlo Red */
                    --color-on-primary: #FFFFFF;
                    --color-secondary: #F4F4F4;
                    /* Light Gray */
                    --color-accent: #E00000;
                    --color-on-accent: #FFFFFF;
                    --color-background: #FFFFFF;
                    /* White */
                    --color-foreground: #111111;
                    /* Black/Dark Gray */
                    --color-card: #FFFFFF;
                    /* Solid White */
                    --color-muted: #767676;
                    --color-border: #E5E5E5;
                }

                body {
                    background-color: var(--color-background);
                    color: var(--color-foreground);
                    font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                    display: flex;
                    flex-direction: column;
                    min-height: 100vh;
                    -webkit-font-smoothing: antialiased;
                }

                h1,
                h2,
                h3,
                h4,
                h5,
                h6 {
                    font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                    font-weight: 700;
                    letter-spacing: -0.5px;
                }

                /* Top Notification Bar */
                .top-notification-bar {
                    background-color: #111111;
                    color: #FFFFFF;
                    font-size: 0.75rem;
                    letter-spacing: 0.5px;
                }

                .top-notification-bar a {
                    color: #BBBBBB;
                    text-decoration: none;
                    transition: color 0.2s ease;
                }

                .top-notification-bar a:hover {
                    color: #FFFFFF;
                }

                /* Uniqlo Style Navbar */
                .navbar-main {
                    background: #FFFFFF !important;
                    border-bottom: 0.2px solid var(--color-border);
                    padding-top: 0.75rem;
                    padding-bottom: 0.75rem;
                }

                .navbar-brand-wrapper {
                    display: inline-flex;
                    gap: 3px;
                    text-decoration: none;
                }

                .brand-box {
                    font-weight: 700;
                    font-size: 1.4rem;
                    color: var(--color-on-primary) !important;
                    background-color: var(--color-primary);
                    padding: 4px 8px;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    display: inline-block;
                    line-height: 1.1;
                }

                .main-nav-link {
                    color: var(--color-foreground) !important;
                    font-weight: 700;
                    font-size: 0.9rem;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                    padding: 0.6rem 0.9rem !important;
                    position: relative;
                    z-index: 1050;
                    text-decoration: none !important;
                    transition: color 0.2s ease;
                    display: inline-block;
                }

                /* Smooth Gliding / Sliding Magic Underline Bar */
                .category-nav-wrapper {
                    position: relative;
                }

                .sliding-nav-indicator {
                    position: absolute;
                    bottom: 4px;
                    left: 0;
                    height: 1.5px;
                    background-color: var(--color-primary);
                    border-radius: 1px;
                    pointer-events: none;
                    transition: left 0.25s cubic-bezier(0.25, 1, 0.5, 1), width 0.25s cubic-bezier(0.25, 1, 0.5, 1), opacity 0.2s ease;
                    opacity: 0;
                    z-index: 1060;
                }

                /* White Underline on Transparent Header */
                .navbar-transparent .sliding-nav-indicator {
                    background-color: #FFFFFF !important;
                    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.8) !important;
                }

                .header-icon-btn {
                    color: var(--color-foreground);
                    font-size: 1.1rem;
                    text-decoration: none;
                    padding: 0.4rem 0.6rem;
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    transition: color 0.2s ease;
                }

                .header-icon-btn:hover {
                    color: var(--color-primary);
                }

                .cart-badge {
                    background-color: var(--color-primary);
                    color: #FFFFFF;
                    font-size: 0.7rem;
                    font-weight: 700;
                    padding: 0.2em 0.5em;
                    border-radius: 50rem;
                }

                .btn-accent {
                    background-color: var(--color-accent);
                    color: var(--color-on-accent);
                    border: none;
                    transition: opacity 0.2s ease;
                    font-weight: 700;
                    border-radius: 0;
                    text-transform: uppercase;
                }

                .btn-accent:hover {
                    opacity: 0.85;
                    color: white;
                    background-color: var(--color-accent);
                }

                /* Transparent Header Overlay for Home Page */
                .navbar-transparent {
                    background: linear-gradient(180deg, rgba(0, 0, 0, 0.6) 0%, rgba(0, 0, 0, 0) 100%) !important;
                    border-bottom: none !important;
                    position: absolute !important;
                    top: 0 !important;
                    left: 0 !important;
                    width: 100% !important;
                    z-index: 1000 !important;
                    padding-top: 1rem !important;
                }

                .navbar-transparent .main-nav-link {
                    color: #FFFFFF !important;
                    text-shadow: 0 1px 5px rgba(0, 0, 0, 0.9);
                }

                .navbar-transparent .main-nav-link:hover {
                    color: var(--color-primary) !important;
                }

                .navbar-transparent .header-icon-btn {
                    color: #FFFFFF !important;
                    text-shadow: 0 1px 5px rgba(0, 0, 0, 0.9);
                }

                .navbar-transparent .header-icon-btn:hover {
                    color: var(--color-primary) !important;
                }

                .navbar-transparent .search-box-container input {
                    background-color: rgba(255, 255, 255, 0.95) !important;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
                    border: none !important;
                }

                /* Hover dropdown animation & spacing */
                .dropdown-hover:hover>.dropdown-menu {
                    display: block !important;
                    margin-top: 8px !important;
                    animation: dropdownFade 0.18s ease-in-out;
                }

                .dropdown-hover>.dropdown-menu::before {
                    content: '';
                    position: absolute;
                    top: -10px;
                    left: 0;
                    width: 100%;
                    height: 10px;
                    background: transparent;
                }

                @keyframes dropdownFade {
                    from {
                        opacity: 0;
                        transform: translateY(6px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .dropdown-menu {
                    background-color: #FFFFFF !important;
                    border-radius: 0 !important;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15) !important;
                    z-index: 1070 !important;
                }

                .dropdown-menu .dropdown-item {
                    color: #222222 !important;
                }

                .dropdown-menu .dropdown-item:hover {
                    background-color: #F8F8F8 !important;
                    color: var(--color-primary) !important;
                    font-weight: 700;
                    padding-left: 1.25rem !important;
                    transition: padding-left 0.15s ease, color 0.15s ease;
                }

                /* Offcanvas & Modal Layering Fix */
                .offcanvas {
                    z-index: 1090 !important;
                }
                .offcanvas-backdrop {
                    z-index: 1085 !important;
                }
                .modal {
                    z-index: 1100 !important;
                }
                .modal-backdrop {
                    z-index: 1095 !important;
                }
            </style>
        </head>

        <body>
            <!-- Top Announcement Bar (Hidden when transparent header is active) -->
            <c:if test="${param.transparentHeader ne 'true'}">
                <div class="top-notification-bar py-1">
                    <div class="container d-flex justify-content-end align-items-center">
                        <div class="d-flex gap-3 small">
                            <a href="#"><i class="fa-solid fa-location-dot me-1"></i> Tìm cửa hàng</a>
                            <span class="text-secondary">|</span>
                            <a href="#"><i class="fa-solid fa-headset me-1"></i> Hotline: 1900 161 161</a>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Main Navigation Bar -->
            <nav
                class="navbar navbar-expand navbar-main ${param.transparentHeader eq 'true' ? 'navbar-transparent' : 'sticky-top'}">
                <div class="container d-flex align-items-center justify-content-between">
                    <!-- Left: Brand Logo & Category Tabs -->
                    <div class="d-flex align-items-center gap-3">
                        <!-- Brand Logo -->
                        <a class="navbar-brand-wrapper me-2" href="home">
                            <span class="brand-box">ONE61</span>
                            <span class="brand-box">GARMENT</span>
                        </a>

                        <!-- Category Navigation Links (Always Visible) -->
                        <ul class="navbar-nav d-flex flex-row align-items-center mb-0 gap-1 category-nav-wrapper"
                            id="mainCategoryNav">
                            <!-- Sliding Magic Underline Bar -->
                            <div id="slidingNavIndicator" class="sliding-nav-indicator"></div>

                            <!-- NỮ Dropdown -->
                            <li class="nav-item dropdown dropdown-hover">
                                <a class="nav-link main-nav-link ${param.categoryID.startsWith('WOMEN') ? 'active-cate text-danger fw-bold' : ''}"
                                    href="product?categoryID=WOMEN_01" role="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    NỮ
                                </a>
                                <ul class="dropdown-menu rounded-0 shadow-lg border border-dark-subtle p-2"
                                    style="min-width: 210px;">
                                    <li class="dropdown-header text-uppercase fw-bold text-danger pb-1"
                                        style="font-size: 0.75rem;">Thời Trang Nữ</li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=WOMEN_01"><i
                                                class="fa-solid fa-shirt me-2 text-muted"></i> Áo Thun Nữ</a></li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=WOMEN_02"><i
                                                class="fa-solid fa-vest me-2 text-muted"></i> Áo Sơ Mi Nữ</a></li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=WOMEN_03"><i
                                                class="fa-solid fa-mitten me-2 text-muted"></i> Áo Khoác Nữ</a></li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=WOMEN_04"><i
                                                class="fa-solid fa-person-dress me-2 text-muted"></i> Quần & Váy Nữ</a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider my-1">
                                    </li>
                                    <li><a class="dropdown-item py-1 small fw-bold text-danger" href="product"><i
                                                class="fa-solid fa-arrow-right me-2"></i> Xem tất cả đồ Nữ</a></li>
                                </ul>
                            </li>

                            <!-- NAM Dropdown -->
                            <li class="nav-item dropdown dropdown-hover">
                                <a class="nav-link main-nav-link ${param.categoryID.startsWith('MEN') ? 'active-cate text-danger fw-bold' : ''}"
                                    href="product?categoryID=MEN_01" role="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    NAM
                                </a>
                                <ul class="dropdown-menu rounded-0 shadow-lg border border-dark-subtle p-2"
                                    style="min-width: 210px;">
                                    <li class="dropdown-header text-uppercase fw-bold text-danger pb-1"
                                        style="font-size: 0.75rem;">Thời Trang Nam</li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=MEN_01"><i
                                                class="fa-solid fa-shirt me-2 text-muted"></i> Áo Thun Nam</a></li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=MEN_02"><i
                                                class="fa-solid fa-user-tie me-2 text-muted"></i> Áo Sơ Mi Nam</a></li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=MEN_03"><i
                                                class="fa-solid fa-mitten me-2 text-muted"></i> Áo Khoác Nam</a></li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=MEN_04"><i
                                                class="fa-solid fa-person me-2 text-muted"></i> Quần Dài Nam</a></li>
                                    <li>
                                        <hr class="dropdown-divider my-1">
                                    </li>
                                    <li><a class="dropdown-item py-1 small fw-bold text-danger" href="product"><i
                                                class="fa-solid fa-arrow-right me-2"></i> Xem tất cả đồ Nam</a></li>
                                </ul>
                            </li>

                            <!-- TRẺ EM Dropdown -->
                            <li class="nav-item dropdown dropdown-hover">
                                <a class="nav-link main-nav-link ${param.categoryID.startsWith('KIDS') ? 'active-cate text-danger fw-bold' : ''}"
                                    href="product?categoryID=KIDS_01" role="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    TRẺ EM
                                </a>
                                <ul class="dropdown-menu rounded-0 shadow-lg border border-dark-subtle p-2"
                                    style="min-width: 210px;">
                                    <li class="dropdown-header text-uppercase fw-bold text-danger pb-1"
                                        style="font-size: 0.75rem;">Thời Trang Trẻ Em</li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=KIDS_01"><i
                                                class="fa-solid fa-child me-2 text-muted"></i> Áo Trẻ Em</a></li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=KIDS_02"><i
                                                class="fa-solid fa-mitten me-2 text-muted"></i> Áo Khoác Trẻ Em</a></li>
                                    <li><a class="dropdown-item py-2 small fw-semibold"
                                            href="product?categoryID=KIDS_03"><i
                                                class="fa-solid fa-shoe-prints me-2 text-muted"></i> Quần Trẻ Em</a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider my-1">
                                    </li>
                                    <li><a class="dropdown-item py-1 small fw-bold text-danger" href="product"><i
                                                class="fa-solid fa-arrow-right me-2"></i> Xem tất cả đồ Trẻ Em</a></li>
                                </ul>
                            </li>

                            <!-- TẤT CẢ Link -->
                            <li class="nav-item">
                                <a class="nav-link main-nav-link ${empty param.categoryID ? 'active-cate' : ''}"
                                    href="product">TẤT CẢ</a>
                            </li>
                        </ul>
                    </div>

                    <!-- Right Box: Middle Search Bar + Action Icons -->
                    <div class="d-flex align-items-center gap-2">
                        <!-- Middle Search Bar (Pill Shape) -->
                        <div class="search-box-container d-none d-md-block position-relative" style="width: 250px;">
                            <input type="text" class="form-control rounded-pill pe-4 ps-3 py-1 border-dark-subtle small"
                                placeholder="Bạn đang tìm sản phẩm gì?"
                                style="font-size: 0.8rem; background-color: #F8F9FA;">
                            <i class="fa-solid fa-magnifying-glass text-muted position-absolute top-50 end-0 translate-middle-y me-3"
                                style="font-size: 0.8rem;"></i>
                        </div>

                        <!-- Right Action Icons -->
                        <div class="d-flex align-items-center gap-1 ms-2">
                            <!-- Wishlist -->
                            <a class="header-icon-btn" href="#" title="Yêu thích">
                                <i class="fa-regular fa-heart"></i>
                            </a>

                            <!-- Cart -->
                            <a class="header-icon-btn" href="cart" title="Giỏ hàng">
                                <i class="fa-solid fa-cart-shopping"></i>
                                <span class="cart-badge">${sessionScope.CART != null ? sessionScope.CART.size() :
                                    0}</span>
                            </a>

                            <!-- User Account -->
                            <c:choose>
                                <c:when test="${not empty sessionScope.LOGIN_USER}">
                                    <div class="dropdown ms-1">
                                        <a class="header-icon-btn dropdown-toggle fw-bold text-uppercase small" href="#"
                                            id="userDropdown" role="button" data-bs-toggle="dropdown"
                                            style="font-size: 0.8rem;">
                                            <i class="fa-regular fa-circle-user fs-5 text-danger"></i>
                                            <span class="d-none d-xl-inline">${sessionScope.LOGIN_USER.fullName}</span>
                                        </a>
                                        <ul
                                            class="dropdown-menu dropdown-menu-end rounded-0 shadow-sm border border-dark-subtle mt-2">
                                            <li class="px-3 py-2 border-bottom bg-light">
                                                <small class="text-muted d-block">Đăng nhập với tư cách</small>
                                                <strong class="text-dark">${sessionScope.LOGIN_USER.userID}</strong>
                                                <c:if test="${sessionScope.LOGIN_USER.roleID eq 'ADMIN'}">
                                                    <span class="badge bg-danger rounded-0 ms-1">Admin</span>
                                                </c:if>
                                            </li>
                                            <c:if test="${sessionScope.LOGIN_USER.roleID eq 'ADMIN'}">
                                                <li>
                                                    <a class="dropdown-item fw-bold text-danger py-2"
                                                        href="admin/dashboard.jsp">
                                                        <i class="fa-solid fa-shield-halved me-2"></i> Trang Quản Trị
                                                        Admin
                                                    </a>
                                                </li>
                                            </c:if>
                                            <li>
                                                <a class="dropdown-item py-2" href="#">
                                                    <i class="fa-solid fa-box-archive me-2 text-muted"></i> Đơn hàng của
                                                    tôi
                                                </a>
                                            </li>
                                            <li>
                                                <hr class="dropdown-divider my-1">
                                            </li>
                                            <li>
                                                <a class="dropdown-item text-danger py-2 fw-bold" href="logout">
                                                    <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex align-items-center gap-2 ms-2">
                                        <a class="btn btn-outline-light btn-sm rounded-0 fw-bold px-3 text-uppercase"
                                            href="login" style="font-size: 0.75rem;">
                                            Đăng nhập
                                        </a>
                                        <a class="btn btn-danger btn-sm rounded-0 fw-bold px-3 text-uppercase"
                                            href="register"
                                            style="background-color: var(--color-primary); border-color: var(--color-primary); font-size: 0.75rem;">
                                            Đăng ký
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </nav>

            <script>
                (function () {
                    function initSlidingUnderline() {
                        const nav = document.getElementById('mainCategoryNav');
                        const indicator = document.getElementById('slidingNavIndicator');
                        if (!nav || !indicator) return;

                        const navLinks = nav.querySelectorAll('.main-nav-link');
                        let activeLink = nav.querySelector('.main-nav-link.active-cate') || navLinks[0];

                        function moveTo(element) {
                            if (!element) {
                                indicator.style.opacity = '0';
                                return;
                            }
                            const navRect = nav.getBoundingClientRect();
                            const elemRect = element.getBoundingClientRect();
                            const padding = 24;
                            const left = (elemRect.left - navRect.left) + (padding / 2);
                            const width = Math.max(elemRect.width - padding, 18);

                            indicator.style.left = left + 'px';
                            indicator.style.width = width + 'px';
                            indicator.style.opacity = '1';
                        }

                        // Set initial position after render
                        setTimeout(function () {
                            moveTo(activeLink);
                        }, 80);

                        navLinks.forEach(function (link) {
                            link.addEventListener('mouseenter', function () {
                                moveTo(this);
                            });
                        });

                        nav.addEventListener('mouseleave', function () {
                            if (activeLink) {
                                moveTo(activeLink);
                            }
                        });

                        window.addEventListener('resize', function () {
                            if (activeLink) moveTo(activeLink);
                        });
                    }

                    if (document.readyState === 'loading') {
                        document.addEventListener('DOMContentLoaded', initSlidingUnderline);
                    } else {
                        initSlidingUnderline();
                    }
                })();
            </script>

            <!-- Main Page Wrapper Container (Suppressed on transparent header page) -->
            <c:if test="${param.transparentHeader ne 'true'}">
                <div class="container mt-4 mb-5 flex-grow-1">
            </c:if>