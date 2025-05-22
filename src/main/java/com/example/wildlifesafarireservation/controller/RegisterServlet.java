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
                forwardWithError(request, response, "Name is required.");
                return;
            }

            if (email == null || email.trim().isEmpty() || !isValidEmail(email)) {
                forwardWithError(request, response, "Valid email is required.");
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                forwardWithError(request, response, "Password is required.");
                return;
            }

            if (!password.equals(confirmPassword)) {
                forwardWithError(request, response, "Passwords do not match.");
                return;
            }

            // Register the user (profileImage not needed anymore)
            int userID = AuthService.register(name, email, password, role);

            if (userID != -1) {
                HttpSession session = request.getSession();
                session.setAttribute("user", AuthService.getUserById(userID));
                session.setMaxInactiveInterval(1800); // 30 minutes
                response.sendRedirect("LoginServlet?success=Account created successfully. Please log in.");
            } else {
                forwardWithError(request, response, "Registration failed. Email might be in use.");
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during registration", e);
            forwardWithError(request, response, "An error occurred: " + e.getMessage());
        }
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return Pattern.compile(emailRegex).matcher(email).matches();
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/WEB-INF/view/Register.jsp").forward(request, response);
    }
}
