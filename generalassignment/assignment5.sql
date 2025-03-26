-- =======================================
-- MS SQL Practice Exam 
-- Duration: 60 minutes | Total Marks: 50
-- =======================================

--Creating Database---
--====================
CREATE DATABASE Employeeassignment;
USE Employeeassignment;
-- =======================================
-- Section A: Storing and Manipulating Data (15 Marks)
-- =======================================


-- 1. Storing Data in a Table (3 Marks)
-- a) Create Employees table
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY, -- Auto-incrementing primary key
    Name VARCHAR(100) NOT NULL,  -- Employee name (required)
    Age INT,  -- Employee age
    Department VARCHAR(50),  -- Department name
    Salary DECIMAL(10,2)  -- Employee salary
);

-- b) Insert three records into Employees table
INSERT INTO Employees (Name, Age, Department, Salary) VALUES
('Alice Johnson', 35, 'HR', 55000.00),
('Bob Smith', 40, 'IT', 70000.00),
('Charlie Brown', 28, 'Finance', 48000.00);

-- =======================================
-- 2. Updating Data in a Table (3 Marks)
-- Increase salary by 10% for employees in the HR department
UPDATE Employees 
SET Salary = Salary * 1.10 
WHERE Department = 'HR';

-- =======================================
-- 3. Deleting Data from a Table (3 Marks)
-- Delete all employees from the IT department
DELETE FROM Employees 
WHERE Department = 'IT';

-- =======================================
-- 4. Demo: Manipulating Data in Tables (6 Marks)
-- a) Insert a new employee, ensuring Salary is at least 30000 (2 Marks)
INSERT INTO Employees (Name, Age, Department, Salary) 
VALUES ('David White', 32, 'Marketing', 
        CASE WHEN 28000 < 30000 THEN 30000 ELSE 28000 END);

-- b) Update the Department of employees who earn more than 50000 to 'Senior Staff' (2 Marks)
UPDATE Employees 
SET Department = 'Senior Staff' 
WHERE Salary > 50000;

-- c) Delete employees older than 60 years (2 Marks)
DELETE FROM Employees 
WHERE Age > 60;

-- =======================================
-- Section B: Retrieving and Filtering Data (35 Marks)
-- =======================================

-- 5. Retrieving Specific Attributes (3 Marks)
-- Retrieve only the Name and Salary of all employees
SELECT Name, Salary FROM Employees;

-- =======================================
-- 6. Retrieving Selected Rows (3 Marks)
-- Retrieve employees from HR department with Salary > 50000
SELECT * FROM Employees 
WHERE Department = 'HR' AND Salary > 50000;

-- =======================================
-- 7. Demo: Retrieving Data (4 Marks)
-- Retrieve all employees sorted by Salary in descending order
SELECT * FROM Employees 
ORDER BY Salary DESC;

-- =======================================
-- 8. Filtering Data - WHERE Clauses (5 Marks)
-- a) Retrieve employees whose Age is greater than 30 (2 Marks)
SELECT * FROM Employees 
WHERE Age > 30;

-- b) Retrieve employees whose Department is either HR or Finance (3 Marks)
SELECT * FROM Employees 
WHERE Department IN ('HR', 'Finance');

-- =======================================
-- 9. Filtering Data - Operators (10 Marks)
-- a) Retrieve employees whose Salary is between 30,000 and 60,000 (2 Marks)
SELECT * FROM Employees 
WHERE Salary BETWEEN 30000 AND 60000;

-- b) Retrieve employees whose Name starts with 'A' (2 Marks)
SELECT * FROM Employees 
WHERE Name LIKE 'A%';

-- c) Retrieve employees who do NOT belong to the IT department (2 Marks)
SELECT * FROM Employees 
WHERE Department <> 'IT';

-- d) Retrieve employees whose Department is either 'Sales' or 'Marketing' using IN (2 Marks)
SELECT * FROM Employees 
WHERE Department IN ('Sales', 'Marketing');

-- e) Retrieve employees with distinct Department names (2 Marks)
SELECT DISTINCT Department FROM Employees;

-- =======================================
-- 10. Column & Table Aliases (3 Marks)
-- Retrieve EmployeeID, Name, and Salary, renaming EmployeeID as 'ID' and Salary as 'Monthly Income'
SELECT EmployeeID AS ID, Name, Salary AS [Monthly Income] FROM Employees;

-- =======================================
-- 11. Demo: Filtering Data (4 Marks)
-- Retrieve employees whose Name contains 'John' and Salary is greater than 40,000
SELECT * FROM Employees 
WHERE Name LIKE '%John%' AND Salary > 40000;

-- =======================================
-- End of SQL Practice Exam Queries
-- =======================================
