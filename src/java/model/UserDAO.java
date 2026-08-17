package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import utils.DBUtils;
import utils.PasswordUtils;

public class UserDAO {

    public UserDTO checkLogin(String identifier, String password) {
        UserDTO user = null;
        String sql = "SELECT * FROM [User] WHERE (userID = ? OR email = ? OR phone = ?) AND password = ? AND status = 1";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            String cleanIdentifier = (identifier != null) ? identifier.trim() : "";
            ptm.setString(1, cleanIdentifier);
            ptm.setString(2, cleanIdentifier);
            ptm.setString(3, cleanIdentifier);
            ptm.setString(4, PasswordUtils.hashPassword(password));
            
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

    public synchronized String generateNextUserID() {
        int maxIndex = 0;
        String sql = "SELECT userID FROM [User]";
        Pattern pattern = Pattern.compile("(?:USR|usr|user|USER|CUS|cus)([0-9]+)");

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {

            while (rs.next()) {
                String id = rs.getString("userID");
                if (id != null) {
                    Matcher m = pattern.matcher(id);
                    if (m.find()) {
                        try {
                            int num = Integer.parseInt(m.group(1));
                            if (num > maxIndex) {
                                maxIndex = num;
                            }
                        } catch (NumberFormatException ignored) {}
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (maxIndex == 0) {
            int total = getTotalUsersCount();
            maxIndex = Math.max(total, 0);
        }

        int nextIndex = maxIndex + 1;
        return String.format("USR%02d", nextIndex);
    }

    public boolean isEmailExists(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        String sql = "SELECT 1 FROM [User] WHERE email = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
            ptm.setString(1, email.trim());
            try (ResultSet rs = ptm.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isPhoneExists(String phone) {
        if (phone == null || phone.trim().isEmpty()) return false;
        String sql = "SELECT 1 FROM [User] WHERE phone = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
            ptm.setString(1, phone.trim());
            try (ResultSet rs = ptm.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
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
    
    public boolean updateProfile(String userID, String fullName, String email, String phone) {
        boolean check = false;
        String sql = "UPDATE [User] SET fullName = ?, email = ?, phone = ? WHERE userID = ?";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setNString(1, fullName);
            ptm.setString(2, email);
            ptm.setString(3, phone);
            ptm.setString(4, userID);
            
            check = ptm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public boolean changePassword(String userID, String oldPassword, String newPassword) {
        UserDTO existing = checkLogin(userID, oldPassword);
        if (existing == null) {
            return false; // Old password does not match
        }

        boolean check = false;
        String sql = "UPDATE [User] SET password = ? WHERE userID = ?";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, PasswordUtils.hashPassword(newPassword));
            ptm.setString(2, userID);
            
            check = ptm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public Map<String, Object> getUserOrderStats(String userID) {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalOrders", 0);
        stats.put("processingOrders", 0);
        stats.put("totalSpent", 0.0);

        String sql = "SELECT COUNT(*) AS totalOrders, "
                   + "SUM(CASE WHEN status IN ('PENDING', 'PROCESSING', 'SHIPPED') THEN 1 ELSE 0 END) AS processingOrders, "
                   + "ISNULL(SUM(CASE WHEN status NOT IN ('CANCELLED') THEN totalMoney ELSE 0 END), 0) AS totalSpent "
                   + "FROM [Order] WHERE userID = ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
            ptm.setString(1, userID);
            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    stats.put("totalOrders", rs.getInt("totalOrders"));
                    stats.put("processingOrders", rs.getInt("processingOrders"));
                    stats.put("totalSpent", rs.getDouble("totalSpent"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
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

    public List<UserDTO> getUsersByPage(int offset, int fetch) {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [User] ORDER BY createDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setInt(1, offset);
            ptm.setInt(2, fetch);
            try (ResultSet rs = ptm.executeQuery()) {
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalUsersCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM [User]";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
             
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean toggleUserStatus(String userID) {
        boolean check = false;
        String sql = "UPDATE [User] SET status = CASE WHEN status = 1 THEN 0 ELSE 1 END WHERE userID = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, userID);
            check = ptm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public boolean updateUserRole(String userID, String roleID) {
        boolean check = false;
        String sql = "UPDATE [User] SET roleID = ? WHERE userID = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, roleID);
            ptm.setString(2, userID);
            check = ptm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
}
