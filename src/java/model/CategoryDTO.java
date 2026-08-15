package model;

public class CategoryDTO {
    private String categoryID;
    private String name;
    private boolean status;

    public CategoryDTO() {
    }
public CategoryDTO(String categoryID, String name, boolean status) {
        this.categoryID = categoryID;
        this.name = name;
        this.status = status;
    }

    public String getCategoryID() { return categoryID; }
    public void setCategoryID(String categoryID) { this.categoryID = categoryID; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
}
