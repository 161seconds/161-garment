package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class CartDAO {

    /**
     * Retrieve all cart items for a given user from the database.
     */
    public List<CartItemDTO> getCartByUserID(String userID) {
        List<CartItemDTO> list = new ArrayList<>();
        if (userID == null || userID.trim().isEmpty() || "GUEST".equalsIgnoreCase(userID)) {
            return list;
        }

        String sql = "SELECT c.quantity AS cartQty, p.productID, p.name, p.description, p.price, "
                   + "       p.quantity AS stockQty, p.image, p.categoryID, p.parentID, p.status, p.createDate "
                   + "FROM [CartItem] c "
                   + "INNER JOIN [Product] p ON c.productID = p.productID "
                   + "WHERE c.userID = ? AND p.status = 1 "
                   + "ORDER BY c.addedDate DESC";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

            ptm.setString(1, userID);
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    ProductDTO product = new ProductDTO(
                        rs.getString("productID"),
                        rs.getNString("name"),
                        rs.getNString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stockQty"),
                        rs.getString("image"),
                        rs.getString("categoryID"),
                        rs.getString("parentID"),
                        rs.getTimestamp("createDate"),
                        rs.getBoolean("status")
                    );
                    int qty = rs.getInt("cartQty");
                    list.add(new CartItemDTO(product, qty));
                }
            }
        } catch (Exception e) {
            // In case table CartItem is not yet created on some environments, fail gracefully
            System.err.println("[CartDAO] getCartByUserID info: " + e.getMessage());
        }
        return list;
    }

    /**
     * Add product to user's database cart or increment quantity if already present.
     */
    public boolean addToCart(String userID, String productID, int quantity) {
        if (userID == null || userID.trim().isEmpty() || "GUEST".equalsIgnoreCase(userID)) {
            return false;
        }

        String checkSql = "SELECT quantity FROM [CartItem] WHERE userID = ? AND productID = ?";
        String updateSql = "UPDATE [CartItem] SET quantity = quantity + ?, addedDate = GETDATE() WHERE userID = ? AND productID = ?";
        String insertSql = "INSERT INTO [CartItem] (userID, productID, quantity, addedDate) VALUES (?, ?, ?, GETDATE())";

        try (Connection conn = DBUtils.getConnection()) {
            if (conn == null) return false;

            int currentQty = 0;
            boolean exists = false;

            try (PreparedStatement ptmCheck = conn.prepareStatement(checkSql)) {
                ptmCheck.setString(1, userID);
                ptmCheck.setString(2, productID);
                try (ResultSet rs = ptmCheck.executeQuery()) {
                    if (rs.next()) {
                        exists = true;
                        currentQty = rs.getInt("quantity");
                    }
                }
            }

            if (exists) {
                try (PreparedStatement ptmUpdate = conn.prepareStatement(updateSql)) {
                    ptmUpdate.setInt(1, quantity);
                    ptmUpdate.setString(2, userID);
                    ptmUpdate.setString(3, productID);
                    return ptmUpdate.executeUpdate() > 0;
                }
            } else {
                try (PreparedStatement ptmInsert = conn.prepareStatement(insertSql)) {
                    ptmInsert.setString(1, userID);
                    ptmInsert.setString(2, productID);
                    ptmInsert.setInt(3, quantity);
                    return ptmInsert.executeUpdate() > 0;
                }
            }
        } catch (Exception e) {
            System.err.println("[CartDAO] addToCart info: " + e.getMessage());
        }
        return false;
    }

    /**
     * Update quantity for a specific product in database cart.
     */
    public boolean updateQuantity(String userID, String productID, int quantity) {
        if (userID == null || userID.trim().isEmpty() || "GUEST".equalsIgnoreCase(userID)) {
            return false;
        }

        if (quantity <= 0) {
            return removeCartItem(userID, productID);
        }

        String sql = "UPDATE [CartItem] SET quantity = ?, addedDate = GETDATE() WHERE userID = ? AND productID = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

            ptm.setInt(1, quantity);
            ptm.setString(2, userID);
            ptm.setString(3, productID);
            return ptm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("[CartDAO] updateQuantity info: " + e.getMessage());
        }
        return false;
    }

    /**
     * Remove a product from database cart.
     */
    public boolean removeCartItem(String userID, String productID) {
        if (userID == null || userID.trim().isEmpty() || "GUEST".equalsIgnoreCase(userID)) {
            return false;
        }

        String sql = "DELETE FROM [CartItem] WHERE userID = ? AND productID = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

            ptm.setString(1, userID);
            ptm.setString(2, productID);
            return ptm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("[CartDAO] removeCartItem info: " + e.getMessage());
        }
        return false;
    }

    /**
     * Clear all items in database cart for user (e.g. after order checkout).
     */
    public boolean clearCart(String userID) {
        if (userID == null || userID.trim().isEmpty() || "GUEST".equalsIgnoreCase(userID)) {
            return false;
        }

        String sql = "DELETE FROM [CartItem] WHERE userID = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ptm = conn.prepareStatement(sql)) {

            ptm.setString(1, userID);
            return ptm.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("[CartDAO] clearCart info: " + e.getMessage());
        }
        return false;
    }

    /**
     * Merge items from guest session cart into database cart upon user login.
     */
    public void mergeSessionCartToDB(String userID, List<CartItemDTO> sessionCart) {
        if (userID == null || sessionCart == null || sessionCart.isEmpty()) {
            return;
        }
        for (CartItemDTO item : sessionCart) {
            if (item.getProduct() != null) {
                addToCart(userID, item.getProduct().getProductID(), item.getQuantity());
            }
        }
    }
}
