-- Database Initialization
CREATE DATABASE CourseManagement;
GO

USE CourseManagement;
GO

-- Table: Instructors (Q2)
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY IDENTITY,FullName VARCHAR(255) NOT NULL,Email VARCHAR(255) UNIQUE NOT NULL,Expertise VARCHAR(255) NOT NULL);
-- Table: Courses (Q2)
CREATE TABLE Courses ( CourseID INT PRIMARY KEY IDENTITY, CourseName VARCHAR(255) NOT NULL, Category VARCHAR(255) NOT NULL, Duration INT NOT NULL,
    InstructorID INT NOT NULL, FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);
-- Table: Students (Q2)
CREATE TABLE Students (StudentID INT PRIMARY KEY IDENTITY,FullName VARCHAR(255) NOT NULL,Email VARCHAR(255) UNIQUE NOT NULL,PhoneNumber VARCHAR(15) NOT NULL
);
-- Table: Enrollments (Q2)
CREATE TABLE Enrollments (EnrollmentID INT PRIMARY KEY IDENTITY,StudentID INT NOT NULL,CourseID INT NOT NULL,EnrollmentDate DATETIME DEFAULT GETDATE(),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),CONSTRAINT UC_Enrollment UNIQUE (StudentID, CourseID)
);
-- Table: Payments (Q2)
CREATE TABLE Payments (PaymentID INT PRIMARY KEY IDENTITY,StudentID INT NOT NULL,AmountPaid DECIMAL(10,2) NOT NULL,PaymentDate DATETIME DEFAULT GETDATE(),
 FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);
