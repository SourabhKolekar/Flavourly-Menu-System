package org.example.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Utility class for managing database connections.
 * Provides a centralized way to obtain database connections.
 */
public final class DatabaseUtil {
    // Database configuration
    // currently using localhost which should be provided from secret manager and env variables
    private static final String DB_URL = "jdbc:mysql://localhost:3306/flavourly_menu_db?useSSL=false";
    private static final String USER = "root";
    private static final String PASS = "root@1234";

    /**
     * Private constructor to prevent instantiation.
     */
    private DatabaseUtil() {
        throw new AssertionError("Database connection cannot be instantiated");
    }

    /**
     * Obtains a database connection.
     *
     * @return Active database Connection
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        Properties properties = new Properties();
        properties.setProperty("user", USER);
        properties.setProperty("password", PASS);

        return DriverManager.getConnection(DB_URL, properties);
    }
}