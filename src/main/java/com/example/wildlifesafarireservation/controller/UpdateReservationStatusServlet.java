package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.ReservDAO;
import com.example.wildlifesafarireservation.utils.DBConnectionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/admin/updateReservationStatus")
public class UpdateReservationStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = DBConnectionUtil.getConnection()) {
            ReservDAO reservDAO = new ReservDAO(connection);

            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            String newStatus = request.getParameter("status");

            boolean updated = reservDAO.updateReservationStatus(reservationId, newStatus);

            if (updated) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/WEB-INF/view/dashboard.jsp?error=updateFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/WEB-INF/view/dashboard.jsp?error=exception");
        }
    }
}
