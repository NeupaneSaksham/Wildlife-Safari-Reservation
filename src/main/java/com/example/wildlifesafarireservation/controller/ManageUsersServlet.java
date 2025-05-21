package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.UserDAO;
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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/manage-users")
public class ManageUsersServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ManageUsersServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserModel user = (session != null) ? (UserModel) session.getAttribute("user") : null;

        // Redirect to login if no user or user is not admin
        if (user == null || user.getRoleEnum() != UserModel.Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        Connection connection = null;
        try {
            connection = DBConnectionUtil.getConnection();
            UserDAO userDAO = new UserDAO(connection);
            List<UserModel> userList = userDAO.getAllUsers();

            request.setAttribute("userList", userList);
            request.getRequestDispatcher("/WEB-INF/view/admin/manage_users.jsp").forward(request, response);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving users", e);
            // You can redirect to an error page or show an error message
            request.setAttribute("errorMessage", "Unable to load users at this time.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);

        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.WARNING, "Error closing DB connection", e);
                }
            }
        }
    }
}
