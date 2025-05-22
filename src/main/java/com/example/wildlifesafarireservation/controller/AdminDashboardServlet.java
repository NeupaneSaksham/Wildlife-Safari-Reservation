package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.UserDAO;
import com.example.wildlifesafarireservation.dao.ReservDAO;
import com.example.wildlifesafarireservation.models.UserModel;
import com.example.wildlifesafarireservation.models.Reservation;
import com.example.wildlifesafarireservation.services.AuthService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class AdminDashboardServlet extends HttpServlet {
    private UserDAO userDao;
    private ReservDAO reservationDao;
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        this.userDao = new UserDAO();
        this.reservationDao = new ReservDAO();
        this.authService = new AuthService(userDao);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Only allow access to the admin dashboard if the user is an admin
        if (!authService.isAdmin(request)) {
            response.sendRedirect("login.jsp"); // Redirect to login if not admin
            return;
        }

        // Fetch data for dashboard
        List<UserModel> allUsers = userDao.getAllUsers();
        List<Reservation> allReservations = reservationDao.getAllReservations();

        // Set data as attributes for the JSP page
        request.setAttribute("users", allUsers);
        request.setAttribute("reservations", allReservations);

        // Forward to the Admin Dashboard JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin_dashboard.jsp");
        dispatcher.forward(request, response);
    }
}
