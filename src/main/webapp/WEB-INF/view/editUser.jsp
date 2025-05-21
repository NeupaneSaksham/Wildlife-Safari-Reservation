<%--
  Created by IntelliJ IDEA.
  User: shaks
  Date: 5/21/2025
  Time: 10:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.wildlifesafarireservation.models.UserModel" %>

<%
    UserModel user = (UserModel) request.getAttribute("user");
%>

<html>
<head>
    <title>Edit User</title>
</head>
<body>
<h2>Edit User</h2>

<form action="edit-user" method="post">
    <input type="hidden" name="id" value="${user.id}"/>

    Full Name: <input type="text" name="fullName" value="${user.fullName}" required /><br/>
    Email: <input type="email" name="email" value="${user.email}" required /><br/>
    Phone: <input type="text" name="phone" value="${user.phone}" /><br/>
    Address: <input type="text" name="address" value="${user.address}" /><br/>

    Role:
    <select name="role">
        <option value="1" ${user.role == 'USER' ? 'selected' : ''}>User</option>
        <option value="2" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
    </select><br/>

    <button type="submit">Update</button>
</form>

<a href="${pageContext.request.contextPath}/admin/dashboard?view=users">Back to User List</a>
</body>
</html>
