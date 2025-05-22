package com.example.wildlifesafarireservation.dao;

import com.example.wildlifesafarireservation.models.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservDAO {

    private Connection connection;

    // Constructor to initialize the connection
    public ReservDAO(Connection connection) {
        this.connection = connection;
    }

    public ReservDAO() {

    }

    // Method to insert a new reservation
    public boolean insertReservation(Reservation reservation) {
        String sql = "INSERT INTO reservation (full_name, email, phone, number_of_guests, total_cost, reservation_date, safari_date, status, notes) " +
                "VALUES (?, ?, ?, ?, ?, NOW(), ?, 'Pending', ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, reservation.getFullName());
            ps.setString(2, reservation.getEmail());
            ps.setString(3, reservation.getPhone());
            ps.setInt(4, reservation.getNumberOfGuests());
            ps.setDouble(5, reservation.getTotalCost());
            ps.setDate(6, reservation.getSafariDate());
            ps.setString(7, reservation.getNotes()); // Notes will be set at index 7

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Return true if insertion was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to retrieve all reservations
    public List<Reservation> getAllReservations() {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM reservation";

        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setReservationId(rs.getInt("reservation_id"));
                reservation.setFullName(rs.getString("full_name"));
                reservation.setEmail(rs.getString("email"));
                reservation.setPhone(rs.getString("phone"));
                reservation.setNumberOfGuests(rs.getInt("number_of_guests"));
                reservation.setTotalCost(rs.getDouble("total_cost"));
                reservation.setReservationDate(rs.getDate("reservation_date"));
                reservation.setSafariDate(rs.getDate("safari_date")); // Directly using rs.getDate()
                reservation.setStatus(rs.getString("status"));
                reservation.setNotes(rs.getString("notes"));

                reservations.add(reservation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reservations;
    }

    // Method to retrieve a reservation by its ID
    public Reservation getReservationById(int reservationId) {
        Reservation reservation = null;
        String sql = "SELECT * FROM reservation WHERE reservation_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reservationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reservation = new Reservation();
                    reservation.setReservationId(rs.getInt("reservation_id"));
                    reservation.setFullName(rs.getString("full_name"));
                    reservation.setEmail(rs.getString("email"));
                    reservation.setPhone(rs.getString("phone"));
                    reservation.setNumberOfGuests(rs.getInt("number_of_guests"));
                    reservation.setTotalCost(rs.getDouble("total_cost"));
                    reservation.setReservationDate(rs.getDate("reservation_date"));
                    reservation.setSafariDate(rs.getDate("safari_date")); // Directly using rs.getDate()
                    reservation.setStatus(rs.getString("status"));
                    reservation.setNotes(rs.getString("notes"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reservation;
    }

    // Method to update the reservation status
    public boolean updateReservationStatus(int reservationId, String status) {
        String sql = "UPDATE reservation SET status = ? WHERE reservation_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, reservationId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Return true if update was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to delete a reservation
    public boolean deleteReservation(int reservationId) {
        String sql = "DELETE FROM reservation WHERE reservation_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reservationId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Return true if deletion was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
