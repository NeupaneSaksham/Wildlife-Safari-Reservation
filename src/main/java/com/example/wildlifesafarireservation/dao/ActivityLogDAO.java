package com.example.wildlifesafarireservation.dao;

import com.example.wildlifesafarireservation.models.ActivityLog;
import com.example.wildlifesafarireservation.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivityLogDAO {

    public List<ActivityLog> getAllLogs() {
        List<ActivityLog> logs = new ArrayList<>();
        String sql = "SELECT id, user_id, activity, activity_type, created_at FROM activity_logs ORDER BY created_at DESC";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ActivityLog log = new ActivityLog();
                log.setId(rs.getInt("id"));
                log.setUserId(rs.getInt("user_id"));
                log.setActivity(rs.getString("activity"));
                log.setActivityType(rs.getString("activity_type"));
                log.setCreatedAt(rs.getTimestamp("created_at"));
                logs.add(log);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logs;
    }

    public boolean addActivityLog(ActivityLog log) {
        if (!userExists(log.getUserId())) {
            System.err.println("User ID does not exist: " + log.getUserId());
            return false;
        }

        String sql = "INSERT INTO activity_logs (user_id, activity, activity_type, created_at) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, log.getUserId());
            stmt.setString(2, log.getActivity());
            stmt.setString(3, log.getActivityType());
            stmt.setTimestamp(4, log.getCreatedAt());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean userExists(int userId) {
        String checkSql = "SELECT id FROM users WHERE id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(checkSql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
