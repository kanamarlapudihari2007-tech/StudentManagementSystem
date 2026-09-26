package com.sms.controller;

import com.sms.dao.FeesDAO;
import com.sms.dao.StudentDAO;
import com.sms.model.Fees;
import com.sms.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * FeesServlet handles fee management and payment logging.
 */
@WebServlet("/fees")
public class FeesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private FeesDAO feesDAO;
    private StudentDAO studentDAO;

    @Override
    public void init() {
        feesDAO = new FeesDAO();
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteFees(request, response);
        } else {
            listFees(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String totalFeeStr = request.getParameter("totalFee");
        String paidFeeStr = request.getParameter("paidFee");

        if (studentId == null || studentId.trim().isEmpty() || 
            totalFeeStr == null || totalFeeStr.trim().isEmpty() || 
            paidFeeStr == null || paidFeeStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fee fields are required.");
            listFees(request, response);
            return;
        }

        if (!studentDAO.isStudentIdExists(studentId.trim())) {
            request.setAttribute("errorMessage", "Error: Student ID '" + studentId + "' does not exist!");
            listFees(request, response);
            return;
        }

        try {
            double totalFee = Double.parseDouble(totalFeeStr.trim());
            double paidFee = Double.parseDouble(paidFeeStr.trim());

            // Validation: non-negative amounts
            if (totalFee < 0 || paidFee < 0) {
                request.setAttribute("errorMessage", "Fee amounts cannot be negative.");
                listFees(request, response);
                return;
            }

            if (paidFee > totalFee) {
                request.setAttribute("errorMessage", "Paid fee cannot exceed total fee amount.");
                listFees(request, response);
                return;
            }

            Fees fees = new Fees(0, studentId.trim(), totalFee, paidFee);
            boolean success = feesDAO.saveOrUpdateFees(fees);

            if (success) {
                request.setAttribute("successMessage", "Fee record updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update fee record.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric values entered for fee amounts.");
        }

        listFees(request, response);
    }

    private void listFees(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Fees> feesList = feesDAO.getAllFees();
        List<Student> students = studentDAO.getAllStudents();

        request.setAttribute("feesList", feesList);
        request.setAttribute("studentList", students);

        request.getRequestDispatcher("fees.jsp").forward(request, response);
    }

    private void deleteFees(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                boolean success = feesDAO.deleteFees(id);
                if (success) {
                    request.setAttribute("successMessage", "Fee record deleted!");
                } else {
                    request.setAttribute("errorMessage", "Failed to delete fee record.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid record ID.");
            }
        }
        listFees(request, response);
    }
}
