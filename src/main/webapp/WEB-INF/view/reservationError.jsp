<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reservation Error - Ban Yatra</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
            background-color: #f8f8f8;
        }
        .error-container {
            max-width: 600px;
            margin: auto;
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h1 {
            color: #d9534f;
        }
        p {
            color: #333;
        }
        .back-link {
            margin-top: 20px;
            display: inline-block;
            color: #007bff;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="error-container">
    <h1>Oops! Something went wrong</h1>
    <p>We encountered an error while processing your reservation.</p>
    <p><strong>Error Details:</strong> <%= exception != null ? exception.getMessage() : "Unknown error occurred." %></p>
    <a class="back-link" href="<%= request.getContextPath() %>/WEB-INF/view/pages/reservation.jsp">← Back to Reservation</a>
</div>
</body>
</html>
