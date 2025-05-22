package com.example.wildlifesafarireservation.services;

import com.example.wildlifesafarireservation.dao.UserDAO;
import com.example.wildlifesafarireservation.models.UserModel;
import com.example.wildlifesafarireservation.utils.PasswordHashUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;

import java.io.IOException;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AuthService {

    private static final Logger logger = Logger.getLogger(AuthService.class.getName());
    private static UserDAO userDao = new UserDAO();

    // Dependency Injection through constructor
    public AuthService(UserDAO userDao) {
        this.userDao = userDao;
    }

    // Register new user
    public static int register(String fullName, String email, String password, String role) {
        validateUserInput(fullName, email, password);

        UserModel.Role userRole;
        try {
            userRole = UserModel.Role.valueOf(role.toUpperCase());
        } catch (IllegalArgumentException e) {
            logger.log(Level.SEVERE, "Invalid role provided: " + role, e);
            throw new IllegalArgumentException("Invalid role provided.");
        }

        String normalizedEmail = email.toLowerCase().trim();

        if (userDao.getUserByEmail(normalizedEmail) != null) {
            logger.warning("Registration attempt with existing email: " + normalizedEmail);
            return -1;
        }

        String hashedPassword = PasswordHashUtil.hashPassword(password);

        UserModel user = new UserModel();
        user.setFullName(fullName);
        user.setEmail(normalizedEmail);
        user.setPassword(hashedPassword);
        user.setRole(userRole);
        // Optionally store profileImage here if you support it

        int userId = userDao.registerUser(user);
        if (userId > 0) {
            logger.info("User registered successfully: " + userId);
        } else {
            logger.warning("User registration failed for: " + normalizedEmail);
        }
        return userId;
    }

    // Authenticate user
    public static Optional<UserModel> authenticate(String email, String password) {
        if (email == null || email.isBlank() || password == null || password.isBlank()) {
            return Optional.empty();
        }

        UserModel user = userDao.getUserByEmail(email.toLowerCase().trim());
        if (user != null && PasswordHashUtil.checkPassword(password, user.getPassword())) {
            return Optional.of(user);
        }

        logger.warning("Failed login attempt for email: " + email);
        return Optional.empty();
    }

    // Get user by ID
    public static UserModel getUserById(int id) {
        return userDao.getUserById(id);
    }

    // Validate if a session has a logged-in user
    public static boolean validateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }

    // Check if current user is admin
    public boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            UserModel user = (UserModel) session.getAttribute("user");
            return user != null && user.getRoleEnum() == UserModel.Role.ADMIN;
        }
        return false;
    }

    // Logout and invalidate session
    public void logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        clearRememberMeCookies(request, response);

        try {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Logout redirect failed", e);
        }
    }

    // Input validation helper
    private static void validateUserInput(String fullName, String email, String password) {
        if (fullName == null || fullName.isBlank() ||
                email == null || email.isBlank() ||
                password == null || password.isBlank()) {
            throw new IllegalArgumentException("Full Name, Email, and Password are required.");
        }
    }

    // Clear cookies on logout
    private void clearRememberMeCookies(HttpServletRequest request, HttpServletResponse response) {
        if (request.getCookies() == null) return;

        for (Cookie cookie : request.getCookies()) {
            if ("user_email".equals(cookie.getName())) {
                cookie.setMaxAge(0);
                cookie.setPath("/");
                cookie.setHttpOnly(true);
                cookie.setSecure(true);
                response.addCookie(cookie);
                logger.info("Cleared 'Remember Me' cookie.");
            }
        }
    }
}
