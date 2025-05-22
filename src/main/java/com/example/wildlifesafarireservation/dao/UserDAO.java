package com.example.wildlifesafarireservation.dao;

import com.example.wildlifesafarireservation.models.UserModel;
import com.example.wildlifesafarireservation.utils.DBConnectionUtil;
import com.example.wildlifesafarireservation.utils.PasswordHashUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private static final String INSERT_USER =
            "INSERT INTO users(full_name, email, password, role, phone, address, profile_image) VALUES(?,?,?,?,?,?,?)";
    private static final String SELECT_USER_BY_EMAIL =
            "SELECT * FROM users WHERE email = ?";
    private static final String SELECT_USER_BY_ID =
            "SELECT * FROM users WHERE id = ?";
    private static final String SELECT_ALL_USERS =
            "SELECT * FROM users";
    private static final String UPDATE_USER =
            "UPDATE users SET full_name=?, email=?, phone=?, address=?, profile_image=? WHERE id=?";
    private static final String UPDATE_PASSWORD =
            "UPDATE users SET password=? WHERE id=?";
    private static final String DELETE_USER =
            "DELETE FROM users WHERE id=?";
    private static final String CHECK_EMAIL_EXISTS =
            "SELECT 1 FROM users WHERE email = ?";

    public UserDAO(Connection connection) {
    }

    public UserDAO() {
    }

    // Register new user
    public static int registerUser(UserModel user) {
        // Check if email already exists
        if (isEmailExist(user.getEmail())) {
            System.err.println("Email already exists: " + user.getEmail());
            return -1; // or throw exception based on your design choice
        }

        String hashedPassword = PasswordHashUtil.hashPassword(user.getPassword());

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_USER, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, hashedPassword);
            ps.setString(4, user.getRoleEnum().name());  // Store role as string enum: "ADMIN" or "USER"
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getProfileImage());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Registration failed: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

    // Check if email already exists
    public static boolean isEmailExist(String email) {
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_EMAIL_EXISTS)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();  // if there is a row, email exists
            }
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Authenticate user
    public static UserModel loginUser(String email, String password) {
        UserModel user = getUserByEmail(email);
        if (user != null) {
            boolean passwordMatch = PasswordHashUtil.checkPassword(password, user.getPassword());
            if (passwordMatch) {
                return user;
            }
        }
        return null;
    }

    // Get user by email
    public static UserModel getUserByEmail(String email) {
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_USER_BY_EMAIL)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user by email: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Get user by ID
    public static UserModel getUserById(int id) {
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_USER_BY_ID)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Get all users
    public static List<UserModel> getAllUsers() {
        List<UserModel> users = new ArrayList<>();

        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(SELECT_ALL_USERS)) {

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching all users: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    // Update user profile (excluding password)
    public static boolean updateUser(UserModel user) {
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_USER)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getProfileImage());
            ps.setInt(6, user.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Update password
    public static boolean updatePassword(int userId, String newPassword) {
        String hashedPassword = PasswordHashUtil.hashPassword(newPassword);

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_PASSWORD)) {

            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating password: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Delete user
    public static boolean deleteUser(int id) {
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_USER)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Map ResultSet row to UserModel, reading role as string enum
    private static UserModel mapResultSetToUser(ResultSet rs) throws SQLException {
        UserModel user = new UserModel();
        user.setId(rs.getInt("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password")); // hashed password

        String roleStr = rs.getString("role");  // read role as string
        try {
            user.setRole(UserModel.Role.valueOf(roleStr));
        } catch (IllegalArgumentException | NullPointerException e) {
            System.err.println("Invalid role value in DB: " + roleStr);
            user.setRole(UserModel.Role.USER);  // default fallback
        }

        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setProfileImage(rs.getString("profile_image"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        return user;
    }
}
