package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.DashboardDAO;
import com.example.wildlifesafarireservation.utils.DBConnectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/dashboardStats")
public class DashboardStatsPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnectionUtil.getConnection()) {
            DashboardDAO dashboardDAO = new DashboardDAO(conn);

            int totalUsers = dashboardDAO.getTotalUsers();
            int totalReservations = dashboardDAO.getTotalReservations();


            // Set attributes expected by Statistic.jsp
            request.setAttribute("userCount", totalUsers);
            request.setAttribute("reservationCount", totalReservations);

            request.getRequestDispatcher("/WEB-INF/view/Statistic.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(500, "Database error");
        }
    }
}

