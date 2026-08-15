package model;

import java.sql.Timestamp;

public class OrderDTO {
    private String orderID;
    private String userID;
    private Timestamp orderDate;
    private double totalMoney;
    private String shippingAddress;
    private String note;
    private String status;

    public OrderDTO() {
    }

    public OrderDTO(String orderID, String userID, Timestamp orderDate, double totalMoney, String shippingAddress, String note, String status) {
        this.orderID = orderID;
        this.userID = userID;
        this.orderDate = orderDate;
        this.totalMoney = totalMoney;
        this.shippingAddress = shippingAddress;
        this.note = note;
        this.status = status;
    }

    // Getters and Setters
    public String getOrderID() { return orderID; }
    public void setOrderID(String orderID) { this.orderID = orderID; }
    public String getUserID() { return userID; }
public void setUserID(String userID) { this.userID = userID; }
    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
    public double getTotalMoney() { return totalMoney; }
    public void setTotalMoney(double totalMoney) { this.totalMoney = totalMoney; }
    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
