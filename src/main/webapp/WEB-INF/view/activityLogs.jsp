<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Activity Logs</title>
</head>
<body>
<h2>Activity Logs</h2>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>User ID</th>
        <th>Activity</th>
        <th>Type</th>
        <th>Timestamp</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="log" items="${logs}">
        <tr>
            <td>${log.id}</td>
            <td>${log.userId}</td>
            <td>${log.activity}</td>
            <td>${log.activityType}</td>
            <td>${log.createdAt}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>