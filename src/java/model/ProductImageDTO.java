package model;

public class ProductImageDTO {
    private int imageID;
    private String productID;
    private String imageUrl;
    private boolean isPrimary;

    public ProductImageDTO() {
    }

    public ProductImageDTO(int imageID, String productID, String imageUrl, boolean isPrimary) {
        this.imageID = imageID;
        this.productID = productID;
this.imageUrl = imageUrl;
        this.isPrimary = isPrimary;
    }

    public int getImageID() { return imageID; }
    public void setImageID(int imageID) { this.imageID = imageID; }
    public String getProductID() { return productID; }
    public void setProductID(String productID) { this.productID = productID; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public boolean isPrimary() { return isPrimary; }
    public void setPrimary(boolean primary) { isPrimary = primary; }
}
