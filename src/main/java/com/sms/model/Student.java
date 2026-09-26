package com.sms.model;

/**
 * Model class representing a Student.
 */
public class Student {
    private String studentId;
    private String name;
    private String dob;
    private String gender;
    private String phone;
    private String email;
    private String department;
    private String year;
    private String section;

    public Student() {}

    public Student(String studentId, String name, String dob, String gender, String phone, 
                   String email, String department, String year, String section) {
        this.studentId = studentId;
        this.name = name;
        this.dob = dob;
        this.gender = gender;
        this.phone = phone;
        this.email = email;
        this.department = department;
        this.year = year;
        this.section = section;
    }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getYear() { return year; }
    public void setYear(String year) { this.year = year; }

    public String getSection() { return section; }
    public void setSection(String section) { this.section = section; }
}
