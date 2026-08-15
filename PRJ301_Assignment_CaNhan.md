# ĐỀ BÀI ASSIGNMENT (PHIÊN BẢN CÁ NHÂN)

**Môn học:** PRJ301 – Java Web Application Development (Phát triển ứng dụng Web Java JSP/Servlet)
**Hình thức:** Bài tập cá nhân (Individual Assignment)
**Số lượng:** 1 sinh viên / bài
**Tổng điểm:** 10 điểm — chỉ tính điểm chính (không có điểm cộng)
**Thời gian:** Theo lịch học 

## I. MỤC TIÊU
Sinh viên tự mình thiết kế và xây dựng hoàn chỉnh một ứng dụng Web bằng Java JSP/Servlet theo mô hình MVC-V2, sử dụng JDBC thuần để thao tác cơ sở dữ liệu (không dùng JPA/Hibernate), tích hợp đầy đủ các công nghệ back-end và front-end đã học trong môn PRJ301. Qua đó, sinh viên rèn luyện khả năng:
- Thiết kế và phát triển ứng dụng web theo kiến trúc phân tầng, hoàn toàn độc lập.
- Vận dụng các công nghệ Java EE (JSP, Servlet, EL, JSTL, JDBC, Filter...).
- Tích hợp các tính năng bảo mật cốt lõi: đăng nhập, đăng xuất, mã hoá mật khẩu, quản lý phiên.
- Trình bày, demo và bảo vệ toàn bộ sản phẩm trước giảng viên.

## II. YÊU CẦU CHUNG
### 2.1. Hình thức thực hiện
- Bài tập thực hiện cá nhân, 100% độc lập — không được chia sẻ, sao chép code từ bất kỳ ai.
- **Quy định bắt buộc (Hard Rule)**: Sinh viên phải tự mình thực hiện đầy đủ chức năng CRUD (Create – Read – Update – Delete) cho tối thiểu 6 models (entity/bảng dữ liệu) khác nhau trong hệ thống, cùng toàn bộ các thành phần MVC, Filter, Security liên quan.

### 2.2. Lĩnh vực ứng dụng gợi ý
Sinh viên được tự do chọn chủ đề, miễn là đủ độ phức tạp và có ít nhất 4 – 6 models/bảng dữ liệu (thu gọn từ quy mô nhóm 12 – 16 models cho phù hợp với khối lượng công việc cá nhân). Một số gợi ý:
- Hệ thống bán hàng / thương mại điện tử quy mô nhỏ (e-commerce)
- Hệ thống đặt phòng khách sạn / homestay
- Hệ thống quản lý học trực tuyến (LMS thu gọn)
- Hệ thống đặt lịch hẹn phòng khám / spa / salon
- Hệ thống quản lý nhà hàng / đặt bàn / gọi món
- Hệ thống ký túc xá / thuê trọ sinh viên
- Hệ thống quản lý câu lạc bộ / sự kiện / vé

Sinh viên có thể tự đề xuất chủ đề khác.
Sinh viên trình bày đề xuất chủ đề vào slot 12 và được giảng viên phê duyệt.

## III. YÊU CẦU KỸ THUẬT VÀ PHÂN BỔ ĐIỂM
Tổng: 10 điểm, chỉ tính điểm chính (không có điểm cộng / hạng mục khuyến khích). Chia thành hai nhóm: Front-end (2 điểm) và Back-end (8 điểm), toàn bộ đều là yêu cầu bắt buộc.

### 3.1. Front-end (2 điểm)
| STT | Công nghệ | Yêu cầu cụ thể | Điểm |
| --- | --- | --- | --- |
| 1 | HTML5 & CSS3 | Cấu trúc trang rõ ràng, semantic HTML; CSS tự viết cho giao diện riêng. | 0.4 |
| 2 | Bootstrap 5 | Responsive layout (grid, breakpoint); sử dụng component Bootstrap (navbar, card, modal, form, toast...). | 0.5 |
| 3 | JavaScript (ES6+) | Validation phía client; xử lý sự kiện; gọi API/Fetch; tương tác động (show/hide, filter, sort...). | 0.6 |
| 4 | UX/UI tổng thể | Giao diện thân thiện, đồng nhất, có logo/branding; trải nghiệm người dùng mượt mà. | 0.5 |
| **Tổng** | **Front-end** | | **2.0** |

