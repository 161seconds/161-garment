package model;

import java.sql.Timestamp;

public class PaymentDTO {
    private String paymentID;
    private String orderID;
    private String paymentMethod;
    private Timestamp paymentDate;
    private double amount;
    private String status;

    public PaymentDTO() {
    }

    public PaymentDTO(String paymentID, String orderID, String paymentMethod, Timestamp paymentDate, double amount, String status) {
        this.paymentID = paymentID;
        this.orderID = orderID;
        this.paymentMethod = paymentMethod;
        this.paymentDate = paymentDate;
        this.amount = amount;
        this.status = status;
    }

    public String getPaymentID() { return paymentID; }
    public void setPaymentID(String paymentID) { this.paymentID = paymentID; }
    public String getOrderID() { return orderID; }
    public void setOrderID(String orderID) { this.orderID = orderID; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public Timestamp getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Timestamp paymentDate) { this.paymentDate = paymentDate; }
    public double getAmount() { return amount; }
public void setAmount(double amount) { this.amount = amount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
