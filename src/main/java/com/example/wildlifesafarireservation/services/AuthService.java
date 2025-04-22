package com.example.wildlifesafarireservation.services;

import com.example.wildlifesafarireservation.dao.UserDAO;
import com.example.wildlifesafarireservation.models.UserModel;
import com.example.wildlifesafarireservation.utils.PasswordHashUtil;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AuthService {

    private static final Logger logger = Logger.getLogger(AuthService.class.getName());

    /**
     * Register a new user.
     *
     * @param fullName The user's full name
     * @param email The user's email address
     * @param password The user's password
     * @param role The user's role (e.g., "USER" or "ADMIN")
     * @param profileImage The user's profile image as a byte array (optional)
     * @return The ID of the registered user, or -1 if registration fails
     */
    public static int register(String fullName, String email, String password, String role, byte[] profileImage) {
        // Validate input
        validateUserInput(fullName, email, password);

        // Hash the password
        String hashedPassword = PasswordHashUtil.hashPassword(password);

        // Create a new UserModel
        UserModel user = new UserModel();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setRole(UserModel.Role.valueOf(role.toUpperCase()));
        user.setImage(profileImage);

        // Save user to the database
        return UserDAO.registerUser(user);
    }

    /**
     * Validate user input during registration.
     *
     * @param fullName The user's full name
     * @param email The user's email address
     * @param password The user's password
     */
    private static void validateUserInput(String fullName, String email, String password) {
        if (fullName == null || fullName.trim().isEmpty()) {
            throw new IllegalArgumentException("Full Name is required");
        }
        if (email == null || email.trim().isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }
        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }
    }

    /**
     * Authenticate a user by checking email and password.
     *
     * @param email The user's email address
     * @param password The user's password
     * @return An Optional containing the UserModel if authentication is successful, otherwise empty
     */
    public static Optional<UserModel> authenticate(String email, String password) {
        UserModel user = UserDAO.getUserByEmail(email);

        if (user != null && PasswordHashUtil.checkPassword(password, user.getPassword())) {
            return Optional.of(user);
        }

        return Optional.empty();
    }

    /**
     * Retrieve a user by their ID.
     *
     * @param id The user ID
     * @return The UserModel if found, otherwise null
     */
    public static UserModel getUserById(int id) {
        return UserDAO.getUserById(id);
    }

    /**
     * Validate session and ensure the user is logged in.
     *
     * @param request The HTTP request
     * @return true if the user is logged in, false otherwise
     */
    public static boolean validateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }

    /**
     * Check if the logged-in user is an admin.
     *
     * @param request The HTTP request
     * @return true if the user is an admin, false otherwise
     */
    public static boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            UserModel user = (UserModel) session.getAttribute("user");
            return user != null && user.getRole() == UserModel.Role.ADMIN;
        }
        return false;
    }

    /**
     * Handle user logout by invalidating the session.
     *
     * @param request The HTTP request
     * @param response The HTTP response
     */
    public static void logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Optionally, clear the "remember me" cookies
        clearRememberMeCookies(request, response);

        // Redirect to the login page
        try {
            response.sendRedirect("login.jsp");
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Error during logout", e);
        }
    }

    /**
     * Clear the "remember me" cookies if any exist.
     *
     * @param request The HTTP request
     * @param response The HTTP response
     */
    private static void clearRememberMeCookies(HttpServletRequest request, HttpServletResponse response) {
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if ("user_email".equals(cookie.getName())) {
                    cookie.setMaxAge(0); // Expire the cookie immediately
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }
        }
    }
}
