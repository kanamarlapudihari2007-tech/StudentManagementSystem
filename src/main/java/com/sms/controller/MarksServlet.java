package com.sms.controller;

import com.sms.dao.MarksDAO;
import com.sms.dao.StudentDAO;
import com.sms.model.Marks;
import com.sms.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * MarksServlet handles subject marks entry and viewing.
 */
@WebServlet("/marks")
public class MarksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private MarksDAO marksDAO;
    private StudentDAO studentDAO;

    @Override
    public void init() {
        marksDAO = new MarksDAO();
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteMarks(request, response);
        } else {
            listMarks(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String subject = request.getParameter("subject");
        String marksStr = request.getParameter("marks");

        if (studentId == null || studentId.trim().isEmpty() || 
            subject == null || subject.trim().isEmpty() || 
            marksStr == null || marksStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            listMarks(request, response);
            return;
        }

        // Validate student exists
        if (!studentDAO.isStudentIdExists(studentId.trim())) {
            request.setAttribute("errorMessage", "Error: Student ID '" + studentId + "' does not exist!");
            listMarks(request, response);
            return;
        }

        try {
            int score = Integer.parseInt(marksStr.trim());

            // Validate Marks Range 0 to 100
            if (score < 0 || score > 100) {
                request.setAttribute("errorMessage", "Marks must be between 0 and 100.");
                listMarks(request, response);
                return;
            }

            Marks marks = new Marks(0, studentId.trim(), subject.trim(), score);
            boolean success = marksDAO.addMarks(marks);

            if (success) {
                request.setAttribute("successMessage", "Marks recorded successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to record marks.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid marks value. Please enter a valid number.");
        }

        listMarks(request, response);
    }

    private void listMarks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Marks> marksList = marksDAO.getAllMarks();
        List<Student> students = studentDAO.getAllStudents();

        request.setAttribute("marksList", marksList);
        request.setAttribute("studentList", students);
        request.getRequestDispatcher("marks.jsp").forward(request, response);
    }

    private void deleteMarks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                boolean success = marksDAO.deleteMarks(id);
                if (success) {
                    request.setAttribute("successMessage", "Marks record deleted!");
                } else {
                    request.setAttribute("errorMessage", "Failed to delete record.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid record ID.");
            }
        }
        listMarks(request, response);
    }
}
