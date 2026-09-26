package com.sms.model;

/**
 * Model class representing Fees details for a Student.
 */
public class Fees {
    private int id;
    private String studentId;
    private String studentName; // Joined from students table
    private double totalFee;
    private double paidFee;

    public Fees() {}

    public Fees(int id, String studentId, double totalFee, double paidFee) {
        this.id = id;
        this.studentId = studentId;
        this.totalFee = totalFee;
        this.paidFee = paidFee;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public double getTotalFee() { return totalFee; }
    public void setTotalFee(double totalFee) { this.totalFee = totalFee; }

    public double getPaidFee() { return paidFee; }
    public void setPaidFee(double paidFee) { this.paidFee = paidFee; }

    /**
     * Calculates remaining fee balance: Total Fee - Paid Fee.
     */
    public double getRemainingFee() {
        return Math.max(0.0, totalFee - paidFee);
    }

    /**
     * Returns fee status string ("Paid" or "Pending").
     */
    public String getStatus() {
        return (getRemainingFee() <= 0.0) ? "Paid" : "Pending";
    }
}
