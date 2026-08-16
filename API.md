# API.md — ONE61 Garmentory HTTP Endpoints & Webhook Specification

This document details all Servlet endpoints, HTTP methods, query parameters, action dispatches, and webhook integration payloads for the **ONE61 Garmentory** application.

---

## 1. Public & Customer Endpoints

### 1.1 Home (`/home`)
- **Servlet:** `MainController`
- **Method:** `GET`, `POST`
- **Parameters:**
  - `categoryID` *(optional, string)*: Filter products by category code.
  - `page` *(optional, integer, default: 1)*: Page number for pagination.
- **Attributes Set:** `PRODUCTS` (List<ProductDTO>), `CATEGORIES` (List<CategoryDTO>), `currentPage`, `endPage`, `totalProducts`.
- **View Target:** `home.jsp`

---

### 1.2 Product Catalog & Detail (`/product`)
- **Servlet:** `ProductController`
- **Method:** `GET`, `POST`
- **Actions:**
  - **`action=list` (default):**
    - `categoryID` *(optional)*: Filter by category.
    - `page` *(optional, default: 1)*: Current page number.
    - `pageSize`: 10 items per page.
    - **View:** `product.jsp`
  - **`action=detail`:**
    - `id` *(required, string)*: Product ID (e.g. `PROD01`).
    - **Attributes Set:** `PRODUCT` (ProductDTO), `CHILD_PRODUCTS` (List<ProductDTO> for dynamic lookbook), `CATEGORY_NAME`.
    - **View:** `product-detail.jsp`

---

### 1.3 Shopping Cart (`/cart`)
- **Servlet:** `CartController`
- **Method:** `GET`, `POST`
- **Actions:**
  - `action=view`: Display current cart items (`cart.jsp`).
  - `action=add`: Adds a product to session cart (`id`, `quantity`).
  - `action=update`: Updates item quantity (`id`, `quantity`).
  - `action=remove`: Deletes item from session cart (`id`).
  - `action=clear`: Empties the shopping cart.

---

### 1.4 Authentication (`/login`, `/register`, `/logout`)
| Endpoint | Servlet | Method | Parameters | Description |
| :--- | :--- | :--- | :--- | :--- |
| `/login` | `LoginController` | `POST` | `userID`, `password` | Authenticates user; establishes session `LOGIN_USER`. |
| `/register` | `RegisterController` | `POST` | `userID`, `fullName`, `email`, `password`, `phone` | Registers new customer account with SHA-256 hash. |
| `/logout` | `LogoutController` | `GET` | *(none)* | Invalidates current session and redirects to `/login`. |

---

### 1.5 Checkout & Order Placement (`/checkout`)
- **Servlet:** `CheckoutController`
- **Method:** `GET`, `POST`
- **Security:** Requires authenticated session (`AuthenticationFilter`).
- **Parameters (POST):** `receiverName`, `phone`, `shippingAddress`, `paymentMethod` (`COD` / `VIETQR`), `note`, `csrfToken`.
- **Flow:** Creates `Order` and `Payment` records in `PENDING` status. For `VIETQR`, returns payment details with QR code.

---

## 2. API & Webhook Endpoints

### 2.1 Check Payment Status (`/api/check-payment`)
- **Servlet:** `CheckPaymentController`
- **Method:** `GET`
- **Query Parameter:** `orderID` (string)
- **Response Format:** `application/json`
```json
{
  "orderID": "ORD20260816001",
  "status": "SUCCESS",
  "paid": true,
  "paymentMethod": "VIETQR",
  "amount": 599000
}
```

---

### 2.2 SePay VietQR Webhook Listener (`/api/sepay-webhook`)
- **Servlet:** `SepayWebhookController`
- **Method:** `POST`
- **Headers:** `Authorization: Bearer <SEPAY_API_TOKEN>`, `X-Sepay-Signature: <HMAC-SHA256>`
- **Request Payload Sample:**
```json
{
  "id": 1234567,
  "gateway": "MBBank",
  "transactionDate": "2026-08-16 17:30:00",
  "accountNumber": "08222216167810",
  "code": null,
  "content": "DH PROD01 12345",
  "transferType": "in",
  "transferAmount": 599000,
  "accumulated": 599000,
  "subAccount": null,
  "referenceCode": "MB12345678",
  "description": "Chuyen tien don hang PROD01"
}
```
- **Processing Logic:**
  1. Validates signature against `SEPAY_WEBHOOK_SECRET`.
  2. Extracts Order ID from transaction content regex.
  3. Updates `[Payment]` to `SUCCESS` and `[Order]` to `PROCESSING`.
  4. Returns `HTTP 200 { "success": true }`.

---

## 3. Admin Endpoints (`/admin/product`)

- **Servlet:** `AdminController`
- **Security:** Requires `LOGIN_USER.roleID == 'ADMIN'` (`AuthorizationFilter`).
- **Actions:**
  - `action=list` (or default): Paginated product table with stock levels (`manage-product.jsp`).
    - Parameter: `page` (default: 1, pageSize: 10).
  - `action=add`: Form to insert new product (`form-product.jsp`).
  - `action=add_submit` (POST): Processes product insertion into database.
  - `action=update_submit` (POST): Updates product attributes.
  - `action=delete`: Soft-deletes product (`UPDATE [Product] SET status = 0 WHERE productID = ? OR parentID = ?`).
