package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/About-us")
public class AboutUsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if the user is logged in (session is valid)
        if (AuthService.validateSession(request)) {
            // Forward the request to the packages.jsp page for rendering content
            request.getRequestDispatcher("/WEB-INF/view/aboutUs.jsp").forward(request, response);
        } else {
            // If not logged in, redirect to the login page
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        }
    }
}
