package com.example.wildlifesafarireservation.controller;

import com.example.wildlifesafarireservation.dao.ActivityLogDAO;
import com.example.wildlifesafarireservation.models.ActivityLog;
import com.example.wildlifesafarireservation.models.UserModel;
import com.example.wildlifesafarireservation.services.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Optional;

@WebServlet(name = "Login", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            UserModel user = (UserModel) session.getAttribute("user");

            if (user.getRoleEnum() == UserModel.Role.ADMIN) {
                response.sendRedirect(contextPath + "/index.jsp");
            } else {
                response.sendRedirect(contextPath + "/Home");
            }
            return;
        }

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_email".equals(cookie.getName())) {
                    request.setAttribute("rememberedEmail", cookie.getValue());
                    break;
                }
            }
        }

        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();

        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Email is required");
                request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Password is required");
                request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
                return;
            }

            Optional<UserModel> userOpt = AuthService.authenticate(email, password);

            if (userOpt.isPresent()) {
                UserModel user = userOpt.get();
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(1800); // 30 minutes

                // Activity logging for login
                ActivityLogDAO activityLogDAO = new ActivityLogDAO();
                ActivityLog log = new ActivityLog();
                log.setUserId(user.getId());
                log.setActivity("User logged in");
                log.setActivityType("LOGIN");
                log.setCreatedAt(new Timestamp(System.currentTimeMillis()));

                activityLogDAO.addActivityLog(log);

                // Remember Me cookie
                String rememberMe = request.getParameter("remember-me");
                if ("on".equals(rememberMe)) {
                    Cookie userCookie = new Cookie("user_email", email);
                    userCookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
                    userCookie.setPath("/");
                    userCookie.setHttpOnly(true);
                    userCookie.setSecure(true);
                    response.addCookie(userCookie);

                    response.setHeader("Set-Cookie", String.format(
                            "user_email=%s; Max-Age=%d; Path=/; HttpOnly; Secure; SameSite=Strict",
                            email, 60 * 60 * 24 * 30));
                } else {
                    Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            if ("user_email".equals(cookie.getName())) {
                                cookie.setMaxAge(0);
                                cookie.setPath("/");
                                cookie.setHttpOnly(true);
                                response.addCookie(cookie);
                            }
                        }
                    }
                }

                if (user.getRoleEnum() == UserModel.Role.ADMIN) {
                    response.sendRedirect(contextPath + "/dashboard");
                } else {
                    response.sendRedirect(contextPath + "/packages");
                }

            } else {
                request.setAttribute("errorMessage", "Invalid email or password");
                request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}
