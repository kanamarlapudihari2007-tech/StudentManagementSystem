package com.sms.dao;

import com.sms.model.Attendance;
import com.sms.model.AttendanceSummary;
import com.sms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) for Attendance operations.
 */
public class AttendanceDAO {

    /**
     * Retrieves all raw attendance logs joined with student name.
     */
    public List<Attendance> getAllAttendanceLogs() {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT a.id, a.student_id, s.name AS student_name, a.attendance_date, a.status " +
                     "FROM attendance a JOIN students s ON a.student_id = s.student_id " +
                     "ORDER BY a.attendance_date DESC, a.id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Attendance a = new Attendance();
                a.setId(rs.getInt("id"));
                a.setStudentId(rs.getString("student_id"));
                a.setStudentName(rs.getString("student_name"));
                Date attDate = rs.getDate("attendance_date");
                a.setAttendanceDate(attDate != null ? attDate.toString() : "");
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Records new attendance entry for a student.
     */
    public boolean recordAttendance(Attendance attendance) {
        String sql = "INSERT INTO attendance (student_id, attendance_date, status) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, attendance.getStudentId());
            stmt.setDate(2, Date.valueOf(attendance.getAttendanceDate()));
            stmt.setString(3, attendance.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Deletes an attendance record.
     */
    public boolean deleteAttendance(int id) {
        String sql = "DELETE FROM attendance WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Calculates Attendance Summary (Total, Present, Percentage) for all students.
     */
    public List<AttendanceSummary> getAttendanceSummaries() {
        List<AttendanceSummary> list = new ArrayList<>();
        String sql = "SELECT s.student_id, s.name, s.department, " +
                     "COUNT(a.id) AS total_classes, " +
                     "SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS present_classes " +
                     "FROM students s LEFT JOIN attendance a ON s.student_id = a.student_id " +
                     "GROUP BY s.student_id, s.name, s.department";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int total = rs.getInt("total_classes");
                int present = rs.getInt("present_classes");
                double pct = (total > 0) ? ((double) present / total) * 100.0 : 100.0;

                AttendanceSummary summary = new AttendanceSummary(
                        rs.getString("student_id"),
                        rs.getString("name"),
                        rs.getString("department"),
                        total,
                        present,
                        Math.round(pct * 100.0) / 100.0
                );
                list.add(summary);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieves students with attendance below threshold percentage (e.g. 75%).
     */
    public List<AttendanceSummary> getLowAttendanceStudents(double threshold) {
        List<AttendanceSummary> all = getAttendanceSummaries();
        List<AttendanceSummary> lowList = new ArrayList<>();
        for (AttendanceSummary s : all) {
            if (s.getTotalClasses() > 0 && s.getPercentage() < threshold) {
                lowList.add(s);
            }
        }
        return lowList;
    }

    /**
     * Returns total count of students with attendance below 75% for dashboard display.
     */
    public int getLowAttendanceCount() {
        return getLowAttendanceStudents(75.0).size();
    }
}
