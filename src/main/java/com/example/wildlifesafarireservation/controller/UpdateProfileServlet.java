package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.UserDAO;
import com.example.wildlifesafarireservation.models.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.sql.Connection;
import java.util.Arrays;

@MultipartConfig  // Enables file upload handling
@WebServlet("/editProfile")
public class UpdateProfileServlet extends HttpServlet {

    private Connection connection;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current user from the session
        UserModel user = UserModel.getUserFromSession(request);

        if (user != null) {
            // Set the user object as an attribute to be accessed in the JSP page
            request.setAttribute("userDTO", user);
            // Forward to the UpdateProfile page
            request.getRequestDispatcher("/WEB-INF/view/UpdateProfile.jsp").forward(request, response);
        } else {
            // If no user is logged in, redirect to the login page
            request.setAttribute("error", "No user found. Please log in.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Validate input: full name and email are required
        if (fullName == null || fullName.isEmpty() || email == null || email.isEmpty()) {
            request.setAttribute("error", "Full name and email are required.");
            request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
            return;
        }

        // Get the current user from the session
        UserModel user = UserModel.getUserFromSession(request);

        if (user != null) {
            // Update user details
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);

            // Handle profile image upload
            Part profileImagePart = request.getPart("profileImage");
            if (profileImagePart != null && profileImagePart.getSize() > 0) {
                // Get the uploaded file name
                String fileName = profileImagePart.getSubmittedFileName();

                // Validate file extension
                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                if (!Arrays.asList("jpg", "jpeg", "png", "gif").contains(fileExtension)) {
                    request.setAttribute("error", "Invalid file type. Please upload an image.");
                    request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
                    return;
                }

                // Define the upload directory
                String uploadDir = getServletContext().getRealPath("/uploads/profileImages");
                File uploadDirPath = new File(uploadDir);
                if (!uploadDirPath.exists()) {
                    uploadDirPath.mkdirs();
                }

                // Save the image file to the directory
                File file = new File(uploadDirPath, fileName);
                try (InputStream inputStream = profileImagePart.getInputStream()) {
                    Files.copy(inputStream, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }

                // Save the file name in the user model
                user.setProfileImage(fileName);
            }

            // Call the DAO to update the user in the database
            UserDAO userDAO = new UserDAO(connection);
            boolean isUpdated = userDAO.updateProfile(user);

            if (isUpdated) {
                // Store the updated user object back into the session
                UserModel.storeUserInSession(request, user);

                // Provide success feedback and redirect to the profile page
                request.setAttribute("success", "Profile updated successfully!");
                response.sendRedirect(request.getContextPath() + "/profile");
            } else {
                // If the update failed, show an error message
                request.setAttribute("error", "Failed to update profile. Please try again.");
                request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
            }
        } else {
            // If no user is logged in, redirect to the login page
            request.setAttribute("error", "User not logged in.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
