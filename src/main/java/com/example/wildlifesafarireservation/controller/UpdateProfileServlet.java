package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.UserDAO;
import com.example.wildlifesafarireservation.models.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.*;
import java.util.Arrays;
import java.util.UUID;

@MultipartConfig
@WebServlet("/editProfile")
public class UpdateProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "D:/uploadedImages/profileImages";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = UserModel.getUserFromSession(request);

        if (user != null) {
            request.setAttribute("userDTO", user);
            request.getRequestDispatcher("/WEB-INF/view/UpdateProfile.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "No user found. Please log in.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (fullName == null || fullName.isEmpty() || email == null || email.isEmpty()) {
            request.setAttribute("error", "Full name and email are required.");
            request.getRequestDispatcher("/WEB-INF/view/UpdateProfile.jsp").forward(request, response);
            return;
        }

        UserModel user = UserModel.getUserFromSession(request);

        if (user != null) {
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);

            Part profileImagePart = request.getPart("profileImage");
            if (profileImagePart != null && profileImagePart.getSize() > 0) {
                String fileName = Paths.get(profileImagePart.getSubmittedFileName()).getFileName().toString();
                String fileExtension = "";

                int dotIndex = fileName.lastIndexOf('.');
                if (dotIndex > 0) {
                    fileExtension = fileName.substring(dotIndex + 1).toLowerCase();
                }

                if (!Arrays.asList("jpg", "jpeg", "png", "gif").contains(fileExtension)) {
                    request.setAttribute("error", "Invalid file type. Please upload an image.");
                    request.getRequestDispatcher("/WEB-INF/view/UpdateProfile.jsp").forward(request, response);
                    return;
                }

                File uploadDir = new File(UPLOAD_DIR);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String uniqueFileName = UUID.randomUUID().toString() + "." + fileExtension;
                File savedFile = new File(uploadDir, uniqueFileName);

                try (InputStream input = profileImagePart.getInputStream()) {
                    Files.copy(input, savedFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    System.out.println("Image uploaded to: " + savedFile.getAbsolutePath());
                } catch (IOException e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to upload image.");
                    request.getRequestDispatcher("/WEB-INF/view/UpdateProfile.jsp").forward(request, response);
                    return;
                }

                user.setProfileImage(uniqueFileName); // Save just the filename (not full path)
            }

            boolean isUpdated = UserDAO.updateUser(user);

            if (isUpdated) {
                UserModel.storeUserInSession(request, user);
                response.sendRedirect(request.getContextPath() + "/profile");
            } else {
                request.setAttribute("error", "Failed to update profile.");
                request.getRequestDispatcher("/WEB-INF/view/UpdateProfile.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "User not logged in.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
