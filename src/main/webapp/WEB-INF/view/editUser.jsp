<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.wildlifesafarireservation.models.UserModel" %>

<%
    UserModel user = (UserModel) request.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit User | Admin Panel</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .form-container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 500px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #2c3e50;
        }

        form label {
            display: block;
            margin-top: 15px;
            font-weight: 600;
            color: #333;
        }

        form input[type="text"],
        form input[type="email"],
        form select {
            width: 100%;
            padding: 10px 12px;
            margin-top: 6px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }

        button {
            margin-top: 25px;
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #218838;
        }

        .back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #007bff;
            text-decoration: none;
            font-size: 0.95rem;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Edit User</h2>
    <form action="edit-user" method="post">
        <input type="hidden" name="id" value="${user.id}" />

        <label>Full Name:</label>
        <input type="text" name="fullName" value="${user.fullName}" required />

        <label>Email:</label>
        <input type="email" name="email" value="${user.email}" required />

        <label>Phone:</label>
        <input type="text" name="phone" value="${user.phone}" />

        <label>Address:</label>
        <input type="text" name="address" value="${user.address}" />

        <label>Role:</label>
        <select name="role">
            <option value="ADMIN">Admin</option>
            <option value="USER">User</option>
        </select>


        <button type="submit">Update</button>
    </form>

    <a class="back-link" href="${pageContext.request.contextPath}/admin/dashboard?view=users">← Back to User List</a>
</div>

</body>
</html>
