<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.sms.model.Attendance" %>
<%@ page import="com.sms.model.AttendanceSummary" %>
<%@ page import="com.sms.model.Student" %>
<%@ page import="com.sms.model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    List<Attendance> logs = (List<Attendance>) request.getAttribute("attendanceLogs");
    List<AttendanceSummary> summaries = (List<AttendanceSummary>) request.getAttribute("attendanceSummaries");
    List<AttendanceSummary> lowList = (List<AttendanceSummary>) request.getAttribute("lowAttendanceList");
    List<Student> studentList = (List<Student>) request.getAttribute("studentList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance Management - SMS</title>
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
                <a href="<%= request.getContextPath() %>/attendance" class="active">
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
                <h1>Attendance Management</h1>
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

            <!-- Record Attendance Form -->
            <div class="table-container" style="margin-bottom: 28px; padding: 24px;">
                <h3 style="font-size: 1.15rem; font-weight: 700; margin-bottom: 16px; color: var(--text-primary);">
                    Record Class Attendance
                </h3>
                <form action="<%= request.getContextPath() %>/attendance" method="post">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(210px, 1fr)); gap: 16px;">
                        <div class="form-group">
                            <label>Select Student *</label>
                            <select name="studentId" class="form-control" required>
                                <option value="">-- Choose Student --</option>
                                <% if (studentList != null) {
                                       for (Student s : studentList) { %>
                                           <option value="<%= s.getStudentId() %>"><%= s.getStudentId() %> - <%= s.getName() %></option>
                                <%     }
                                   } %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Date *</label>
                            <input type="date" name="attendanceDate" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label>Status *</label>
                            <select name="status" class="form-control" required>
                                <option value="Present">Present</option>
                                <option value="Absent">Absent</option>
                            </select>
                        </div>
                    </div>

                    <div style="margin-top: 16px;">
                        <button type="submit" class="btn btn-primary">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
                            <span>Mark Attendance</span>
                        </button>
                    </div>
                </form>
            </div>

            <!-- Attendance Percentage Summaries -->
            <div class="table-container" style="margin-bottom: 28px;">
                <div class="table-header">
                    <h3>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/><polyline points="9 16 11 18 15 14"/></svg>
                        <span>Overall Attendance Percentage (&lt; 75% Highlighted)</span>
                    </h3>
                </div>
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Student ID</th>
                                <th>Student Name</th>
                                <th>Department</th>
                                <th>Total Classes</th>
                                <th>Present</th>
                                <th>Attendance %</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (summaries != null && !summaries.isEmpty()) { 
                                   for (AttendanceSummary s : summaries) { 
                                       boolean isLow = (s.getTotalClasses() > 0 && s.getPercentage() < 75.0);
                            %>
                                <tr<%= isLow ? " class=\"row-low-attendance\"" : "" %>>
                                    <td><strong><%= s.getStudentId() %></strong></td>
                                    <td><%= s.getStudentName() %></td>
                                    <td><span class="badge badge-info"><%= s.getDepartment() %></span></td>
                                    <td><%= s.getTotalClasses() %></td>
                                    <td><%= s.getPresentClasses() %></td>
                                    <td><strong><%= s.getPercentage() %>%</strong></td>
                                    <td>
                                        <% if (isLow) { %>
                                            <span class="badge badge-danger">Low Attendance (&lt;75%)</span>
                                        <% } else { %>
                                            <span class="badge badge-success">Sufficient</span>
                                        <% } %>
                                    </td>
                                </tr>
                            <%     } 
                               } else { %>
                                <tr>
                                    <td colspan="7" style="text-align: center; color: var(--text-muted); padding: 24px;">
                                        No attendance calculated.
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Raw Attendance Logs Table -->
            <div class="table-container">
                <div class="table-header">
                    <h3>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>
                        <span>Recent Attendance Logs</span>
                    </h3>
                </div>

                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Log ID</th>
                                <th>Student ID</th>
                                <th>Student Name</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (logs != null && !logs.isEmpty()) { 
                                   for (Attendance a : logs) { %>
                                <tr>
                                    <td>#<%= a.getId() %></td>
                                    <td><strong><%= a.getStudentId() %></strong></td>
                                    <td><%= a.getStudentName() %></td>
                                    <td><%= a.getAttendanceDate() %></td>
                                    <td>
                                        <% if ("Present".equalsIgnoreCase(a.getStatus())) { %>
                                            <span class="badge badge-success">Present</span>
                                        <% } else { %>
                                            <span class="badge badge-danger">Absent</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <a href="<%= request.getContextPath() %>/attendance?action=delete&id=<%= a.getId() %>" 
                                           class="btn btn-danger btn-sm" style="padding: 4px 8px;"
                                           onclick="return confirm('Delete this attendance entry?');">
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                                            Delete
                                        </a>
                                    </td>
                                </tr>
                            <%     } 
                               } else { %>
                                <tr>
                                    <td colspan="6" style="text-align: center; color: var(--text-muted); padding: 24px;">
                                        No attendance records logged yet.
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