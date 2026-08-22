package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class CategoryDAO {

    // Fast In-Memory Cache with 5-minute TTL to eliminate remote DB latency on navigation
    private static List<CategoryDTO> CACHED_CATEGORIES = null;
    private static long LAST_CACHE_TIME = 0;
    private static final long CACHE_TTL_MS = 5 * 60 * 1000; // 5 minutes

    public static synchronized void invalidateCache() {
        CACHED_CATEGORIES = null;
        LAST_CACHE_TIME = 0;
    }
    
    public List<CategoryDTO> getAllCategories() {
        long now = System.currentTimeMillis();
        if (CACHED_CATEGORIES != null && (now - LAST_CACHE_TIME) < CACHE_TTL_MS) {
            return new ArrayList<>(CACHED_CATEGORIES);
        }

        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Category] WHERE status = 1";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
             
            while (rs.next()) {
                CategoryDTO category = new CategoryDTO(
                    rs.getString("categoryID"),
                    rs.getNString("name"),
                    rs.getBoolean("status")
                );
                list.add(category);
            }
            CACHED_CATEGORIES = new ArrayList<>(list);
            LAST_CACHE_TIME = now;
        } catch (Exception e) {
            e.printStackTrace();
            if (CACHED_CATEGORIES != null) {
                return new ArrayList<>(CACHED_CATEGORIES);
            }
        }
        return list;
    }

    public CategoryDTO getCategoryByID(String categoryID) {
        if (categoryID == null) return null;
        for (CategoryDTO c : getAllCategories()) {
            if (c.getCategoryID().equalsIgnoreCase(categoryID)) {
                return c;
            }
        }

        CategoryDTO category = null;
        String sql = "SELECT * FROM [Category] WHERE categoryID = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, categoryID);
            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    category = new CategoryDTO(
                        rs.getString("categoryID"),
                        rs.getNString("name"),
                        rs.getBoolean("status")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return category;
    }

    public boolean insertCategory(CategoryDTO category) {
        boolean check = false;
        String sql = "INSERT INTO [Category] (categoryID, name, status) VALUES (?, ?, ?)";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, category.getCategoryID());
            ptm.setNString(2, category.getName());
            ptm.setBoolean(3, category.isStatus());
            
            check = ptm.executeUpdate() > 0;
            if (check) invalidateCache();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public boolean updateCategory(CategoryDTO category) {
        boolean check = false;
        String sql = "UPDATE [Category] SET name = ?, status = ? WHERE categoryID = ?";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setNString(1, category.getName());
            ptm.setBoolean(2, category.isStatus());
            ptm.setString(3, category.getCategoryID());
            
            check = ptm.executeUpdate() > 0;
            if (check) invalidateCache();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public List<CategoryDTO> getAllCategoriesAdmin() {
        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Category] ORDER BY categoryID ASC";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
             
            while (rs.next()) {
                CategoryDTO category = new CategoryDTO(
                    rs.getString("categoryID"),
                    rs.getNString("name"),
                    rs.getBoolean("status")
                );
                list.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countProductsPerCategory(String categoryID) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM [Product] WHERE categoryID = ? AND parentID IS NULL AND status = 1";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, categoryID);
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

    public boolean toggleCategoryStatus(String categoryID) {
        boolean check = false;
        String sql = "UPDATE [Category] SET status = CASE WHEN status = 1 THEN 0 ELSE 1 END WHERE categoryID = ?";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, categoryID);
            check = ptm.executeUpdate() > 0;
            if (check) invalidateCache();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public boolean deleteCategory(String categoryID) {
        boolean check = false;
        String sql = "UPDATE [Category] SET status = 0 WHERE categoryID = ?";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, categoryID);
            check = ptm.executeUpdate() > 0;
            if (check) invalidateCache();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
}
