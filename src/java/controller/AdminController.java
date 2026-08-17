package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.CategoryDAO;
import model.CategoryDTO;
import model.OrderDAO;
import model.OrderDTO;
import model.OrderDetailDAO;
import model.OrderDetailDTO;
import model.ProductDAO;
import model.ProductDTO;
import model.UserDAO;
import model.UserDTO;

@WebServlet(name = "AdminController", urlPatterns = {
    "/admin/dashboard",
    "/admin/product",
    "/admin/category",
    "/admin/order",
    "/admin/user"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AdminController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (servletPath) {
            case "/admin/dashboard":
                handleDashboard(request, response);
                break;
            case "/admin/product":
                handleProduct(request, response, action);
                break;
            case "/admin/category":
                handleCategory(request, response, action);
                break;
            case "/admin/order":
                handleOrder(request, response, action);
                break;
            case "/admin/user":
                handleUser(request, response, action);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
        }
    }

    // ==========================================
    // 1. DASHBOARD HANDLER
    // ==========================================
    private void handleDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        double totalRevenue = orderDAO.getTotalRevenue();
        int totalOrders = orderDAO.getTotalOrdersCount("ALL");
        int totalProducts = productDAO.getTotalProducts(null);
        int totalUsers = userDAO.getTotalUsersCount();
        int lowStockCount = productDAO.getLowStockCount(5);
        Map<String, Integer> orderCounts = orderDAO.getOrderStatusCounts();
        List<OrderDTO> recentOrders = orderDAO.getRecentOrders(6);

        request.setAttribute("STAT_REVENUE", totalRevenue);
        request.setAttribute("STAT_ORDERS", totalOrders);
        request.setAttribute("STAT_PRODUCTS", totalProducts);
        request.setAttribute("STAT_USERS", totalUsers);
        request.setAttribute("STAT_LOW_STOCK", lowStockCount);
        request.setAttribute("STAT_ORDER_COUNTS", orderCounts);
        request.setAttribute("RECENT_ORDERS", recentOrders);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    // ==========================================
    // 2. PRODUCT MANAGEMENT HANDLER
    // ==========================================
    private void handleProduct(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        
        if (action.equals("list")) {
            int pageSize = 10;
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            String keyword = request.getParameter("keyword");
            String categoryID = request.getParameter("categoryID");

            int totalProducts = productDAO.countSearchProductsAdmin(keyword, categoryID);
            int endPage = (totalProducts % pageSize == 0) ? (totalProducts / pageSize) : (totalProducts / pageSize + 1);

            if (page < 1) page = 1;
            if (endPage > 0 && page > endPage) page = endPage;

            int offset = (page - 1) * pageSize;
            List<ProductDTO> products = productDAO.searchProductsAdmin(keyword, categoryID, offset, pageSize);
            List<CategoryDTO> categories = categoryDAO.getAllCategoriesAdmin();

            request.setAttribute("PRODUCTS", products);
            request.setAttribute("CATEGORIES", categories);
            request.setAttribute("endPage", endPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("keyword", keyword);
            request.setAttribute("categoryID", categoryID);

            request.getRequestDispatcher("/admin/manage-product.jsp").forward(request, response);

        } else if (action.equals("add")) {
            List<CategoryDTO> categories = categoryDAO.getAllCategoriesAdmin();
            String nextProductID = productDAO.generateNextProductID();
            request.setAttribute("CATEGORIES", categories);
            request.setAttribute("NEXT_PRODUCT_ID", nextProductID);
            request.getRequestDispatcher("/admin/form-product.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            String productID = request.getParameter("id");
            ProductDTO product = productDAO.getProductByID(productID);
            List<ProductDTO> childProducts = productDAO.getChildProducts(productID);
            List<CategoryDTO> categories = categoryDAO.getAllCategoriesAdmin();

            request.setAttribute("PRODUCT", product);
            request.setAttribute("CHILD_PRODUCTS", childProducts);
            request.setAttribute("CATEGORIES", categories);
            request.getRequestDispatcher("/admin/form-product.jsp").forward(request, response);

        } else if (action.equals("add_submit") || action.equals("update_submit")) {
            boolean isEditMode = action.equals("update_submit");
            String prodID = request.getParameter("productID");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String categoryID = request.getParameter("categoryID");
            String priceRaw = request.getParameter("price");
            String quantityRaw = request.getParameter("quantity");

            // Server-side Validation: Name
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("ERROR", "Tên sản phẩm không được để trống!");
                handleEditOrAddForward(request, response, isEditMode, prodID);
                return;
            }

            // Server-side Validation: Price (1,000 to 100,000,000 VND)
            double price = 0;
            try {
                price = Double.parseDouble(priceRaw);
                if (price < 1000 || price > 100000000) {
                    request.setAttribute("ERROR", "Giá bán không hợp lệ! Vui lòng nhập từ 1.000 VNĐ đến 100.000.000 VNĐ.");
                    handleEditOrAddForward(request, response, isEditMode, prodID);
                    return;
                }
            } catch (Exception e) {
                request.setAttribute("ERROR", "Giá bán phải là số hợp lệ!");
                handleEditOrAddForward(request, response, isEditMode, prodID);
                return;
            }

            // Server-side Validation: Quantity (0 to 100,000)
            int quantity = 0;
            try {
                quantity = Integer.parseInt(quantityRaw);
                if (quantity < 0 || quantity > 100000) {
                    request.setAttribute("ERROR", "Số lượng tồn kho không hợp lệ! Vui lòng nhập số nguyên từ 0 đến 100.000.");
                    handleEditOrAddForward(request, response, isEditMode, prodID);
                    return;
                }
            } catch (Exception e) {
                request.setAttribute("ERROR", "Số lượng tồn kho phải là số nguyên không âm!");
                handleEditOrAddForward(request, response, isEditMode, prodID);
                return;
            }

            // Populate and save master product
            ProductDTO product = new ProductDTO();
            if (!isEditMode && (prodID == null || prodID.trim().isEmpty())) {
                prodID = productDAO.generateNextProductID();
            }
            product.setProductID(prodID.trim());
            product.setName(name.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setCategoryID(categoryID);
            product.setParentID(null);
            product.setStatus(true);

            // Handle cover image upload or text path
            String imagePath = handleImageUpload(request, "imageFile");
            if (imagePath == null || imagePath.isEmpty()) {
                imagePath = request.getParameter("image");
                if (imagePath == null || imagePath.isEmpty()) {
                    if (isEditMode) {
                        ProductDTO existing = productDAO.getProductByID(prodID);
                        if (existing != null) {
                            imagePath = existing.getImage();
                        }
                    } else {
                        imagePath = "products/men/cover/cover-shirts-men-1.avif";
                    }
                }
            }
            product.setImage(imagePath);

            if (isEditMode) {
                productDAO.updateProduct(product);
            } else {
                productDAO.insertProduct(product);
            }

            // Handle 4 Lookbook/Content Child Images
            for (int i = 1; i <= 4; i++) {
                String contentImg = handleImageUpload(request, "contentImage_" + i);
                if (contentImg == null || contentImg.isEmpty()) {
                    contentImg = request.getParameter("contentImageHidden_" + i);
                }
                if (contentImg != null && !contentImg.trim().isEmpty()) {
                    productDAO.upsertChildProduct(prodID.trim(), i, contentImg.trim(), name.trim(), categoryID, price);
                }
            }

            if (isEditMode) {
                response.sendRedirect(request.getContextPath() + "/admin/product?action=list&success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/product?action=list&success=added");
            }

        } else if (action.equals("delete")) {
            String productID = request.getParameter("id");
            productDAO.deleteProduct(productID);
            response.sendRedirect(request.getContextPath() + "/admin/product?action=list&success=deleted");
        }
    }

    private void handleEditOrAddForward(HttpServletRequest request, HttpServletResponse response, boolean isEditMode, String prodID)
            throws ServletException, IOException {
        List<CategoryDTO> categories = categoryDAO.getAllCategoriesAdmin();
        request.setAttribute("CATEGORIES", categories);
        if (isEditMode) {
            ProductDTO product = productDAO.getProductByID(prodID);
            List<ProductDTO> childProducts = productDAO.getChildProducts(prodID);
            request.setAttribute("PRODUCT", product);
            request.setAttribute("CHILD_PRODUCTS", childProducts);
        } else {
            String nextProductID = productDAO.generateNextProductID();
            request.setAttribute("NEXT_PRODUCT_ID", nextProductID);
        }
        request.getRequestDispatcher("/admin/form-product.jsp").forward(request, response);
    }

    // ==========================================
    // FILE UPLOAD HELPER
    // ==========================================
    private String handleImageUpload(HttpServletRequest request, String partName) {
        try {
            Part filePart = request.getPart(partName);
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    // Normalize filename to avoid invalid characters
                    String cleanName = submittedFileName.replaceAll("[^a-zA-Z0-9\\._-]", "_");
                    String uniqueFileName = System.currentTimeMillis() + "_" + cleanName;

                    // 1. Save to deployed realPath
                    String appPath = request.getServletContext().getRealPath("");
                    String uploadDirPath = appPath + File.separator + "img-prj301" + File.separator + "products" + File.separator + "uploads";
                    File uploadDir = new File(uploadDirPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    File targetFile = new File(uploadDir, uniqueFileName);
                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, targetFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }

                    // 2. Also save to source directory if running locally
                    try {
                        String srcUploadDirPath = request.getServletContext().getRealPath("").replace("build" + File.separator + "web", "web") 
                                + File.separator + "img-prj301" + File.separator + "products" + File.separator + "uploads";
                        File srcDir = new File(srcUploadDirPath);
                        if (srcDir.exists()) {
                            Files.copy(targetFile.toPath(), new File(srcDir, uniqueFileName).toPath(), StandardCopyOption.REPLACE_EXISTING);
                        }
                    } catch (Exception ignored) {}

                    return "products/uploads/" + uniqueFileName;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ==========================================
    // 3. CATEGORY MANAGEMENT HANDLER
    // ==========================================
    private void handleCategory(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        
        if (action.equals("list")) {
            List<CategoryDTO> categories = categoryDAO.getAllCategoriesAdmin();
            Map<String, Integer> productCounts = new HashMap<>();
            for (CategoryDTO cat : categories) {
                productCounts.put(cat.getCategoryID(), categoryDAO.countProductsPerCategory(cat.getCategoryID()));
            }

            model.FeaturedCategoryDAO featDao = new model.FeaturedCategoryDAO();
            List<model.FeaturedCategoryDTO> featuredList = featDao.getAllFeaturedCategories(getServletContext());

            request.setAttribute("CATEGORIES", categories);
            request.setAttribute("PRODUCT_COUNTS", productCounts);
            request.setAttribute("FEATURED_CATEGORIES", featuredList);
            request.getRequestDispatcher("/admin/manage-category.jsp").forward(request, response);

        } else if (action.equals("add")) {
            String categoryID = request.getParameter("categoryID");
            String name = request.getParameter("name");
            boolean status = request.getParameter("status") != null;

            CategoryDTO cat = new CategoryDTO(categoryID, name, status);
            categoryDAO.insertCategory(cat);
            response.sendRedirect(request.getContextPath() + "/admin/category?action=list&success=added");

        } else if (action.equals("update")) {
            String categoryID = request.getParameter("categoryID");
            String name = request.getParameter("name");
            boolean status = request.getParameter("status") != null;

            CategoryDTO cat = new CategoryDTO(categoryID, name, status);
            categoryDAO.updateCategory(cat);
            response.sendRedirect(request.getContextPath() + "/admin/category?action=list&success=updated");

        } else if (action.equals("update_featured")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String subtitle = request.getParameter("subtitle");
                String badge = request.getParameter("badge");
                String categoryID = request.getParameter("categoryID");
                boolean status = request.getParameter("status") != null;
                String currentImage = request.getParameter("currentImage");

                String uploadedImage = handleImageUpload(request, "imageFile");
                String finalImage = (uploadedImage != null && !uploadedImage.isEmpty()) ? uploadedImage : currentImage;

                model.FeaturedCategoryDTO item = new model.FeaturedCategoryDTO(id, title, subtitle, badge, categoryID, finalImage, status);
                model.FeaturedCategoryDAO featDao = new model.FeaturedCategoryDAO();
                featDao.updateFeaturedCategory(getServletContext(), item);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/admin/category?action=list&tab=featured&success=featured_updated");

        } else if (action.equals("delete")) {
            String categoryID = request.getParameter("id");
            categoryDAO.deleteCategory(categoryID);
            response.sendRedirect(request.getContextPath() + "/admin/category?action=list&success=deleted");
        }
    }

    // ==========================================
    // 4. ORDER MANAGEMENT HANDLER
    // ==========================================
    private void handleOrder(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        
        if (action.equals("list")) {
            int pageSize = 10;
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            String status = request.getParameter("status");
            if (status == null || status.isEmpty()) {
                status = "ALL";
            }

            int totalOrders = orderDAO.getTotalOrdersCount(status);
            int endPage = (totalOrders % pageSize == 0) ? (totalOrders / pageSize) : (totalOrders / pageSize + 1);

            if (page < 1) page = 1;
            if (endPage > 0 && page > endPage) page = endPage;

            int offset = (page - 1) * pageSize;
            List<OrderDTO> orders = orderDAO.getOrdersByPage(status, offset, pageSize);

            request.setAttribute("ORDERS", orders);
            request.setAttribute("selectedStatus", status);
            request.setAttribute("endPage", endPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalOrders", totalOrders);

            request.getRequestDispatcher("/admin/manage-order.jsp").forward(request, response);

        } else if (action.equals("detail")) {
            String orderID = request.getParameter("id");
            OrderDTO order = orderDAO.getOrderByID(orderID);
            List<OrderDetailDTO> details = orderDetailDAO.getOrderDetails(orderID);

            request.setAttribute("ORDER", order);
            request.setAttribute("DETAILS", details);
            request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);

        } else if (action.equals("update_status")) {
            String orderID = request.getParameter("id");
            String newStatus = request.getParameter("status");
            String currentFilter = request.getParameter("currentFilter");
            if (currentFilter == null) currentFilter = "ALL";

            orderDAO.updateOrderStatus(orderID, newStatus);
            response.sendRedirect(request.getContextPath() + "/admin/order?action=list&status=" + currentFilter + "&success=status_updated");
        }
    }

    // ==========================================
    // 5. USER MANAGEMENT HANDLER
    // ==========================================
    private void handleUser(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        
        if (action.equals("list")) {
            int pageSize = 10;
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            int totalUsers = userDAO.getTotalUsersCount();
            int endPage = (totalUsers % pageSize == 0) ? (totalUsers / pageSize) : (totalUsers / pageSize + 1);

            if (page < 1) page = 1;
            if (endPage > 0 && page > endPage) page = endPage;

            int offset = (page - 1) * pageSize;
            List<UserDTO> users = userDAO.getUsersByPage(offset, pageSize);

            request.setAttribute("USERS", users);
            request.setAttribute("endPage", endPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalUsers", totalUsers);

            request.getRequestDispatcher("/admin/manage-user.jsp").forward(request, response);

        } else if (action.equals("toggle_status")) {
            String userID = request.getParameter("id");
            userDAO.toggleUserStatus(userID);
            response.sendRedirect(request.getContextPath() + "/admin/user?action=list&success=status_toggled");

        } else if (action.equals("update_role")) {
            String userID = request.getParameter("id");
            String roleID = request.getParameter("roleID");
            userDAO.updateUserRole(userID, roleID);
            response.sendRedirect(request.getContextPath() + "/admin/user?action=list&success=role_updated");
        }
    }
}
