package com.example.wildlifesafarireservation.utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnectionUtil {
    private static final String URL;
    private static final String USER;
    private static final String PASS;
    private static final int MIN_CONNECTIONS;
    private static final int MAX_CONNECTIONS;
    private static final int CONNECTION_TIMEOUT;

    static {
        try (InputStream is = DBConnectionUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (is == null) {
                throw new RuntimeException("application.properties file not found in classpath");
            }

            Properties prop = new Properties();
            prop.load(is);

            URL = prop.getProperty("db.url");
            USER = prop.getProperty("db.username");
            PASS = prop.getProperty("db.password");
            String driver = prop.getProperty("db.driver");

            MIN_CONNECTIONS = Integer.parseInt(prop.getProperty("db.min_connections", "5"));
            MAX_CONNECTIONS = Integer.parseInt(prop.getProperty("db.max_connections", "20"));
            CONNECTION_TIMEOUT = Integer.parseInt(prop.getProperty("db.connection_timeout", "30000"));

            Class.forName(driver);

            System.out.println("Database connection properties loaded successfully");
        } catch (IOException | ClassNotFoundException | NumberFormatException e) {
            System.err.println("Error loading database properties: " + e.getMessage());
            throw new RuntimeException("Failed to load database properties", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    public static int getMinConnections() {
        return MIN_CONNECTIONS;
    }

    public static int getMaxConnections() {
        return MAX_CONNECTIONS;
    }

    public static int getConnectionTimeout() {
        return CONNECTION_TIMEOUT;
    }
}