### 3.2. Back-end (8 điểm) — chỉ điểm chính, bắt buộc, dùng JDBC
| STT | Công nghệ / Thành phần | Yêu cầu cụ thể (Bắt buộc) | Điểm |
| --- | --- | --- | --- |
| 1 | Kiến trúc MVC-V2 | • Tách biệt rõ ràng: Model – View – Controller.<br>• FrontController (DispatcherServlet) điều phối toàn bộ request.<br>• DAO/Service layer riêng biệt; không viết SQL/logic trong Servlet. | 2.0 |
| 2 | JSP & Servlet | • Servlet xử lý request/response (doGet, doPost).<br>• JSP chỉ chứa logic trình bày (không có Java code lớn, hạn chế tối đa scriptlet).<br>• Sử dụng RequestDispatcher, redirect, forward hợp lý. | 1.5 |
| 3 | EL & JSTL | • Dùng Expression Language (EL) thay vì scriptlet.<br>• JSTL: c:forEach, c:if, c:choose, c:url, fmt:formatDate, fmt:formatNumber... | 1.0 |
| 4 | JDBC (thuần, không dùng JPA/Hibernate) | • Kết nối CSDL bằng JDBC API (DriverManager hoặc Connection Pool - ví dụ DBCP/HikariCP).<br>• Sử dụng PreparedStatement cho mọi câu lệnh (chống SQL Injection).<br>• DAO pattern: mỗi model có 1 DAO riêng, đóng/đóng gói Connection đúng cách (try-with-resources).<br>• Không dùng @Entity/@Table hay JPQL — chỉ SQL thuần trong tầng DAO. | 1.0 |
| 5 | Filter | • AuthenticationFilter: kiểm tra session, chặn truy cập URL khi chưa đăng nhập.<br>• AuthorizationFilter: phân quyền theo role (Admin/User/Guest).<br>• Encoding Filter: đảm bảo UTF-8 toàn hệ thống. | 1.0 |
| 6 | Bảo mật & Quản lý phiên (Security) | • Đăng ký tài khoản (Register) với validate input server-side.<br>• Đăng nhập (Login) / Đăng xuất (Logout).<br>• Mã hoá mật khẩu bằng BCrypt hoặc SHA-256 (không lưu plain-text).<br>• Quản lý phiên (Session Management): tạo/huỷ session khi login/logout, session timeout, chặn truy cập trái phép.<br>• Chống CSRF cơ bản (CSRF token cho các form quan trọng). | 1.5 |
| **Tổng** | **Back-end** | | **8.0** |

⚠️ **Lưu ý:** Đây là phiên bản cá nhân — tất cả các hạng mục trên đều là điểm chính, không có điểm cộng. Tổng điểm tối đa là 10 điểm.

## IV. TÍNH NĂNG BẮT bắt buộc (DANH SÁCH CỐ ĐỊNH)
Ngoài phần CRUD của các models tự chọn, hệ thống bắt buộc phải có đầy đủ các chức năng nền tảng sau, không phụ thuộc vào chủ đề:
- Đăng ký tài khoản (Register) — validate input server-side.
- Đăng nhập (Login).
- Đăng xuất (Logout).
- Mã hoá mật khẩu (BCrypt hoặc SHA-256), không lưu mật khẩu dạng plain-text.
- Quản lý phiên (Session Management): tạo session khi đăng nhập, huỷ session khi đăng xuất, session timeout.
- Phân quyền (Authorization) theo role — tối thiểu Admin và User.
- AuthenticationFilter chặn truy cập URL khi chưa đăng nhập.
- AuthorizationFilter chặn truy cập chức năng không đúng quyền.
- Encoding Filter đảm bảo UTF-8 toàn hệ thống.
- Chống CSRF cơ bản cho các form quan trọng (đổi mật khẩu, thanh toán, xoá dữ liệu...).
- CRUD đầy đủ cho tối thiểu 4 – 6 models qua JDBC + DAO pattern.

