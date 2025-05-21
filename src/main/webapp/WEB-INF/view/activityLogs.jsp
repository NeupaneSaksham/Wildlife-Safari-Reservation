<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Activity Logs</title>
</head>
<body>
<h2>Activity Logs</h2>

<c:choose>
    <c:when test="${not empty activityLogs}">
        <table border="1" cellpadding="5" cellspacing="0">
            <thead>
            <tr>
                <th>ID</th>
                <th>Activity</th>
                <th>Type</th>
                <th>User ID</th>
                <th>Created At</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="log" items="${activityLogs}">
                <tr>
                    <td>${log.id}</td>
                    <td>${log.activity}</td>
                    <td>${log.activityType}</td>
                    <td>${log.userId}</td>
                    <td><fmt:formatDate value="${log.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <p>No activity logs found.</p>
    </c:otherwise>
</c:choose>

</body>
</html>
