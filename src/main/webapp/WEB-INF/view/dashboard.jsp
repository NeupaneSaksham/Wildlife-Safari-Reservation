<%@ page import="com.example.wildlifesafarireservation.models.UserModel" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  UserModel loggedInUser = (UserModel) session.getAttribute("user");
  if (loggedInUser == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  String view = request.getParameter("view");
  if (view == null) {
    view = "dashboardStats"; // Default to dashboard stats
  }

  String contentPage;
  switch (view) {
    case "users":
      contentPage = "manageUsers.jsp";
      break;
    case "activity_logs":
      contentPage = "activityLogs.jsp";
      break;
    case "reservations":
      contentPage = "adminReservations.jsp";
      break;
    case "Statistic.jsp":
    default:
      contentPage = "Statistic.jsp";
      view = "dashboardStats";
      break;
  }
%>

<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard | Wildlife Safari</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: #ff9b34;
      --secondary: #ffbc77;
      --light: #f8f9fa;
      --dark: #343a40;
      --success: #28a745;
      --danger: #ff0016;
      --sidebar-width: 260px;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: 'Poppins', sans-serif;
      margin: 0;
      display: flex;
      min-height: 100vh;
      background-color: #f5f7fa;
      color: #333;
      line-height: 1.6;
    }

    nav.sidebar {
      width: var(--sidebar-width);
      background-color: white;
      display: flex;
      flex-direction: column;
      padding: 20px 0;
      color: var(--dark);
      box-shadow: 2px 0 10px rgba(0,0,0,0.05);
      position: fixed;
      height: 100vh;
      z-index: 100;
    }

    .sidebar-header {
      padding: 0 20px 20px;
      margin-bottom: 20px;
      border-bottom: 1px solid #eee;
    }

    .sidebar-header h2 {
      font-size: 1.2rem;
      color: var(--primary);
      margin-bottom: 5px;
    }

    .sidebar-header p {
      font-size: 0.9rem;
      color: #666;
      font-weight: 300;
    }

    .user-avatar {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      background-color: var(--primary);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      margin-right: 15px;
    }

    .user-info {
      display: flex;
      align-items: center;
      padding: 0 20px 20px;
    }

    nav.sidebar a {
      color: #555;
      padding: 12px 25px;
      text-decoration: none;
      font-weight: 500;
      display: flex;
      align-items: center;
      transition: all 0.3s ease;
      margin: 5px 15px;
      border-radius: 8px;
    }

    nav.sidebar a:hover {
      background-color: rgba(44, 120, 108, 0.1);
      color: var(--primary);
    }

    nav.sidebar a.active {
      background-color: var(--primary);
      color: white;
    }

    nav.sidebar a i {
      margin-right: 10px;
      font-size: 1.1rem;
    }

    .main-content {
      margin-left: var(--sidebar-width);
      flex-grow: 1;
      padding: 20px;
      background-color: #f5f7fa;
      min-height: 100vh;
    }

    header {
      background-color: white;
      color: var(--dark);
      padding: 20px;
      font-size: 1.5rem;
      font-weight: 600;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      margin-bottom: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logout-btn {
      background-color: var(--danger);
      color: #ffffff;
      border: none;
      padding: 8px 15px;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 500;
      transition: background-color 0.3s;
      display: flex;
      align-items: center;
    }

    .logout-btn:hover {
      background-color: #ff5367;
    }

    .logout-btn i {
      margin-right: 5px;
    }

    .content-container {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      padding: 25px;
      min-height: calc(100vh - 120px);
    }

    @media (max-width: 768px) {
      nav.sidebar {
        width: 80px;
        overflow: hidden;
      }

      .sidebar-header, .user-info {
        display: none;
      }

      nav.sidebar a {
        justify-content: center;
        padding: 15px 0;
        margin: 5px 10px;
      }

      nav.sidebar a i {
        margin-right: 0;
        font-size: 1.3rem;
      }

      nav.sidebar a span {
        display: none;
      }

      .main-content {
        margin-left: 80px;
      }
    }
  </style>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

<nav class="sidebar">
  <div class="sidebar-header">
    <h2>Wildlife Safari</h2>
    <p>Admin Dashboard</p>
  </div>

  <div class="user-info">
    <div class="user-avatar">
      <%= loggedInUser.getFullName().substring(0, 1).toUpperCase() %>
    </div>
    <div>
      <div style="font-weight: 500;"><%= loggedInUser.getFullName() %></div>
      <small style="color: #777;">Administrator</small>
    </div>
  </div>

  <a href="<%=request.getContextPath()%>/admin/dashboard?view=dashboardStats"
     class="<%= "dashboardStats".equals(view) ? "active" : "" %>">
    <i class="fas fa-chart-line"></i>
    <span>View Statistics</span>
  </a>

  <a href="<%=request.getContextPath()%>/admin/dashboard?view=reservations"
     class="<%= "reservations".equals(view) ? "active" : "" %>">
    <i class="fas fa-calendar-alt"></i>
    <span>Reservations</span>
  </a>
  <a href="<%=request.getContextPath()%>/admin/dashboard?view=users"
     class="<%= "users".equals(view) ? "active" : "" %>">
    <i class="fas fa-users"></i>
    <span>Users</span>
  </a>
  <a href="<%=request.getContextPath()%>/admin/dashboard?view=activity_logs"
     class="<%= "activity_logs".equals(view) ? "active" : "" %>">
    <i class="fas fa-history"></i>
    <span>Activity Logs</span>
  </a>

  <div style="margin-top: auto;">
    <a href="<%=request.getContextPath()%>/logout" class="logout-btn" style="margin: 15px; color: white;">
      <i class="fas fa-sign-out-alt"></i>
      <span>Logout</span>
    </a>
  </div>
</nav>

<div class="main-content">
  <header>
    <div>
      <%=
      "users".equals(view) ? "User Management" :
              "activity_logs".equals(view) ? "Activity Logs" :
                      "reservations".equals(view) ? "Reservation Management" :
                              "Dashboard Statistics"
      %>
    </div>
  </header>

  <div class="content-container">
    <jsp:include page="<%= contentPage %>" />
  </div>
</div>

</body>
</html>