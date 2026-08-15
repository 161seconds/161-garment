package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class RoleDAO {

    public List<RoleDTO> getAllRoles() {
        List<RoleDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [Role]";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
             
            while (rs.next()) {
                RoleDTO role = new RoleDTO(
                    rs.getString("roleID"),
                    rs.getString("roleName")
                );
                list.add(role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
