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
        String sql = "SELECT * FROM [OrderDetail] WHERE orderID = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {
             
            ptm.setString(1, orderID);
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    OrderDetailDTO detail = new OrderDetailDTO(
                        rs.getString("orderID"),
                        rs.getString("productID"),
                        rs.getDouble("price"),
                        rs.getInt("quantity")
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
