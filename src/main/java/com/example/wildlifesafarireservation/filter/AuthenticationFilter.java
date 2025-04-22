package com.example.wildlifesafarireservation.filter;

import com.example.wildlifesafarireservation.models.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * AuthenticationFilter
 *
 * This filter checks if a user is authenticated before allowing access to protected resources.
 * It intercepts requests to secured URLs and redirects unauthenticated users to the login page.
 */
@WebFilter(urlPatterns = {
        "/UserDashboardServlet",
        "/AdminDashboardServlet",
        "/view/user/*",
        "/view/admin/*"
})
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig config) throws ServletException {
        // Optional initialization code
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

        // Public resources that don’t require authentication
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
        // Optional cleanup
    }
}
