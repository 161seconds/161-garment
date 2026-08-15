<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title != null ? param.title : '161 Garment | Admin Portal'}</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Helvetica+Neue:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --admin-red: #E00000;
            --admin-dark: #111111;
            --admin-gray: #767676;
            --admin-border: #E5E5E5;
            --admin-bg: #F8F9FA;
            --admin-card-bg: #FFFFFF;
        }
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: var(--admin-bg);
            color: var(--admin-dark);
            min-height: 100vh;
        }
        .navbar-admin {
            background-color: var(--admin-dark);
            border-bottom: 3px solid var(--admin-red);
        }
        .admin-brand-box {
            background-color: var(--admin-red);
            color: #FFFFFF;
            font-weight: 700;
            padding: 4px 8px;
            letter-spacing: 1px;
        }
        .sidebar-admin .list-group-item {
            border: 1px solid var(--admin-border);
            margin-bottom: 4px;
            font-weight: 600;
            font-size: 0.9rem;
            color: var(--admin-dark);
            transition: all 0.2s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .sidebar-admin .list-group-item:hover {
            background-color: #ECECEC;
            color: var(--admin-dark);
        }
        .sidebar-admin .list-group-item.active {
            background-color: var(--admin-red) !important;
            border-color: var(--admin-red) !important;
            color: #FFFFFF !important;
        }
        .admin-card {
            background-color: var(--admin-card-bg);
            border: 1px solid var(--admin-border);
            border-radius: 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }
        .stat-card {
            border-left: 4px solid var(--admin-dark);
            transition: transform 0.2s ease;
        }
        .stat-card:hover {
            transform: translateY(-2px);
        }
        .stat-card.red-border { border-left-color: var(--admin-red); }
        .stat-card.dark-border { border-left-color: var(--admin-dark); }
        .stat-card.gray-border { border-left-color: var(--admin-gray); }
        
        .btn-admin-primary {
            background-color: var(--admin-red);
            color: #FFFFFF;
            font-weight: 700;
            border: none;
            border-radius: 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .btn-admin-primary:hover {
            background-color: #B80000;
            color: #FFFFFF;
        }
        .btn-admin-dark {
            background-color: var(--admin-dark);
            color: #FFFFFF;
            font-weight: 700;
            border: none;
            border-radius: 0;
            text-transform: uppercase;
        }
        .btn-admin-dark:hover {
            background-color: #333333;
            color: #FFFFFF;
        }
        .table thead th {
            background-color: var(--admin-dark);
            color: #FFFFFF;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            border-color: var(--admin-dark);
        }
    </style>
</head>
<body>
    <!-- Admin Top Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-admin sticky-top">
        <div class="container-fluid px-4">
            <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                <span class="admin-brand-box">161</span>
                <span class="fw-bold tracking-wider">GARMENT ADMIN</span>
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="adminNavbar">
                <ul class="navbar-nav ms-auto align-items-center gap-2">
                    <li class="nav-item">
                        <span class="text-light small me-2">
                            <i class="fa-regular fa-user-circle me-1"></i> ${sessionScope.LOGIN_USER.fullName} (Admin)
                        </span>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm rounded-0 text-uppercase fw-bold" style="font-size: 0.8rem;">
                            <i class="fa-solid fa-store me-1"></i> Trang bán hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm rounded-0 text-uppercase fw-bold" style="font-size: 0.8rem;">
                            <i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuất
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Admin Container -->
    <div class="container-fluid px-4 py-4">
        <div class="row g-4">
            <!-- Sidebar Included -->
            <jsp:include page="sidebar.jsp" />
            
            <!-- Main Content Area -->
            <div class="col-lg-10 col-md-9">
