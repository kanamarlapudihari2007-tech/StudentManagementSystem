package com.sms.controller;

import com.sms.dao.AttendanceDAO;
import com.sms.dao.StudentDAO;
import com.sms.model.Attendance;
import com.sms.model.AttendanceSummary;
import com.sms.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * AttendanceServlet handles attendance recording and low attendance reports.
 */
@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AttendanceDAO attendanceDAO;
    private StudentDAO studentDAO;

    @Override
    public void init() {
        attendanceDAO = new AttendanceDAO();
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteAttendance(request, response);
        } else {
            listAttendance(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String date = request.getParameter("attendanceDate");
        String status = request.getParameter("status");

        if (studentId == null || studentId.trim().isEmpty() || 
            date == null || date.trim().isEmpty() || 
            status == null || status.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            listAttendance(request, response);
            return;
        }

        if (!studentDAO.isStudentIdExists(studentId.trim())) {
            request.setAttribute("errorMessage", "Error: Student ID '" + studentId + "' does not exist!");
            listAttendance(request, response);
            return;
        }

        Attendance attendance = new Attendance(0, studentId.trim(), date.trim(), status.trim());
        boolean success = attendanceDAO.recordAttendance(attendance);

        if (success) {
            request.setAttribute("successMessage", "Attendance recorded successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to record attendance.");
        }

        listAttendance(request, response);
    }

    private void listAttendance(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Attendance> logs = attendanceDAO.getAllAttendanceLogs();
        List<AttendanceSummary> summaries = attendanceDAO.getAttendanceSummaries();
        List<AttendanceSummary> lowAttendanceList = attendanceDAO.getLowAttendanceStudents(75.0);
        List<Student> students = studentDAO.getAllStudents();

        request.setAttribute("attendanceLogs", logs);
        request.setAttribute("attendanceSummaries", summaries);
        request.setAttribute("lowAttendanceList", lowAttendanceList);
        request.setAttribute("studentList", students);

        request.getRequestDispatcher("attendance.jsp").forward(request, response);
    }

    private void deleteAttendance(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                boolean success = attendanceDAO.deleteAttendance(id);
                if (success) {
                    request.setAttribute("successMessage", "Attendance record deleted!");
                } else {
                    request.setAttribute("errorMessage", "Failed to delete record.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid record ID.");
            }
        }
        listAttendance(request, response);
    }
}
