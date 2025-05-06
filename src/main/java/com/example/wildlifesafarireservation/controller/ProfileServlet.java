package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.UserDAO;
import com.example.wildlifesafarireservation.models.UserModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Get the session without creating a new one

        if (session == null || session.getAttribute("userId") == null) {
            // If no session exists or userId is not present in session, redirect to login page
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve userId from session
        int userId = (int) session.getAttribute("userId");

        try {
            // Retrieve user data from the database using the UserDAO
            UserModel user = UserDAO.getUserById(userId);

            // Check if the user data was found
            if (user == null) {
                // If no user data is found, send a "not found" error
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
                return;
            }

            // Set the user object as a request attribute
            request.setAttribute("user", user);

            // Forward the request to the profile.jsp page
            request.getRequestDispatcher("profile.jsp").forward(request, response);

        } catch (Exception e) {
            // Log the error and provide a user-friendly message
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load profile. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
