<%@ page import="java.text.NumberFormat" %>
<%
  // Retrieve counts from request attributes with fallback to 0
  int userCount = request.getAttribute("userCount") != null ? (Integer) request.getAttribute("userCount") : 0;
  int reservationCount = request.getAttribute("reservationCount") != null ? (Integer) request.getAttribute("reservationCount") : 0;
  int activityLogCount = request.getAttribute("activityLogCount") != null ? (Integer) request.getAttribute("activityLogCount") : 0;

  NumberFormat numberFormat = NumberFormat.getInstance();
%>

<div class="stats-container">
  <h2>System Statistics</h2>
  <div class="stats-cards">
    <div class="stat-card users-card">
      <i class="fas fa-users stat-icon"></i>
      <div class="stat-info">
        <h3><%= numberFormat.format(userCount) %></h3>
        <p>Total Users</p>
      </div>
    </div>
    <div class="stat-card reservations-card">
      <i class="fas fa-calendar-check stat-icon"></i>
      <div class="stat-info">
        <h3><%= numberFormat.format(reservationCount) %></h3>
        <p>Total Reservations</p>
      </div>
    </div>
    <div class="stat-card logs-card">
      <i class="fas fa-clipboard-list stat-icon"></i>
      <div class="stat-info">
        <h3><%= numberFormat.format(activityLogCount) %></h3>
        <p>Activity Logs</p>
      </div>
    </div>
  </div>
</div>

<style>
  .stats-container {
    background: #fff;
    border-radius: 10px;
    padding: 25px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.06);
    font-family: 'Poppins', sans-serif;
    max-width: 900px;
    margin: 40px auto;
  }

  .stats-container h2 {
    color: #2c3e50;
    margin-bottom: 25px;
    font-weight: 600;
    font-size: 1.8rem;
    text-align: center;
  }

  .stats-cards {
    display: flex;
    justify-content: space-around;
    gap: 20px;
    flex-wrap: wrap;
  }

  .stat-card {
    background: #f8f9fa;
    border-radius: 10px;
    padding: 25px 30px;
    flex: 1 1 250px;
    max-width: 280px;
    box-shadow: 0 1px 8px rgba(0,0,0,0.04);
    display: flex;
    align-items: center;
    gap: 20px;
    transition: transform 0.2s ease;
  }

  .stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 16px rgba(0,0,0,0.1);
  }

  .stat-icon {
    font-size: 3rem;
    color: #17a2b8; /* Bootstrap info color */
    flex-shrink: 0;
  }

  .users-card .stat-icon {
    color: #007bff; /* Blue */
  }

  .reservations-card .stat-icon {
    color: #28a745; /* Green */
  }

  .logs-card .stat-icon {
    color: #ffc107; /* Amber */
  }

  .stat-info h3 {
    margin: 0;
    font-size: 2.4rem;
    color: #343a40;
  }

  .stat-info p {
    margin: 5px 0 0;
    font-size: 1rem;
    color: #6c757d;
    font-weight: 600;
    text-transform: uppercase;
  }

  @media (max-width: 700px) {
    .stats-cards {
      flex-direction: column;
      align-items: center;
    }
  }
</style>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
