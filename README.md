# ONE61 GARMENTORY — Minimalist LifeWear E-Commerce Platform

[![Java](https://img.shields.io/badge/Java-1.8%2B%20%7C%2011%2B-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![Servlet](https://img.shields.io/badge/Jakarta%20Servlet-3.1%2B-blue?style=for-the-badge&logo=apache-tomcat&logoColor=white)](https://tomcat.apache.org/)
[![Database](https://img.shields.io/badge/Microsoft%20SQL%20Server-2019%2B-CC292B?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)](https://www.microsoft.com/sql-server)
[![Payment](https://img.shields.io/badge/VietQR-SePay%20Webhook-00A859?style=for-the-badge&logo=qr-code&logoColor=white)](https://sepay.vn/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)

> **ONE61 Garmentory** là dự án website thương mại điện tử thời trang tối giản chuẩn phong cách Uniqlo LifeWear, xây dựng trên nền tảng **Java Servlet & JSP (Mô hình MVC)**, cơ sở dữ liệu **MSSQL Server với cấu trúc đệ quy (Self-referencing)** và tích hợp cổng thanh toán tự động **VietQR qua SePay Webhook**.

---

## Mục lục tài liệu cho Developers & AI Agents

Dự án đã được tài liệu hóa chi tiết qua các file markdown chuyên dụng:
- **[AGENTS.md](./AGENTS.md)** — Quy tắc, quy ước code, cấu trúc thư mục và chỉ dẫn dành cho AI Agents / Pair Programmers.
- **[CLAUDE.md](./CLAUDE.md)** — Hướng dẫn phát triển, lệnh thực thi và quy chuẩn dành riêng cho Claude Code & AI Assistants.
- **[ARCHITECTURE.md](./ARCHITECTURE.md)** — Kiến trúc hệ thống MVC, luồng dữ liệu, vòng đời Filter và sơ đồ thanh toán VietQR Webhook.
- **[DATABASE.md](./DATABASE.md)** — Sơ đồ ER Diagram, chi tiết các bảng, quan hệ đệ quy `parentID` và hướng dẫn chạy database trên Local / Somee.
- **[API.md](./API.md)** — Danh mục toàn bộ Servlet Endpoints, HTTP Methods, Actions, Parameters và Webhook Payload.

---

## Tính năng nổi bật

### Trải nghiệm Khách Hàng (Customer Experience)
- **Trang chủ & Banner Video**: Hero video thời thượng, bộ lọc danh mục trực quan theo giới tính (Nam / Nữ) và từng nhóm sản phẩm.
- **Lookbook Gallery Động (Đệ quy)**: Mỗi sản phẩm tự động render đầy đủ các góc chụp thực tế (Mặt trước, Phối đồ styling, Chi tiết chất vải, Form dáng).
- **Bộ lọc & Phân trang đa tầng**: Phân trang 10 sản phẩm/trang mượt mà trên toàn bộ trang chủ, trang danh mục và trang quản trị.
- **Giỏ hàng & Danh sách Yêu thích**: Slide drawer giỏ hàng tiện lợi, lưu trữ giỏ hàng và sản phẩm yêu thích trên Session / LocalStorage.
- **Thanh toán VietQR thời gian thực**: Tự động sinh mã QR chuyển khoản ngân hàng chính xác số tiền và cú pháp, lắng nghe SePay Webhook để tự động xác nhận đơn hàng thành công trong vài giây.

### Quản Trị Hệ Thống (Admin Portal)
- **Quản lý kho hàng & sản phẩm**: Bảng danh sách sản phẩm phân trang, hiển thị mức tồn kho cảnh báo sắp hết hàng.
- **CRUD Sản phẩm**: Thêm mới, chỉnh sửa thông tin, giá niêm yết, phân loại và xóa mềm (soft delete).
- **Phân quyền truy cập**: Bộ lọc `AuthenticationFilter` và `AuthorizationFilter` ngăn chặn truy cập trái phép.

---

## Công nghệ sử dụng

| Lớp (Layer) | Công nghệ |
| :--- | :--- |
| **Backend Core** | Java EE 8 / Jakarta Servlet 3.1, JSP 2.3, JSTL 1.2 |
| **Kiến trúc** | MVC (Model - View - Controller), DAO Pattern, DTO |
| **Cơ sở dữ liệu** | Microsoft SQL Server (Hỗ trợ Local & Somee Cloud Hosting) |
| **Cổng thanh toán** | SePay Webhook API, VietQR Banking Gateway |
| **Bảo mật** | SHA-256 Hashing (`PasswordUtils`), CSRF Token (`CSRFUtils`), Session Management |
| **Frontend** | HTML5 Semantic, Vanilla CSS3, Vanilla JS (ES6+), Bootstrap 5.3, FontAwesome 6 |

---

## Hướng dẫn Cài đặt & Chạy ứng dụng

### 1. Yêu cầu hệ thống
- **JDK:** Java SE 8 hoặc Java SE 11+
- **Database:** Microsoft SQL Server 2017+ (hoặc Somee SQL Server)
- **Web Server:** Apache Tomcat 9.0+
- **IDE:** Apache NetBeans 12+, IntelliJ IDEA, hoặc Eclipse

### 2. Cài đặt Cơ sở Dữ liệu
- **Chạy trên máy cá nhân (Local):** Mở file [`PRJ301_Ecommerce.sql`](./PRJ301_Ecommerce.sql) trong SQL Server Management Studio (SSMS) và nhấn **F5**.
- **Chạy trên Somee Hosting:** Mở file [`PRJ301_Ecommerce_Somee.sql`](./PRJ301_Ecommerce_Somee.sql), copy nội dung dán vào mục *Manage SQL* trên Somee và nhấn **Run SQL**.

### 3. Cấu hình Môi trường (`.env`)
Tạo file `.env` tại thư mục gốc của project (dựa theo [`.env.example`](./.env.example)):
```ini
DB_HOST=localhost
DB_PORT=1433
DB_NAME=PRJ301_Ecommerce
DB_USERNAME=sa
DB_PASSWORD=your_password

SEPAY_API_TOKEN=your_sepay_token
SEPAY_WEBHOOK_SECRET=your_webhook_secret
SEPAY_BANK_NAME=MBBank
SEPAY_ACCOUNT_NUMBER=08222216167810
SEPAY_ACCOUNT_HOLDER=NGUYEN VAN QUOC BAO
```

### 4. Build & Chạy Website
- Mở project trong IDE $\rightarrow$ **Clean and Build**.
- Deploy lên Apache Tomcat và truy cập: `http://localhost:8080/PRJ301-Assignment/home`

---

## Tài khoản mặc định

| Vai trò (Role) | Username | Password | Email |
| :--- | :--- | :--- | :--- |
| **Quản trị viên (Admin)** | `admin` | `12345` | `admin@gmail.com` |
| **Khách hàng (Customer)** | `user1` | `12345` | `usera@gmail.com` |

*(Mật khẩu đã được tự động băm SHA-256 an toàn trong cơ sở dữ liệu)*

---

## Bản quyền & Giấy phép
Dự án được phân phối dưới giấy phép **MIT License** — xem file [LICENSE](./LICENSE) để biết thêm chi tiết.