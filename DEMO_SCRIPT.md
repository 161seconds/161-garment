# 🎬 KỊCH BẢN VIDEO DEMO — ONE61 GARMENTORY (PRJ301)

* **Dự án:** ONE61 Garmentory — Minimalist LifeWear E-Commerce Web Application
* **Công nghệ:** Java Servlet / JSP, SQL Server, MVC Architecture, Cổng thanh toán VietQR SePay
* **Thời lượng đề xuất:** 4:00 – 5:00 phút
* **Định dạng video:** 1080p 60fps (hoặc 2K)

---

## 🛠️ Chuẩn Bị Trước Khi Bấm Quay (Checklist)

- [ ] **Khởi động server:** Chạy Tomcat và kiểm tra kết nối CSDL (Local SQL Server hoặc Somee).
- [ ] **Tài khoản test:**
  - Tài khoản Admin: `admin` / mật khẩu quản trị.
  - Tài khoản Khách hàng: `user01` / mật khẩu (hoặc sẵn sàng tạo mới trong video).
- [ ] **Dọn dẹp giỏ hàng:** Xóa trống giỏ hàng trước khi bắt đầu quay.
- [ ] **Trình duyệt:** Thu phóng ở 100%, ẩn bớt thanh Bookmark, mở sẵn tab `http://localhost:8080/PRJ301-Assignment/home.jsp` (hoặc domain deploy).
- [ ] **Phần mềm quay:** Mở OBS Studio / Bandicam / CapCut PC, kiểm tra micro rõ ràng và không bị rè.

---

## 📋 CHI TIẾT KỊCH BẢN THEO PHÂN CẢNH

### 📌 PHẦN 1: GIỚI THIỆU TỔNG QUAN (0:00 – 0:30)

| Thời gian | Hành động trên màn hình (Visual / Action) | Lời thoại thuyết minh (Voiceover) |
| :--- | :--- | :--- |
| **0:00 – 0:15** | Mở trang chủ (`home.jsp`), cuộn chuột nhẹ nhàng từ trên xuống dưới để thấy giao diện banner video, slider danh mục thời trang và danh sách sản phẩm nổi bật. | *"Xin chào thầy cô và các bạn. Hôm nay em xin phép được demo dự án web Thương mại Điện tử thời trang tối giản có tên là **ONE61 Garmentory**, được xây dựng trên nền tảng Java Servlet, JSP theo mô hình kiến trúc MVC và hệ quản trị cơ sở dữ liệu SQL Server."* |
| **0:15 – 0:30** | Lướt qua thanh header, logo, menu điều hướng (Nam / Nữ / Bộ sưu tập) và thanh tìm kiếm. | *"Dự án được lấy cảm hứng từ phong cách LifeWear hiện đại, cung cấp đầy đủ hai phân hệ chính: Trải nghiệm mua sắm mượt mà cho **Khách hàng** và Hệ thống quản trị toàn diện cho **Quản trị viên (Admin)**."* |

---

### 📌 PHẦN 2: TRẢI NGHIỆM MUA SẮM CỦA KHÁCH HÀNG (0:30 – 2:45)

#### 2.1. Khám phá Sản phẩm & Bộ lọc (0:30 – 1:05)
| Thời gian | Hành động trên màn hình (Visual / Action) | Lời thoại thuyết minh (Voiceover) |
| :--- | :--- | :--- |
| **0:30 – 0:50** | 1. Bấm vào menu **Sản phẩm / Catalog** (`product.jsp`).<br>2. Bấm lọc thử theo **Danh mục** (Áo thun, Sơ mi, Quần...).<br>3. Nhập tìm kiếm 1 từ khóa (ví dụ: *"Áo"* hoặc *"Linen"*).<br>4. Thử chọn sắp xếp theo giá (Tăng dần / Giảm dần) và bấm chuyển trang phân trang. | *"Đầu tiên là trang danh mục sản phẩm. Khách hàng có thể dễ dàng tìm kiếm theo từ khóa, lọc theo danh mục cho Nam và Nữ, hoặc sắp xếp theo mức giá. Hệ thống có tích hợp phân trang chuẩn 10 sản phẩm mỗi trang giúp tối ưu hiệu năng tải trang."* |
| **0:50 – 1:05** | Hover chuột vào một vài thẻ sản phẩm (để thấy hiệu ứng chuyển ảnh đổi góc nhìn cover/content), sau đó click vào 1 sản phẩm để mở trang **Chi tiết sản phẩm**. | *"Khi rê chuột vào từng thẻ sản phẩm, giao diện sẽ tự động chuyển đổi ảnh góc chụp khác nhau rất trực quan. Giờ chúng ta sẽ truy cập vào trang chi tiết của một sản phẩm."* |

