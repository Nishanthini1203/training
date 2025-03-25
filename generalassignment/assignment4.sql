-- Database Creation
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- Creating the SalesData table to avoid 'Invalid object name' error
IF OBJECT_ID('SalesData', 'U') IS NULL
BEGIN
    CREATE TABLE SalesData (
        SalesID INT PRIMARY KEY,
        ProductName VARCHAR(100),
        SalesAmount DECIMAL(10,2),
        SalesDate DATE
    );
    
    -- Inserting sample data
    INSERT INTO SalesData (SalesID, ProductName, SalesAmount, SalesDate) VALUES
    (1, 'Laptop', 1500.00, '2025-03-01'),
    (2, 'Smartphone', 800.00, '2025-03-05'),
    (3, 'Tablet', 600.00, '2025-03-10');
END

-- Question 1: Dynamic Column Aliasing
DECLARE @CurrentMonth NVARCHAR(20);
DECLARE @SQLQuery NVARCHAR(MAX);

-- Set the current month
SET @CurrentMonth = DATENAME(MONTH, GETDATE());

-- Construct the dynamic SQL query
SET @SQLQuery = N'
SELECT SalesID, ProductName, 
       SalesAmount AS [Sales_' + @CurrentMonth + '],
       SalesDate
FROM SalesData;';

-- Execute the query
EXEC sp_executesql @SQLQuery;

-- Question 2: Pivoting Data for Custom Report
-- Ensure we are using the correct database
USE CompanyDB;

-- Create EmployeeSalary table if it does not exist
IF OBJECT_ID('EmployeeSalary', 'U') IS NULL
BEGIN
    CREATE TABLE EmployeeSalary (
        EmployeeID INT,
        EmployeeName VARCHAR(100),
        SalaryMonth VARCHAR(10),
        SalaryAmount DECIMAL(10,2)
    );

    -- Insert Sample Data
    INSERT INTO EmployeeSalary (EmployeeID, EmployeeName, SalaryMonth, SalaryAmount) VALUES
    (1, 'Alice', 'January', 5000.00),
    (1, 'Alice', 'February', 5200.00),
    (2, 'Bob', 'January', 4800.00),
    (2, 'Bob', 'February', 4900.00);
END;

-- Now Execute the Pivot Query
SELECT * 
FROM (
    SELECT EmployeeID, EmployeeName, SalaryMonth, SalaryAmount 
    FROM EmployeeSalary
) AS SourceTable
PIVOT (
    SUM(SalaryAmount) 
    FOR SalaryMonth IN ([January], [February], [March], [April], [May], [June], 
                        [July], [August], [September], [October], [November], [December])
) AS PivotTable;



-- Question 3: Ranking and Filtering Data
-- Retrieves the top 3 transactions per customer, ranked by TransactionAmount in descending order
-- Ensure the database exists
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- 1?? Creating the CustomerTransactions table
IF OBJECT_ID('CustomerTransactions', 'U') IS NULL
BEGIN
    CREATE TABLE CustomerTransactions (
        TransactionID INT PRIMARY KEY IDENTITY(1,1),  -- Auto-incrementing Transaction ID
        CustomerID INT,  -- Foreign Key reference to Customers table
        TransactionAmount DECIMAL(10,2),  -- Amount of the transaction
        TransactionDate DATE  -- Date of transaction
    );

    -- 2?? Inserting sample data into CustomerTransactions
    INSERT INTO CustomerTransactions (CustomerID, TransactionAmount, TransactionDate) VALUES
    (1, 500.00, '2025-03-01'),
    (1, 150.00, '2025-03-02'),
    (1, 300.00, '2025-03-03'),
    (1, 800.00, '2025-03-04'), -- New top transaction
    (1, 800.00, '2025-03-05'), -- Same amount but newer date
    (2, 200.00, '2025-03-06'),
    (2, 700.00, '2025-03-07'),
    (2, 400.00, '2025-03-08'),
    (2, 950.00, '2025-03-09'),
    (2, 950.00, '2025-03-10'); -- Same amount but newer date
