package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.ActivityLogDAO;
import com.example.wildlifesafarireservation.dao.ReservDAO;
import com.example.wildlifesafarireservation.models.ActivityLog;
import com.example.wildlifesafarireservation.models.Reservation;
import com.example.wildlifesafarireservation.services.AuthService;
import com.example.wildlifesafarireservation.utils.DBConnectionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;

@WebServlet("/Reservation")
public class ReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (AuthService.validateSession(request)) {
            request.getRequestDispatcher("/WEB-INF/view/reservation.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!AuthService.validateSession(request)) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String groupSizeStr = request.getParameter("groupSize");
        String safariDateStr = request.getParameter("safariDate");
        String packageIdStr = request.getParameter("packageName");
        String notes = request.getParameter("notes");
        String priceStr = request.getParameter("price");

        int groupSize = 0;
        double price = 0.0;
        Date safariDate = null;

        try {
            if (groupSizeStr == null || groupSizeStr.isEmpty() ||
                    priceStr == null || priceStr.isEmpty() ||
                    packageIdStr == null || packageIdStr.isEmpty()) {
                request.setAttribute("error", "Group size, price, and package are required.");
                request.getRequestDispatcher("/WEB-INF/view/reservationError.jsp").forward(request, response);
                return;
            }

            groupSize = Integer.parseInt(groupSizeStr);
            price = Double.parseDouble(priceStr);

            try {
                safariDate = Date.valueOf(safariDateStr);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Invalid date format. Please use yyyy-mm-dd.");
                request.getRequestDispatcher("/WEB-INF/view/reservationError.jsp").forward(request, response);
                return;
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Group size and price must be valid numbers.");
            request.getRequestDispatcher("/WEB-INF/view/reservationError.jsp").forward(request, response);
            return;
        }

        try (Connection connection = DBConnectionUtil.getConnection()) {
            ReservDAO reservDAO = new ReservDAO(connection);

            Reservation reservation = new Reservation();
            reservation.setFullName(fullName);
            reservation.setEmail(email);
            reservation.setPhone(phone);
            reservation.setNumberOfGuests(groupSize);
            reservation.setSafariDate(safariDate);
            reservation.setNotes(notes);
            reservation.setTotalCost(price);
            reservation.setReservationDate(new Date(System.currentTimeMillis()));

            boolean inserted = reservDAO.insertReservation(reservation);

            if (inserted) {
                Integer userId = (Integer) request.getSession().getAttribute("userId");
                if (userId == null) userId = -1;

                // Log the activity
                ActivityLogDAO logDAO = new ActivityLogDAO();
                ActivityLog log = new ActivityLog();
                log.setUserId(userId);
                log.setActivity("Made a reservation for " + fullName);
                log.setActivityType("Reservation");
                log.setCreatedAt(new Timestamp(System.currentTimeMillis()));

                logDAO.addActivityLog(log);

                response.sendRedirect(request.getContextPath() + "/reservationSuccess");
            } else {
                request.setAttribute("error", "Reservation failed. Please try again.");
                request.getRequestDispatcher("/WEB-INF/view/reservationError.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/reservationError.jsp").forward(request, response);
        }
    }
}
