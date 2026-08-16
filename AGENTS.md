# AGENTS.md — ONE61 Garmentory Agent & AI Guidance

This document provides system context, architectural rules, code conventions, and operational workflows for AI assistants, agents, and automated pair programmers working on the **ONE61 Garmentory** repository.

---

## 1. Project Overview & Tech Stack

- **Project Name:** ONE61 Garmentory (`PRJ301-Assignment`)
- **Domain:** Minimalist LifeWear E-Commerce Web Application (Uniqlo-inspired)
- **Course Reference:** PRJ301 — Java Web Application Development
- **Core Stack:**
  - **Runtime:** Java EE / Jakarta (Servlet 3.1+, JSP 2.3+, JSTL 1.2)
  - **Application Server:** Apache Tomcat 9 / 10
  - **Database:** Microsoft SQL Server (Local & Somee Remote Cloud)
  - **Data Access:** JDBC with DAO/DTO Pattern (`java.sql.*`)
  - **Security:** SHA-256 Hashing (`PasswordUtils`), CSRF Protection (`CSRFUtils`), Servlet Filters
  - **Payment Integration:** SePay VietQR Payment Gateway (Webhook + Polling Verification)
  - **Frontend:** Vanilla HTML5, CSS3, Vanilla JavaScript, Bootstrap 5.3, FontAwesome 6, Google Fonts (*Outfit* & *Be Vietnam Pro*)

---

## 2. Directory Structure

```
PRJ301-Assignment/
├── .agents/                      # Agent customizations, skills, rules
├── .env                          # Local environment variables (DB, SePay keys)
├── .env.example                  # Environment template
├── Dockerfile & render.yaml      # Docker / Cloud deployment configs
├── PRJ301_Ecommerce.sql          # Local SQL script with database reset & seed data
├── PRJ301_Ecommerce_Somee.sql    # Remote Somee hosting SQL script
├── pages/                        # Static HTML/JS preview mocks (browser testing)
│   ├── index.html                # Static Home Page preview
│   ├── product.html              # Static Catalog preview
│   ├── product-detail.html       # Static Product Detail preview
│   └── js/                       # Mock logic (home.js, product.js, product-detail.js, one61-alert.js)
├── src/java/                     # Java Source Code
│   ├── controller/               # Servlet Controllers (MVC Controller Layer)
│   │   ├── AdminController.java
│   │   ├── CartController.java
│   │   ├── CheckPaymentController.java
│   │   ├── CheckoutController.java
│   │   ├── LoginController.java
│   │   ├── LogoutController.java
│   │   ├── MainController.java
│   │   ├── ProductController.java
│   │   ├── RegisterController.java
│   │   ├── SepayReconciliationController.java
│   │   └── SepayWebhookController.java
│   ├── filter/                   # Servlet Filters (Security & Encoding)
│   │   ├── AuthenticationFilter.java
│   │   ├── AuthorizationFilter.java
│   │   └── EncodingFilter.java
│   ├── model/                    # Data Access Objects (DAO) & Data Transfer Objects (DTO)
│   │   ├── AddressDTO.java, CartItemDTO.java
│   │   ├── CategoryDAO.java, CategoryDTO.java
│   │   ├── OrderDAO.java, OrderDTO.java, OrderDetailDAO.java, OrderDetailDTO.java
│   │   ├── PaymentDTO.java, RoleDAO.java, RoleDTO.java
│   │   ├── ProductDAO.java, ProductDTO.java, ProductImageDTO.java
│   │   ├── UserDAO.java, UserDTO.java, WishlistDTO.java
│   └── utils/                    # Utility Singletons & Helpers
│       ├── CSRFUtils.java        # CSRF Token Generator & Validator
│       ├── DBUtils.java          # JDBC Connection Manager
│       ├── EnvUtils.java         # .env Environment Variable Loader
│       └── PasswordUtils.java    # SHA-256 Cryptographic Hash Utility
└── web/                          # Web Root (JSP views, assets, WEB-INF)
    ├── admin/                    # Admin Dashboard JSP Views
    │   ├── dashboard.jsp, form-product.jsp, manage-product.jsp, includes/
    ├── css/                      # Stylesheets (base.css, style.css, responsive.css)
    ├── img-prj301/               # Static images & product assets
    │   ├── categories/           # Category thumbnail icons (men & women)
    │   └── products/             # High-res product images (men & women)
    │       ├── men/              # cover/ (cover-*.avif) & content/ (content-*.avif)
    │       └── women/            # cover/ (cover-*.avif) & content/ (content-*.avif)
    ├── includes/                 # Reusable JSP Partials (header.jsp, footer.jsp)
    ├── js/                       # Client-side scripts synced with pages/js
    ├── home.jsp, product.jsp, product-detail.jsp, cart.jsp, checkout.jsp, login.jsp
    └── WEB-INF/web.xml           # Servlet mapping, Session timeout, Filter chain
```

