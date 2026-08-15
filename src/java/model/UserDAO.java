package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;
import utils.PasswordUtils;

public class UserDAO {

    public UserDTO checkLogin(String userID, String password) {
        UserDTO user = null;
        String sql = "SELECT * FROM [User] WHERE userID = ? AND password = ? AND status = 1";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, userID);
            ptm.setString(2, PasswordUtils.hashPassword(password));
            
            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    user = new UserDTO();
                    user.setUserID(rs.getString("userID"));
                    user.setFullName(rs.getNString("fullName"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setRoleID(rs.getString("roleID"));
                    user.setStatus(rs.getBoolean("status"));
                    user.setCreateDate(rs.getTimestamp("createDate"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean insertUser(UserDTO user) {
        boolean check = false;
        String sql = "INSERT INTO [User] (userID, fullName, password, email, phone, roleID, status, createDate) "
                   + "VALUES (?, ?, ?, ?, ?, 'CUS', 1, GETDATE())";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, user.getUserID());
            ptm.setNString(2, user.getFullName());
            ptm.setString(3, PasswordUtils.hashPassword(user.getPassword()));
            ptm.setString(4, user.getEmail());
            ptm.setString(5, user.getPhone());
            
            check = ptm.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
    
    public List<UserDTO> getAllUsers() {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
             
            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserID(rs.getString("userID"));
                user.setFullName(rs.getNString("fullName"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRoleID(rs.getString("roleID"));
                user.setStatus(rs.getBoolean("status"));
                user.setCreateDate(rs.getTimestamp("createDate"));
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean updateUser(UserDTO user) {
        boolean check = false;
        String sql = "UPDATE [User] SET fullName = ?, email = ?, phone = ?, roleID = ?, status = ? WHERE userID = ?";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setNString(1, user.getFullName());
            ptm.setString(2, user.getEmail());
            ptm.setString(3, user.getPhone());
            ptm.setString(4, user.getRoleID());
            ptm.setBoolean(5, user.isStatus());
            ptm.setString(6, user.getUserID());
            
            check = ptm.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
    
    public boolean deleteUser(String userID) {
        boolean check = false;
        String sql = "UPDATE [User] SET status = 0 WHERE userID = ?";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, userID);
            check = ptm.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
    
    public UserDTO getUserByID(String userID) {
        UserDTO user = null;
        String sql = "SELECT * FROM [User] WHERE userID = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, userID);
            
            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    user = new UserDTO();
                    user.setUserID(rs.getString("userID"));
                    user.setFullName(rs.getNString("fullName"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setRoleID(rs.getString("roleID"));
                    user.setStatus(rs.getBoolean("status"));
                    user.setCreateDate(rs.getTimestamp("createDate"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
