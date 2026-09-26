package com.sms.dao;

import com.sms.model.Admin;
import com.sms.util.DBConnection;
import com.sms.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Data Access Object (DAO) for Admin database operations.
 */
public class AdminDAO {

    /**
     * Authenticates an admin by username and plain text password.
     * Uses SHA-256 password hashing and PreparedStatement to prevent SQL injection.
     *
     * @param username Provided username
     * @param password Provided plain-text password
     * @return Admin object if authenticated successfully, null otherwise
     */
    public Admin authenticate(String username, String password) {
        String sql = "SELECT id, username, full_name, email FROM admin WHERE username = ? AND password = ?";
        String hashedPassword = PasswordUtil.hashPassword(password);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setId(rs.getInt("id"));
                    admin.setUsername(rs.getString("username"));
                    admin.setFullName(rs.getString("full_name"));
                    admin.setEmail(rs.getString("email"));
                    return admin;
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error during admin authentication: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
