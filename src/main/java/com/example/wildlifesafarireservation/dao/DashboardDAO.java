package com.example.wildlifesafarireservation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DashboardDAO {

    private Connection connection;

    public DashboardDAO(Connection connection) {
        this.connection = connection;
    }

    // Get total number of reservations
    public int getTotalReservations() {
        String sql = "SELECT COUNT(*) AS total FROM reservation";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get total number of users
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) AS total FROM users";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get count of reservations by status (e.g., Pending, Confirmed)
    public int getReservationsCountByStatus(String status) {
        String sql = "SELECT COUNT(*) AS total FROM reservation WHERE status = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get total revenue from all reservations
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_cost) AS revenue FROM reservation";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble("revenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
}