#### 2.2. Chi tiết Sản phẩm & Giỏ hàng (1:05 – 1:35)
| Thời gian | Hành động trên màn hình (Visual / Action) | Lời thoại thuyết minh (Voiceover) |
| :--- | :--- | :--- |
| **1:05 – 1:20** | 1. Bấm qua các ảnh thumbnail nhỏ trong Lookbook Gallery để thấy ảnh lớn thay đổi đa góc độ.<br>2. Chọn **Kích thước (Size)** (M, L), chọn **Màu sắc**, tăng giảm **Số lượng**.<br>3. Bấm **"Thêm vào giỏ hàng"** (Add to Cart) để hiện toast thông báo thành công. | *"Trang chi tiết cung cấp bộ sưu tập hình ảnh đa góc chụp của sản phẩm. Khách hàng có thể lựa chọn kích thước, màu sắc và số lượng mong muốn. Khi nhấn 'Thêm vào giỏ', hệ thống sẽ gửi thông báo và cập nhật số lượng ngay trên biểu tượng giỏ hàng."* |
| **1:20 – 1:35** | Click mở **Giỏ hàng** (`cart.jsp`). Thử tăng số lượng 1 món (tổng tiền tự động cập nhật). | *"Tại trang giỏ hàng, người dùng có thể xem lại các sản phẩm đã chọn, điều chỉnh số lượng — tổng tiền sẽ được tự động tính toán lại theo thời gian thực — hoặc xóa các món không cần thiết."* |

#### 2.3. Đăng nhập & Quy trình Thanh toán VietQR SePay (1:35 – 2:45) ⭐ *(Điểm nhấn)*
| Thời gian | Hành động trên màn hình (Visual / Action) | Lời thoại thuyết minh (Voiceover) |
| :--- | :--- | :--- |
| **1:35 – 1:55** | 1. Bấm nút **"Tiến hành đặt hàng"**.<br>2. Hệ thống chuyển hướng sang `login.jsp` (do chưa đăng nhập).<br>3. Nhập thông tin tài khoản Khách hàng để đăng nhập. | *"Khi tiến hành thanh toán, hệ thống bảo mật bằng Authentication Filter sẽ yêu cầu người dùng đăng nhập. Mật khẩu của người dùng được mã hóa bằng thuật toán băm SHA-256 an toàn."* |
| **1:55 – 2:20** | 1. Chuyển vào trang **Checkout** (`checkout.jsp`).<br>2. Điền thông tin nhận hàng (Họ tên, SĐT, Địa chỉ).<br>3. Chọn phương thức thanh toán: **Chuyển khoản QR (VietQR / SePay)**.<br>4. Nhấn **"Đặt hàng"**. | *"Tại trang thanh toán, khách hàng điền địa chỉ giao hàng và có thể lựa chọn thanh toán COD hoặc Chuyển khoản VietQR tự động qua cổng SePay. Em sẽ chọn phương thức chuyển khoản QR."* |
| **2:20 – 2:45** | 1. Màn hình hiện mã **VietQR** cùng nội dung chuyển khoản và số tiền chính xác.<br>2. *(Giả lập webhook / thanh toán)*: Hệ thống tự động nhận diện giao dịch thành công và chuyển sang trang **Order Success** (`order-success.jsp`).<br>3. Bấm vào **Lịch sử đơn hàng** (`my-orders.jsp`) để thấy đơn hàng mới nhất đang ở trạng thái 'Đã thanh toán'. | *"Mã VietQR động được tạo kèm nội dung chuyển khoản tương ứng với mã đơn hàng. Hệ thống tích hợp cơ chế Polling và Webhook, ngay khi tiền về tài khoản, trang web sẽ tự động xác nhận thành công mà người dùng không cần bấm f5 hay thao tác thủ công nào. Khách hàng cũng có thể vào mục Đơn hàng của tôi để theo dõi tiến độ đơn hàng."* |

---

### 📌 PHẦN 3: PHÂN HỆ QUẢN TRỊ ADMIN (2:45 – 4:15)

#### 3.1. Phân quyền & Dashboard Thống kê (2:45 – 3:15)
| Thời gian | Hành động trên màn hình (Visual / Action) | Lời thoại thuyết minh (Voiceover) |
| :--- | :--- | :--- |
| **2:45 – 3:00** | 1. Đăng xuất tài khoản khách hàng.<br>2. Đăng nhập bằng tài khoản **Admin**.<br>3. Truy cập vào trang Quản trị (`/admin/dashboard.jsp`). | *"Tiếp theo, chúng ta cùng khám phá phân hệ Quản trị viên (Admin). Toàn bộ các đường dẫn `/admin/*` đều được bảo vệ nghiêm ngặt bằng Authorization Filter, chỉ tài khoản có Role Admin mới có thể truy cập."* |
| **3:00 – 3:15** | Cuộn xem trang Dashboard: Thẻ Card số liệu (Tổng doanh thu, Tổng đơn hàng, Sản phẩm, Khách hàng) và biểu đồ thống kê. | *"Đây là trang Dashboard tổng quan, hiển thị các chỉ số kinh doanh quan trọng như tổng doanh thu, số lượng đơn hàng, số khách hàng mới và biểu đồ thống kê trực quan."* |

