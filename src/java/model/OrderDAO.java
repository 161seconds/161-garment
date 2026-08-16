package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class OrderDAO {

    public boolean insertOrder(OrderDTO order, List<OrderDetailDTO> details) {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                // Sử dụng Transaction
                conn.setAutoCommit(false);
                
                String sql = "INSERT INTO [Order] (orderID, userID, orderDate, totalMoney, shippingAddress, note, status) "
                           + "VALUES (?, ?, GETDATE(), ?, ?, ?, ?)";
                ptm = conn.prepareStatement(sql);
                ptm.setString(1, order.getOrderID());
                ptm.setString(2, order.getUserID());
                ptm.setDouble(3, order.getTotalMoney());
                ptm.setNString(4, order.getShippingAddress());
                ptm.setNString(5, order.getNote());
                ptm.setString(6, "PENDING");
                
                int row = ptm.executeUpdate();
                
                if (row > 0) {
                    // Thêm OrderDetail
                    String sqlDetail = "INSERT INTO [OrderDetail] (orderID, productID, price, quantity) VALUES (?, ?, ?, ?)";
                    PreparedStatement ptmDetail = conn.prepareStatement(sqlDetail);
                    
                    for (OrderDetailDTO detail : details) {
                        ptmDetail.setString(1, order.getOrderID());
                        ptmDetail.setString(2, detail.getProductID());
                        ptmDetail.setDouble(3, detail.getPrice());
                        ptmDetail.setInt(4, detail.getQuantity());
                        ptmDetail.executeUpdate();
                    }
                    ptmDetail.close();
                    
                    // Commit
                    conn.commit();
                    check = true;
                } else {
                    conn.rollback();
                }
            }
        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (ptm != null) ptm.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return check;
    }

    public List<OrderDTO> getOrdersByUserID(String userID) {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Order] WHERE userID = ? ORDER BY orderDate DESC";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, userID);
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = new OrderDTO(
                        rs.getString("orderID"),
                        rs.getString("userID"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalMoney"),
                        rs.getNString("shippingAddress"),
                        rs.getNString("note"),
                        rs.getString("status")
                    );
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderDTO> getAllOrders() {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Order] ORDER BY orderDate DESC";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
             
            while (rs.next()) {
                OrderDTO order = new OrderDTO(
                    rs.getString("orderID"),
                    rs.getString("userID"),
                    rs.getTimestamp("orderDate"),
                    rs.getDouble("totalMoney"),
                    rs.getNString("shippingAddress"),
                    rs.getNString("note"),
                    rs.getString("status")
                );
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderDTO> getRecentOrders(int limit) {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM [Order] ORDER BY orderDate DESC";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setInt(1, limit);
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = new OrderDTO(
                        rs.getString("orderID"),
                        rs.getString("userID"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalMoney"),
                        rs.getNString("shippingAddress"),
                        rs.getNString("note"),
                        rs.getString("status")
                    );
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderDTO> getOrdersByPage(String status, int offset, int fetch) {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Order]";
        if (status != null && !status.isEmpty() && !status.equalsIgnoreCase("ALL")) {
            sql += " WHERE status = ?";
        }
        sql += " ORDER BY orderDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            int idx = 1;
            if (status != null && !status.isEmpty() && !status.equalsIgnoreCase("ALL")) {
                ptm.setString(idx++, status);
            }
            ptm.setInt(idx++, offset);
            ptm.setInt(idx, fetch);
            
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = new OrderDTO(
                        rs.getString("orderID"),
                        rs.getString("userID"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalMoney"),
                        rs.getNString("shippingAddress"),
                        rs.getNString("note"),
                        rs.getString("status")
                    );
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalOrdersCount(String status) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM [Order]";
        if (status != null && !status.isEmpty() && !status.equalsIgnoreCase("ALL")) {
            sql += " WHERE status = ?";
        }
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            if (status != null && !status.isEmpty() && !status.equalsIgnoreCase("ALL")) {
                ptm.setString(1, status);
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

    public double getTotalRevenue() {
        double total = 0;
        String sql = "SELECT SUM(totalMoney) FROM [Order] WHERE status IN ('PROCESSING', 'SHIPPED', 'DELIVERED', 'SUCCESS')";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
             
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public OrderDTO getOrderByID(String orderID) {
        OrderDTO order = null;
        String sql = "SELECT * FROM [Order] WHERE orderID = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, orderID);
            try (ResultSet rs = ptm.executeQuery()) {
                if (rs.next()) {
                    order = new OrderDTO(
                        rs.getString("orderID"),
                        rs.getString("userID"),
                        rs.getTimestamp("orderDate"),
                        rs.getDouble("totalMoney"),
                        rs.getNString("shippingAddress"),
                        rs.getNString("note"),
                        rs.getString("status")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    public boolean updateOrderStatus(String orderID, String status) {
        boolean check = false;
        String sql = "UPDATE [Order] SET status = ? WHERE orderID = ?";
                   
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, status);
            ptm.setString(2, orderID);
            
            check = ptm.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }
}
