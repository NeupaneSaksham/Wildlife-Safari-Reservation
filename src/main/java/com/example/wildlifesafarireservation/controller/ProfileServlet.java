package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.models.UserModel;
import com.example.wildlifesafarireservation.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private Connection connection;
    private UserDAO userDAO = new UserDAO(null);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = (UserModel) request.getSession().getAttribute("user");

        if (user != null) {
            UserModel dbUser = userDAO.getUserById(user.getId());

            if (dbUser != null) {
                request.setAttribute("user", dbUser);
                request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() +"/loginServlet");
            }
        } else {
            response.sendRedirect(request.getContextPath() +"/loginServlet");
        }
    }
}
