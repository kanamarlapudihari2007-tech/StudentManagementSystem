package com.sms.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * PasswordUtil provides utility methods to hash passwords using SHA-256.
 * Beginner-friendly implementation using built-in Java MessageDigest.
 */
public class PasswordUtil {

    /**
     * Hashes a plain-text password using SHA-256 algorithm.
     *
     * @param password Plain-text password
     * @return Hexadecimal string of SHA-256 hash
     */
    public static String hashPassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            return "";
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedHash = digest.digest(password.getBytes("UTF-8"));
            
            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedHash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password with SHA-256", e);
        }
    }
}
