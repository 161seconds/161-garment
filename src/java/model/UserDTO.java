package model;

import java.sql.Timestamp;

public class UserDTO {
    private String userID;
    private String fullName;
    private String password;
    private String email;
    private String phone;
    private String roleID;
    private boolean status;
    private Timestamp createDate;

    public UserDTO() {
    }

    public UserDTO(String userID, String fullName, String password, String email, String phone, String roleID, boolean status, Timestamp createDate) {
        this.userID = userID;
        this.fullName = fullName;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.roleID = roleID;
        this.status = status;
        this.createDate = createDate;
    }

    // Getters and Setters
    public String getUserID() { return userID; }
    public void setUserID(String userID) { this.userID = userID; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getRoleID() { return roleID; }
    public void setRoleID(String roleID) { this.roleID = roleID; }
    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
    public Timestamp getCreateDate() { return createDate; }
    public void setCreateDate(Timestamp createDate) { this.createDate = createDate; }
}
