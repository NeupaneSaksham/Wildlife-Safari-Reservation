package com.example.wildlifesafarireservation.models;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.Serializable;

/**
 * UserModel Class
 *
 * Represents a user in the Wildlife Demo Application.
 * Includes attributes like id, name, email, password, role, and profile image.
 * Implements Serializable for session storage and includes session/cookie helpers.
 */
public class UserModel implements Serializable {

    // Enumeration for User Roles
    public enum Role { ADMIN, USER }

    // Attributes
    private int id;
    private String fullName;
    private String email;
    private String password;
    private Role role;
    private byte[] image;

    // Default constructor for JavaBeans/session management
    public UserModel() {}

    // Constructor to create a UserModel with only email and password for login
    public UserModel(String email, String password) {
        this.email = email;
        this.password = password;
    }

    // All-args constructor
    public UserModel(int id, String fullName, String email, String password, Role role, byte[] image) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.image = image;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }

    public byte[] getImage() { return image; }
    public void setImage(byte[] image) { this.image = image; }

    /**
     * Store the user object in session after login.
     *
     * @param request HTTP request to get session from
     * @param user    UserModel object to store
     */
    public static void storeUserInSession(HttpServletRequest request, UserModel user) {
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
    }

    /**
     * Get the currently logged-in user from session.
     *
     * @param request HTTP request with session
     * @return UserModel object or null if not logged in
     */
    public static UserModel getUserFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (UserModel) session.getAttribute("user");
        }
        return null;
    }

    /**
     * Logout the user by invalidating session and clearing relevant cookies.
     *
     * @param request  HTTP request
     * @param response HTTP response to set cleared cookies
     */
    public static void logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Invalidate session
        }

        // Remove authentication cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_email".equals(cookie.getName())) {
                    cookie.setMaxAge(0); // Expire the cookie
                    cookie.setPath("/"); // Ensure cookie is removed across entire app
                    response.addCookie(cookie);
                }
            }
        }
    }
}
