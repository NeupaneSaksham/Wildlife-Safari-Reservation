package com.example.wildlifesafarireservation.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/ReservationError")
public class ReservationErrorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errorMessage = request.getParameter("message");

        if (errorMessage == null || errorMessage.isEmpty()) {
            errorMessage = "An unknown error occurred while processing your reservation.";
        }

        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("/WEB-INF/view/reservationError.jsp").forward(request, response);
    }
}
