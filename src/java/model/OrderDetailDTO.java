package model;

public class OrderDetailDTO {
    private String orderID;
    private String productID;
    private double price;
    private int quantity;
    private String productName;
    private String productImage;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(String orderID, String productID, double price, int quantity) {
        this.orderID = orderID;
        this.productID = productID;
        this.price = price;
        this.quantity = quantity;
    }

    public OrderDetailDTO(String orderID, String productID, double price, int quantity, String productName, String productImage) {
        this.orderID = orderID;
        this.productID = productID;
        this.price = price;
        this.quantity = quantity;
        this.productName = productName;
        this.productImage = productImage;
    }

    public String getOrderID() { return orderID; }
    public void setOrderID(String orderID) { this.orderID = orderID; }
    public String getProductID() { return productID; }
    public void setProductID(String productID) { this.productID = productID; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }
}
