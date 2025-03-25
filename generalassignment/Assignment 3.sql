-- ASSIGNMENT: SQL Queries for Database Management

-- 1) List all system databases available in MS SQL Server
SELECT name FROM sys.databases WHERE database_id <= 4;

-- 2) Retrieve the physical file locations (MDF & LDF) of a database named "CompanyDB"
SELECT name, physical_name, type_desc  
FROM sys.master_files  
WHERE database_id = DB_ID('CompanyDB');

-- 3) Create a database "HRDB" with specified file sizes and auto-growth settings
CREATE DATABASE HRDB
ON PRIMARY (NAME = 'HRDB_Data', FILENAME = 'C:\SQLData\HRDB.mdf', SIZE = 10MB, FILEGROWTH = 2MB)
LOG ON (NAME = 'HRDB_Log', FILENAME = 'C:\SQLData\HRDB.ldf', SIZE = 5MB, FILEGROWTH = 1MB);

-- 4) Rename "HRDB" to "EmployeeDB" if it exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'HRDB')
    ALTER DATABASE HRDB MODIFY NAME = EmployeeDB;

-- 5) Drop "EmployeeDB" safely if it exists
USE master;
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'EmployeeDB')
BEGIN
    ALTER DATABASE EmployeeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EmployeeDB;
END

-- 6) Display all supported data types in MS SQL Server
SELECT name AS DataType FROM sys.types;

-- 7) Create "Employees" table with the required fields
DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    JoinDate DATE NOT NULL,
    Salary DECIMAL(10,2) DEFAULT 30000.00
);


-- 8) Add a new column "Department" to the "Employees" table
ALTER TABLE Employees ADD Department VARCHAR(50);

-- 9) Rename "Employees" table to "Staff"
EXEC sp_rename 'Employees', 'Staff';

-- 10) Drop "Staff" table
DROP TABLE Staff;
