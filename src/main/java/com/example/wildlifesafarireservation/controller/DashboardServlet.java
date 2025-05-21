package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.ReservDAO;
import com.example.wildlifesafarireservation.dao.UserDAO;
import com.example.wildlifesafarireservation.models.Reservation;
import com.example.wildlifesafarireservation.models.UserModel;
import com.example.wildlifesafarireservation.utils.DBConnectionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserModel user = (session != null) ? (UserModel) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Reservation> reservationList = null;
        List<UserModel> userList = null;

        try (Connection connection = DBConnectionUtil.getConnection()) {
            ReservDAO reservDAO = new ReservDAO(connection);
            reservationList = reservDAO.getAllReservations();

            UserDAO userDAO = new UserDAO(connection);
            userList = userDAO.getAllUsers();

        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        request.setAttribute("reservations", reservationList);
        request.setAttribute("userList", userList);

        request.getRequestDispatcher("/WEB-INF/view/dashboard.jsp").forward(request, response);
    }
}
