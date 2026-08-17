package model;

import java.io.Serializable;

public class FeaturedCategoryDTO implements Serializable {
    private int id;
    private String title;
    private String subtitle;
    private String badge;
    private String categoryID;
    private String image;
    private boolean status;

    public FeaturedCategoryDTO() {
    }

    public FeaturedCategoryDTO(int id, String title, String subtitle, String badge, String categoryID, String image, boolean status) {
        this.id = id;
        this.title = title;
        this.subtitle = subtitle;
        this.badge = badge;
        this.categoryID = categoryID;
        this.image = image;
        this.status = status;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getSubtitle() { return subtitle; }
    public void setSubtitle(String subtitle) { this.subtitle = subtitle; }
    public String getBadge() { return badge; }
    public void setBadge(String badge) { this.badge = badge; }
    public String getCategoryID() { return categoryID; }
    public void setCategoryID(String categoryID) { this.categoryID = categoryID; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
}
