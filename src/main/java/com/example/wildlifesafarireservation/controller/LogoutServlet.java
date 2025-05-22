package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.ActivityLogDAO;
import com.example.wildlifesafarireservation.models.ActivityLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = null;
        if (request.getSession(false) != null) {
            userId = (Integer) request.getSession().getAttribute("userId");
            request.getSession().invalidate();
        }

        if (userId == null) userId = -1;

        // Log the logout activity
        ActivityLogDAO logDAO = new ActivityLogDAO();
        ActivityLog log = new ActivityLog();
        log.setUserId(userId);
        log.setActivity("User logged out");
        log.setActivityType("Logout");
        log.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        logDAO.addActivityLog(log);

        response.sendRedirect(request.getContextPath() + "/LoginServlet");
    }
}
