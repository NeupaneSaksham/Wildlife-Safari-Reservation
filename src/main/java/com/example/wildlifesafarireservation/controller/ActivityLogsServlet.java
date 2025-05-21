package com.example.wildlifesafarireservation.controller;

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

@WebServlet("/activityLogs")
public class ActivityLogsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ActivityLog> logs = new ArrayList<>();

        String sql = "SELECT id, activity, activity_type, user_id, created_at FROM activity_logs ORDER BY created_at DESC";

        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ActivityLog log = new ActivityLog();
                log.setId(rs.getInt("id"));
                log.setActivity(rs.getString("activity"));
                log.setActivityType(rs.getString("activity_type"));
                log.setUserId(rs.getInt("user_id"));
                log.setCreatedAt(rs.getTimestamp("created_at"));
                logs.add(log);
            }

            System.out.println("Fetched " + logs.size() + " activity logs from DB.");
            for (ActivityLog log : logs) {
                System.out.println(
                        "Log ID: " + log.getId() +
                                ", Activity: " + log.getActivity() +
                                ", Type: " + log.getActivityType() +
                                ", User ID: " + log.getUserId() +
                                ", Created At: " + log.getCreatedAt()
                );
            }


        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving activity logs: " + e.getMessage());
        }

        request.setAttribute("activityLogs", logs);
        request.getRequestDispatcher("/WEB-INF/view/activityLogs.jsp").forward(request, response);
    }
}
