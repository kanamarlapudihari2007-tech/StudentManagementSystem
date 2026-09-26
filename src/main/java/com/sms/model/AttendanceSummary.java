package com.sms.model;

/**
 * Model DTO class representing calculated Attendance Summary per student.
 */
public class AttendanceSummary {
    private String studentId;
    private String studentName;
    private String department;
    private int totalClasses;
    private int presentClasses;
    private double percentage;

    public AttendanceSummary() {}

    public AttendanceSummary(String studentId, String studentName, String department, 
                             int totalClasses, int presentClasses, double percentage) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.department = department;
        this.totalClasses = totalClasses;
        this.presentClasses = presentClasses;
        this.percentage = percentage;
    }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public int getTotalClasses() { return totalClasses; }
    public void setTotalClasses(int totalClasses) { this.totalClasses = totalClasses; }

    public int getPresentClasses() { return presentClasses; }
    public void setPresentClasses(int presentClasses) { this.presentClasses = presentClasses; }

    public double getPercentage() { return percentage; }
    public void setPercentage(double percentage) { this.percentage = percentage; }
}
