package com.example.wildlifesafarireservation.filter;

import com.example.wildlifesafarireservation.models.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/UserDashboardServlet",
        "/AdminDashboardServlet",
        "/view/user/*",
        "/view/admin/*"
})
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig config) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isAuthenticated = false;

        if (session != null) {
            UserModel user = (UserModel) session.getAttribute("user");
            isAuthenticated = (user != null);
        }

        String requestURI = httpRequest.getRequestURI();

        boolean isPublicResource = requestURI.contains("login.jsp")
                || requestURI.contains("register.jsp")
                || requestURI.contains("LoginServlet")
                || requestURI.contains("RegisterServlet")
                || requestURI.contains("/assets/");

        if (isAuthenticated || isPublicResource) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/view/login/login.jsp");
        }
    }

    @Override
    public void destroy() {
    }
}
