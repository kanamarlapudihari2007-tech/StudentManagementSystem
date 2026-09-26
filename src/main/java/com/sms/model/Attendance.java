package com.sms.model;

/**
 * Model class representing Attendance log for a Student.
 */
public class Attendance {
    private int id;
    private String studentId;
    private String studentName;
    private String attendanceDate;
    private String status; // 'Present' or 'Absent'

    public Attendance() {}

    public Attendance(int id, String studentId, String attendanceDate, String status) {
        this.id = id;
        this.studentId = studentId;
        this.attendanceDate = attendanceDate;
        this.status = status;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getAttendanceDate() { return attendanceDate; }
    public void setAttendanceDate(String attendanceDate) { this.attendanceDate = attendanceDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
