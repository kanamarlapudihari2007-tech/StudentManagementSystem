package com.sms.dao;

import com.sms.model.Fees;
import com.sms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) for Fees database operations.
 */
public class FeesDAO {

    /**
     * Retrieves all fee records joined with student names.
     */
    public List<Fees> getAllFees() {
        List<Fees> list = new ArrayList<>();
        String sql = "SELECT f.id, f.student_id, s.name AS student_name, f.total_fee, f.paid_fee " +
                     "FROM fees f JOIN students s ON f.student_id = s.student_id " +
                     "ORDER BY f.id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Fees f = new Fees();
                f.setId(rs.getInt("id"));
                f.setStudentId(rs.getString("student_id"));
                f.setStudentName(rs.getString("student_name"));
                f.setTotalFee(rs.getDouble("total_fee"));
                f.setPaidFee(rs.getDouble("paid_fee"));
                list.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Adds new fee record or updates existing fee record for a student.
     */
    public boolean saveOrUpdateFees(Fees fees) {
        String checkSql = "SELECT id FROM fees WHERE student_id = ?";
        String insertSql = "INSERT INTO fees (student_id, total_fee, paid_fee) VALUES (?, ?, ?)";
        String updateSql = "UPDATE fees SET total_fee = ?, paid_fee = ? WHERE student_id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            boolean exists = false;
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, fees.getStudentId());
                try (ResultSet rs = checkStmt.executeQuery()) {
                    exists = rs.next();
                }
            }

            if (exists) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setDouble(1, fees.getTotalFee());
                    updateStmt.setDouble(2, fees.getPaidFee());
                    updateStmt.setString(3, fees.getStudentId());
                    return updateStmt.executeUpdate() > 0;
                }
            } else {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setString(1, fees.getStudentId());
                    insertStmt.setDouble(2, fees.getTotalFee());
                    insertStmt.setDouble(3, fees.getPaidFee());
                    return insertStmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Deletes a fee record by ID.
     */
    public boolean deleteFees(int id) {
        String sql = "DELETE FROM fees WHERE id = ?";

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
     * Retrieves students with pending fee balances (Total Fee > Paid Fee).
     */
    public List<Fees> getPendingFeesStudents() {
        List<Fees> all = getAllFees();
        List<Fees> pendingList = new ArrayList<>();
        for (Fees f : all) {
            if (f.getRemainingFee() > 0.0) {
                pendingList.add(f);
            }
        }
        return pendingList;
    }

    /**
     * Calculates count of students with pending fees for dashboard.
     */
    public int getPendingFeesCount() {
        return getPendingFeesStudents().size();
    }
}
