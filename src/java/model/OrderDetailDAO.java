package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class OrderDetailDAO {

    public List<OrderDetailDTO> getOrderDetails(String orderID) {
        List<OrderDetailDTO> list = new ArrayList<>();
        String sql = "SELECT od.orderID, od.productID, od.price, od.quantity, p.name AS productName, p.image AS productImage "
                   + "FROM [OrderDetail] od "
                   + "LEFT JOIN [Product] p ON od.productID = p.productID "
                   + "WHERE od.orderID = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, orderID);
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    OrderDetailDTO detail = new OrderDetailDTO(
                        rs.getString("orderID"),
                        rs.getString("productID"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getNString("productName"),
                        rs.getString("productImage")
                    );
                    list.add(detail);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