---

## 3. Key Architectural Principles

### 3.1 Self-Referencing Recursive Product Model
- The `[Product]` table uses a recursive hierarchy (`parentID` column):
  - **Master / Parent Products (`parentID IS NULL`)**: 24 items. Represents the catalog item displayed on Home / Catalog with the cover image (`products/{gender}/cover/...`).
  - **Child / Variant Products (`parentID = 'PRODxx'`)**: 94 items. Represents multi-angle content images (`products/{gender}/content/...`).
- **Listing Queries (`getAllProducts`, `getProductsByCategory`, `getProductsByPage`)**: Must always filter `WHERE parentID IS NULL AND status = 1`.
- **Detail Queries (`getChildProducts(parentID)`)**: Must fetch `WHERE parentID = ? AND status = 1` to render the lookbook gallery dynamically.

### 3.2 Dual Database Deployment
- **Local SQL Server:** Use `PRJ301_Ecommerce.sql` (includes `USE master; CREATE DATABASE...`).
- **Remote Somee SQL Server:** Use `PRJ301_Ecommerce_Somee.sql` (no `master` permissions, uses direct table drops in foreign-key order).

### 3.3 Pagination Standard
- Every product listing page (`home.jsp`, `product.jsp`, `admin/manage-product.jsp`, and static client previews) must have pagination with:
  - Page size: 10 items per page.
  - Page calculation: `int endPage = (total % pageSize == 0) ? (total / pageSize) : (total / pageSize + 1);`
  - Safe bounds: `1 <= page <= endPage`.
  - Offset calculation: `(page - 1) * pageSize`.

### 3.4 Synchronization Rule
- Any changes made in `web/` assets (`web/js/*`, `web/css/*`, `web/img-prj301/*`) must be mirrored to `pages/` (for static preview) and synced to `build/web/` for Tomcat execution:
  ```powershell
  Copy-Item -Recurse -Force 'web\*' -Destination 'build\web\'
  ```

---

## 4. Security & Filter Execution Pipeline

1. **`EncodingFilter` (`/*`)**: Sets request & response encoding to `UTF-8`.
2. **`AuthenticationFilter` (`/admin/*`, `/checkout`, `/order/*`)**: Checks `session.getAttribute("LOGIN_USER")`. Redirects unauthorized users to `login.jsp`.
3. **`AuthorizationFilter` (`/admin/*`)**: Validates that `LOGIN_USER.getRoleID().equals("ADMIN")`. Returns 403 / redirects to home if non-admin.
4. **Password Hashing:** Passwords must **never** be saved in plain text. Always use `PasswordUtils.hashSHA256(password)`.
5. **CSRF Tokens:** State-modifying POST requests (checkout, add product, delete) should validate `CSRFUtils.validateToken(request)`.

---

## 5. Development & Build Commands

- **Git Status:** `git status -s`
- **Git Push:** `git push origin <branch_name>`
- **Sync Web Assets to Build:** `powershell -Command "Copy-Item -Recurse -Force 'web\*' -Destination 'build\web\'"`
- **Compile / Test:** Open in NetBeans or IntelliJ IDEA, clean and build with Ant (`build.xml`).
