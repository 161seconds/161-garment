USE master;
GO

-- Drop database if it exists
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'PRJ301_Ecommerce')
BEGIN
    ALTER DATABASE PRJ301_Ecommerce SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE PRJ301_Ecommerce;
END
GO

CREATE DATABASE PRJ301_Ecommerce;
GO

USE PRJ301_Ecommerce;
GO

-- 1. Role Table
CREATE TABLE [Role] (
    roleID VARCHAR(20) PRIMARY KEY,
    roleName NVARCHAR(50) NOT NULL
);

-- 2. User Table
CREATE TABLE [User] (
    userID VARCHAR(50) PRIMARY KEY,
    fullName NVARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    roleID VARCHAR(20) FOREIGN KEY REFERENCES [Role](roleID),
    status BIT DEFAULT 1,
    createDate DATETIME DEFAULT GETDATE()
);

-- 3. Category Table
CREATE TABLE [Category] (
    categoryID VARCHAR(20) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    status BIT DEFAULT 1
);

-- 4. Product Table (Self-Referencing / De Quy Cha - Con)
-- parentID IS NULL: San pham cha (Anh bia Cover)
-- parentID IS NOT NULL: San pham con (Anh chi tiet Content)
CREATE TABLE [Product] (
    productID VARCHAR(50) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(18, 2) NOT NULL,
    quantity INT DEFAULT 0,
    image VARCHAR(255),
    categoryID VARCHAR(20) FOREIGN KEY REFERENCES [Category](categoryID),
    parentID VARCHAR(50) FOREIGN KEY REFERENCES [Product](productID) NULL,
    createDate DATETIME DEFAULT GETDATE(),
    status BIT DEFAULT 1
);

-- 5. Address Table
CREATE TABLE [Address] (
    addressID INT IDENTITY(1,1) PRIMARY KEY,
    userID VARCHAR(50) FOREIGN KEY REFERENCES [User](userID),
    receiverName NVARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    addressLine NVARCHAR(255) NOT NULL,
    isDefault BIT DEFAULT 0
);

-- 6. Order Table
CREATE TABLE [Order] (
    orderID VARCHAR(50) PRIMARY KEY,
    userID VARCHAR(50) FOREIGN KEY REFERENCES [User](userID),
    orderDate DATETIME DEFAULT GETDATE(),
    totalMoney DECIMAL(18, 2) NOT NULL,
    shippingAddress NVARCHAR(255) NOT NULL,
    note NVARCHAR(500),
    status VARCHAR(20) DEFAULT 'PENDING' -- PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED
);

-- 7. OrderDetail Table
CREATE TABLE [OrderDetail] (
    orderID VARCHAR(50) FOREIGN KEY REFERENCES [Order](orderID),
    productID VARCHAR(50) FOREIGN KEY REFERENCES [Product](productID),
    price DECIMAL(18, 2) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (orderID, productID)
);

