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
