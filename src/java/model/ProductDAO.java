package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class ProductDAO {

    private ProductDTO extractProduct(ResultSet rs) throws SQLException {
        return new ProductDTO(
            rs.getString("productID"),
            rs.getNString("name"),
            rs.getNString("description"),
            rs.getDouble("price"),
            rs.getInt("quantity"),
            rs.getString("image"),
            rs.getString("categoryID"),
            rs.getString("parentID"),
            rs.getTimestamp("createDate"),
            rs.getBoolean("status")
        );
    }

    public List<ProductDTO> getAllProducts() {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Product] WHERE parentID IS NULL AND status = 1";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
             
            while (rs.next()) {
                list.add(extractProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ProductDTO getProductByID(String productID) {
        ProductDTO product = null;
        String sql = "SELECT * FROM [Product] WHERE productID = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, productID);
            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    product = extractProduct(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }
    
    public List<ProductDTO> getProductsByCategory(String categoryID) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Product] WHERE categoryID = ? AND parentID IS NULL AND status = 1";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, categoryID);
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    list.add(extractProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertProduct(ProductDTO product) {
        boolean check = false;
        String sql = "INSERT INTO [Product] (productID, name, description, price, quantity, image, categoryID, parentID, createDate, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), 1)";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, product.getProductID());
            ptm.setNString(2, product.getName());
            ptm.setNString(3, product.getDescription());
            ptm.setDouble(4, product.getPrice());
            ptm.setInt(5, product.getQuantity());
            ptm.setString(6, product.getImage());
            ptm.setString(7, product.getCategoryID());
            ptm.setString(8, product.getParentID());
            
            check = ptm.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public boolean updateProduct(ProductDTO product) {
        boolean check = false;
        String sql = "UPDATE [Product] SET name = ?, description = ?, price = ?, quantity = ?, image = ?, categoryID = ?, parentID = ?, status = ? WHERE productID = ?";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setNString(1, product.getName());
            ptm.setNString(2, product.getDescription());
            ptm.setDouble(3, product.getPrice());
            ptm.setInt(4, product.getQuantity());
            ptm.setString(5, product.getImage());
            ptm.setString(6, product.getCategoryID());
            ptm.setString(7, product.getParentID());
            ptm.setBoolean(8, product.isStatus());
            ptm.setString(9, product.getProductID());
            
            check = ptm.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public boolean deleteProduct(String productID) {
        boolean check = false;
        String sql = "UPDATE [Product] SET status = 0 WHERE productID = ? OR parentID = ?";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, productID);
            ptm.setString(2, productID);
            check = ptm.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public int getTotalProducts(String categoryID) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM [Product] WHERE parentID IS NULL AND status = 1";
        if (categoryID != null && !categoryID.isEmpty()) {
            sql += " AND categoryID = ?";
        }
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            if (categoryID != null && !categoryID.isEmpty()) {
                ptm.setString(1, categoryID);
            }
            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<ProductDTO> getProductsByPage(String categoryID, int offset, int fetch) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Product] WHERE parentID IS NULL AND status = 1";
        if (categoryID != null && !categoryID.isEmpty()) {
            sql += " AND categoryID = ?";
        }
        sql += " ORDER BY productID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            int index = 1;
            if (categoryID != null && !categoryID.isEmpty()) {
                ptm.setString(index++, categoryID);
            }
            ptm.setInt(index++, offset);
            ptm.setInt(index, fetch);
            
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    list.add(extractProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductDTO> getChildProducts(String parentID) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Product] WHERE parentID = ? AND status = 1 ORDER BY productID ASC";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, parentID);
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    list.add(extractProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductDTO> searchProductsAdmin(String keyword, String categoryID, int offset, int fetch) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Product] WHERE parentID IS NULL AND status = 1";
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (name LIKE ? OR productID LIKE ?)";
        }
        if (categoryID != null && !categoryID.trim().isEmpty() && !categoryID.equalsIgnoreCase("ALL")) {
            sql += " AND categoryID = ?";
        }
        sql += " ORDER BY productID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String pattern = "%" + keyword.trim() + "%";
                ptm.setString(idx++, pattern);
                ptm.setString(idx++, pattern);
            }
            if (categoryID != null && !categoryID.trim().isEmpty() && !categoryID.equalsIgnoreCase("ALL")) {
                ptm.setString(idx++, categoryID.trim());
            }
            ptm.setInt(idx++, offset);
            ptm.setInt(idx, fetch);
            
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    list.add(extractProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countSearchProductsAdmin(String keyword, String categoryID) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM [Product] WHERE parentID IS NULL AND status = 1";
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (name LIKE ? OR productID LIKE ?)";
        }
        if (categoryID != null && !categoryID.trim().isEmpty() && !categoryID.equalsIgnoreCase("ALL")) {
            sql += " AND categoryID = ?";
        }
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String pattern = "%" + keyword.trim() + "%";
                ptm.setString(idx++, pattern);
                ptm.setString(idx++, pattern);
            }
            if (categoryID != null && !categoryID.trim().isEmpty() && !categoryID.equalsIgnoreCase("ALL")) {
                ptm.setString(idx++, categoryID.trim());
            }
            
            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getLowStockCount(int threshold) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM [Product] WHERE parentID IS NULL AND status = 1 AND quantity <= ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setInt(1, threshold);
            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public String generateNextProductID() {
        String sql = "SELECT productID FROM [Product] WHERE parentID IS NULL";
        int maxId = 0;
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                String id = rs.getString("productID");
                if (id != null && id.toUpperCase().startsWith("PROD")) {
                    String numPart = id.substring(4);
                    try {
                        int num = Integer.parseInt(numPart);
                        if (num > maxId) {
                            maxId = num;
                        }
                    } catch (NumberFormatException ignored) {}
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return String.format("PROD%02d", maxId + 1);
    }
}
