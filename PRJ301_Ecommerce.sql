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

-- 4. Product Table
CREATE TABLE [Product] (
    productID VARCHAR(50) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(18, 2) NOT NULL,
    quantity INT DEFAULT 0,
    image VARCHAR(255),
    categoryID VARCHAR(20) FOREIGN KEY REFERENCES [Category](categoryID),
    createDate DATETIME DEFAULT GETDATE(),
    status BIT DEFAULT 1
);

-- 5. ProductImage Table
CREATE TABLE [ProductImage] (
    imageID INT IDENTITY(1,1) PRIMARY KEY,
    productID VARCHAR(50) FOREIGN KEY REFERENCES [Product](productID),
    imageUrl VARCHAR(255) NOT NULL,
    isPrimary BIT DEFAULT 0
);

-- 6. Address Table
CREATE TABLE [Address] (
    addressID INT IDENTITY(1,1) PRIMARY KEY,
    userID VARCHAR(50) FOREIGN KEY REFERENCES [User](userID),
    receiverName NVARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    addressLine NVARCHAR(255) NOT NULL,
    isDefault BIT DEFAULT 0
);

-- 7. Order Table
CREATE TABLE [Order] (
    orderID VARCHAR(50) PRIMARY KEY,
    userID VARCHAR(50) FOREIGN KEY REFERENCES [User](userID),
    orderDate DATETIME DEFAULT GETDATE(),
    totalMoney DECIMAL(18, 2) NOT NULL,
    shippingAddress NVARCHAR(255) NOT NULL,
    note NVARCHAR(500),
    status VARCHAR(20) DEFAULT 'PENDING' -- PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED
);

-- 8. OrderDetail Table
CREATE TABLE [OrderDetail] (
    orderID VARCHAR(50) FOREIGN KEY REFERENCES [Order](orderID),
    productID VARCHAR(50) FOREIGN KEY REFERENCES [Product](productID),
    price DECIMAL(18, 2) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (orderID, productID)
);

