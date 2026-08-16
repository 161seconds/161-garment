# CLAUDE.md — Claude Code & AI Developer Guide for ONE61 Garmentory

This document provides system guidelines, commands, architectural patterns, and code conventions for Claude Code and AI assistants working on **ONE61 Garmentory**.

---

## 1. Project Summary & Quick Reference

- **Name:** ONE61 Garmentory (`PRJ301-Assignment`)
- **Domain:** Minimalist LifeWear E-Commerce Platform (Uniqlo-inspired)
- **Tech Stack:** Java EE 8 / Jakarta (Servlet 3.1, JSP 2.3, JSTL 1.2), MSSQL Server, Apache Tomcat 9/10, Bootstrap 5.3, SePay VietQR Payment Gateway.
- **Architecture:** Classic MVC with DAO/DTO pattern and Servlet Filter security pipeline.

---

## 2. Common Development & Build Commands

```powershell
# Sync updated JSP/JS/CSS assets to Tomcat build directory
powershell -Command "Copy-Item -Recurse -Force 'web\*' -Destination 'build\web\'"

# Sync static preview JS files
powershell -Command "Copy-Item -Force 'web/js/product.js' -Destination 'pages/js/product.js'"
powershell -Command "Copy-Item -Force 'web/js/product-detail.js' -Destination 'pages/js/product-detail.js'"
powershell -Command "Copy-Item -Force 'web/js/home.js' -Destination 'pages/js/home.js'"
powershell -Command "Copy-Item -Force 'web/js/one61-alert.js' -Destination 'pages/js/one61-alert.js'"

# Check git status
git status -s

# Commit & Push
git add .
git commit -m "your message"
git push origin <branch_name>
```

---

## 3. Key Architecture & Coding Conventions

### 3.1 Self-Referencing Recursive Product Catalog
- The `[Product]` table uses a recursive hierarchy (`parentID` column):
  - **Master / Cover Products (`parentID IS NULL`)**: 24 items. Represents catalog items with cover images (`products/{gender}/cover/...`).
  - **Child / Content Products (`parentID = 'PRODxx'`)**: 94 items. Represents multi-angle content images (`products/{gender}/content/...`).
- **Listing Queries:** Must ALWAYS filter `WHERE parentID IS NULL AND status = 1`.
- **Detail Queries:** Must query `WHERE parentID = ? AND status = 1` via `ProductDAO.getChildProducts(parentID)`.

### 3.2 Pagination Rules
- Every product listing (`MainController`, `ProductController`, `AdminController`, client-side JS) must implement pagination:
  - Default `pageSize = 10`.
  - Calculate `endPage = (total % pageSize == 0) ? (total / pageSize) : (total / pageSize + 1)`.
  - Handle safe page bounds `1 <= page <= endPage`.
  - Pass `currentPage`, `endPage`, `totalProducts` to views.

### 3.3 Database Access (DAO Pattern)
- Always use **`java.sql.PreparedStatement`** with try-with-resources to prevent SQL injection and connection leaks.
- Always obtain connections through `DBUtils.getConnection()`.
- Keep business logic in Controllers/DAOs, never in JSP scriptlets.

### 3.4 Security & Cryptography Standards
- **Password Storage:** Never save plain-text passwords. Always use `PasswordUtils.hashSHA256(password)`.
- **Filters:**
  - `EncodingFilter` (`/*`): Enforces UTF-8 encoding on all requests/responses.
  - `AuthenticationFilter` (`/admin/*`, `/checkout`, `/order/*`): Verifies `session.getAttribute("LOGIN_USER")`.
  - `AuthorizationFilter` (`/admin/*`): Verifies `LOGIN_USER.getRoleID().equals("ADMIN")`.
- **CSRF Defense:** Validate `CSRFUtils.validateToken(request)` on state-modifying POST requests.

---

## 4. Payment Integration: SePay VietQR Webhooks
- **Webhook Endpoint:** `/api/sepay-webhook` (`SepayWebhookController`).
- **Payment Verification:** `/api/check-payment` (`CheckPaymentController`) polled by client every 3 seconds during checkout modal display.
- **Environment Variables:** Loaded via `EnvUtils.java` from `.env`.

---

## 5. Directory Map

| Path | Purpose |
| :--- | :--- |
| `src/java/controller/` | MVC Servlet Controllers (`MainController`, `ProductController`, `AdminController`, `CheckoutController`, `SepayWebhookController`, etc.) |
| `src/java/model/` | Data Access Objects (`*DAO.java`) & Data Transfer Objects (`*DTO.java`) |
| `src/java/filter/` | Security and Encoding Filters (`EncodingFilter`, `AuthenticationFilter`, `AuthorizationFilter`) |
| `src/java/utils/` | Helpers (`DBUtils`, `EnvUtils`, `PasswordUtils`, `CSRFUtils`) |
| `web/` | Web Root (JSP views, stylesheets, JavaScript, product image assets, `WEB-INF/web.xml`) |
| `pages/` | Standalone static HTML5/JS mockup for previewing in browsers without Tomcat |
| `PRJ301_Ecommerce.sql` | Local MSSQL database initialization script |
| `PRJ301_Ecommerce_Somee.sql` | Remote Somee hosting database initialization script |
