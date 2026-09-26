package com.sms.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    static {
        try {
            Class.forName(JDBC_DRIVER);
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(
                "MySQL JDBC Driver not found: " + e.getMessage()
            );
        }
    }

    public static Connection getConnection() throws SQLException {

        String host = getEnv("DB_HOST", "localhost");
        String port = getEnv("DB_PORT", "3306");
        String dbName = getEnv("DB_NAME", "student_management");
        String user = getEnv("DB_USER", "root");
        String password = getEnv("DB_PASSWORD", "");

       String jdbcUrl = String.format(
    "jdbc:mysql://%s:%s/%s?sslMode=REQUIRED&serverTimezone=UTC",
    host, port, dbName
);

        return DriverManager.getConnection(jdbcUrl, user, password);
    }

    private static String getEnv(String name, String defaultValue) {
        String value = System.getenv(name);

        return (value != null && !value.trim().isEmpty())
                ? value.trim()
                : defaultValue;
    }
}