END;

-- 3?? Ranking Query: Returns the top 3 transactions per customer, ordered by amount and date
WITH RankedTransactions AS (
    SELECT 
        TransactionID, 
        CustomerID, 
        TransactionAmount, 
        TransactionDate, 
        RANK() OVER (PARTITION BY CustomerID 
                     ORDER BY TransactionAmount DESC, TransactionDate DESC) AS Rank
    FROM CustomerTransactions
)
SELECT TransactionID, CustomerID, TransactionAmount, TransactionDate 
FROM RankedTransactions 
WHERE Rank <= 3;


-- Question 4: Conditional Aggregation
-- Creating the Orders table to avoid 'Invalid object name' error
IF OBJECT_ID('Orders', 'U') IS NULL
BEGIN
    CREATE TABLE Orders (
        OrderID INT PRIMARY KEY IDENTITY(1,1),
        CustomerID INT,
        OrderAmount DECIMAL(10,2),
        OrderDate DATE
    );
    
    -- Inserting sample data
    INSERT INTO Orders (CustomerID, OrderAmount, OrderDate) VALUES
    (1, 250.00, '2024-03-10'),
    (1, 180.00, '2023-06-15'),
    (2, 320.00, '2024-01-25'),
    (2, 400.00, '2023-05-05'),
    (3, 150.00, '2024-02-20');
END
-- Summarizes total OrderAmount per customer and calculates TotalOrdersThisYear and TotalOrdersLastYear
SELECT 
    CustomerID, 
    SUM(OrderAmount) AS TotalOrderAmount,
    SUM(CASE WHEN YEAR(OrderDate) = YEAR(GETDATE()) THEN OrderAmount ELSE 0 END) AS TotalOrdersThisYear,
    SUM(CASE WHEN YEAR(OrderDate) = YEAR(GETDATE()) - 1 THEN OrderAmount ELSE 0 END) AS TotalOrdersLastYear
FROM Orders
GROUP BY CustomerID;


-- Question 5: Generating a Custom Ranking Report

-- Creating the StudentScores table to avoid 'Invalid object name' error
IF OBJECT_ID('StudentScores', 'U') IS NULL
BEGIN
    CREATE TABLE StudentScores (
        StudentID INT PRIMARY KEY,
        StudentName VARCHAR(100),
        Subject VARCHAR(50),
        Score INT
    );
    
    -- Inserting sample data
    INSERT INTO StudentScores (StudentID, StudentName, Subject, Score) VALUES
    (1, 'Alice', 'Math', 95),
    (2, 'Bob', 'Math', 90),
    (3, 'Charlie', 'Math', 85),
    (1, 'Alice', 'Science', 88),
    (2, 'Bob', 'Science', 92);
END
SELECT * FROM StudentScores;
DROP TABLE IF EXISTS StudentScores;

CREATE TABLE StudentScores (
    StudentID INT,
    StudentName VARCHAR(100),
    Subject VARCHAR(50),
    Score INT,
    PRIMARY KEY (StudentID, Subject) -- Allows multiple subjects per student
);

-- Insert sample data again
INSERT INTO StudentScores (StudentID, StudentName, Subject, Score) VALUES
(1, 'Alice', 'Math', 95),
(2, 'Bob', 'Math', 90),
(3, 'Charlie', 'Math', 85),
(1, 'Alice', 'Science', 88),
(2, 'Bob', 'Science', 92),
(3, 'Charlie', 'Science', 85),
(4, 'David', 'Math', 95),
(5, 'Eve', 'Science', 91);

-- Assigns a rank to each student per subject based on their Score using DENSE_RANK()
SELECT 
    StudentID, 
    StudentName, 
    Subject, 
    Score,
    DENSE_RANK() OVER (PARTITION BY Subject ORDER BY Score DESC) AS Rank
FROM StudentScores;
