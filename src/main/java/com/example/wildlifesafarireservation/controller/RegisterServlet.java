package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,     // 1MB
        maxFileSize = 1024 * 1024 * 5,       // 5MB
        maxRequestSize = 1024 * 1024 * 20    // 20MB
)
public class RegisterServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(RegisterServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/register/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm-password");
            String role = request.getParameter("role");

            // Input validation
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Name is required.");
                request.getRequestDispatcher("/view/register/register.jsp").forward(request, response);
                return;
            }

            if (email == null || email.trim().isEmpty() || !isValidEmail(email)) {
                request.setAttribute("errorMessage", "Valid email is required.");
                request.getRequestDispatcher("/view/register/register.jsp").forward(request, response);
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Password is required.");
                request.getRequestDispatcher("/view/register/register.jsp").forward(request, response);
                return;
            }

            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Passwords do not match.");
                request.getRequestDispatcher("/view/register/register.jsp").forward(request, response);
                return;
            }

            // Handle image upload
            Part imagePart = request.getPart("image");
            byte[] imageBytes = null;

            if (imagePart != null && imagePart.getSize() > 0) {
                if (imagePart.getSize() > 1024 * 1024 * 5) {
                    request.setAttribute("errorMessage", "Image too large. Max size is 5MB.");
                    request.getRequestDispatcher("/view/register/register.jsp").forward(request, response);
                    return;
                }

                if (!imagePart.getContentType().startsWith("image/")) {
                    request.setAttribute("errorMessage", "Invalid file type. Please upload an image.");
                    request.getRequestDispatcher("/view/register/register.jsp").forward(request, response);
                    return;
                }

                imageBytes = imagePart.getInputStream().readAllBytes();
            }

            // Register user
            int userID = AuthService.register(name, email, password, role, imageBytes);

            if (userID != -1) {
                // Set user session and redirect to index.jsp
                HttpSession session = request.getSession();
                session.setAttribute("user", AuthService.getUserById(userID));
                session.setMaxInactiveInterval(1800); // 30 minutes
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("errorMessage", "Registration failed. Email might be in use.");
                request.getRequestDispatcher("/view/register/register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during registration", e);
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/view/register/register.jsp").forward(request, response);
        }
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }
}
