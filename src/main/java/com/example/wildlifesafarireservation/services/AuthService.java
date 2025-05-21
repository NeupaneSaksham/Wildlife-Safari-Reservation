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

    public static int register(String fullName, String email, String password, String role, byte[] profileImage) {
        validateUserInput(fullName, email, password);

        // Handle invalid role more gracefully
        UserModel.Role userRole;
        try {
            userRole = UserModel.Role.valueOf(role.toUpperCase());
        } catch (IllegalArgumentException e) {
            logger.log(Level.SEVERE, "Invalid role provided during registration: " + role, e);
            throw new IllegalArgumentException("Invalid role provided");
        }

        String hashedPassword = PasswordHashUtil.hashPassword(password);
        UserModel user = new UserModel();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setRole(userRole);


        return UserDAO.registerUser(user);
    }

    public static Optional<UserModel> authenticate(String email, String password) {
        UserModel user = UserDAO.getUserByEmail(email);
        if (user != null && PasswordHashUtil.checkPassword(password, user.getPassword())) {
            return Optional.of(user);
        }
        logger.log(Level.WARNING, "Failed login attempt for email: " + email);
        return Optional.empty();
    }

    public static UserModel getUserById(int id) {
        return UserDAO.getUserById(id);
    }

    public static boolean validateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }

    public static boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            UserModel user = (UserModel) session.getAttribute("user");
            if (user != null && user.getRoleEnum() == UserModel.Role.ADMIN) {
                return true;
            }
        }
        return false;
    }



    public static void logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        clearRememberMeCookies(request, response);

        try {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Error during logout", e);
        }
    }

    private static void validateUserInput(String fullName, String email, String password) {
        if (fullName == null || fullName.isBlank() ||
                email == null || email.isBlank() ||
                password == null || password.isBlank()) {
            throw new IllegalArgumentException("Full Name, Email, and Password are required");
        }
    }

    private static void clearRememberMeCookies(HttpServletRequest request, HttpServletResponse response) {
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if ("user_email".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    cookie.setHttpOnly(true);
                    cookie.setSecure(true); // Secure flag to ensure cookie is sent over HTTPS
                    response.addCookie(cookie);
                    logger.info("Cleared 'Remember Me' cookie for user.");
                }
            }
        }
    }
}
