package com.example.wildlifesafarireservation.dao;

import com.example.wildlifesafarireservation.models.UserModel;
import com.example.wildlifesafarireservation.utils.DBConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    private static final String INSERT_USER = "INSERT INTO users(full_name, email, password, role) VALUES(?,?,?,?)";
    private static final String SELECT_USER_BY_EMAIL_PASSWORD = "SELECT * FROM users WHERE email = ? AND password = ?";
    private static final String SELECT_USER_BY_ID = "SELECT * FROM users WHERE id = ?";
    private static final String SELECT_USER_BY_EMAIL = "SELECT * FROM users WHERE email = ?";

    public static int registerUser(UserModel user) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_USER, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole().name());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error registering user: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return -1;
    }

    public static UserModel loginUser(UserModel user) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_EMAIL_PASSWORD)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserModel userFromDB = new UserModel();
                userFromDB.setId(rs.getInt("id"));
                userFromDB.setFullName(rs.getString("full_name"));
                userFromDB.setEmail(rs.getString("email"));
                userFromDB.setPassword(rs.getString("password"));
                userFromDB.setRole(UserModel.Role.valueOf(rs.getString("role")));
                return userFromDB;
            }
        } catch (SQLException e) {
            System.err.println("Error authenticating user: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }

    public static UserModel getUserById(int id) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_ID)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserModel userFromDB = new UserModel();
                userFromDB.setId(rs.getInt("id"));
                userFromDB.setFullName(rs.getString("full_name"));
                userFromDB.setEmail(rs.getString("email"));
                userFromDB.setPassword(rs.getString("password"));
                userFromDB.setRole(UserModel.Role.valueOf(rs.getString("role")));
                return userFromDB;
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving user by ID: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }

    /**
     * Get user by email address.
     *
     * @param email the email to search for
     * @return UserModel if found, null otherwise
     */
    public static UserModel getUserByEmail(String email) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_EMAIL)) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserModel user = new UserModel();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(UserModel.Role.valueOf(rs.getString("role")));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving user by email: " + e.getMessage());
            throw new RuntimeException(e);
        }

        return null;
    }
}
