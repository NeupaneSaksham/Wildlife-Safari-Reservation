package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.models.UserModel;
import com.example.wildlifesafarireservation.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/edit-user")
public class EditUserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        // Initialize UserDAO here - assuming it has a no-arg constructor or change accordingly
        userDAO = new UserDAO();
    }

    // Show the edit form with user data (GET request)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-users"); // redirect if no id provided
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            UserModel user = userDAO.getUserById(id);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/manage-users"); // redirect if user not found
                return;
            }
            request.setAttribute("userToEdit", user);
            request.getRequestDispatcher("/WEB-INF/view/editUser.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    // Process the update (POST request)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String profileImage = request.getParameter("profileImage");
            String roleStr = request.getParameter("role");

            UserModel.Role role = UserModel.Role.valueOf(roleStr.toUpperCase());

            UserModel user = userDAO.getUserById(id);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/manage-users");
                return;
            }

            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setProfileImage(profileImage);
            user.setRole(role);

            userDAO.updateUser(user);

            response.sendRedirect(request.getContextPath() + "/admin/manage-users?success=User updated successfully");
        } catch (NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}
