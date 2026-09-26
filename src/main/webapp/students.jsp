<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.sms.model.Student" %>
<%@ page import="com.sms.model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    List<Student> studentList = (List<Student>) request.getAttribute("studentList");
    Student editStudent = (Student) request.getAttribute("editStudent");
    String formMode = (String) request.getAttribute("formMode");
    String searchQuery = (String) request.getAttribute("searchQuery");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management - SMS</title>
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
                <a href="<%= request.getContextPath() %>/students" class="active">
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
                <h1>Student Management</h1>
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

            <%-- Student Form (Add / Edit) --%>
            <% 
                boolean isEdit = "edit".equals(formMode);
                String formAction = isEdit ? "update" : "insert";
                String formHeading = isEdit ? "Edit Student Details" : "Add New Student";
                String submitBtnText = isEdit ? "Update Student" : "Save Student";
                String sId = (editStudent != null && editStudent.getStudentId() != null) ? editStudent.getStudentId() : "";
                String sName = (editStudent != null && editStudent.getName() != null) ? editStudent.getName() : "";
                String sDob = (editStudent != null && editStudent.getDob() != null) ? editStudent.getDob() : "";
                String sPhone = (editStudent != null && editStudent.getPhone() != null) ? editStudent.getPhone() : "";
                String sEmail = (editStudent != null && editStudent.getEmail() != null) ? editStudent.getEmail() : "";
                String sDept = (editStudent != null && editStudent.getDepartment() != null) ? editStudent.getDepartment() : "";
                String sSec = (editStudent != null && editStudent.getSection() != null) ? editStudent.getSection() : "";
            %>
            <div class="table-container" style="margin-bottom: 28px; padding: 24px;">
                <h3 style="font-size: 1.15rem; font-weight: 700; margin-bottom: 16px; color: var(--text-primary);">
                    <%= formHeading %>
                </h3>
                <form action="<%= request.getContextPath() %>/students" method="post">
                    <input type="hidden" name="action" value="<%= formAction %>">

                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(210px, 1fr)); gap: 16px;">
                        <div class="form-group">
                            <label>Student ID *</label>
                            <input type="text" name="studentId" class="form-control" 
                                   value="<%= sId %>"
                                   <%= isEdit ? "readonly" : "" %> required placeholder="e.g. STU101">
                        </div>

                        <div class="form-group">
                            <label>Full Name *</label>
                            <input type="text" name="name" class="form-control" 
                                   value="<%= sName %>" required placeholder="Enter full name">
                        </div>

                        <div class="form-group">
                            <label>Date of Birth *</label>
                            <input type="date" name="dob" class="form-control" 
                                   value="<%= sDob %>" required>
                        </div>

                        <div class="form-group">
                            <label>Gender *</label>
                            <select name="gender" class="form-control" required>
                                <option value="Male" <%= editStudent != null && "Male".equals(editStudent.getGender()) ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= editStudent != null && "Female".equals(editStudent.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="Other" <%= editStudent != null && "Other".equals(editStudent.getGender()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Phone *</label>
                            <input type="tel" name="phone" class="form-control" 
                                   value="<%= sPhone %>" required placeholder="10-digit phone">
                        </div>

                        <div class="form-group">
                            <label>Email *</label>
                            <input type="email" name="email" class="form-control" 
                                   value="<%= sEmail %>" required placeholder="email@domain.com">
                        </div>

                        <div class="form-group">
                            <label>Department *</label>
                            <input type="text" name="department" class="form-control" 
                                   value="<%= sDept %>" required placeholder="e.g. CSE">
                        </div>

                        <div class="form-group">
                            <label>Year *</label>
                            <select name="year" class="form-control" required>
                                <option value="1st Year" <%= editStudent != null && "1st Year".equals(editStudent.getYear()) ? "selected" : "" %>>1st Year</option>
                                <option value="2nd Year" <%= editStudent != null && "2nd Year".equals(editStudent.getYear()) ? "selected" : "" %>>2nd Year</option>
                                <option value="3rd Year" <%= editStudent != null && "3rd Year".equals(editStudent.getYear()) ? "selected" : "" %>>3rd Year</option>
                                <option value="4th Year" <%= editStudent != null && "4th Year".equals(editStudent.getYear()) ? "selected" : "" %>>4th Year</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Section *</label>
                            <input type="text" name="section" class="form-control" 
                                   value="<%= sSec %>" required placeholder="e.g. A">
                        </div>
                    </div>

                    <div style="margin-top: 16px; display: flex; gap: 12px;">
                        <button type="submit" class="btn btn-primary">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
                            <span><%= submitBtnText %></span>
                        </button>
                        <% if (isEdit) { %>
                            <a href="<%= request.getContextPath() %>/students" class="btn btn-secondary">Cancel</a>
                        <% } %>
                    </div>
                </form>
            </div>

            <!-- Student Data Table -->
            <div class="table-container">
                <div class="table-header">
                    <h3>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                        <span>Registered Students List</span>
                    </h3>
                    <form action="<%= request.getContextPath() %>/students" method="get" style="display: flex; gap: 8px;">
                        <input type="hidden" name="action" value="search">
                        <div class="search-box-wrapper">
                            <span class="search-box-icon">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
                            </span>
                            <input type="text" name="query" class="search-box" placeholder="Search ID, Name, Dept..." 
                                   value="<%= searchQuery != null ? searchQuery : "" %>">
                        </div>
                        <button type="submit" class="btn btn-primary btn-sm">Search</button>
                        <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                            <a href="<%= request.getContextPath() %>/students" class="btn btn-secondary btn-sm">Reset</a>
                        <% } %>
                    </form>
                </div>

                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Student ID</th>
                                <th>Name</th>
                                <th>DOB</th>
                                <th>Gender</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Dept</th>
                                <th>Year</th>
                                <th>Section</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (studentList != null && !studentList.isEmpty()) { 
                                   for (Student s : studentList) { %>
                                <tr>
                                    <td><strong><%= s.getStudentId() %></strong></td>
                                    <td><%= s.getName() %></td>
                                    <td><%= s.getDob() %></td>
                                    <td><%= s.getGender() %></td>
                                    <td><%= s.getPhone() %></td>
                                    <td><%= s.getEmail() %></td>
                                    <td><span class="badge badge-info"><%= s.getDepartment() %></span></td>
                                    <td><%= s.getYear() %></td>
                                    <td><%= s.getSection() %></td>
                                    <td>
                                        <div style="display: flex; gap: 6px;">
                                            <a href="<%= request.getContextPath() %>/students?action=edit&id=<%= s.getStudentId() %>" 
                                               class="btn btn-secondary btn-sm" style="padding: 4px 8px;" title="Edit">
                                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                                                Edit
                                            </a>
                                            <a href="<%= request.getContextPath() %>/students?action=delete&id=<%= s.getStudentId() %>" 
                                               class="btn btn-danger btn-sm" style="padding: 4px 8px;" title="Delete"
                                               onclick="return confirm('Are you sure you want to delete student <%= s.getStudentId() %>? This will also remove their marks, attendance, and fee records.');">
                                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                                                Delete
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            <%     } 
                               } else { %>
                                <tr>
                                    <td colspan="10" style="text-align: center; color: var(--text-muted); padding: 24px;">
                                        No student records found.
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
