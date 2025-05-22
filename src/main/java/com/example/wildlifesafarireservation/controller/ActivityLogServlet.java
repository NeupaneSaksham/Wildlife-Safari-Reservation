package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.ActivityLogDAO;
import com.example.wildlifesafarireservation.models.ActivityLog;
import com.example.wildlifesafarireservation.utils.DBConnectionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/activity-log")
public class ActivityLogServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ActivityLogDAO logDAO = new ActivityLogDAO();
        List<ActivityLog> logs = logDAO.getAllLogs();

        request.setAttribute("logs", logs);
        request.getRequestDispatcher("/WEB-INF/view/activityLogs.jsp").forward(request, response);
    }
}
