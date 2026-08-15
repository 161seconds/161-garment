package model;

import java.sql.Timestamp;

public class WishlistDTO {
    private String userID;
    private String productID;
    private Timestamp addedDate;

    public WishlistDTO() {
    }

    public WishlistDTO(String userID, String productID, Timestamp addedDate) {
        this.userID = userID;
        this.productID = productID;
        this.addedDate = addedDate;
    }

    public String getUserID() { return userID; }
    public void setUserID(String userID) { this.userID = userID; }
    public String getProductID() { return productID; }
    public void setProductID(String productID) { this.productID = productID; }
    public Timestamp getAddedDate() { return addedDate; }
    public void setAddedDate(Timestamp addedDate) { this.addedDate = addedDate; }
}
