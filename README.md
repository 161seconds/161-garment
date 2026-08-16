# ONE61 GARMENTORY — Minimalist LifeWear E-Commerce Platform

[![Java](https://img.shields.io/badge/Java-1.8%2B%20%7C%2011%2B-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![Servlet](https://img.shields.io/badge/Jakarta%20Servlet-3.1%2B-blue?style=for-the-badge&logo=apache-tomcat&logoColor=white)](https://tomcat.apache.org/)
[![Database](https://img.shields.io/badge/Microsoft%20SQL%20Server-2019%2B-CC292B?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)](https://www.microsoft.com/sql-server)
[![Payment](https://img.shields.io/badge/VietQR-SePay%20Webhook-00A859?style=for-the-badge&logo=qr-code&logoColor=white)](https://sepay.vn/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)

> **ONE61 Garmentory** is a modern fashion e-commerce web application inspired by Uniqlo's LifeWear philosophy. It is engineered with **Java Servlet & JSP (MVC Architecture)**, **Microsoft SQL Server (Recursive Self-Referencing Schema)**, and real-time bank transfer reconciliation via the **SePay VietQR Payment Gateway**.

---

## Documentation Hub for Developers & AI Agents

This repository includes dedicated technical documentation tailored for both engineers and AI pair programmers:

- **[AGENTS.md](./AGENTS.md)** — Architectural conventions, file hierarchy, coding rules, and development guidelines for AI assistants.
- **[CLAUDE.md](./CLAUDE.md)** — Quick-reference development cheat sheet, build commands, and execution standards for Claude Code.
- **[ARCHITECTURE.md](./ARCHITECTURE.md)** — System layered architecture, filter pipeline, session management, and SePay VietQR sequence diagrams.
- **[DATABASE.md](./DATABASE.md)** — Entity-Relationship (ER) diagram, table schemas, self-referencing `parentID` model, and dual deployment guides.
- **[API.md](./API.md)** — Complete catalog of Servlet endpoints, HTTP methods, action dispatchers, request/response models, and Webhook payloads.

---

## Key Features

### Customer Experience
- **Interactive Home & Hero Showcase**: High-definition hero video banner, dynamic category filter tabs (Men & Women collections).
- **Dynamic Recursive Lookbook**: Product detail pages dynamically render 3 to 4 multi-angle photography shots (Front view, Outfit styling, Fabric close-up, Motion fit) loaded from the recursive database schema.
- **Multi-Level Filtering & Pagination**: Standardized 10-item pagination across catalog browsing with active page indicators and quick jump input.
- **Offcanvas Cart & Wishlist**: Slide drawer shopping cart with instant quantity updates and persistent wishlist storage.
- **Real-Time VietQR Payment Gateway**: Generates precise banking QR codes with exact transfer amounts and order references; automatically marks orders as paid in real-time via SePay Webhook events.

### Administrative Management (Admin Portal)
- **Inventory & Catalog Control**: Paginated product management table with live stock status badges (In Stock, Low Stock, Out of Stock).
- **Product Lifecycle CRUD**: Add, edit pricing/descriptions/categories, and perform safe soft deletions.
- **Role-Based Access Control**: Protected admin routes strictly enforced via `AuthenticationFilter` and `AuthorizationFilter`.

---

## Technology Stack

| Layer | Technologies & Frameworks |
| :--- | :--- |
| **Backend Core** | Java EE 8 / Jakarta Servlet 3.1, JSP 2.3, JSTL 1.2 |
| **Architecture** | Model-View-Controller (MVC), Data Access Object (DAO) Pattern, DTO |
| **Database** | Microsoft SQL Server (Local instances & Somee Remote Cloud) |
| **Payment Integration** | SePay Webhook API, VietQR Banking Gateway (MBBank) |
| **Security** | SHA-256 Cryptographic Hashing (`PasswordUtils`), CSRF Protection (`CSRFUtils`), Servlet Filters |
| **Frontend UI** | HTML5 Semantic Markup, Vanilla CSS3, JavaScript (ES6+), Bootstrap 5.3, FontAwesome 6 |

---

## Installation & Getting Started

### 1. Prerequisites
- **Java Development Kit (JDK):** Java SE 8 or Java SE 11+
- **Database Server:** Microsoft SQL Server 2017+ (or Somee Cloud SQL Server)
- **Servlet Container:** Apache Tomcat 9.0+
- **IDE:** Apache NetBeans 12+, IntelliJ IDEA, or Eclipse

### 2. Database Initialization
- **Local SQL Server:** Open [`PRJ301_Ecommerce.sql`](./PRJ301_Ecommerce.sql) in SQL Server Management Studio (SSMS) and execute (**F5**).
- **Somee Cloud Hosting:** Open [`PRJ301_Ecommerce_Somee.sql`](./PRJ301_Ecommerce_Somee.sql), paste the content into Somee's *Manage SQL* console, and click **Run SQL**.

### 3. Environment Configuration (`.env`)
Create a `.env` file in the root directory (based on [`.env.example`](./.env.example)):

```ini
DB_HOST=localhost
DB_PORT=1433
DB_NAME=PRJ301_Ecommerce
DB_USERNAME=sa
DB_PASSWORD=your_database_password

SEPAY_API_TOKEN=your_sepay_token
SEPAY_WEBHOOK_SECRET=your_webhook_secret
SEPAY_BANK_NAME=MBBank
SEPAY_ACCOUNT_NUMBER=08222216167810
SEPAY_ACCOUNT_HOLDER=NGUYEN VAN QUOC BAO

SERVER_PORT=8080
PUBLIC_WEBHOOK_URL=http://localhost:8080/PRJ301-Assignment/api/sepay-webhook
```

### 4. Build & Deployment
1. Open the project in your IDE $\rightarrow$ **Clean and Build**.
2. Deploy the artifact to Apache Tomcat.
3. Navigate to: `http://localhost:8080/PRJ301-Assignment/home`

---

## Default Seed Accounts

| Role | Username | Password | Email | Access Scope |
| :--- | :--- | :--- | :--- | :--- |
| **Administrator** | `admin` | `12345` | `admin@gmail.com` | Full Administrative Dashboard & Management (`/admin/*`) |
| **Customer** | `user1` | `12345` | `usera@gmail.com` | Storefront, Cart, Checkout, and Order History |

*(All passwords are cryptographically hashed using SHA-256 with salt protection in the database)*

---

## License

This project is open-source software licensed under the **[MIT License](./LICENSE)**.