-- 8. Payment Table
CREATE TABLE [Payment] (
    paymentID VARCHAR(50) PRIMARY KEY,
    orderID VARCHAR(50) FOREIGN KEY REFERENCES [Order](orderID),
    paymentMethod VARCHAR(50) NOT NULL, -- COD, VNPAY, MOMO
    paymentDate DATETIME DEFAULT GETDATE(),
    amount DECIMAL(18, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING' -- PENDING, SUCCESS, FAILED
);

-- 9. Wishlist Table
CREATE TABLE [Wishlist] (
    userID VARCHAR(50) FOREIGN KEY REFERENCES [User](userID),
    productID VARCHAR(50) FOREIGN KEY REFERENCES [Product](productID),
    addedDate DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (userID, productID)
);

-- 10. CartItem Table (Persistent Shopping Cart)
CREATE TABLE [CartItem] (
    cartItemID INT IDENTITY(1,1) PRIMARY KEY,
    userID VARCHAR(50) FOREIGN KEY REFERENCES [User](userID) ON DELETE CASCADE,
    productID VARCHAR(50) FOREIGN KEY REFERENCES [Product](productID) ON DELETE CASCADE,
    quantity INT NOT NULL DEFAULT 1,
    addedDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_Cart_User_Product UNIQUE (userID, productID)
);
GO

-- =========================================
-- INSERT SAMPLE DATA
-- =========================================

-- Roles
INSERT INTO [Role] (roleID, roleName) VALUES ('ADMIN', N'Quản trị viên');
INSERT INTO [Role] (roleID, roleName) VALUES ('CUS', N'Khách hàng');

-- Users (Mật khẩu default: 12345, đã được băm bằng SHA-256)
INSERT INTO [User] (userID, fullName, password, email, phone, roleID, status) 
VALUES ('admin', N'Quản Trị Viên', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 'admin@gmail.com', '0123456789', 'ADMIN', 1);

INSERT INTO [User] (userID, fullName, password, email, phone, roleID, status) 
VALUES ('user1', N'Nguyễn Văn A', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 'usera@gmail.com', '0987654321', 'CUS', 1);

-- Categories (Nam & Nữ)
INSERT INTO [Category] (categoryID, name, status) VALUES 
('MEN_01', N'Áo Sơ Mi Nam', 1),
('MEN_02', N'Áo Khoác Nam', 1),
('MEN_03', N'Quần Dài Nam', 1),
('MEN_04', N'Quần Jeans Nam', 1),
('WOMEN_01', N'Áo Sơ Mi & Blouse Nữ', 1),
('WOMEN_02', N'Áo Khoác Nữ', 1),
('WOMEN_03', N'Quần & Váy Nữ', 1),
('WOMEN_04', N'Shorts & Culottes Nữ', 1);

-- =======================================================
-- 1. SAN PHAM CHA (24 Master Products with Cover Images)
-- parentID = NULL
-- =======================================================
INSERT INTO [Product] (productID, name, description, price, quantity, image, categoryID, parentID, status) VALUES 
-- MEN: Sơ Mi (MEN_01)
('PROD01', N'Áo Sơ Mi Oxford Nam Dài Tay', N'Chất vải cotton Oxford dệt chéo cao cấp, phom dáng chuẩn công sở và dạo phố.', 599000, 50, 'products/men/cover/cover-shirts-men-1.avif', 'MEN_01', NULL, 1),
('PROD02', N'Áo Sơ Mi Linen Cổ Tàu Thoáng Khí', N'Vải sợi lanh Linen 100% tự nhiên thoáng mát, mang lại cảm giác dễ chịu ngày hè.', 699000, 40, 'products/men/cover/cover-shirts-men-2.avif', 'MEN_01', NULL, 1),
('PROD03', N'Áo Sơ Mi Cộc Tay Phom Rộng', N'Thiết kế ngắn tay trẻ trung, phom suông rộng rãi thoải mái cho các hoạt động ngoài trời.', 499000, 35, 'products/men/cover/cover-shirts-men-3.avif', 'MEN_01', NULL, 1),

-- MEN: Áo Khoác (MEN_02)
('PROD04', N'Áo Khoác Gió Nam Chống Thấm Nước', N'Công nghệ BlockTech cản gió và chống nước tối ưu, siêu nhẹ và dễ gấp gọn.', 799000, 30, 'products/men/cover/cover-outerwear-men-1.avif', 'MEN_02', NULL, 1),
('PROD05', N'Áo Khoác Blazer Nam Công Sở', N'Thiết kế may đo tỉ mỉ, tôn dáng lịch lãm và sang trọng cho quý ông hiện đại.', 1299000, 25, 'products/men/cover/cover-outerwear-men-2.avif', 'MEN_02', NULL, 1),
('PROD06', N'Áo Khoác Bomber Kaki Dáng Trẻ', N'Chất kaki cao cấp đứng phom, phong cách street-style năng động và cá tính.', 899000, 40, 'products/men/cover/cover-outerwear-men-3.avif', 'MEN_02', NULL, 1),

-- MEN: Quần Dài (MEN_03)
('PROD07', N'Quần Smart Pants Co Giãn 2 Chiều', N'Quần âu dáng slim fit với lưng thun ẩn thoải mái, không nhăn sau khi giặt.', 799000, 45, 'products/men/cover/cover-pants-men-1.avif', 'MEN_03', NULL, 1),
('PROD08', N'Quần Kaki Chino Dáng Suông Nam', N'Chất vải cotton pha spandex co giãn, phom regular fit chuẩn mực cho mọi dịp.', 699000, 35, 'products/men/cover/cover-pants-men-2.avif', 'MEN_03', NULL, 1),
('PROD09', N'Quần Jogger Kaki Túi Hộp Năng Động', N'Thiết kế túi hộp tiện dụng, ống bo thun thể thao khỏe khoắn.', 599000, 50, 'products/men/cover/cover-pants-men-3.avif', 'MEN_03', NULL, 1),

-- MEN: Quần Jeans (MEN_04)
('PROD10', N'Quần Jeans Nam Slim Fit Co Giãn', N'Denim Nhật Bản cao cấp dệt sợi đàn hồi, bền màu và mềm mại với làn da.', 899000, 40, 'products/men/cover/cover-jeans-men-1.avif', 'MEN_04', NULL, 1),
('PROD11', N'Quần Jeans Ống Suông Regular Vintage', N'Xử lý wash màu cổ điển thời thượng, tôn dáng chân dài và nam tính.', 949000, 30, 'products/men/cover/cover-jeans-men-2.avif', 'MEN_04', NULL, 1),
('PROD12', N'Quần Jeans Relaxed Fit Dáng Rộng', N'Form ống rộng thoải mái tối đa cho ngày dài vận động.', 849000, 35, 'products/men/cover/cover-jeans-men-3.avif', 'MEN_04', NULL, 1),

-- WOMEN: Sơ Mi & Blouse (WOMEN_01)
('PROD13', N'Áo Sơ Mi Rayon Nữ Mềm Rủ', N'Chất lụa Rayon cao cấp chống nhăn, rủ nhẹ nhàng tôn vẻ đẹp thanh tao.', 549000, 50, 'products/women/cover/cover-shirt-and-blouses-women-1.avif', 'WOMEN_01', NULL, 1),
('PROD14', N'Áo Blouse Cổ Thắt Nơ Nữ Tính', N'Điểm nhấn cổ nơ duyên dáng, dễ dàng kết hợp cùng chân váy hoặc quần âu.', 599000, 40, 'products/women/cover/cover-shirt-and-blouses-women-2.avif', 'WOMEN_01', NULL, 1),
('PROD15', N'Áo Sơ Mi Vải Đũi Cổ Chữ V', N'Vải đũi tự nhiên mát lạnh, phom suông phóng khoáng chuẩn phong cách LifeWear.', 499000, 35, 'products/women/cover/cover-shirt-and-blouses-women-3.avif', 'WOMEN_01', NULL, 1),

-- WOMEN: Áo Khoác (WOMEN_02)
('PROD16', N'Áo Khoác Chống Tia UV AirSense Nữ', N'Chỉ số chống nắng UPF 50+, công nghệ dệt siêu nhẹ bảo vệ làn da tuyệt đối.', 699000, 50, 'products/women/cover/cover-outerwear-women-1.avif', 'WOMEN_02', NULL, 1),
('PROD17', N'Áo Khoác Dạ Tweed Sang Trọng', N'Vải dạ dệt kim ánh kim sang trọng, viền chỉ tỉ mỉ chuẩn phong cách Parisian.', 1399000, 20, 'products/women/cover/cover-outerwear-women-2.avif', 'WOMEN_02', NULL, 1),
('PROD18', N'Áo Khoác Trench Coat Dáng Dài', N'Phom dáng trench coat kinh điển, chống thấm nước nhẹ và cản gió tốt.', 1599000, 25, 'products/women/cover/cover-outerwear-women-3.avif', 'WOMEN_02', NULL, 1),

-- WOMEN: Quần & Váy (WOMEN_03)
('PROD19', N'Quần Ống Suông Xếp Ly Pleated Pants', N'Thiết kế xếp ly tinh tế tạo hiệu ứng kéo dài chân, chất vải rủ nhẹ nhàng.', 799000, 45, 'products/women/cover/cover-bottom-women-1.avif', 'WOMEN_03', NULL, 1),
('PROD20', N'Chân Váy Midi Dáng Chữ A Tôn Dáng', N'Phom chữ A nhẹ nhàng che khuyết điểm, cạp cao tôn vòng eo thon gọn.', 649000, 40, 'products/women/cover/cover-bottom-women-2.avif', 'WOMEN_03', NULL, 1),
('PROD21', N'Quần Tây Nữ Ống Đứng Ankle Pants', N'Chiều dài ngang mắt cá chân thanh thoát, lưng co giãn tiện lợi cả ngày làm việc.', 749000, 35, 'products/women/cover/cover-bottom-women-3.avif', 'WOMEN_03', NULL, 1),

-- WOMEN: Shorts & Culottes (WOMEN_04)
('PROD22', N'Quần Shorts Kaki Lưng Cao Nữ', N'Chất kaki co giãn nhẹ, cạp cao tôn dáng, năng động khi phối cùng áo thun và sơ mi.', 449000, 50, 'products/women/cover/cover-shorts-and-culott-1.avif', 'WOMEN_04', NULL, 1),
('PROD23', N'Quần Giả Váy Xếp Nếp Thời Thượng', N'Thiết kế xếp nếp trẻ trung, vừa kín đáo vừa phong cách cho phái đẹp.', 499000, 40, 'products/women/cover/cover-shorts-and-culott-2.avif', 'WOMEN_04', NULL, 1),
('PROD24', N'Quần Culottes Ống Rộng Vải Linen', N'Ống rộng bay bổng, chất vải lanh tự nhiên mang lại sự thư thái tuyệt đối.', 549000, 30, 'products/women/cover/cover-shorts-and-culott-3.avif', 'WOMEN_04', NULL, 1);

-- =======================================================
-- 2. SAN PHAM CON (94 Child Products with Content Images)
-- parentID = 'PRODxx'
-- =======================================================
INSERT INTO [Product] (productID, name, description, price, quantity, image, categoryID, parentID, status) VALUES 
-- PROD01 (4 content angles)
('PROD01_01', N'Áo Sơ Mi Oxford Nam - Góc 1', N'Chi tiết mặt trước', 599000, 50, 'products/men/content/content-shirts-men-1-01.avif', 'MEN_01', 'PROD01', 1),
('PROD01_02', N'Áo Sơ Mi Oxford Nam - Góc 2', N'Phối đồ người mẫu', 599000, 50, 'products/men/content/content-shirts-men-1-02.avif', 'MEN_01', 'PROD01', 1),
('PROD01_03', N'Áo Sơ Mi Oxford Nam - Góc 3', N'Cận cảnh chất vải', 599000, 50, 'products/men/content/content-shirts-men-1-03.avif', 'MEN_01', 'PROD01', 1),
('PROD01_04', N'Áo Sơ Mi Oxford Nam - Góc 4', N'Chi tiết form dáng', 599000, 50, 'products/men/content/content-shirts-men-1-04.avif', 'MEN_01', 'PROD01', 1),

-- PROD02 (4 content angles)
('PROD02_01', N'Áo Sơ Mi Linen Cổ Tàu - Góc 1', N'Chi tiết mặt trước', 699000, 40, 'products/men/content/content-shirts-men-2-01.avif', 'MEN_01', 'PROD02', 1),
('PROD02_02', N'Áo Sơ Mi Linen Cổ Tàu - Góc 2', N'Phối đồ người mẫu', 699000, 40, 'products/men/content/content-shirts-men-2-02.avif', 'MEN_01', 'PROD02', 1),
('PROD02_03', N'Áo Sơ Mi Linen Cổ Tàu - Góc 3', N'Cận cảnh chất vải', 699000, 40, 'products/men/content/content-shirts-men-2-03.avif', 'MEN_01', 'PROD02', 1),
('PROD02_04', N'Áo Sơ Mi Linen Cổ Tàu - Góc 4', N'Chi tiết form dáng', 699000, 40, 'products/men/content/content-shirts-men-2-04.avif', 'MEN_01', 'PROD02', 1),

-- PROD03 (4 content angles)
('PROD03_01', N'Áo Sơ Mi Cộc Tay - Góc 1', N'Chi tiết mặt trước', 499000, 35, 'products/men/content/content-shirts-men-3-01.avif', 'MEN_01', 'PROD03', 1),
('PROD03_02', N'Áo Sơ Mi Cộc Tay - Góc 2', N'Phối đồ người mẫu', 499000, 35, 'products/men/content/content-shirts-men-3-02.avif', 'MEN_01', 'PROD03', 1),
('PROD03_03', N'Áo Sơ Mi Cộc Tay - Góc 3', N'Cận cảnh chất vải', 499000, 35, 'products/men/content/content-shirts-men-3-03.avif', 'MEN_01', 'PROD03', 1),
('PROD03_04', N'Áo Sơ Mi Cộc Tay - Góc 4', N'Chi tiết form dáng', 499000, 35, 'products/men/content/content-shirts-men-3-04.avif', 'MEN_01', 'PROD03', 1),

-- PROD04 (4 content angles)
('PROD04_01', N'Áo Khoác Gió Nam - Góc 1', N'Chi tiết mặt trước', 799000, 30, 'products/men/content/content-outerwear-men-1-01.avif', 'MEN_02', 'PROD04', 1),
('PROD04_02', N'Áo Khoác Gió Nam - Góc 2', N'Phối đồ người mẫu', 799000, 30, 'products/men/content/content-outerwear-men-1-02.avif', 'MEN_02', 'PROD04', 1),
('PROD04_03', N'Áo Khoác Gió Nam - Góc 3', N'Cận cảnh chất vải', 799000, 30, 'products/men/content/content-outerwear-men-1-03.avif', 'MEN_02', 'PROD04', 1),
('PROD04_04', N'Áo Khoác Gió Nam - Góc 4', N'Chi tiết form dáng', 799000, 30, 'products/men/content/content-outerwear-men-1-04.avif', 'MEN_02', 'PROD04', 1),

-- PROD05 (4 content angles)
('PROD05_01', N'Áo Khoác Blazer Nam - Góc 1', N'Chi tiết mặt trước', 1299000, 25, 'products/men/content/content-outerwear-men-2-01.avif', 'MEN_02', 'PROD05', 1),
('PROD05_02', N'Áo Khoác Blazer Nam - Góc 2', N'Phối đồ người mẫu', 1299000, 25, 'products/men/content/content-outerwear-men-2-02.avif', 'MEN_02', 'PROD05', 1),
('PROD05_03', N'Áo Khoác Blazer Nam - Góc 3', N'Cận cảnh chất vải', 1299000, 25, 'products/men/content/content-outerwear-men-2-03.avif', 'MEN_02', 'PROD05', 1),
('PROD05_04', N'Áo Khoác Blazer Nam - Góc 4', N'Chi tiết form dáng', 1299000, 25, 'products/men/content/content-outerwear-men-2-04.avif', 'MEN_02', 'PROD05', 1),

-- PROD06 (4 content angles)
('PROD06_01', N'Áo Khoác Bomber Kaki - Góc 1', N'Chi tiết mặt trước', 899000, 40, 'products/men/content/content-outerwear-men-3-01.avif', 'MEN_02', 'PROD06', 1),
('PROD06_02', N'Áo Khoác Bomber Kaki - Góc 2', N'Phối đồ người mẫu', 899000, 40, 'products/men/content/content-outerwear-men-3-02.avif', 'MEN_02', 'PROD06', 1),
('PROD06_03', N'Áo Khoác Bomber Kaki - Góc 3', N'Cận cảnh chất vải', 899000, 40, 'products/men/content/content-outerwear-men-3-03.avif', 'MEN_02', 'PROD06', 1),
('PROD06_04', N'Áo Khoác Bomber Kaki - Góc 4', N'Chi tiết form dáng', 899000, 40, 'products/men/content/content-outerwear-men-3-04.avif', 'MEN_02', 'PROD06', 1),

-- PROD07 (4 content angles)
('PROD07_01', N'Quần Smart Pants - Góc 1', N'Chi tiết mặt trước', 799000, 45, 'products/men/content/content-pants-men-1-01.avif', 'MEN_03', 'PROD07', 1),
('PROD07_02', N'Quần Smart Pants - Góc 2', N'Phối đồ người mẫu', 799000, 45, 'products/men/content/content-pants-men-1-02.avif', 'MEN_03', 'PROD07', 1),
('PROD07_03', N'Quần Smart Pants - Góc 3', N'Cận cảnh chất vải', 799000, 45, 'products/men/content/content-pants-men-1-03.avif', 'MEN_03', 'PROD07', 1),
('PROD07_04', N'Quần Smart Pants - Góc 4', N'Chi tiết form dáng', 799000, 45, 'products/men/content/content-pants-men-1-04.avif', 'MEN_03', 'PROD07', 1),

-- PROD08 (4 content angles)
('PROD08_01', N'Quần Kaki Chino - Góc 1', N'Chi tiết mặt trước', 699000, 35, 'products/men/content/content-pants-men-2-01.avif', 'MEN_03', 'PROD08', 1),
('PROD08_02', N'Quần Kaki Chino - Góc 2', N'Phối đồ người mẫu', 699000, 35, 'products/men/content/content-pants-men-2-02.avif', 'MEN_03', 'PROD08', 1),
('PROD08_03', N'Quần Kaki Chino - Góc 3', N'Cận cảnh chất vải', 699000, 35, 'products/men/content/content-pants-men-2-03.avif', 'MEN_03', 'PROD08', 1),
('PROD08_04', N'Quần Kaki Chino - Góc 4', N'Chi tiết form dáng', 699000, 35, 'products/men/content/content-pants-men-2-04.avif', 'MEN_03', 'PROD08', 1),

-- PROD09 (4 content angles)
('PROD09_01', N'Quần Jogger Kaki - Góc 1', N'Chi tiết mặt trước', 599000, 50, 'products/men/content/content-pants-men-3-01.avif', 'MEN_03', 'PROD09', 1),
('PROD09_02', N'Quần Jogger Kaki - Góc 2', N'Phối đồ người mẫu', 599000, 50, 'products/men/content/content-pants-men-3-02.avif', 'MEN_03', 'PROD09', 1),
('PROD09_03', N'Quần Jogger Kaki - Góc 3', N'Cận cảnh chất vải', 599000, 50, 'products/men/content/content-pants-men-3-03.avif', 'MEN_03', 'PROD09', 1),
('PROD09_04', N'Quần Jogger Kaki - Góc 4', N'Chi tiết form dáng', 599000, 50, 'products/men/content/content-pants-men-3-04.avif', 'MEN_03', 'PROD09', 1),

-- PROD10 (3 content angles)
('PROD10_01', N'Quần Jeans Nam Slim Fit - Góc 1', N'Chi tiết mặt trước', 899000, 40, 'products/men/content/content-jeans-men-1-01.avif', 'MEN_04', 'PROD10', 1),
('PROD10_02', N'Quần Jeans Nam Slim Fit - Góc 2', N'Phối đồ người mẫu', 899000, 40, 'products/men/content/content-jeans-men-1-02.avif', 'MEN_04', 'PROD10', 1),
('PROD10_03', N'Quần Jeans Nam Slim Fit - Góc 3', N'Cận cảnh chất vải', 899000, 40, 'products/men/content/content-jeans-men-1-03.avif', 'MEN_04', 'PROD10', 1),

-- PROD11 (4 content angles)
('PROD11_01', N'Quần Jeans Ống Suông - Góc 1', N'Chi tiết mặt trước', 949000, 30, 'products/men/content/content-jeans-men-2-01.avif', 'MEN_04', 'PROD11', 1),
('PROD11_02', N'Quần Jeans Ống Suông - Góc 2', N'Phối đồ người mẫu', 949000, 30, 'products/men/content/content-jeans-men-2-02.avif', 'MEN_04', 'PROD11', 1),
('PROD11_03', N'Quần Jeans Ống Suông - Góc 3', N'Cận cảnh chất vải', 949000, 30, 'products/men/content/content-jeans-men-2-03.avif', 'MEN_04', 'PROD11', 1),
('PROD11_04', N'Quần Jeans Ống Suông - Góc 4', N'Chi tiết form dáng', 949000, 30, 'products/men/content/content-jeans-men-2-04.avif', 'MEN_04', 'PROD11', 1),

-- PROD12 (4 content angles)
('PROD12_01', N'Quần Jeans Relaxed Fit - Góc 1', N'Chi tiết mặt trước', 849000, 35, 'products/men/content/content-jeans-men-3-01.avif', 'MEN_04', 'PROD12', 1),
('PROD12_02', N'Quần Jeans Relaxed Fit - Góc 2', N'Phối đồ người mẫu', 849000, 35, 'products/men/content/content-jeans-men-3-02.avif', 'MEN_04', 'PROD12', 1),
('PROD12_03', N'Quần Jeans Relaxed Fit - Góc 3', N'Cận cảnh chất vải', 849000, 35, 'products/men/content/content-jeans-men-3-03.avif', 'MEN_04', 'PROD12', 1),
('PROD12_04', N'Quần Jeans Relaxed Fit - Góc 4', N'Chi tiết form dáng', 849000, 35, 'products/men/content/content-jeans-men-3-04.avif', 'MEN_04', 'PROD12', 1),

-- PROD13 (4 content angles)
('PROD13_01', N'Áo Sơ Mi Rayon Nữ - Góc 1', N'Chi tiết mặt trước', 549000, 50, 'products/women/content/content-shirt-and-blouses-women-1-01.avif', 'WOMEN_01', 'PROD13', 1),
('PROD13_02', N'Áo Sơ Mi Rayon Nữ - Góc 2', N'Phối đồ người mẫu', 549000, 50, 'products/women/content/content-shirt-and-blouses-women-1-02.avif', 'WOMEN_01', 'PROD13', 1),
('PROD13_03', N'Áo Sơ Mi Rayon Nữ - Góc 3', N'Cận cảnh chất vải', 549000, 50, 'products/women/content/content-shirt-and-blouses-women-1-03.avif', 'WOMEN_01', 'PROD13', 1),
('PROD13_04', N'Áo Sơ Mi Rayon Nữ - Góc 4', N'Chi tiết form dáng', 549000, 50, 'products/women/content/content-shirt-and-blouses-women-1-04.avif', 'WOMEN_01', 'PROD13', 1),

-- PROD14 (4 content angles)
('PROD14_01', N'Áo Blouse Cổ Thắt Nơ - Góc 1', N'Chi tiết mặt trước', 599000, 40, 'products/women/content/content-shirt-and-blouses-women-2-01.avif', 'WOMEN_01', 'PROD14', 1),
('PROD14_02', N'Áo Blouse Cổ Thắt Nơ - Góc 2', N'Phối đồ người mẫu', 599000, 40, 'products/women/content/content-shirt-and-blouses-women-2-02.avif', 'WOMEN_01', 'PROD14', 1),
('PROD14_03', N'Áo Blouse Cổ Thắt Nơ - Góc 3', N'Cận cảnh chất vải', 599000, 40, 'products/women/content/content-shirt-and-blouses-women-2-03.avif', 'WOMEN_01', 'PROD14', 1),
('PROD14_04', N'Áo Blouse Cổ Thắt Nơ - Góc 4', N'Chi tiết form dáng', 599000, 40, 'products/women/content/content-shirt-and-blouses-women-2-04.avif', 'WOMEN_01', 'PROD14', 1),

-- PROD15 (4 content angles)
('PROD15_01', N'Áo Sơ Mi Vải Đũi - Góc 1', N'Chi tiết mặt trước', 499000, 35, 'products/women/content/content-shirt-and-blouses-women-3-01.avif', 'WOMEN_01', 'PROD15', 1),
('PROD15_02', N'Áo Sơ Mi Vải Đũi - Góc 2', N'Phối đồ người mẫu', 499000, 35, 'products/women/content/content-shirt-and-blouses-women-3-02.avif', 'WOMEN_01', 'PROD15', 1),
('PROD15_03', N'Áo Sơ Mi Vải Đũi - Góc 3', N'Cận cảnh chất vải', 499000, 35, 'products/women/content/content-shirt-and-blouses-women-3-03.avif', 'WOMEN_01', 'PROD15', 1),
('PROD15_04', N'Áo Sơ Mi Vải Đũi - Góc 4', N'Chi tiết form dáng', 499000, 35, 'products/women/content/content-shirt-and-blouses-women-3-04.avif', 'WOMEN_01', 'PROD15', 1),

-- PROD16 (4 content angles)
('PROD16_01', N'Áo Khoác Chống UV Nữ - Góc 1', N'Chi tiết mặt trước', 699000, 50, 'products/women/content/content-outerwear-women-1-01.avif', 'WOMEN_02', 'PROD16', 1),
('PROD16_02', N'Áo Khoác Chống UV Nữ - Góc 2', N'Phối đồ người mẫu', 699000, 50, 'products/women/content/content-outerwear-women-1-02.avif', 'WOMEN_02', 'PROD16', 1),
('PROD16_03', N'Áo Khoác Chống UV Nữ - Góc 3', N'Cận cảnh chất vải', 699000, 50, 'products/women/content/content-outerwear-women-1-03.avif', 'WOMEN_02', 'PROD16', 1),
('PROD16_04', N'Áo Khoác Chống UV Nữ - Góc 4', N'Chi tiết form dáng', 699000, 50, 'products/women/content/content-outerwear-women-1-04.avif', 'WOMEN_02', 'PROD16', 1),

-- PROD17 (4 content angles)
('PROD17_01', N'Áo Khoác Dạ Tweed - Góc 1', N'Chi tiết mặt trước', 1399000, 20, 'products/women/content/content-outerwear-women-2-01.avif', 'WOMEN_02', 'PROD17', 1),
('PROD17_02', N'Áo Khoác Dạ Tweed - Góc 2', N'Phối đồ người mẫu', 1399000, 20, 'products/women/content/content-outerwear-women-2-02.avif', 'WOMEN_02', 'PROD17', 1),
('PROD17_03', N'Áo Khoác Dạ Tweed - Góc 3', N'Cận cảnh chất vải', 1399000, 20, 'products/women/content/content-outerwear-women-2-03.avif', 'WOMEN_02', 'PROD17', 1),
('PROD17_04', N'Áo Khoác Dạ Tweed - Góc 4', N'Chi tiết form dáng', 1399000, 20, 'products/women/content/content-outerwear-women-2-04.avif', 'WOMEN_02', 'PROD17', 1),

-- PROD18 (4 content angles)
('PROD18_01', N'Áo Khoác Trench Coat - Góc 1', N'Chi tiết mặt trước', 1599000, 25, 'products/women/content/content-outerwear-women-3-01.avif', 'WOMEN_02', 'PROD18', 1),
('PROD18_02', N'Áo Khoác Trench Coat - Góc 2', N'Phối đồ người mẫu', 1599000, 25, 'products/women/content/content-outerwear-women-3-02.avif', 'WOMEN_02', 'PROD18', 1),
('PROD18_03', N'Áo Khoác Trench Coat - Góc 3', N'Cận cảnh chất vải', 1599000, 25, 'products/women/content/content-outerwear-women-3-03.avif', 'WOMEN_02', 'PROD18', 1),
('PROD18_04', N'Áo Khoác Trench Coat - Góc 4', N'Chi tiết form dáng', 1599000, 25, 'products/women/content/content-outerwear-women-3-04.avif', 'WOMEN_02', 'PROD18', 1),

-- PROD19 (4 content angles)
('PROD19_01', N'Quần Ống Suông Xếp Ly - Góc 1', N'Chi tiết mặt trước', 799000, 45, 'products/women/content/content-bottom-women-1-01.avif', 'WOMEN_03', 'PROD19', 1),
('PROD19_02', N'Quần Ống Suông Xếp Ly - Góc 2', N'Phối đồ người mẫu', 799000, 45, 'products/women/content/content-bottom-women-1-02.avif', 'WOMEN_03', 'PROD19', 1),
('PROD19_03', N'Quần Ống Suông Xếp Ly - Góc 3', N'Cận cảnh chất vải', 799000, 45, 'products/women/content/content-bottom-women-1-03.avif', 'WOMEN_03', 'PROD19', 1),
('PROD19_04', N'Quần Ống Suông Xếp Ly - Góc 4', N'Chi tiết form dáng', 799000, 45, 'products/women/content/content-bottom-women-1-04.avif', 'WOMEN_03', 'PROD19', 1),

-- PROD20 (4 content angles)
('PROD20_01', N'Chân Váy Midi Chữ A - Góc 1', N'Chi tiết mặt trước', 649000, 40, 'products/women/content/content-bottom-women-2-01.avif', 'WOMEN_03', 'PROD20', 1),
('PROD20_02', N'Chân Váy Midi Chữ A - Góc 2', N'Phối đồ người mẫu', 649000, 40, 'products/women/content/content-bottom-women-2-02.avif', 'WOMEN_03', 'PROD20', 1),
('PROD20_03', N'Chân Váy Midi Chữ A - Góc 3', N'Cận cảnh chất vải', 649000, 40, 'products/women/content/content-bottom-women-2-03.avif', 'WOMEN_03', 'PROD20', 1),
('PROD20_04', N'Chân Váy Midi Chữ A - Góc 4', N'Chi tiết form dáng', 649000, 40, 'products/women/content/content-bottom-women-2-04.avif', 'WOMEN_03', 'PROD20', 1),

-- PROD21 (3 content angles)
('PROD21_01', N'Quần Tây Nữ Ankle Pants - Góc 1', N'Chi tiết mặt trước', 749000, 35, 'products/women/content/content-bottom-women-3-01.avif', 'WOMEN_03', 'PROD21', 1),
('PROD21_02', N'Quần Tây Nữ Ankle Pants - Góc 2', N'Phối đồ người mẫu', 749000, 35, 'products/women/content/content-bottom-women-3-02.avif', 'WOMEN_03', 'PROD21', 1),
('PROD21_03', N'Quần Tây Nữ Ankle Pants - Góc 3', N'Cận cảnh chất vải', 749000, 35, 'products/women/content/content-bottom-women-3-03.avif', 'WOMEN_03', 'PROD21', 1),

-- PROD22 (4 content angles)
('PROD22_01', N'Quần Shorts Kaki Lưng Cao - Góc 1', N'Chi tiết mặt trước', 449000, 50, 'products/women/content/content-shorts-and-culott-1-01.avif', 'WOMEN_04', 'PROD22', 1),
('PROD22_02', N'Quần Shorts Kaki Lưng Cao - Góc 2', N'Phối đồ người mẫu', 449000, 50, 'products/women/content/content-shorts-and-culott-1-02.avif', 'WOMEN_04', 'PROD22', 1),
('PROD22_03', N'Quần Shorts Kaki Lưng Cao - Góc 3', N'Cận cảnh chất vải', 449000, 50, 'products/women/content/content-shorts-and-culott-1-03.avif', 'WOMEN_04', 'PROD22', 1),
('PROD22_04', N'Quần Shorts Kaki Lưng Cao - Góc 4', N'Chi tiết form dáng', 449000, 50, 'products/women/content/content-shorts-and-culott-1-04.avif', 'WOMEN_04', 'PROD22', 1),

-- PROD23 (4 content angles)
('PROD23_01', N'Quần Giả Váy Xếp Nếp - Góc 1', N'Chi tiết mặt trước', 499000, 40, 'products/women/content/content-shorts-and-culott-2-01.avif', 'WOMEN_04', 'PROD23', 1),
('PROD23_02', N'Quần Giả Váy Xếp Nếp - Góc 2', N'Phối đồ người mẫu', 499000, 40, 'products/women/content/content-shorts-and-culott-2-02.avif', 'WOMEN_04', 'PROD23', 1),
('PROD23_03', N'Quần Giả Váy Xếp Nếp - Góc 3', N'Cận cảnh chất vải', 499000, 40, 'products/women/content/content-shorts-and-culott-2-03.avif', 'WOMEN_04', 'PROD23', 1),
('PROD23_04', N'Quần Giả Váy Xếp Nếp - Góc 4', N'Chi tiết form dáng', 499000, 40, 'products/women/content/content-shorts-and-culott-2-04.avif', 'WOMEN_04', 'PROD23', 1),

-- PROD24 (4 content angles)
('PROD24_01', N'Quần Culottes Ống Rộng - Góc 1', N'Chi tiết mặt trước', 549000, 30, 'products/women/content/content-shorts-and-culott-3-01.avif', 'WOMEN_04', 'PROD24', 1),
('PROD24_02', N'Quần Culottes Ống Rộng - Góc 2', N'Phối đồ người mẫu', 549000, 30, 'products/women/content/content-shorts-and-culott-3-02.avif', 'WOMEN_04', 'PROD24', 1),
('PROD24_03', N'Quần Culottes Ống Rộng - Góc 3', N'Cận cảnh chất vải', 549000, 30, 'products/women/content/content-shorts-and-culott-3-03.avif', 'WOMEN_04', 'PROD24', 1),
('PROD24_04', N'Quần Culottes Ống Rộng - Góc 4', N'Chi tiết form dáng', 549000, 30, 'products/women/content/content-shorts-and-culott-3-04.avif', 'WOMEN_04', 'PROD24', 1);

-- Address
INSERT INTO [Address] (userID, receiverName, phone, addressLine, isDefault)
VALUES ('user1', N'Nguyễn Văn A', '0987654321', N'123 Đường ABC, Quận 1, TP.HCM', 1);

-- Sample Orders
INSERT INTO [Order] (orderID, userID, orderDate, totalMoney, shippingAddress, note, status)
VALUES 
('ORD10001', 'user1', DATEADD(day, -2, GETDATE()), 1248000, N'Nguyễn Văn A (0987654321) - 123 Đường ABC, Quận 1, TP.HCM', N'[Thanh toán COD] Giao hàng giờ hành chính', 'DELIVERED'),
('ORD10002', 'user1', DATEADD(day, -1, GETDATE()), 799000, N'Nguyễn Văn A (0987654321) - 123 Đường ABC, Quận 1, TP.HCM', N'[Thanh toán VietQR] Đã thanh toán chuyển khoản', 'PROCESSING'),
('ORD10003', 'user1', GETDATE(), 599000, N'Nguyễn Văn A (0987654321) - 123 Đường ABC, Quận 1, TP.HCM', N'[Thanh toán COD]', 'PENDING');

-- Sample Order Details
INSERT INTO [OrderDetail] (orderID, productID, price, quantity)
VALUES
('ORD10001', 'PROD01', 599000, 1),
('ORD10001', 'PROD03', 649000, 1),
('ORD10002', 'PROD13', 799000, 1),
('ORD10003', 'PROD02', 599000, 1);

-- Sample Payments
INSERT INTO [Payment] (paymentID, orderID, paymentMethod, paymentDate, amount, status)
VALUES
('PAY10001', 'ORD10001', 'COD', DATEADD(day, -2, GETDATE()), 1248000, 'SUCCESS'),
('PAY10002', 'ORD10002', 'QR_CODE', DATEADD(day, -1, GETDATE()), 799000, 'SUCCESS');

-- Sample Wishlist
INSERT INTO [Wishlist] (userID, productID, addedDate)
VALUES
('user1', 'PROD01', GETDATE()),
('user1', 'PROD05', GETDATE()),
('user1', 'PROD13', GETDATE());

-- Sample CartItem (Persistent Shopping Cart)
INSERT INTO [CartItem] (userID, productID, quantity, addedDate)
VALUES
('user1', 'PROD04', 1, GETDATE()),
('user1', 'PROD14', 2, GETDATE());
GO
