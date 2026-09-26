package com.sms.dao;

import com.sms.model.Student;
import com.sms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) for Student CRUD database operations.
 */
public class StudentDAO {

    /**
     * Retrieves all students from database sorted by student_id.
     */
    public List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY student_id ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(extractStudentFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching all students: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Searches students by Student ID, Name, or Department.
     */
    public List<Student> searchStudents(String query) {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE student_id LIKE ? OR name LIKE ? OR department LIKE ? ORDER BY student_id ASC";
        String searchPattern = "%" + query + "%";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(extractStudentFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error searching students: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Finds a student by exact Student ID.
     */
    public Student getStudentById(String studentId) {
        String sql = "SELECT * FROM students WHERE student_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, studentId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractStudentFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting student by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Checks if a Student ID already exists in the database.
     */
    public boolean isStudentIdExists(String studentId) {
        String sql = "SELECT 1 FROM students WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Inserts a new student record into database.
     */
    public boolean addStudent(Student student) {
        String sql = "INSERT INTO students (student_id, name, dob, gender, phone, email, department, year, section) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getStudentId());
            stmt.setString(2, student.getName());
            stmt.setDate(3, Date.valueOf(student.getDob()));
            stmt.setString(4, student.getGender());
            stmt.setString(5, student.getPhone());
            stmt.setString(6, student.getEmail());
            stmt.setString(7, student.getDepartment());
            stmt.setString(8, student.getYear());
            stmt.setString(9, student.getSection());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding student: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Updates an existing student record in database.
     */
    public boolean updateStudent(Student student) {
        String sql = "UPDATE students SET name = ?, dob = ?, gender = ?, phone = ?, email = ?, department = ?, " +
                     "year = ?, section = ? WHERE student_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getName());
            stmt.setDate(2, Date.valueOf(student.getDob()));
            stmt.setString(3, student.getGender());
            stmt.setString(4, student.getPhone());
            stmt.setString(5, student.getEmail());
            stmt.setString(6, student.getDepartment());
            stmt.setString(7, student.getYear());
            stmt.setString(8, student.getSection());
            stmt.setString(9, student.getStudentId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating student: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Deletes a student by Student ID.
     */
    public boolean deleteStudent(String studentId) {
        String sql = "DELETE FROM students WHERE student_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, studentId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting student: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Calculates total students count for dashboard.
     */
    public int getTotalStudentsCount() {
        String sql = "SELECT COUNT(*) FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Calculates distinct departments count for dashboard.
     */
    public int getTotalDepartmentsCount() {
        String sql = "SELECT COUNT(DISTINCT department) FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Student extractStudentFromResultSet(ResultSet rs) throws SQLException {
        Student s = new Student();
        s.setStudentId(rs.getString("student_id"));
        s.setName(rs.getString("name"));
        Date dobDate = rs.getDate("dob");
        s.setDob(dobDate != null ? dobDate.toString() : "");
        s.setGender(rs.getString("gender"));
        s.setPhone(rs.getString("phone"));
        s.setEmail(rs.getString("email"));
        s.setDepartment(rs.getString("department"));
        s.setYear(rs.getString("year"));
        s.setSection(rs.getString("section"));
        return s;
    }
}