-- Table: Assessments (Q2)
CREATE TABLE Assessments (AssessmentID INT PRIMARY KEY IDENTITY,CourseID INT NOT NULL,AssessmentType VARCHAR(255) NOT NULL,TotalMarks INT NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
-- Table: Discounts (New Table - Q2)
CREATE TABLE Discounts ( DiscountID INT PRIMARY KEY IDENTITY, Season VARCHAR(50) NOT NULL, DiscountPercentage DECIMAL(5,2) NOT NULL, CourseID INT NOT NULL,
 FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Insert Values (Q2)
INSERT INTO Instructors (FullName, Email, Expertise) VALUES
('Dr. Smith', 'smith@example.com', 'AI'),
('Prof. John', 'john@example.com', 'Cloud Computing'),
('Dr. Adams', 'adams@example.com', 'Cyber Security');

INSERT INTO Courses (CourseName, Category, Duration, InstructorID) VALUES
('AI Fundamentals', 'Technology', 40, 1),
('Cloud Architecture', 'Technology', 50, 2),
('Ethical Hacking', 'Cyber Security', 30, 3);

INSERT INTO Students (FullName, Email, PhoneNumber) VALUES
('Nikila', 'nikila@example.com', '1234567890'),
('Nivedha', 'nivedha@example.com', '2345678901'),
('Nisha', 'nisha@example.com', '3456789012'),
('Gani', 'gani@example.com', '4567890123'),
('Varshana', 'varshana@example.com', '5678901234'),
('Appu', 'appu@example.com', '6789012345'),
('Sanju', 'sanju@example.com', '7890123456'),
('Rohith', 'rohith@example.com', '8901234567'),
('Vicky', 'vicky@example.com', '9012345678'),
('Yogesh', 'yogesh@example.com', '0123456789');

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, '2025-01-10'),
(2, 1, '2025-01-15'),
(3, 2, '2025-01-20'),
(4, 2, '2025-01-25'),
(5, 3, '2025-02-01');

INSERT INTO Payments (StudentID, AmountPaid, PaymentDate) VALUES
(1, 500.00, '2025-01-11'),
(2, 500.00, '2025-01-16'),
(3, 700.00, '2025-01-21'),
(4, 700.00, '2025-01-26');

INSERT INTO Assessments (CourseID, AssessmentType, TotalMarks) VALUES
(1, 'Quiz', 100),
(2, 'Assignment', 100),
(3, 'Exam', 100);

INSERT INTO Discounts (Season, DiscountPercentage, CourseID) VALUES
('Summer', 10.00, 1),
('Christmas', 15.00, 2),
('Saraswathi Pooja', 20.00, 3);

-- Q3: Retrieve Available Courses
SELECT C.CourseName, C.Category, C.Duration, I.FullName AS InstructorName
FROM Courses C
JOIN Instructors I ON C.InstructorID = I.InstructorID;

-- Q4: Retrieve Students Enrolled in a Specific Course
DECLARE @CourseID INT = 1;
SELECT S.FullName, S.Email, E.EnrollmentDate
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.CourseID = @CourseID;

-- Q5: Update Instructor Information (Stored Procedure)
CREATE PROCEDURE UpdateInstructor
    @InstructorID INT,
    @FullName VARCHAR(255),
    @Email VARCHAR(255)
AS
BEGIN
    UPDATE Instructors
    SET FullName = @FullName, Email = @Email
    WHERE InstructorID = @InstructorID;
END;
EXEC UpdateInstructor 
    @InstructorID = 1,       -- Replace with the actual Instructor ID
    @FullName = 'John Doe',  -- Replace with the new Full Name
    @Email = 'johndoe@email.com'; -- Replace with the new Email

-- Q6: Retrieve All Enrolled Students 
-- Q6: Calculate Total Payments per Student
SELECT 
    S.FullName AS StudentName, 
    COALESCE(SUM(P.AmountPaid), 0) AS TotalAmountPaid
FROM Students S
LEFT JOIN Payments P ON S.StudentID = P.StudentID
GROUP BY S.FullName;

-- Q7: Retrieve Students Without Enrollments
SELECT S.FullName AS StudentName, S.Email
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.StudentID IS NULL;

-- Q8: Retrieve Monthly Revenue
SELECT 
    YEAR(P.PaymentDate) AS Year,
    MONTH(P.PaymentDate) AS Month,
    SUM(P.AmountPaid) AS TotalRevenue
FROM Payments P
GROUP BY YEAR(P.PaymentDate), MONTH(P.PaymentDate)
ORDER BY Year DESC, Month DESC;


-- Q9: Find Students Enrolled in More Than 3 Courses
INSERT INTO Instructors (FullName, Email, Expertise)
VALUES 
    ('Dr. Smith', 'smith@example.com', 'Data Science'),
    ('Prof. Emily', 'emily@example.com', 'Software Engineering');
INSERT INTO Courses (CourseName, Category, Duration, InstructorID)
VALUES 
    ('Machine Learning', 'Data Science', 45, 5),
    ('Software Development', 'Technology', 35, 6);
INSERT INTO Students (FullName, Email, PhoneNumber) 
VALUES ('Alice Johnson', 'alice.johnson@example.com', '9876543210');
SELECT StudentID FROM Students WHERE FullName = 'Alice Johnson';
DECLARE @StudentID INT = (SELECT StudentID FROM Students WHERE FullName = 'Alice Johnson');
DECLARE @StudentID INT = 13;
INSERT INTO Enrollments (StudentID, CourseID)
VALUES 
    (@StudentID, 1),  -- Example: AI Fundamentals
    (@StudentID, 2),  -- Example: Cloud Computing
    (@StudentID, 3),  -- Example: Machine Learning
    (@StudentID, 9);  -- Example: Software Engineering
SELECT 
    S.StudentID, 
    S.FullName, 
    S.Email, 
    COUNT(E.CourseID) AS EnrolledCourses
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
GROUP BY S.StudentID, S.FullName, S.Email
HAVING COUNT(E.CourseID) > 3
ORDER BY EnrolledCourses DESC;

-- Q10: Retrieve Instructor-wise Course Count
SELECT 
    I.FullName AS InstructorName, 
    COUNT(C.CourseID) AS CourseCount
FROM 
    Instructors I
LEFT JOIN 
    Courses C ON I.InstructorID = C.InstructorID
GROUP BY 
    I.InstructorID, I.FullName;


-- Q11: 11.	Find Students Without Payments:
SELECT 
    S.FullName AS StudentName, 
    S.Email 
FROM 
    Students S
JOIN 
    Enrollments E ON S.StudentID = E.StudentID
LEFT JOIN 
    Payments P ON S.StudentID = P.StudentID
WHERE 
    P.PaymentID IS NULL;


-- Q12: Retrieve Course Enrollment Count
SELECT 
    C.CourseName, 
    C.Category, 
    C.Duration
FROM 
    Courses C
LEFT JOIN 
    Enrollments E ON C.CourseID = E.CourseID
WHERE 
    E.EnrollmentID IS NULL;


-- Q13: Retrieve Top 3 Most Popular Courses
SELECT TOP 3 C.CourseName, COUNT(E.StudentID) AS EnrollmentCount
FROM Courses C
LEFT JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY C.CourseName
ORDER BY EnrollmentCount DESC;

-- Q14: Retrieve Students and Their Total Marks in a Course:
SELECT 
    S.FullName AS StudentName, 
    C.CourseName, 
    SUM(A.TotalMarks) AS TotalMarks
FROM 
    Students S
JOIN 
    Enrollments E ON S.StudentID = E.StudentID
JOIN 
    Courses C ON E.CourseID = C.CourseID
JOIN 
    Assessments A ON C.CourseID = A.CourseID
GROUP BY 
    S.StudentID, S.FullName, C.CourseName;


-- Q15: List Courses with Assessments but No Enrollments:
SELECT 
    C.CourseName, 
    C.Category, 
    C.Duration
FROM 
    Courses C
JOIN 
    Assessments A ON C.CourseID = A.CourseID
LEFT JOIN 
    Enrollments E ON C.CourseID = E.CourseID
WHERE 
    E.EnrollmentID IS NULL;


-- Q16: Retrieve Payment Status per Student
SELECT 
    S.FullName AS StudentName,
    COUNT(E.CourseID) AS EnrolledCourses,
    COALESCE(SUM(P.AmountPaid), 0) AS TotalAmountPaid
FROM 
    Students S
LEFT JOIN 
    Enrollments E ON S.StudentID = E.StudentID
LEFT JOIN 
    Payments P ON S.StudentID = P.StudentID
GROUP BY 
    S.StudentID, S.FullName;


-- Q17: Find Course Pairs with the Same Instructor
SELECT 
    C1.CourseName AS Course1,
    C2.CourseName AS Course2,
    I.FullName AS InstructorName
FROM 
    Courses C1
JOIN 
    Courses C2 ON C1.InstructorID = C2.InstructorID
JOIN 
    Instructors I ON C1.InstructorID = I.InstructorID
WHERE 
    C1.CourseID < C2.CourseID;  -- To avoid duplicate pairs like (Course1, Course2) and (Course2, Course1)


-- Q18: List All Possible Student-Course Combinations
SELECT 
    S.FullName AS StudentName,
    C.CourseName AS CourseName
FROM 
    Students S
CROSS JOIN 
    Courses C;


-- Q19: Retrieve Active Students (Students with Enrollments)
-- Q19: Determine the Instructor with the Highest Number of Students
SELECT TOP 1
    I.FullName AS InstructorName,
    COUNT(DISTINCT E.StudentID) AS NumberOfStudents
FROM 
    Instructors I
JOIN 
    Courses C ON I.InstructorID = C.InstructorID
JOIN 
    Enrollments E ON C.CourseID = E.CourseID
GROUP BY 
    I.InstructorID, I.FullName
ORDER BY 
    NumberOfStudents DESC;



-- Trigger: Prevent Double Enrollment (Q20)
CREATE TRIGGER PreventDuplicateEnrollment
ON Enrollments
AFTER INSERT
AS
BEGIN
    ROLLBACK;
    PRINT 'Error: Student is already enrolled in this course';
END;