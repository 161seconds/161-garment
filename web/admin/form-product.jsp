<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thêm Mới Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow border-0 p-4">
                    <h3 class="fw-bold mb-4 border-bottom pb-2">THÊM SẢN PHẨM MỚI</h3>
                    
                    <form action="${pageContext.request.contextPath}/admin/product" method="POST">
                        <input type="hidden" name="action" value="add_submit">
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Mã sản phẩm (ID)</label>
                                <input type="text" class="form-control" name="productID" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Danh mục</label>
                                <select class="form-select" name="categoryID">
                                    <c:forEach var="cat" items="${CATEGORIES}">
                                        <option value="${cat.categoryID}">${cat.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên sản phẩm</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Giá bán (VNĐ)</label>
                                <input type="number" class="form-control" name="price" required min="0">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Số lượng kho</label>
                                <input type="number" class="form-control" name="quantity" required min="0">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên File Ảnh (VD: dienthoai.jpg)</label>
                            <input type="text" class="form-control" name="image" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Mô tả sản phẩm</label>
                            <textarea class="form-control" name="description" rows="4"></textarea>
                        </div>
                        
                        <button type="submit" class="btn btn-success fw-bold px-4">LƯU SẢN PHẨM</button>
                        <a href="${pageContext.request.contextPath}/admin/product?action=list" class="btn btn-secondary">Hủy bỏ</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
