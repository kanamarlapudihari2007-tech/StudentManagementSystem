package com.sms.controller;

import com.sms.dao.AttendanceDAO;
import com.sms.dao.FeesDAO;
import com.sms.dao.StudentDAO;
import com.sms.model.AttendanceSummary;
import com.sms.model.Fees;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * DashboardServlet gathers overview statistics and renders the main Dashboard page.
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private StudentDAO studentDAO;
    private AttendanceDAO attendanceDAO;
    private FeesDAO feesDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
        attendanceDAO = new AttendanceDAO();
        feesDAO = new FeesDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        int totalStudents = studentDAO.getTotalStudentsCount();
        int totalDepartments = studentDAO.getTotalDepartmentsCount();
        int lowAttendanceCount = attendanceDAO.getLowAttendanceCount();
        int pendingFeesCount = feesDAO.getPendingFeesCount();

        List<AttendanceSummary> lowAttendanceList = attendanceDAO.getLowAttendanceStudents(75.0);
        List<Fees> pendingFeesList = feesDAO.getPendingFeesStudents();

        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("totalDepartments", totalDepartments);
        request.setAttribute("lowAttendanceCount", lowAttendanceCount);
        request.setAttribute("pendingFeesCount", pendingFeesCount);
        request.setAttribute("lowAttendanceList", lowAttendanceList);
        request.setAttribute("pendingFeesList", pendingFeesList);

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
