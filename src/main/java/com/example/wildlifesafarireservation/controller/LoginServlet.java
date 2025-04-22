package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.models.UserModel;
import com.example.wildlifesafarireservation.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            UserModel user = (UserModel) session.getAttribute("user");
            if (user.getRole() == UserModel.Role.ADMIN) {
                response.sendRedirect("index.jsp"); // Redirect to index.jsp instead of admin dashboard
            } else {
                response.sendRedirect("index.jsp"); // Redirect to index.jsp instead of user dashboard
            }
            return;
        }

        // Pre-fill email if "Remember Me" cookie exists
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_email".equals(cookie.getName())) {
                    request.setAttribute("rememberedEmail", cookie.getValue());
                    break;
                }
            }
        }

        request.getRequestDispatcher("/view/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Basic validation
            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Email is required");
                request.getRequestDispatcher("/view/pages/login.jsp").forward(request, response);
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Password is required");
                request.getRequestDispatcher("/view/pages/login.jsp").forward(request, response);
                return;
            }

            // Use AuthService.authenticate() to authenticate the user
            Optional<UserModel> userOpt = AuthService.authenticate(email, password);

            if (userOpt.isPresent()) {
                UserModel user = userOpt.get();
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(1800); // 30 minutes

                String rememberMe = request.getParameter("remember-me");
                if ("on".equals(rememberMe)) {
                    Cookie userCookie = new Cookie("user_email", email);
                    userCookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
                    userCookie.setPath("/");
                    userCookie.setHttpOnly(true);
                    userCookie.setSecure(true); // Only sent over HTTPS
                    response.addCookie(userCookie);

                    // Manually set SameSite for cookie
                    response.setHeader("Set-Cookie", String.format("user_email=%s; Max-Age=%d; Path=/; HttpOnly; Secure; SameSite=Strict", email, 60 * 60 * 24 * 30));
                } else {
                    Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            if ("user_email".equals(cookie.getName())) {
                                cookie.setMaxAge(0); // Delete cookie
                                cookie.setPath("/");
                                cookie.setHttpOnly(true);
                                response.addCookie(cookie);
                            }
                        }
                    }
                }

                // Redirect to index.jsp after successful login
                response.sendRedirect("index.jsp");

            } else {
                request.setAttribute("errorMessage", "Invalid email or password");
                request.getRequestDispatcher("/view/pages/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/view/pages/login.jsp").forward(request, response);
        }
    }
}
