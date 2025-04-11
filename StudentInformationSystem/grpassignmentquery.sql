-- ===================================
-- Task 1.1: Create the database named "SISDB"
-- ===================================
CREATE DATABASE SISDB;
GO

-- ===================================
-- Task 1.2: Use the SISDB database
-- ===================================
USE SISDB;
GO

-- ===================================
-- Task 1.2.a: Create Students table
-- ===================================
CREATE TABLE Students (
    student_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    date_of_birth DATE,
    email NVARCHAR(100),
    phone_number NVARCHAR(20)
);

-- ===================================
-- Task 1.2.b: Create Teachers table
-- ===================================
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    email NVARCHAR(100)
);

-- ===================================
-- Task 1.2.c: Create Courses table
-- ===================================
CREATE TABLE Courses (
    course_id INT PRIMARY KEY IDENTITY(1,1),
    course_name NVARCHAR(100),
    credits INT,
    teacher_id INT FOREIGN KEY REFERENCES Teachers(teacher_id)
);

-- ===================================
-- Task 1.2.d: Create Enrollments table
-- ===================================
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    course_id INT FOREIGN KEY REFERENCES Courses(course_id),
    enrollment_date DATE
);

-- ===================================
-- Task 1.2.e: Create Payments table
-- ===================================
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    amount DECIMAL(10,2),
    payment_date DATE
);

-- ===================================
-- Task 1.5.i: Insert sample records into Students table
-- ===================================
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES 
('Rahul', 'Sharma', '2000-08-15', 'rahul.sharma@gmail.com', '9876543210'),
('Priya', 'Mehta', '2001-07-12', 'priya.mehta@yahoo.com', '8765432109'),
('Amit', 'Verma', '2002-01-21', 'amit.verma@outlook.com', '7654321098'),
('Sneha', 'Reddy', '2003-11-11', 'sneha.reddy@gmail.com', '9543210987'),
('Karan', 'Patel', '2000-05-09', 'karan.patel@gmail.com', '9988776655'),
('Neha', 'Singh', '2001-03-28', 'neha.singh@gmail.com', '9123456780'),
('Ravi', 'Kumar', '2002-09-14', 'ravi.kumar@gmail.com', '8899776655'),
('Pooja', 'Nair', '2003-12-19', 'pooja.nair@gmail.com', '9345678901'),
('Anil', 'Yadav', '2001-06-06', 'anil.yadav@gmail.com', '9001234567'),
('Divya', 'Joshi', '2000-02-23', 'divya.joshi@gmail.com', '8888888888');

-- ===================================
-- Task 1.5.ii: Insert sample records into Teachers table
-- ===================================
INSERT INTO Teachers (first_name, last_name, email)
VALUES 
('Anita', 'Deshmukh', 'anita.deshmukh@college.edu.in'),
('Rajeev', 'Nair', 'rajeev.nair@college.edu.in'),
('Sonal', 'Kapoor', 'sonal.kapoor@college.edu.in'),
('Arjun', 'Iyer', 'arjun.iyer@college.edu.in'),
('Meena', 'Rao', 'meena.rao@college.edu.in'),
('Sunil', 'Mishra', 'sunil.mishra@college.edu.in'),
('Swati', 'Shah', 'swati.shah@college.edu.in'),
('Nitin', 'Chowdhury', 'nitin.chowdhury@college.edu.in'),
('Rekha', 'Saxena', 'rekha.saxena@college.edu.in'),
('Vikram', 'Sen', 'vikram.sen@college.edu.in');

-- ===================================
-- Task 1.5.iii: Insert sample records into Courses table
-- ===================================
INSERT INTO Courses (course_name, credits, teacher_id)
VALUES 
('Introduction to Programming', 4, 1),
('Mathematics 101', 3, 2),
('Computer Science 101', 4, 3),
('English Literature', 3, 4),
('Physics Fundamentals', 4, 5),
('Chemistry Basics', 4, 6),
('Indian History', 3, 7),
('Environmental Studies', 2, 8),
('Web Technologies', 4, 9),
('Database Management Systems', 4, 10);

