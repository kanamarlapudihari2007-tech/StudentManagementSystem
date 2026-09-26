package com.sms.dao;

import com.sms.model.Marks;
import com.sms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) for Marks database operations.
 */
public class MarksDAO {

    /**
     * Retrieves all marks joined with student name.
     */
    public List<Marks> getAllMarks() {
        List<Marks> list = new ArrayList<>();
        String sql = "SELECT m.id, m.student_id, s.name AS student_name, m.subject, m.marks " +
                     "FROM marks m JOIN students s ON m.student_id = s.student_id " +
                     "ORDER BY m.id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Marks m = new Marks();
                m.setId(rs.getInt("id"));
                m.setStudentId(rs.getString("student_id"));
                m.setStudentName(rs.getString("student_name"));
                m.setSubject(rs.getString("subject"));
                m.setMarks(rs.getInt("marks"));
                list.add(m);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching marks: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Inserts new subject marks for a student.
     */
    public boolean addMarks(Marks marks) {
        String sql = "INSERT INTO marks (student_id, subject, marks) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, marks.getStudentId());
            stmt.setString(2, marks.getSubject());
            stmt.setInt(3, marks.getMarks());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding marks: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Deletes marks entry by record ID.
     */
    public boolean deleteMarks(int id) {
        String sql = "DELETE FROM marks WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting marks: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}
