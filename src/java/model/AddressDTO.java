package model;

public class AddressDTO {
    private int addressID;
    private String userID;
    private String receiverName;
    private String phone;
    private String addressLine;
    private boolean isDefault;

    public AddressDTO() {
    }

    public AddressDTO(int addressID, String userID, String receiverName, String phone, String addressLine, boolean isDefault) {
        this.addressID = addressID;
        this.userID = userID;
        this.receiverName = receiverName;
        this.phone = phone;
        this.addressLine = addressLine;
        this.isDefault = isDefault;
    }

    // Getters and Setters
    public int getAddressID() { return addressID; }
    public void setAddressID(int addressID) { this.addressID = addressID; }
    public String getUserID() { return userID; }
    public void setUserID(String userID) { this.userID = userID; }
    public String getReceiverName() { return receiverName; }
    public void setReceiverName(String receiverName) { this.receiverName = receiverName; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddressLine() { return addressLine; }
    public void setAddressLine(String addressLine) { this.addressLine = addressLine; }
    public boolean isDefault() { return isDefault; }
    public void setDefault(boolean isDefault) { this.isDefault = isDefault; }
}
