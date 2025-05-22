<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.wildlifesafarireservation.models.UserModel" %>

<%
    List<UserModel> users = (List<UserModel>) request.getAttribute("userList");
    if (users == null) {
        users = java.util.Collections.emptyList();
    }
%>

<div class="user-management-container">
    <div class="table-header">
        <h3>Manage Users</h3>
    </div>

    <div class="table-responsive">
        <table class="user-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (UserModel user : users) {
            %>
            <tr>
                <td><%= user.getId() %></td>
                <td><strong><%= user.getFullName() %></strong></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getPhone() %></td>
                <td><%= user.getRole() %></td>
                <td><%= user.getCreatedAt() != null ? new java.text.SimpleDateFormat("MMM dd, yyyy").format(user.getCreatedAt()) : "-" %></td>
                <td class="actions">
                    <a href="edit-user?id=<%= user.getId() %>" class="btn-edit">
                        <i class="fas fa-edit"></i> Edit
                    </a>
                    <a href="delete-user?id=<%= user.getId() %>" class="btn-delete" onclick="return confirm('Are you sure you want to delete this user?');">
                        <i class="fas fa-trash-alt"></i> Delete
                    </a>
                </td>
            </tr>
            <%
                }
                if (users.isEmpty()) {
            %>
            <tr>
                <td colspan="7" class="empty-state">
                    <i class="fas fa-user-slash"></i><br>
                    No users found.
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

</div>

<style>
    .user-management-container {
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

    .user-table {
        width: 100%;
        border-collapse: collapse;
    }

    .user-table th {
        background-color: #f8f9fa;
        color: #495057;
        font-weight: 600;
        padding: 12px 15px;
        text-align: left;
        border-bottom: 2px solid #dee2e6;
    }

    .user-table td {
        padding: 15px;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }

    .user-table tr:hover {
        background-color: #f8f9fa;
    }

    .actions {
        display: flex;
        gap: 10px;
    }

    a.btn-edit, a.btn-delete {
        padding: 6px 12px;
        border-radius: 4px;
        font-size: 0.85rem;
        color: white;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 5px;
        transition: background-color 0.2s;
    }

    a.btn-edit {
        background-color: #17a2b8;
    }

    a.btn-edit:hover {
        background-color: #138496;
    }

    a.btn-delete {
        background-color: #dc3545;
    }

    a.btn-delete:hover {
        background-color: #c82333;
    }

    .empty-state {
        text-align: center;
        padding: 30px 10px;
        color: #6c757d;
        font-size: 1.1rem;
    }

    .empty-state i {
        font-size: 3rem;
        margin-bottom: 10px;
        color: #adb5bd;
    }

    @media (max-width: 1200px) {
        .user-table {
            display: block;
            overflow-x: auto;
        }
    }
</style>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
