package com.sms.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AuthFilter ensures that protected pages (dashboard, students, marks, attendance, fees)
 * cannot be accessed without an active logged-in Admin session.
 */
@WebFilter(urlPatterns = {"/dashboard", "/students", "/marks", "/attendance", "/fees", "*.jsp"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String requestURI = request.getRequestURI();
        
        // Exclude public pages and static resources
        boolean isLoginReq = requestURI.endsWith("login") || requestURI.endsWith("login.jsp") || requestURI.endsWith("error.jsp");
        boolean isStaticResource = requestURI.contains("/css/") || requestURI.contains("/js/");

        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("admin") != null);

        if (isLoggedIn || isLoginReq || isStaticResource) {
            // Prevent browser back button caching after logout
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
            response.setDateHeader("Expires", 0); // Proxies

            chain.doFilter(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {}
}
