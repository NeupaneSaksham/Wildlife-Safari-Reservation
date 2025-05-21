package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.services.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.regex.Pattern;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 20
)
public class RegisterServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(RegisterServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/Register.jsp").forward(request, response);
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

            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Name is required.");
                request.getRequestDispatcher("/WEB-INF/view/Register.jsp").forward(request, response);
                return;
            }

            if (email == null || email.trim().isEmpty() || !isValidEmail(email)) {
                request.setAttribute("errorMessage", "Valid email is required.");
                request.getRequestDispatcher("/WEB-INF/view/Register.jsp").forward(request, response);
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Password is required.");
                request.getRequestDispatcher("/WEB-INF/view/Register.jsp").forward(request, response);
                return;
            }

            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Passwords do not match.");
                request.getRequestDispatcher("/WEB-INF/view/Register.jsp").forward(request, response);
                return;
            }

            Part imagePart = request.getPart("image");
            byte[] imageBytes = null;

            if (imagePart != null && imagePart.getSize() > 0) {
                if (imagePart.getSize() > 1024 * 1024 * 5) {
                    request.setAttribute("errorMessage", "Image too large. Max size is 5MB.");
                    request.getRequestDispatcher("/WEB-INF/view/Register.jsp").forward(request, response);
                    return;
                }

                if (!imagePart.getContentType().startsWith("image/")) {
                    request.setAttribute("errorMessage", "Invalid file type. Please upload an image.");
                    request.getRequestDispatcher("/WEB-INF/view/Register.jsp").forward(request, response);
                    return;
                }

                imageBytes = imagePart.getInputStream().readAllBytes();
            }

            int userID = AuthService.register(name, email, password, role, imageBytes);

            if (userID != -1) {
                HttpSession session = request.getSession();
                session.setAttribute("user", AuthService.getUserById(userID));
                session.setMaxInactiveInterval(1800);
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("errorMessage", "Registration failed. Email might be in use.");
                request.getRequestDispatcher("/WEB-INF/view/Register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during registration", e);
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/Register.jsp").forward(request, response);
        }
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }
}
