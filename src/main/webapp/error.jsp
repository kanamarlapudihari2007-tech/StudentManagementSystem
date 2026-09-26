<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Student Management System</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body class="login-body">

    <div class="login-card" style="max-width: 480px;">
        <div class="login-brand-icon" style="background: var(--danger-bg); color: var(--danger-color);">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
        </div>

        <div class="login-header">
            <h2 style="color: var(--danger-color);">Something Went Wrong</h2>
            <p>An unexpected error occurred while processing your request.</p>
        </div>

        <div class="alert alert-danger">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <span>Something went wrong. Please try again.</span>
        </div>

        <div style="margin-top: 24px;">
            <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-primary btn-block">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
                <span>Return to Dashboard</span>
            </a>
        </div>
    </div>

</body>
</html>
