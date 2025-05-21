package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.ReservDAO;
import com.example.wildlifesafarireservation.models.Reservation;
import com.example.wildlifesafarireservation.utils.DBConnectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminReservationServlet extends HttpServlet {
    private ReservDAO reservDAO;

    @Override
    public void init() {
        try {
            reservDAO = new ReservDAO(DBConnectionUtil.getConnection());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // You can check if admin is logged in using session attribute
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Reservation> reservations = reservDAO.getAllReservations();
        request.setAttribute("reservations", reservations);

        // Forward to dashboard.jsp
        request.getRequestDispatcher("/dashboard").forward(request, response);
    }
}
