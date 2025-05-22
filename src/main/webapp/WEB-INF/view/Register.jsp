<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>
<div class="container">
    <h1>Create Account</h1>
    <p class="subtitle">Join us today!</p>

    <div id="errorMessage" class="alert alert-error" style="display: none;"></div>
    <div id="successMessage" class="alert alert-success" style="display: none;"></div>

    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" onsubmit="return validateForm()">
    <div class="form-row">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" placeholder="Enter your name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group password-field">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create password" required>
                <button type="button" class="toggle-password" onclick="togglePassword('password')">Show</button>
            </div>
            <div class="form-group password-field">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirm-password" placeholder="Confirm password" required>
                <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword')">Show</button>
            </div>
        </div>

        <!-- Hidden role input: fixed as "user" -->
        <input type="hidden" name="role" value="USER">

        <div class="terms-container">
            <input type="checkbox" id="terms" name="terms" required>
            <label for="terms">I agree to the Terms and Conditions and Privacy Policy</label>
        </div>

        <button type="submit" class="register-button">Create Account</button>

        <div class="login-link">
            Already have an account?
            <a href="${pageContext.request.contextPath}/LoginServlet">Login here</a>
        </div>
    </form>
</div>

<script>
    function togglePassword(id) {
        const input = document.getElementById(id);
        const btn = input.nextElementSibling;
        if (input.type === "password") {
            input.type = "text";
            btn.textContent = "Hide";
        } else {
            input.type = "password";
            btn.textContent = "Show";
        }
    }

    function validateForm() {
        const pass = document.getElementById("password").value;
        const confirm = document.getElementById("confirmPassword").value;
        if (pass !== confirm) {
            const errorDiv = document.getElementById('errorMessage');
            errorDiv.textContent = "Passwords do not match!";
            errorDiv.style.display = "block";
            return false;
        }
        return true;
    }

    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const error = urlParams.get('error');
        const success = urlParams.get('success');

        if (error) {
            const errorDiv = document.getElementById('errorMessage');
            errorDiv.textContent = error;
            errorDiv.style.display = "block";
        }

        if (success) {
            const successDiv = document.getElementById('successMessage');
            successDiv.textContent = success;
            successDiv.style.display = "block";
        }
    }
</script>
</body>
</html>