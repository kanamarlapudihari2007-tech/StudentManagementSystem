<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.sms.model.Admin" %>
<%@ page import="com.sms.model.AttendanceSummary" %>
<%@ page import="com.sms.model.Fees" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    Integer totalStudentsObj = (Integer) request.getAttribute("totalStudents");
    int totalStudents = (totalStudentsObj != null) ? totalStudentsObj : 0;

    Integer totalDepartmentsObj = (Integer) request.getAttribute("totalDepartments");
    int totalDepartments = (totalDepartmentsObj != null) ? totalDepartmentsObj : 0;

    Integer lowAttendanceCountObj = (Integer) request.getAttribute("lowAttendanceCount");
    int lowAttendanceCount = (lowAttendanceCountObj != null) ? lowAttendanceCountObj : 0;

    Integer pendingFeesCountObj = (Integer) request.getAttribute("pendingFeesCount");
    int pendingFeesCount = (pendingFeesCountObj != null) ? pendingFeesCountObj : 0;

    List<AttendanceSummary> lowAttendanceList = (List<AttendanceSummary>) request.getAttribute("lowAttendanceList");
    List<Fees> pendingFeesList = (List<Fees>) request.getAttribute("pendingFeesList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Student Management System</title>
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
                <a href="<%= request.getContextPath() %>/dashboard" class="active">
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
                <a href="<%= request.getContextPath() %>/fees">
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
                <h1>Dashboard Overview</h1>
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
            
            <!-- Dashboard Overview Stat Cards -->
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-info">
                        <span class="stat-title">Total Students</span>
                        <span class="stat-value"><%= totalStudents %></span>
                    </div>
                    <div class="stat-icon stat-icon-blue">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-info">
                        <span class="stat-title">Departments</span>
                        <span class="stat-value" style="color: var(--secondary-color);"><%= totalDepartments %></span>
                    </div>
                    <div class="stat-icon stat-icon-purple">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-info">
                        <span class="stat-title">Low Attendance (&lt;75%)</span>
                        <span class="stat-value" style="color: var(--danger-color);"><%= lowAttendanceCount %></span>
                    </div>
                    <div class="stat-icon stat-icon-red">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-info">
                        <span class="stat-title">Pending Fees</span>
                        <span class="stat-value" style="color: var(--warning-color);"><%= pendingFeesCount %></span>
                    </div>
                    <div class="stat-icon stat-icon-amber">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="4" width="20" height="16" rx="2"/><line x1="2" y1="10" x2="22" y2="10"/><circle cx="12" cy="15" r="2"/></svg>
                    </div>
                </div>
            </div>

            <!-- Two Column Section: Action Lists -->
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(360px, 1fr)); gap: 24px;">
                
                <!-- Low Attendance Alerts -->
                <div class="table-container">
                    <div class="table-header" style="background-color: #fef2f2; border-bottom: 1px solid #fecaca;">
                        <h3 style="color: #991b1b;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                            <span>Low Attendance Students (&lt; 75%)</span>
                        </h3>
                        <a href="<%= request.getContextPath() %>/attendance" class="btn btn-primary btn-sm">View All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Student ID</th>
                                    <th>Name</th>
                                    <th>Dept</th>
                                    <th>Attendance %</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (lowAttendanceList != null && !lowAttendanceList.isEmpty()) {
                                       for (AttendanceSummary s : lowAttendanceList) { %>
                                    <tr>
                                        <td><strong><%= s.getStudentId() %></strong></td>
                                        <td><%= s.getStudentName() %></td>
                                        <td><span class="badge badge-info"><%= s.getDepartment() %></span></td>
                                        <td><span class="badge badge-danger"><%= s.getPercentage() %>%</span></td>
                                    </tr>
                                <%     }
                                   } else { %>
                                    <tr>
                                        <td colspan="4" style="text-align: center; color: var(--text-muted); padding: 24px;">
                                            No low attendance alerts. All students maintain &ge; 75%!
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pending Fees Alerts -->
                <div class="table-container">
                    <div class="table-header" style="background-color: #fffbeb; border-bottom: 1px solid #fef3c7;">
                        <h3 style="color: #92400e;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="4" width="20" height="16" rx="2"/><line x1="2" y1="10" x2="22" y2="10"/></svg>
                            <span>Students with Pending Fees</span>
                        </h3>
                        <a href="<%= request.getContextPath() %>/fees" class="btn btn-primary btn-sm">View Ledger</a>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Student ID</th>
                                    <th>Name</th>
                                    <th>Paid</th>
                                    <th>Remaining Fee</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (pendingFeesList != null && !pendingFeesList.isEmpty()) {
                                       for (Fees f : pendingFeesList) { %>
                                    <tr>
                                        <td><strong><%= f.getStudentId() %></strong></td>
                                        <td><%= f.getStudentName() %></td>
                                        <td>₹<%= String.format("%.2f", f.getPaidFee()) %></td>
                                        <td><span class="badge badge-warning">₹<%= String.format("%.2f", f.getRemainingFee()) %></span></td>
                                    </tr>
                                <%     }
                                   } else { %>
                                    <tr>
                                        <td colspan="4" style="text-align: center; color: var(--text-muted); padding: 24px;">
                                            No pending fee records found. All tuition fees settled!
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
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
