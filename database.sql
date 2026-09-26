-- =========================================================
-- Student Management System - Database Schema & Sample Data
-- Database: student_management
-- =========================================================

CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

-- 1. Drop existing tables if re-running script (Order matters due to Foreign Keys)
DROP TABLE IF EXISTS fees;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS marks;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS admin;

-- 2. Create 'admin' table
CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL, -- Stores SHA-256 Hash of password
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create 'students' table
CREATE TABLE students (
    student_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(50) NOT NULL,
    year VARCHAR(10) NOT NULL,
    section VARCHAR(5) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Create 'marks' table
CREATE TABLE marks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    marks INT NOT NULL CHECK (marks >= 0 AND marks <= 100),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. Create 'attendance' table
CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL,
    attendance_date DATE NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('Present', 'Absent')),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. Create 'fees' table
CREATE TABLE fees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL UNIQUE,
    total_fee DECIMAL(10,2) NOT NULL CHECK (total_fee >= 0),
    paid_fee DECIMAL(10,2) NOT NULL CHECK (paid_fee >= 0),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- =========================================================
-- Sample Data Insertion
-- =========================================================

-- Insert Default Admin (Username: admin, Password: admin123 -> SHA-256 Hashed)
-- SHA-256('admin123') = 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
INSERT INTO admin (username, password, full_name, email) 
VALUES ('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'System Administrator', 'admin@college.edu');

-- Insert Sample Students
INSERT INTO students (student_id, name, dob, gender, phone, email, department, year, section) VALUES
('STU101', 'Rahul Sharma', '2004-05-15', 'Male', '9876543210', 'rahul.sharma@example.com', 'CSE', '2nd Year', 'A'),
('STU102', 'Priya Patel', '2004-08-22', 'Female', '9876543211', 'priya.patel@example.com', 'CSE', '2nd Year', 'B'),
('STU103', 'Amit Verma', '2003-11-10', 'Male', '9876543212', 'amit.verma@example.com', 'ECE', '3rd Year', 'A'),
('STU104', 'Sneha Reddy', '2004-02-18', 'Female', '9876543213', 'sneha.reddy@example.com', 'EEE', '2nd Year', 'A'),
('STU105', 'Vikram Singh', '2003-07-29', 'Male', '9876543214', 'vikram.singh@example.com', 'MECH', '3rd Year', 'B'),
('STU106', 'Ananya Gupta', '2005-01-05', 'Female', '9876543215', 'ananya.gupta@example.com', 'CIVIL', '1st Year', 'A');

-- Insert Sample Marks
INSERT INTO marks (student_id, subject, marks) VALUES
('STU101', 'Data Structures', 85),
('STU101', 'Database Systems', 90),
('STU101', 'Java Programming', 88),
('STU102', 'Data Structures', 78),
('STU102', 'Database Systems', 82),
('STU103', 'Digital Signal Processing', 92),
('STU104', 'Circuit Theory', 65),
('STU105', 'Thermodynamics', 45),
('STU106', 'Engineering Physics', 95);

-- Insert Sample Attendance Entries
-- Rahul (STU101): High attendance (4 Present, 0 Absent = 100%)
INSERT INTO attendance (student_id, attendance_date, status) VALUES
('STU101', '2026-09-01', 'Present'),
('STU101', '2026-09-02', 'Present'),
('STU101', '2026-09-03', 'Present'),
('STU101', '2026-09-04', 'Present');

-- Priya (STU102): High attendance (3 Present, 1 Absent = 75%)
INSERT INTO attendance (student_id, attendance_date, status) VALUES
('STU102', '2026-09-01', 'Present'),
('STU102', '2026-09-02', 'Present'),
('STU102', '2026-09-03', 'Present'),
('STU102', '2026-09-04', 'Absent');

-- Amit (STU103): Low attendance (1 Present, 3 Absent = 25% < 75%)
INSERT INTO attendance (student_id, attendance_date, status) VALUES
('STU103', '2026-09-01', 'Absent'),
('STU103', '2026-09-02', 'Present'),
('STU103', '2026-09-03', 'Absent'),
('STU103', '2026-09-04', 'Absent');

-- Vikram (STU105): Low attendance (1 Present, 3 Absent = 25% < 75%)
INSERT INTO attendance (student_id, attendance_date, status) VALUES
('STU105', '2026-09-01', 'Absent'),
('STU105', '2026-09-02', 'Absent'),
('STU105', '2026-09-03', 'Present'),
('STU105', '2026-09-04', 'Absent');

-- Insert Sample Fees
INSERT INTO fees (student_id, total_fee, paid_fee) VALUES
('STU101', 50000.00, 50000.00), -- Paid
('STU102', 50000.00, 30000.00), -- Pending: 20000
('STU103', 55000.00, 55000.00), -- Paid
('STU104', 50000.00, 25000.00), -- Pending: 25000
('STU105', 60000.00, 10000.00), -- Pending: 50000
('STU106', 45000.00, 45000.00); -- Paid
