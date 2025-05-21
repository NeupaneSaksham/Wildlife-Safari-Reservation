package com.example.wildlifesafarireservation.dao;

import com.example.wildlifesafarireservation.models.ActivityLog;
import com.example.wildlifesafarireservation.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivityLogDAO {

    public ActivityLogDAO(Connection connection) {
    }

    public ActivityLogDAO() {

    }

    // Insert a new activity log into the database
    public boolean addActivityLog(ActivityLog log) {
        String sql = "INSERT INTO activity_logs (activity, activity_type, user_id, created_at) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, log.getActivity());
            stmt.setString(2, log.getActivityType());
            stmt.setInt(3, log.getUserId());
            stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve all activity logs from the database
    public List<ActivityLog> getAllActivityLogs() {
        List<ActivityLog> logs = new ArrayList<>();
        String sql = "SELECT * FROM activity_logs ORDER BY created_at DESC";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ActivityLog log = new ActivityLog();
                log.setId(rs.getInt("id"));
                log.setActivity(rs.getString("activity"));
                log.setActivityType(rs.getString("activity_type"));
                log.setUserId(rs.getInt("user_id"));
                log.setCreatedAt(rs.getTimestamp("created_at"));
                logs.add(log);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logs;
    }
}
