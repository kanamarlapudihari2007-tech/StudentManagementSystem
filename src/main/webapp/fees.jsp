<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.sms.model.Fees" %>
<%@ page import="com.sms.model.Student" %>
<%@ page import="com.sms.model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    List<Fees> feesList = (List<Fees>) request.getAttribute("feesList");
    List<Student> studentList = (List<Student>) request.getAttribute("studentList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fees Management - SMS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<!-- Mobile Header Toggle -->
<div class="mobile-header">
    <div style="display: flex; align-items: center; gap: 10px;">
        <div class="sidebar-brand-icon" style="width: 30px; height: 30px;">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c3 3 9 3 12 0v-5"/></svg>
        </div>
        <span style="font-weight: 700; font-size: 1.1rem;">SMS Portal</span>
    </div>
    <button type="button" class="mobile-toggle-btn" onclick="toggleSidebar()">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
    </button>
</div>

<div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>

<div class="layout-wrapper">
    <!-- Sidebar Navigation -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <div class="sidebar-brand-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c3 3 9 3 12 0v-5"/></svg>
            </div>
            <span>SMS Portal</span>
        </div>
        <ul class="sidebar-menu">
            <li>
                <a href="<%= request.getContextPath() %>/dashboard">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/students">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                    <span>Students</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/marks">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>
                    <span>Marks</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/attendance">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/><polyline points="9 16 11 18 15 14"/></svg>
                    <span>Attendance</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/fees" class="active">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="4" width="20" height="16" rx="2"/><line x1="2" y1="10" x2="22" y2="10"/></svg>
                    <span>Fees</span>
                </a>
            </li>
        </ul>
    </aside>

    <!-- Main Content Area -->
    <main class="main-content">
        <header class="topbar">
            <div class="topbar-title">
                <h1>Fees Management</h1>
            </div>
            <div class="user-info">
                <div class="user-avatar-pill">
                    <div class="avatar-circle">
                        <%= admin != null && admin.getFullName() != null && !admin.getFullName().isEmpty() ? admin.getFullName().substring(0, 1).toUpperCase() : "A" %>
                    </div>
                    <span>Welcome, <strong><%= admin != null ? admin.getFullName() : "Admin" %></strong></span>
                </div>
                <a href="<%= request.getContextPath() %>/logout" class="logout-link">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                    <span>Logout</span>
                </a>
            </div>
        </header>

        <div class="content-body">
            
            <%-- Alert Banners --%>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                    <span><%= errorMessage %></span>
                </div>
            <% } %>

            <% String successMessage = (String) request.getAttribute("successMessage"); %>
            <% if (successMessage != null) { %>
                <div class="alert alert-success">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                    <span><%= successMessage %></span>
                </div>
            <% } %>

            <!-- Add/Update Fees Form -->
            <div class="table-container" style="margin-bottom: 28px; padding: 24px;">
                <h3 style="font-size: 1.15rem; font-weight: 700; margin-bottom: 16px; color: var(--text-primary);">
                    Record / Update Fee Details
                </h3>
                <form action="<%= request.getContextPath() %>/fees" method="post">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 16px;">
                        <div class="form-group">
                            <label>Select Student *</label>
                            <select name="studentId" class="form-control" required>
                                <option value="">-- Choose Student --</option>
                                <% if (studentList != null) {
                                       for (Student s : studentList) { %>
                                           <option value="<%= s.getStudentId() %>"><%= s.getStudentId() %> - <%= s.getName() %> (<%= s.getDepartment() %>)</option>
                                <%     }
                                   } %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Total Fee (₹) *</label>
                            <input type="number" step="0.01" name="totalFee" class="form-control" min="0" placeholder="e.g. 50000" required>
                        </div>

                        <div class="form-group">
                            <label>Paid Fee (₹) *</label>
                            <input type="number" step="0.01" name="paidFee" class="form-control" min="0" placeholder="e.g. 30000" required>
                        </div>
                    </div>

                    <div style="margin-top: 16px;">
                        <button type="submit" class="btn btn-primary">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
                            <span>Save Fee Record</span>
                        </button>
                    </div>
                </form>
            </div>

            <!-- Fees Data Table -->
            <div class="table-container">
                <div class="table-header">
                    <h3>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="4" width="20" height="16" rx="2"/><line x1="2" y1="10" x2="22" y2="10"/></svg>
                        <span>Student Fee Status & Ledger</span>
                    </h3>
                </div>

                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Record ID</th>
                                <th>Student ID</th>
                                <th>Student Name</th>
                                <th>Total Fee</th>
                                <th>Paid Fee</th>
                                <th>Remaining Fee</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (feesList != null && !feesList.isEmpty()) { 
                                   for (Fees f : feesList) { 
                                       boolean isPending = f.getRemainingFee() > 0.0;
                            %>
                                <tr>
                                    <td>#<%= f.getId() %></td>
                                    <td><strong><%= f.getStudentId() %></strong></td>
                                    <td><%= f.getStudentName() %></td>
                                    <td>₹<%= String.format("%.2f", f.getTotalFee()) %></td>
                                    <td>₹<%= String.format("%.2f", f.getPaidFee()) %></td>
                                    <td><strong>₹<%= String.format("%.2f", f.getRemainingFee()) %></strong></td>
                                    <td>
                                        <% if (isPending) { %>
                                            <span class="badge badge-warning">Pending</span>
                                        <% } else { %>
                                            <span class="badge badge-success">Paid</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <a href="<%= request.getContextPath() %>/fees?action=delete&id=<%= f.getId() %>" 
                                           class="btn btn-danger btn-sm" style="padding: 4px 8px;"
                                           onclick="return confirm('Delete fee record for <%= f.getStudentId() %>?');">
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                                            Delete
                                        </a>
                                    </td>
                                </tr>
                            <%     } 
                               } else { %>
                                <tr>
                                    <td colspan="8" style="text-align: center; color: var(--text-muted); padding: 24px;">
                                        No fee records found.
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </main>
</div>

<script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("open");
        document.getElementById("sidebarOverlay").classList.toggle("active");
    }
</script>

</body>
</html>
