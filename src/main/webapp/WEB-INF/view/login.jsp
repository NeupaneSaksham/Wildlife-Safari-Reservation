<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
<div class="container">
    <div class="login-section">
        <h1>Welcome Back!</h1>
        <p class="subtitle">Please log in to your account.</p>

        <% if(request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>

        <% if(request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success">
            <%= request.getAttribute("successMessage") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="Enter email" required
                       value="<%= request.getAttribute("rememberedEmail") != null ? request.getAttribute("rememberedEmail") : "" %>">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>
            </div>

            <div class="options-row">
                <div class="checkbox-container">
                    <input type="checkbox" id="remember" name="remember-me">
                    <label for="remember">Remember me</label>
                </div>
                <a href="#" class="forgot-password">Forgot password?</a>
            </div>

            <button type="submit" class="login-button">Login</button>

            <a href="${pageContext.request.contextPath}/RegisterServlet" class="create-account">Create account</a>
        </form>
    </div>
    <div class="image-section">
        <img src="${pageContext.request.contextPath}/assets/tigers.png" alt="Lion">
    </div>
</div>
</body>
</html>
