package com.sms.controller;

import com.sms.dao.AdminDAO;
import com.sms.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * LoginServlet processes admin login requests and manages user sessions.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AdminDAO adminDAO;

    @Override
    public void init() {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // If already logged in, redirect to dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Display login page
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate basic inputs
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and Password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Authenticate with database via AdminDAO
        Admin admin = adminDAO.authenticate(username.trim(), password.trim());

        if (admin != null) {
            // Success: Create session & store admin info
            HttpSession session = request.getSession(true);
            session.setAttribute("admin", admin);
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            // Failure: Show error message
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
