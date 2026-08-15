package model;

import java.sql.Timestamp;

public class ProductDTO {
    private String productID;
    private String name;
    private String description;
    private double price;
    private int quantity;
    private String image;
    private String categoryID;
    private Timestamp createDate;
    private boolean status;

    public ProductDTO() {
    }

    public ProductDTO(String productID, String name, String description, double price, int quantity, String image, String categoryID, Timestamp createDate, boolean status) {
        this.productID = productID;
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.image = image;
        this.categoryID = categoryID;
        this.createDate = createDate;
        this.status = status;
    }

    // Getters and Setters
    public String getProductID() { return productID; }
    public void setProductID(String productID) { this.productID = productID; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public String getCategoryID() { return categoryID; }
    public void setCategoryID(String categoryID) { this.categoryID = categoryID; }
    public Timestamp getCreateDate() { return createDate; }
    public void setCreateDate(Timestamp createDate) { this.createDate = createDate; }
    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
}