-- ===================================
-- Task 1.5.iv: Insert sample records into Enrollments table
-- ===================================
INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES 
(1, 1, '2024-01-10'),
(2, 2, '2024-01-11'),
(3, 3, '2024-01-12'),
(4, 4, '2024-01-13'),
(5, 5, '2024-01-14'),
(6, 6, '2024-01-15'),
(7, 7, '2024-01-16'),
(8, 8, '2024-01-17'),
(9, 9, '2024-01-18'),
(10, 10, '2024-01-19');

-- ===================================
-- Task 1.5.v: Insert sample records into Payments table
-- ===================================
INSERT INTO Payments (student_id, amount, payment_date)
VALUES 
(1, 5000.00, '2024-02-01'),
(2, 4500.00, '2024-02-02'),
(3, 6000.00, '2024-02-03'),
(4, 3000.00, '2024-02-04'),
(5, 4000.00, '2024-02-05'),
(6, 7000.00, '2024-02-06'),
(7, 3500.00, '2024-02-07'),
(8, 2000.00, '2024-02-08'),
(9, 5500.00, '2024-02-09'),
(10, 6500.00, '2024-02-10');

-- ===================================
-- Task 2.1: Insert a new student named John Doe
-- ===================================
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES ('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

-- ===================================
-- Task 2.2: Enroll student_id = 1 in course_id = 2 with today's date
-- ===================================
INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES (1, 2, GETDATE());

-- ===================================
-- Task 2.3: Update email address of teacher_id = 1
-- ===================================
UPDATE Teachers
SET email = 'anita.updated@college.edu.in'
WHERE teacher_id = 1;

-- ===================================
-- Task 2.4: Delete enrollment record for student_id = 2 and course_id = 2
-- ===================================
DELETE FROM Enrollments
WHERE student_id = 2 AND course_id = 2;

-- ===================================
-- Task 2.5: Assign teacher_id = 3 to course_id = 1
-- ===================================
UPDATE Courses
SET teacher_id = 3
WHERE course_id = 1;

-- ===================================
-- Task 2.6: Delete student_id = 4 and all their enrollments and payments
-- ===================================
DELETE FROM Enrollments WHERE student_id = 4;
DELETE FROM Payments WHERE student_id = 4;
DELETE FROM Students WHERE student_id = 4;

-- ===================================
-- Task 2.7: Update payment amount for payment_id = 1
-- ===================================
UPDATE Payments
SET amount = 9999.00
WHERE payment_id = 1;

-- ===================================
-- Task 3.1: Total payments made by student_id = 1
-- ===================================
SELECT s.first_name, s.last_name, SUM(p.amount) AS total_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE s.student_id = 1
GROUP BY s.first_name, s.last_name;

-- ===================================
-- Task 3.2: List of courses with count of students enrolled
-- ===================================
SELECT c.course_name, COUNT(e.student_id) AS enrolled_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- ===================================
-- Task 3.3: Students who have not enrolled in any course
-- ===================================
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- ===================================
-- Task 3.4: Student names and the names of courses they are enrolled in
-- ===================================
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- ===================================
-- Task 3.5: Teachers and the courses they are assigned to
-- ===================================
SELECT t.first_name, t.last_name, c.course_name
FROM Teachers t
JOIN Courses c ON t.teacher_id = c.teacher_id;

-- ===================================
-- Task 3.6: Students and their enrollment dates for course_id = 2
-- ===================================
SELECT s.first_name, s.last_name, e.enrollment_date
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.course_id = 2;

-- ===================================
-- Task 3.7: Students who have not made any payments
-- ===================================
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
WHERE p.payment_id IS NULL;

-- ===================================
-- Task 3.8: Courses that have no enrollments
-- ===================================
SELECT c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;

-- ===================================
-- Task 3.9: Students who are enrolled in more than one course
-- ===================================
SELECT s.first_name, s.last_name, COUNT(e.course_id) AS course_count
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.first_name, s.last_name
HAVING COUNT(e.course_id) > 1;

-- ===================================
-- Task 3.10: Teachers who are not assigned to any courses
-- ===================================
SELECT t.first_name, t.last_name
FROM Teachers t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id
WHERE c.course_id IS NULL;

-- ===================================
-- Task 4.1: Calculate the average number of students enrolled in each course
-- ===================================
SELECT AVG(student_count) AS avg_enrollments
FROM (
    SELECT COUNT(*) AS student_count
    FROM Enrollments
    GROUP BY course_id
) AS sub;

-- ===================================
-- Task 4.2: Identify the student(s) who made the highest payment
-- ===================================
SELECT s.first_name, s.last_name, p.amount
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE p.amount = (
    SELECT MAX(amount) FROM Payments
);

-- ===================================
-- Task 4.3: List of courses with the highest number of enrollments
-- ===================================
SELECT c.course_name, COUNT(e.enrollment_id) AS total_enrollments
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(e.enrollment_id) = (
    SELECT MAX(enrollment_count)
    FROM (
        SELECT COUNT(*) AS enrollment_count
        FROM Enrollments
        GROUP BY course_id
    ) AS sub
);

-- ===================================
-- Task 4.4: Total payments made to courses taught by each teacher
-- ===================================
SELECT t.first_name, t.last_name, SUM(p.amount) AS total_payment
FROM Teachers t
JOIN Courses c ON t.teacher_id = c.teacher_id
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Payments p ON e.student_id = p.student_id
GROUP BY t.first_name, t.last_name;

-- ===================================
-- Task 4.5: Students who are enrolled in all available courses
-- Add a new student who will be enrolled in all available courses
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES ('Meera', 'Kashyap', '2001-05-20', 'meera.kashyap@example.com', '9111222333');

-- Enroll Meera (student_id = 11) into all 10 existing courses (IDs 1 through 10)
INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES 
(12, 1, GETDATE()),
(12, 2, GETDATE()),
(12, 3, GETDATE()),
(12, 4, GETDATE()),
(12, 5, GETDATE()),
(12, 6, GETDATE()),
(12, 7, GETDATE()),
(12, 8, GETDATE()),
(12, 9, GETDATE()),
(12, 10, GETDATE());

-- ===================================

SELECT s.student_id, s.first_name, s.last_name
FROM Students s
WHERE NOT EXISTS (
    SELECT course_id FROM Courses
    EXCEPT
    SELECT course_id FROM Enrollments e WHERE e.student_id = s.student_id
);


-- ===================================
-- Task 4.6: Teachers who have not been assigned to any courses
-- ===================================
SELECT first_name, last_name
FROM Teachers
WHERE teacher_id NOT IN (
    SELECT DISTINCT teacher_id FROM Courses WHERE teacher_id IS NOT NULL
);

-- ===================================
-- Task 4.7: Calculate the average age of all students
-- ===================================
SELECT AVG(DATEDIFF(YEAR, date_of_birth, GETDATE())) AS average_age
FROM Students;

-- ===================================
-- Task 4.8: Courses with no enrollments
-- ===================================
SELECT course_name
FROM Courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM Enrollments
);

-- ===================================
-- Task 4.9: Total payments made by each student for each course
-- ===================================
SELECT s.first_name, s.last_name, c.course_name, SUM(p.amount) AS total_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
GROUP BY s.first_name, s.last_name, c.course_name;

-- ===================================
-- Task 4.10: Students who have made more than one payment
-- ===================================
SELECT s.first_name, s.last_name, COUNT(p.payment_id) AS payment_count
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.first_name, s.last_name
HAVING COUNT(p.payment_id) > 1;

-- ===================================
-- Task 4.11: Total payments made by each student
-- ===================================
SELECT s.first_name, s.last_name, SUM(p.amount) AS total_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.first_name, s.last_name;

-- ===================================
-- Task 4.12: List course names and count of students enrolled in each
-- ===================================
SELECT c.course_name, COUNT(e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- ===================================
-- Task 4.13: Average payment amount made by students
-- ===================================
SELECT AVG(p.amount) AS avg_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id;

ALTER TABLE Courses
ADD course_code NVARCHAR(50);
UPDATE Courses
SET course_code = 'CS302'
WHERE course_name = 'Advanced Database Management';

SELECT student_id, first_name, last_name FROM Students;
SELECT student_id FROM Students WHERE email = 'jane.johnson@example.com';