#### 3.2. Quản lý Sản phẩm & Danh mục (3:15 – 3:45)
| Thời gian | Hành động trên màn hình (Visual / Action) | Lời thoại thuyết minh (Voiceover) |
| :--- | :--- | :--- |
| **3:15 – 3:35** | 1. Vào mục **Quản lý sản phẩm** (`manage-product.jsp`).<br>2. Bấm **"Thêm mới sản phẩm"** (`form-product.jsp`).<br>3. Nhập thử tên sản phẩm, chọn danh mục, điền giá, chọn ảnh bìa.<br>4. Nhấn Lưu để thấy sản phẩm hiển thị trong danh sách. | *"Ở mục Quản lý Sản phẩm, Admin có thể xem toàn bộ kho hàng, tìm kiếm, sửa hoặc thêm mới sản phẩm. Form thêm sản phẩm cho phép thiết lập danh mục, giá tiền, số lượng tồn kho và tải lên các hình ảnh bìa cũng như ảnh chi tiết đa góc độ."* |
| **3:35 – 3:45** | Bấm qua mục **Quản lý danh mục** (`manage-category.jsp`) và **Quản lý người dùng** (`manage-user.jsp`) lướt nhanh. | *"Admin cũng có thể quản lý các Danh mục thời trang và theo dõi, phân quyền danh sách Người dùng trong hệ thống."* |

#### 3.3. Quản lý & Xử lý Đơn hàng (3:45 – 4:15)
| Thời gian | Hành động trên màn hình (Visual / Action) | Lời thoại thuyết minh (Voiceover) |
| :--- | :--- | :--- |
| **3:45 – 4:05** | 1. Vào mục **Quản lý đơn hàng** (`manage-order.jsp`).<br>2. Mở xem chi tiết đơn hàng vừa tạo ở bước Khách hàng (`order-detail.jsp`).<br>3. Xem thông tin sản phẩm, lịch sử giao dịch.<br>4. Cập nhật trạng thái đơn sang **"Đang giao hàng"** (Shipping) hoặc **"Hoàn thành"** (Delivered). | *"Tại mục Quản lý Đơn hàng, Admin có thể kiểm tra danh sách tất cả các đơn mua, xem chi tiết từng món hàng, địa chỉ giao và trạng thái thanh toán. Tại đây, Admin có thể cập nhật trạng thái đơn sang Đang giao hàng hoặc Đã giao thành công."* |
| **4:05 – 4:15** | Quay lại danh sách đơn hàng để thấy trạng thái đã cập nhật đồng bộ. | *"Trạng thái đơn hàng sẽ ngay lập tức được đồng bộ sang trang tài khoản của khách hàng."* |

---

### 📌 PHẦN 4: TỔNG KẾT & LỜI KẾT (4:15 – 4:35)

| Thời gian | Hành động trên màn hình (Visual / Action) | Lời thoại thuyết minh (Voiceover) |
| :--- | :--- | :--- |
| **4:15 – 4:35** | Quay trở lại trang chủ (`home.jsp`), cuộn mượt mà xuống phần footer có thông tin sinh viên / nhóm thực hiện. | *"Vừa rồi là toàn bộ phần demo các chức năng chính của dự án ONE61 Garmentory. Dự án đã hoàn thiện đầy đủ luồng mua sắm, thanh toán tự động và hệ thống quản trị theo đúng chuẩn đồ án PRJ301. Cảm ơn thầy cô và các bạn đã theo dõi!"* |

---

## 📺 MẪU TIÊU ĐỀ & MÔ TẢ YOUTUBE (COPY & PASTE)

### Tiêu đề (Title):
```text
[PRJ301] Demo Đồ Án Website Thương Mại Điện Tử ONE61 Garmentory (Java Servlet / JSP / VietQR)
```

### Mô tả (Description):
```text
Dự án Web Thương Mại Điện Tử Thời Trang Tối Giản — ONE61 Garmentory
Môn học: PRJ301 — Java Web Application Development
Công nghệ sử dụng: Java EE (Servlet, JSP, JSTL), SQL Server, Bootstrap 5, SePay VietQR Payment Gateway.

📌 TIMESTAMPS:
0:00 - Giới thiệu tổng quan dự án
0:30 - Khám phá sản phẩm & Bộ lọc tìm kiếm
1:05 - Chi tiết sản phẩm & Giỏ hàng
1:35 - Đăng nhập & Đặt hàng
2:20 - Thanh toán tự động VietQR (SePay) & Lịch sử đơn hàng
2:45 - Phân hệ Admin & Dashboard thống kê
3:15 - Quản lý Sản phẩm & Danh mục
3:45 - Quản lý & Xử lý Đơn hàng
4:15 - Tổng kết
```
