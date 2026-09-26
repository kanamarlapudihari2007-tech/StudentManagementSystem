package com.sms.controller;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * StudentServlet handles CRUD requests for Students.
 */
@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteStudent(request, response);
                break;
            case "search":
                searchStudents(request, response);
                break;
            default:
                listStudents(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertStudent(request, response);
        } else if ("update".equals(action)) {
            updateStudent(request, response);
        } else {
            listStudents(request, response);
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("studentList", students);
        request.getRequestDispatcher("students.jsp").forward(request, response);
    }

    private void searchStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String query = request.getParameter("query");
        List<Student> students = (query != null && !query.trim().isEmpty()) ? 
                studentDAO.searchStudents(query.trim()) : studentDAO.getAllStudents();
        request.setAttribute("studentList", students);
        request.setAttribute("searchQuery", query);
        request.getRequestDispatcher("students.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("formMode", "add");
        listStudents(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Student existingStudent = studentDAO.getStudentById(id);
        if (existingStudent != null) {
            request.setAttribute("editStudent", existingStudent);
            request.setAttribute("formMode", "edit");
        }
        listStudents(request, response);
    }

    private void insertStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        String year = request.getParameter("year");
        String section = request.getParameter("section");

        // Backend Validation
        if (studentId == null || studentId.trim().isEmpty() || name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Student ID and Name are required.");
            listStudents(request, response);
            return;
        }

        if (studentDAO.isStudentIdExists(studentId.trim())) {
            request.setAttribute("errorMessage", "Error: Student ID '" + studentId + "' already exists!");
            listStudents(request, response);
            return;
        }

        Student student = new Student(studentId.trim(), name.trim(), dob, gender, phone.trim(), 
                                      email.trim(), department.trim(), year, section);
        boolean success = studentDAO.addStudent(student);

        if (success) {
            request.setAttribute("successMessage", "Student added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add student. Please try again.");
        }
        listStudents(request, response);
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        String year = request.getParameter("year");
        String section = request.getParameter("section");

        Student student = new Student(studentId, name.trim(), dob, gender, phone.trim(), 
                                      email.trim(), department.trim(), year, section);
        boolean success = studentDAO.updateStudent(student);

        if (success) {
            request.setAttribute("successMessage", "Student updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update student.");
        }
        listStudents(request, response);
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null) {
            boolean success = studentDAO.deleteStudent(id);
            if (success) {
                request.setAttribute("successMessage", "Student deleted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to delete student.");
            }
        }
        listStudents(request, response);
    }
}
