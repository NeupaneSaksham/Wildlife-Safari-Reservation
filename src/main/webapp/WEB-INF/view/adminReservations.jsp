<%--
  Created by IntelliJ IDEA.
  User: shaks
  Date: 5/21/2025
  Time: 9:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.wildlifesafarireservation.models.Reservation" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
  List<Reservation> reservationList = (List<Reservation>) request.getAttribute("reservations");
  if (reservationList == null) {
    reservationList = java.util.Collections.emptyList(); // fallback
  }

  SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
  SimpleDateFormat datetimeFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm a");
%>

<div class="reservation-container">
  <div class="table-header">
    <h3>Reservation Management</h3>
  </div>

  <div class="table-responsive">
    <table class="reservation-table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Guest</th>
        <th>Contact</th>
        <th>Details</th>
        <th>Dates</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <%
        for (Reservation res : reservationList) {
          String statusClass = "";
          switch(res.getStatus().toLowerCase()) {
            case "confirmed": statusClass = "status-confirmed"; break;
            case "cancelled": statusClass = "status-cancelled"; break;
            default: statusClass = "status-pending";
          }
      %>
      <tr>
        <td>#<%= res.getReservationId() %></td>
        <td>
          <div class="guest-info">
            <strong><%= res.getFullName() %></strong>
            <span><%= res.getNumberOfGuests() %> guest<%= res.getNumberOfGuests() != 1 ? "s" : "" %></span>
          </div>
        </td>
        <td>
          <div class="contact-info">
            <div><i class="fas fa-envelope"></i> <%= res.getEmail() %></div>
            <div><i class="fas fa-phone"></i> <%= res.getPhone() %></div>
          </div>
        </td>
        <td>
          <div class="reservation-details">
            <div><strong>$<%= String.format("%.2f", res.getTotalCost()) %></strong> total</div>
            <div class="notes" title="<%= res.getNotes() != null ? res.getNotes() : "No notes" %>">
              <i class="fas fa-sticky-note"></i>
              <%= res.getNotes() != null && !res.getNotes().isEmpty() ?
                      res.getNotes().length() > 20 ? res.getNotes().substring(0, 20) + "..." : res.getNotes()
                      : "No notes" %>
            </div>
          </div>
        </td>
        <td>
          <div class="date-info">
            <div><i class="far fa-calendar-plus"></i> <%= datetimeFormat.format(res.getReservationDate()) %></div>
            <div><i class="fas fa-calendar-day"></i> <%= dateFormat.format(res.getSafariDate()) %></div>
          </div>
        </td>
        <td>
            <span class="status-badge <%= statusClass %>">
              <%= res.getStatus() %>
            </span>
        </td>
        <td class="actions">
          <form action="${pageContext.request.contextPath}/admin/updateReservationStatus" method="post" class="status-form">
            <input type="hidden" name="reservationId" value="<%= res.getReservationId() %>">
            <select name="status" class="status-select <%= statusClass %>">
              <option value="Pending" <%= res.getStatus().equalsIgnoreCase("Pending") ? "selected" : "" %>>Pending</option>
              <option value="Confirmed" <%= res.getStatus().equalsIgnoreCase("Confirmed") ? "selected" : "" %>>Confirmed</option>
              <option value="Cancelled" <%= res.getStatus().equalsIgnoreCase("Cancelled") ? "selected" : "" %>>Cancelled</option>
            </select>
            <button type="submit" class="btn-update">
              <i class="fas fa-sync-alt"></i> Update
            </button>
          </form>
          <form action="${pageContext.request.contextPath}/admin/deleteReservation" method="post" onsubmit="return confirm('Are you sure you want to delete this reservation?');">
            <input type="hidden" name="reservationId" value="<%= res.getReservationId() %>">
            <button type="submit" class="btn-delete">
              <i class="fas fa-trash-alt"></i> Delete
            </button>
          </form>
        </td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>

  <% if (reservationList.isEmpty()) { %>
  <div class="empty-state">
    <i class="fas fa-calendar-times"></i>
    <h4>No Reservations Found</h4>
    <p>There are currently no reservations in the system.</p>
  </div>
  <% } %>
</div>

<style>
  .reservation-container {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    padding: 20px;
    font-family: 'Poppins', sans-serif;
  }

  .table-header {
    margin-bottom: 20px;
  }

  .table-header h3 {
    color: #2c3e50;
    font-size: 1.4rem;
    margin: 0;
  }

  .reservation-table {
    width: 100%;
    border-collapse: collapse;
  }

  .reservation-table th {
    background-color: #f8f9fa;
    color: #495057;
    font-weight: 600;
    padding: 12px 15px;
    text-align: left;
    border-bottom: 2px solid #dee2e6;
  }

  .reservation-table td {
    padding: 15px;
    border-bottom: 1px solid #eee;
    vertical-align: middle;
  }

  .reservation-table tr:hover {
    background-color: #f8f9fa;
  }

  .guest-info {
    display: flex;
    flex-direction: column;
  }

  .guest-info span {
    font-size: 0.85rem;
    color: #6c757d;
  }

  .contact-info div {
    margin-bottom: 5px;
    font-size: 0.9rem;
  }

  .contact-info i {
    margin-right: 8px;
    color: #6c757d;
    width: 15px;
  }

  .reservation-details {
    font-size: 0.9rem;
  }

  .reservation-details .notes {
    color: #6c757d;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 200px;
  }

  .reservation-details .notes i {
    margin-right: 5px;
  }

  .date-info div {
    margin-bottom: 5px;
    font-size: 0.9rem;
  }

  .date-info i {
    margin-right: 8px;
    color: #6c757d;
    width: 15px;
  }

  .status-badge {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 500;
    text-transform: capitalize;
  }

  .status-pending {
    background-color: #fff3cd;
    color: #856404;
  }

  .status-confirmed {
    background-color: #d4edda;
    color: #155724;
  }

  .status-cancelled {
    background-color: #f8d7da;
    color: #721c24;
  }

  .actions {
    display: flex;
    gap: 10px;
  }

  .status-form {
    display: flex;
    align-items: center;
    gap: 5px;
  }

  .status-select {
    padding: 5px;
    border-radius: 4px;
    border: 1px solid #ddd;
    font-size: 0.85rem;
  }

  .status-select.status-pending {
    border-color: #ffeeba;
  }

  .status-select.status-confirmed {
    border-color: #c3e6cb;
  }

  .status-select.status-cancelled {
    border-color: #f5c6cb;
  }

  .btn-update, .btn-delete {
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.85rem;
    display: flex;
    align-items: center;
    gap: 5px;
    transition: all 0.2s;
  }

  .btn-update {
    background-color: #17a2b8;
    color: white;
  }

  .btn-update:hover {
    background-color: #138496;
  }

  .btn-delete {
    background-color: #dc3545;
    color: white;
  }

  .btn-delete:hover {
    background-color: #c82333;
  }

  .empty-state {
    text-align: center;
    padding: 40px 20px;
    color: #6c757d;
  }

  .empty-state i {
    font-size: 3rem;
    margin-bottom: 15px;
    color: #adb5bd;
  }

  .empty-state h4 {
    margin-bottom: 10px;
    color: #495057;
  }

  @media (max-width: 1200px) {
    .reservation-table {
      display: block;
      overflow-x: auto;
    }

    .contact-info div, .date-info div {
      white-space: nowrap;
    }
  }
</style>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">