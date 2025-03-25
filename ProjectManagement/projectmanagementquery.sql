-- Drop the database if it already exists
DROP DATABASE IF EXISTS ProjectManagement;
GO

-- Create a new ProjectManagement database
CREATE DATABASE ProjectManagement;
GO

-- Use the newly created database
USE ProjectManagement;
GO

-- Create the Project table to store project details
CREATE TABLE Project (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremented primary key
    projectName NVARCHAR(100) NOT NULL,  -- Project name
    description NVARCHAR(255),  -- Optional project description
    startDate DATE NOT NULL,  -- Project start date
    status NVARCHAR(50) CHECK (status IN ('started', 'dev', 'build', 'test', 'deployed')) NOT NULL  -- Project status with allowed values
);
GO

-- Create the Employee table to store employee details
CREATE TABLE Employee (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremented primary key
    name NVARCHAR(100) NOT NULL,  -- Employee name
    designation NVARCHAR(100) NOT NULL,  -- Job title
    gender NVARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')) NOT NULL,  -- Gender with allowed values
    salary DECIMAL(10,2) CHECK (salary > 0) NOT NULL,  -- Salary must be greater than 0
    project_id INT NULL,  -- Foreign key linking employee to a project
    FOREIGN KEY (project_id) REFERENCES Project(id) ON DELETE SET NULL  -- If project is deleted, set project_id to NULL
);
GO

-- Create the Task table to store task details
CREATE TABLE Task (
    task_id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremented primary key
    task_name NVARCHAR(100) NOT NULL,  -- Task name
    project_id INT NOT NULL,  -- Foreign key linking task to a project
    employee_id INT NULL,  -- Foreign key linking task to an employee
    status NVARCHAR(50) CHECK (status IN ('Assigned', 'Started', 'Completed')) NOT NULL,  -- Task status with allowed values
    FOREIGN KEY (project_id) REFERENCES Project(id) ON DELETE CASCADE,  -- If project is deleted, delete associated tasks
    FOREIGN KEY (employee_id) REFERENCES Employee(id) ON DELETE SET NULL  -- If employee is deleted, set employee_id to NULL
);
GO

-- Inserting sample projects
INSERT INTO Project (projectName, description, startDate, status) 
VALUES 
('AI Development', 'Machine Learning model for image recognition', '2025-03-01', 'started'),
('Web App', 'E-commerce platform development', '2025-02-15', 'dev'),
('Mobile App', 'Android and iOS mobile application', '2025-04-10', 'build'),
('Data Analytics', 'Big Data and analytics project', '2025-03-20', 'test'),
('Cloud Migration', 'Migrating legacy systems to the cloud', '2025-01-05', 'deployed'),
('Cyber Security', 'Implementing security features', '2025-05-01', 'started'),
('IoT Integration', 'Connecting IoT devices', '2025-06-15', 'dev'),
('Blockchain Project', 'Developing blockchain-based solutions', '2025-07-10', 'build'),
('Healthcare System', 'Creating a digital healthcare platform', '2025-08-01', 'test'),
('AI Chatbot', 'Developing an AI-powered chatbot', '2025-09-01', 'deployed');
GO

-- Inserting sample employees
INSERT INTO Employee (name, designation, gender, salary, project_id) 
VALUES 
('Nisha', 'Software Engineer', 'Female', 75000, 1),
('Gani', 'Data Scientist', 'Male', 85000, 2),
('Ram', 'Mobile Developer', 'Male', 70000, 3),
('Hairni', 'Data Analyst', 'Female', 65000, 4),
('Prabha', 'Cloud Engineer', 'Male', 90000, 5),
('Sangeetha', 'Cyber Security Expert', 'Female', 95000, 6),
('Nivetha', 'IoT Developer', 'Female', 80000, 7),
('Nikila', 'Blockchain Developer', 'Female', 88000, 8),
('Varshana', 'Healthcare IT Specialist', 'Female', 72000, 9),
('Dharshan', 'AI Researcher', 'Male', 98000, 10);
GO

-- Inserting sample tasks
INSERT INTO Task (task_name, project_id, employee_id, status) 
VALUES 
('Data Preprocessing', 1, 2, 'Assigned'),
('Frontend Design', 2, 1, 'Started'),
('Database Setup', 3, 3, 'Completed'),
('Data Visualization', 4, 4, 'Assigned'),
('Server Migration', 5, 5, 'Started'),
('Penetration Testing', 6, 6, 'Completed'),
('Sensor Integration', 7, 7, 'Assigned'),
('Smart Contract Development', 8, 8, 'Started'),
('Medical Data Analysis', 9, 9, 'Completed'),
('Chatbot AI Model Training', 10, 10, 'Assigned');
GO

-- Retrieve all employee data
SELECT * FROM Employee;

-- Retrieve all project data
SELECT * FROM Project;

-- Retrieve all task data
SELECT * FROM Task;

-- Verify that the Employee table has the correct structure
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Employee';

-- Count the number of employees named 'Nisha'
SELECT COUNT(*) AS EmployeeCount FROM Employee WHERE name = 'Nisha';

-- This should fail because project_id 100 doesn't exist
INSERT INTO Employee (name, designation, gender, salary, project_id) 
VALUES ('Mithun', 'Tech Lead', 'Male', 110000, 100);

-- Delete a project and check if associated tasks are removed
DELETE FROM Project WHERE id = 1; 
SELECT * FROM Task WHERE project_id = 1;  -- Should return no results
