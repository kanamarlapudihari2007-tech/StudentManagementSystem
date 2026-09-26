package com.sms.model;

/**
 * Model class representing Marks for a Student.
 */
public class Marks {
    private int id;
    private String studentId;
    private String studentName; // Joined from students table for display
    private String subject;
    private int marks;

    public Marks() {}

    public Marks(int id, String studentId, String subject, int marks) {
        this.id = id;
        this.studentId = studentId;
        this.subject = subject;
        this.marks = marks;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public int getMarks() { return marks; }
    public void setMarks(int marks) { this.marks = marks; }

    /**
     * Calculates letter grade based on numerical marks.
     */
    public String getGrade() {
        if (marks >= 90) return "A+";
        if (marks >= 80) return "A";
        if (marks >= 70) return "B";
        if (marks >= 60) return "C";
        if (marks >= 50) return "D";
        return "F";
    }
}