## V. TIÊU CHÍ CHẤM ĐIỂM VÀ BẢO VỆ
### 5.1. Bảng điểm tổng hợp
| Hạng mục | Hình thức đánh giá | Điểm tối đa |
| --- | --- | --- |
| Sản phẩm kỹ thuật (code + demo) | GV review code + chạy demo trực tiếp | 7.0 |
| Trình bày & bảo vệ (vấn đáp) | Video thuyết trình<br>Hỏi đáp trực tiếp | 3.0 |
| **Tổng** | | **10.0** |

### 5.2. Lưu ý khi bảo vệ
- Sinh viên phải có khả năng giải thích toàn bộ code của mình, không có phần "của người khác" để đổ lỗi.
- Giảng viên có thể yêu cầu sửa code trực tiếp trong buổi bảo vệ.
- Không demo được chức năng nào thì bị trừ điểm trực tiếp vào chức năng đó.
- Nếu phát hiện sao chép code từ sinh viên khác, cả hai bên liên quan nhận điểm 0.

## VI. QUY ĐỊNH VÀ THỜI HẠN
### 6.1. Mốc thời gian
| Tuần | Hoạt động | Hình thức |
| --- | --- | --- |
| 13/08/2022 | Nộp đề xuất chủ đề (Topic Proposal) | Form online |
| 17/08/2022 | Checkpoint 1: ERD, thiết kế DB, wireframe UI | Demo + nộp tài liệu sơ bộ |
| 22/08/2022 | Checkpoint 2: CRUD cơ bản hoàn chỉnh, tích hợp security & filter | Demo trực tiếp với GV |
| 22/08/2022 | Nộp toàn bộ (GitHub + tài liệu + video) và bảo vệ, vấn đáp | LMS submission + trình bày trực tiếp |

### 6.2. Quy định chung
- Nộp trễ hạn không nhận bài.
- Mọi trao đổi/thắc mắc thực hiện qua diễn đàn môn học hoặc email giảng viên.
- Sử dụng Git/GitHub để quản lý phiên bản; lịch sử commit phản ánh tiến độ thực tế.
- Không sử dụng framework nặng (Spring Boot, Spring MVC); chỉ dùng Java EE thuần + thư viện hỗ trợ.
- Không sử dụng JPA/Hibernate — bắt buộc thao tác CSDL bằng JDBC thuần.

## VII. YÊU CẦU VỀ TÀI LIỆU NỘP
### 7.1. Source code
- Toàn bộ project, đẩy lên GitHub (public repo), upload lên LMS của trường.
- File README.md hướng dẫn cài đặt và chạy project.
- Script SQL khởi tạo database (schema + dữ liệu mẫu).

### 7.2. Video demo
- Thời lượng không giới hạn, tự demo toàn bộ chức năng.
- Upload lên YouTube (unlisted) và đính kèm link vào tài liệu.

## VIII. THƯ VIỆN GỢI Ý (KHÔNG TÍNH ĐIỂM CỘNG)
Các thư viện dưới đây chỉ mang tính tham khảo, hỗ trợ triển khai — không phải điểm cộng riêng, vì đã được tính gộp vào phần điểm chính ở Mục III.
- `jBCrypt` (org.mindrot:jbcrypt) — mã hoá mật khẩu.
- `HikariCP` hoặc `Apache Commons DBCP` — connection pool cho JDBC.
- `Jackson` (com.fasterxml.jackson.core) — JSON parsing nếu dùng AJAX/Fetch.
- `Slf4j + Logback` — logging (khuyến khích, không bắt buộc).

---
Chúc các bạn thực hiện thành công!
Mọi thắc mắc vui lòng liên hệ giảng viên phụ trách môn học.
