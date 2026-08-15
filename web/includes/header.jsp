<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>161 Garment | Mua Sắm Trực Tuyến</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <!-- Uniqlo Style Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Helvetica+Neue:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --color-primary: #E00000; /* Uniqlo Red */
            --color-on-primary: #FFFFFF;
            --color-secondary: #F4F4F4; /* Light Gray */
            --color-accent: #E00000;
            --color-on-accent: #FFFFFF;
            --color-background: #FFFFFF; /* White */
            --color-foreground: #111111; /* Black/Dark Gray */
            --color-card: #FFFFFF; /* Solid White */
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
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            font-weight: 700;
            letter-spacing: -0.5px;
        }
        
        /* Uniqlo Style Navbar */
        .navbar-glass {
            background: #FFFFFF !important;
            border-bottom: 1px solid var(--color-border);
        }
        .navbar-brand-wrapper {
            display: inline-flex;
            gap: 4px; /* Khoảng cách giữa 2 ô */
            text-decoration: none;
        }
        .brand-box { 
            font-weight: 700; 
            font-size: 1.5rem; 
            color: var(--color-on-primary) !important; 
            background-color: var(--color-primary);
            padding: 5px 10px;
            letter-spacing: 1px;
            text-transform: uppercase;
            display: inline-block;
            line-height: 1.2;
        }
        .nav-link { 
            color: var(--color-foreground) !important; 
            font-weight: 700; 
            font-size: 0.9rem;
            text-transform: uppercase;
            transition: opacity 0.2s ease; 
        }
        .nav-link:hover { 
            opacity: 0.6;
            color: var(--color-foreground) !important; 
        }
        
        .btn-accent {
            background-color: var(--color-accent);
            color: var(--color-on-accent);
            border: none;
            transition: opacity 0.2s ease;
            font-weight: 700;
            border-radius: 0; /* Square buttons */
            text-transform: uppercase;
        }
        .btn-accent:hover {
            opacity: 0.8;
            color: white;
            background-color: var(--color-accent);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-glass sticky-top">
        <div class="container">
            <a class="navbar-brand-wrapper" href="home">
                <span class="brand-box">161</span>
                <span class="brand-box">GARMENT</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="product">Sản phẩm</a></li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="cart"><i class="fa-solid fa-cart-shopping"></i> Giỏ hàng 
                            <span class="badge bg-danger rounded-pill">${sessionScope.CART != null ? sessionScope.CART.size() : 0}</span>
                        </a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.LOGIN_USER}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fa-solid fa-user"></i> ${sessionScope.LOGIN_USER.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <c:if test="${sessionScope.LOGIN_USER.roleID eq 'ADMIN'}">
                                        <li><a class="dropdown-item" href="admin/product?action=list">Quản lý Admin</a></li>
                                    </c:if>
                                    <li><a class="dropdown-item" href="#">Hồ sơ</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="logout">Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="login">Đăng nhập</a></li>
                            <li class="nav-item"><a class="nav-link" href="register">Đăng ký</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-4 mb-5 flex-grow-1">