-- 9. Payment Table
CREATE TABLE [Payment] (
    paymentID VARCHAR(50) PRIMARY KEY,
    orderID VARCHAR(50) FOREIGN KEY REFERENCES [Order](orderID),
    paymentMethod VARCHAR(50) NOT NULL, -- COD, VNPAY, MOMO
    paymentDate DATETIME DEFAULT GETDATE(),
    amount DECIMAL(18, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING' -- PENDING, SUCCESS, FAILED
);

-- 10. Wishlist Table
CREATE TABLE [Wishlist] (
    userID VARCHAR(50) FOREIGN KEY REFERENCES [User](userID),
    productID VARCHAR(50) FOREIGN KEY REFERENCES [Product](productID),
    addedDate DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (userID, productID)
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

-- Categories (Nam, Nữ, Trẻ em)
INSERT INTO [Category] (categoryID, name, status) VALUES 
('MEN_01', N'Áo Thun Nam', 1),
('MEN_02', N'Áo Sơ Mi Nam', 1),
('MEN_03', N'Áo Khoác Nam', 1),
('MEN_04', N'Quần Dài Nam', 1),
('WOMEN_01', N'Áo Thun Nữ', 1),
('WOMEN_02', N'Áo Sơ Mi Nữ', 1),
('WOMEN_03', N'Áo Khoác Nữ', 1),
('WOMEN_04', N'Quần & Váy Nữ', 1),
('KIDS_01', N'Áo Trẻ Em', 1),
('KIDS_02', N'Áo Khoác Trẻ Em', 1),
('KIDS_03', N'Quần Trẻ Em', 1);

-- Products (16 items to match images)
INSERT INTO [Product] (productID, name, description, price, quantity, image, categoryID, status) VALUES 
('PROD01', N'Áo Thun Cổ Tròn Nam Ngắn Tay', N'Chất liệu cotton mềm, thoáng mát.', 299000, 50, 'ao-thun-01.avif', 'MEN_01', 1),
('PROD02', N'Áo Thun AIRism Nam Trắng', N'Công nghệ AIRism mát lạnh độc quyền.', 249000, 40, 'ao-thun-02.avif', 'MEN_01', 1),
('PROD03', N'Áo Thun Dáng Rộng Unisex', N'Form oversize thoải mái cho cả nam và nữ.', 399000, 30, 'ao-thun-03.avif', 'MEN_01', 1),
('PROD04', N'Áo Thun Vải Linen Cao Cấp', N'Vải linen cao cấp thấm hút mồ hôi tối đa.', 599000, 20, 'ao-thun-04.avif', 'MEN_01', 1),
('PROD05', N'Áo Polo Thể Thao Nam', N'Lịch lãm chốn công sở và năng động khi dạo phố.', 599000, 25, 'ao-thun-05.avif', 'MEN_01', 1),
('PROD06', N'Áo Khoác Chống UV Nữ', N'Chống nắng hiệu quả UPF 50+ bảo vệ làn da.', 499000, 40, 'ao-khoac-01.avif', 'WOMEN_03', 1),
('PROD07', N'Áo Khoác Nỉ Lót Lông Nữ', N'Mềm mại, ấm áp cho ngày se lạnh.', 699000, 15, 'ao-khoac-03.avif', 'WOMEN_03', 1),
('PROD08', N'Áo Khoác Gió Nam BlockTech', N'Chống gió, chống nước cực tốt.', 599000, 20, 'ao-khoac-04.avif', 'MEN_03', 1),
('PROD09', N'Áo Khoác Thể Thao Nữ', N'Nhẹ nhàng, tiện lợi mặc tập hoặc dạo phố.', 199000, 50, 'ao-khoac-05.avif', 'WOMEN_03', 1),
('PROD10', N'Áo Khoác Phao Dáng Dài Nam', N'Giữ ấm mùa đông với lớp bông siêu nhẹ.', 799000, 30, 'ao-khoac-06.avif', 'MEN_03', 1),
('PROD11', N'Quần Shorts Kaki Nam', N'Thoải mái vận động suốt ngày dài.', 399000, 35, 'quan-dai-01.avif', 'MEN_04', 1),
('PROD12', N'Quần Jeans Nam Co Giãn', N'Dáng slim fit trẻ trung, tôn dáng.', 799000, 40, 'quan-dai-02.avif', 'MEN_04', 1),
('PROD13', N'Quần Âu Nữ Ống Suông', N'Phẳng phiu, thanh lịch nơi công sở.', 699000, 25, 'quan-dai-03.avif', 'WOMEN_04', 1),
('PROD14', N'Quần Tây Nam Cao Cấp', N'Lịch thiệp, sang trọng cho quý ông.', 899000, 50, 'quan-dai-04.avif', 'MEN_04', 1),
('PROD15', N'Quần Thể Thao Trẻ Em', N'Chất liệu cotton mềm, an toàn cho bé.', 299000, 40, 'quan-dai-05.avif', 'KIDS_03', 1),
('PROD16', N'Áo Thun Trẻ Em In Họa Tiết', N'Đáng yêu, thoáng mát cả ngày.', 199000, 30, 'ao-thun-01.avif', 'KIDS_01', 1);

-- Product Images
INSERT INTO [ProductImage] (productID, imageUrl, isPrimary) VALUES 
('PROD01', 'ao-thun-01.avif', 1),
('PROD02', 'ao-thun-02.avif', 1),
('PROD03', 'ao-thun-03.avif', 1),
('PROD04', 'ao-thun-04.avif', 1),
('PROD05', 'ao-thun-05.avif', 1),
('PROD06', 'ao-khoac-01.avif', 1),
('PROD07', 'ao-khoac-03.avif', 1),
('PROD08', 'ao-khoac-04.avif', 1),
('PROD09', 'ao-khoac-05.avif', 1),
('PROD10', 'ao-khoac-06.avif', 1),
('PROD11', 'quan-dai-01.avif', 1),
('PROD12', 'quan-dai-02.avif', 1),
('PROD13', 'quan-dai-03.avif', 1),
('PROD14', 'quan-dai-04.avif', 1),
('PROD15', 'quan-dai-05.avif', 1),
('PROD16', 'quan-dai-06.avif', 1);

-- Address
INSERT INTO [Address] (userID, receiverName, phone, addressLine, isDefault)
VALUES ('user1', N'Nguyễn Văn A', '0987654321', N'123 Đường ABC, Quận 1, TP.HCM', 1);
GO
