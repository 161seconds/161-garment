package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class CategoryDAO {
    
    public List<CategoryDTO> getAllCategories() {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public CategoryDTO getCategoryByID(String categoryID) {
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
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
}
