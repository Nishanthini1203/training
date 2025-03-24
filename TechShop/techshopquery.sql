DROP DATABASE IF EXISTS TechShop;
CREATE DATABASE TechShop;
USE TechShop;

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(15) UNIQUE NOT NULL,
    Address NVARCHAR(255) NOT NULL
);
GO

-- Create Products table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0)
);
GO

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);
GO

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
GO

-- Create Inventory table
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL UNIQUE,
    QuantityInStock INT NOT NULL CHECK (QuantityInStock >= 0),
    LastStockUpdate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
GO
-- Insert sample Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('Rohith', 'Kumar', 'rohith.kumar@email.com', '9876543210', 'Hyderabad, Telangana'),
('Sandeep', 'Reddy', 'sandeep.reddy@email.com', '9876543211', 'Bangalore, Karnataka'),
('Gani', 'Sheikh', 'gani.sheikh@email.com', '9876543212', 'Chennai, Tamil Nadu'),
('Nikila', 'M', 'nikila.m@email.com', '9876543213', 'Mumbai, Maharashtra'),
('Vicky', 'Raj', 'vicky.raj@email.com', '9876543214', 'Pune, Maharashtra'),
('Nivedha', 'S', 'nivedha.s@email.com', '9876543215', 'Coimbatore, Tamil Nadu'),
('Yogesh', 'Naidu', 'yogesh.naidu@email.com', '9876543216', 'Delhi'),
('Harini', 'Rao', 'harini.rao@email.com', '9876543217', 'Kolkata, West Bengal'),
('Harish', 'Patel', 'harish.patel@email.com', '9876543218', 'Ahmedabad, Gujarat'),
('Prabha', 'Devi', 'prabha.devi@email.com', '9876543219', 'Jaipur, Rajasthan');
GO

-- Insert sample Products
INSERT INTO Products (ProductName, Description, Price) VALUES
('Smartphone', 'Latest Android smartphone', 19999.00),
('Laptop', 'High-performance laptop', 59999.00),
('Smartwatch', 'Fitness and health tracking smartwatch', 4999.00),
('Headphones', 'Noise-cancelling over-ear headphones', 2999.00),
('Tablet', '10-inch Android tablet', 14999.00),
('Bluetooth Speaker', 'Portable wireless speaker', 1999.00),
('Gaming Console', 'Next-gen gaming console', 39999.00),
('Power Bank', '10000mAh power bank', 999.00),
('Wireless Mouse', 'Ergonomic wireless mouse', 799.00),
('Keyboard', 'Mechanical gaming keyboard', 2499.00);
GO

-- Insert sample Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2025-03-20', 22998.00),
(2, '2025-03-21', 999.00),
(3, '2025-03-19', 19999.00),
(4, '2025-03-18', 8498.00),
(5, '2025-03-22', 59999.00),
(6, '2025-03-17', 4999.00),
(7, '2025-03-16', 14999.00),
(8, '2025-03-23', 2999.00),
(9, '2025-03-15', 39999.00),
(10, '2025-03-14', 799.00);
GO

-- Insert sample OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),  -- Rohith bought a Smartphone
(2, 8, 1),  -- Sandeep bought a Power Bank
(3, 2, 1),  -- Gani bought a Laptop
(4, 4, 2),  -- Nikila bought 2 Headphones
(5, 3, 1),  -- Vicky bought a Smartwatch
(6, 5, 1),  -- Nivedha bought a Tablet
(7, 6, 1),  -- Yogesh bought a Bluetooth Speaker
(8, 7, 1),  -- Harini bought a Gaming Console
(9, 9, 1),  -- Harish bought a Wireless Mouse
(10, 10, 1); -- Prabha bought a Keyboard
GO

-- Insert sample Inventory Data
INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate) VALUES
(1, 50, '2025-03-10'),
(2, 30, '2025-03-11'),
(3, 20, '2025-03-12'),
(4, 100, '2025-03-13'),
(5, 25, '2025-03-14'),
(6, 40, '2025-03-15'),
(7, 15, '2025-03-16'),
(8, 80, '2025-03-17'),
(9, 60, '2025-03-18'),
(10, 35, '2025-03-19');
GO

-- Display all Customers
SELECT * FROM Customers;

-- Display all Products
SELECT * FROM Products;

-- Display all Orders
SELECT * FROM Orders;

-- Display all OrderDetails
SELECT * FROM OrderDetails;

-- Display all Inventory
SELECT * FROM Inventory;

-- ============================================
-- TASK 2: SELECT, WHERE, BETWEEN, AND, LIKE
-- ============================================

USE TechShop;
GO

-- 1 Retrieve the names and emails of all customers
PRINT 'Displaying all customer names and emails:';
SELECT FirstName, LastName, Email FROM Customers;
GO

-- 2 List all orders with their order dates and corresponding customer names
PRINT 'Listing all orders with customer names:';
SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName 
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID;
GO

-- 3 Insert a new customer record
PRINT 'Inserting a new customer...';
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) 
VALUES ('Raj', 'Sharma', 'raj.sharma@email.com', '9876543220', 'Chennai, Tamil Nadu');

-- Verify the insert
PRINT 'New customer inserted. Displaying updated customer list:';
SELECT * FROM Customers;
GO

-- 4 Update prices of all electronic gadgets by increasing them by 10%
PRINT 'Updating product prices by 10%...';
UPDATE Products 
SET Price = Price * 1.10;

-- Verify price update
PRINT 'Prices updated successfully. Displaying updated products list:';
SELECT * FROM Products;
GO

-- 5 Delete a specific order and its associated order details (Using Stored Procedure)
PRINT 'Creating stored procedure for deleting an order...';
GO
CREATE OR ALTER PROCEDURE DeleteOrderAndDetails
    @OrderID INT
AS
BEGIN
    -- Check if the OrderID exists before attempting to delete
    IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
    BEGIN
        PRINT 'Error: Order ID does not exist.';
        RETURN;
    END

    -- Step 1: Delete associated order details first
    DELETE FROM OrderDetails WHERE OrderID = @OrderID;

    -- Step 2: Delete the order
    DELETE FROM Orders WHERE OrderID = @OrderID;

    PRINT 'Order and associated details deleted successfully.';
END;
GO

-- EXECUTE: Run this command to delete an order
EXEC DeleteOrderAndDetails @OrderID = 3;
GO
SELECT * FROM OrderDetails;

-- 6 Insert a new order into the "Orders" table
PRINT 'Inserting a new order...';
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) 
VALUES (2, GETDATE(), 0);

-- Verify the insert
PRINT 'New order inserted. Displaying updated orders list:';
SELECT * FROM Orders;
GO

-- 7 Update the contact information of a specific customer (Using Stored Procedure)
PRINT 'Creating stored procedure for updating customer contact info...';
GO
CREATE OR ALTER PROCEDURE UpdateCustomerInfo
    @CustomerID INT,
    @NewEmail NVARCHAR(100),
    @NewAddress NVARCHAR(255)
AS
BEGIN
    -- Check if Customer exists before updating
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
    BEGIN
        PRINT 'Error: Customer ID does not exist.';
        RETURN;
    END

    UPDATE Customers 
    SET Email = @NewEmail, Address = @NewAddress
    WHERE CustomerID = @CustomerID;

    PRINT 'Customer information updated successfully.';
END;
GO

-- EXECUTE: Run this command to update a customer's contact details
EXEC UpdateCustomerInfo @CustomerID = 5, @NewEmail = 'stjoseph@email.com', @NewAddress = 'Chennai, TamilNadu';
GO

-- 8 Recalculate and update the total cost of each order
PRINT 'Recalculating and updating total order costs...';
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(P.Price * OD.Quantity)
    FROM OrderDetails OD
    JOIN Products P ON OD.ProductID = P.ProductID
    WHERE OD.OrderID = Orders.OrderID
);

-- Verify update
PRINT 'Order totals updated successfully. Displaying updated orders:';
SELECT * FROM Orders;
GO

-- 9 Delete all orders and associated order details for a specific customer (Using Stored Procedure)
PRINT 'Creating stored procedure for deleting all orders for a customer...';
GO
CREATE OR ALTER PROCEDURE DeleteCustomerOrders
    @CustomerID INT
AS
BEGIN
    -- Check if Customer exists before deleting orders
    IF NOT EXISTS (SELECT 1 FROM Orders WHERE CustomerID = @CustomerID)
    BEGIN
        PRINT 'Error: Customer has no orders.';
        RETURN;
    END

    DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerID);
    DELETE FROM Orders WHERE CustomerID = @CustomerID;

    PRINT 'Orders and order details for the customer deleted successfully.';
END;
GO

-- EXECUTE: Run this command to delete all orders for a customer
EXEC DeleteCustomerOrders @CustomerID = 4;
GO
-- Display orders along with order details using a JOIN
PRINT 'Displaying all remaining orders with their order details:';
SELECT 
    O.OrderID, 
    O.CustomerID, 
    O.OrderDate, 
    O.TotalAmount, 
    OD.OrderDetailID, 
    OD.ProductID, 
    OD.Quantity
FROM Orders O
LEFT JOIN OrderDetails OD ON O.OrderID = OD.OrderID
ORDER BY O.OrderID;
GO

-- 10 Insert a new electronic gadget into the "Products" table
PRINT 'Inserting a new product...';
INSERT INTO Products (ProductName, Description, Price) 
VALUES ('Wireless Earbuds', 'Bluetooth 5.0 wireless earbuds with noise cancellation', 3499.00);

-- Verify insert
PRINT 'New product added. Displaying updated products list:';
SELECT * FROM Products;
GO

-- 11 Update the status of a specific order
-- Ensure 'Status' column exists
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Orders' AND COLUMN_NAME = 'Status')
BEGIN
    ALTER TABLE Orders ADD Status NVARCHAR(20) DEFAULT 'Pending';
END
GO

PRINT 'Creating stored procedure for updating order status...';
GO
CREATE OR ALTER PROCEDURE UpdateOrderStatus
    @OrderID INT,
    @NewStatus NVARCHAR(20)
AS
BEGIN
    UPDATE Orders 
    SET Status = @NewStatus
    WHERE OrderID = @OrderID;

    PRINT 'Order status updated successfully.';
END;
GO

-- EXECUTE: Run this command to update order status
EXEC UpdateOrderStatus @OrderID = 6, @NewStatus = 'Shipped';
GO
SELECT * FROM Orders;

-- 12 Calculate and update the number of orders placed by each customer
-- Ensure 'OrderCount' column exists
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Customers' AND COLUMN_NAME = 'OrderCount')
BEGIN
    ALTER TABLE Customers ADD OrderCount INT DEFAULT 0;
END
GO

PRINT 'Creating stored procedure for updating order counts...';
GO
CREATE OR ALTER PROCEDURE UpdateCustomerOrderCount
AS
BEGIN
    UPDATE Customers
    SET OrderCount = (
        SELECT COUNT(*) FROM Orders WHERE Orders.CustomerID = Customers.CustomerID
    );

    PRINT 'Order counts updated successfully.';
END;
GO

-- EXECUTE: Run this command to update order counts for all customers
EXEC UpdateCustomerOrderCount;
GO
-- Display updated Customers table with OrderCount
PRINT 'Displaying updated Customers table with OrderCount:';
SELECT CustomerID, FirstName, LastName, Email, Phone, Address, OrderCount FROM Customers;
GO

-- Display Customers and their orders using a JOIN
PRINT 'Displaying Customers and their respective orders:';
SELECT 
    C.CustomerID, 
    C.FirstName, 
    C.LastName, 
    C.Email, 
    C.OrderCount, 
    O.OrderID, 
    O.OrderDate, 
    O.TotalAmount
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
ORDER BY C.CustomerID;
GO

-- ============================================
-- TASK 3: Aggregate Functions, Joins, Group By, Having, Order By
-- ============================================

USE TechShop;
GO

-- 1 Retrieve a list of all orders along with customer information (e.g., customer name) for each order
PRINT 'Displaying all orders with customer information:';
SELECT 
    O.OrderID, 
    O.OrderDate, 
    O.TotalAmount, 
    C.CustomerID, 
    C.FirstName + ' ' + C.LastName AS CustomerName, 
    C.Email, 
    C.Phone
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
ORDER BY O.OrderDate DESC;
GO

-- 2 Find the total revenue generated by each electronic gadget product
PRINT 'Displaying total revenue generated by each product:';
SELECT 
    P.ProductID, 
    P.ProductName, 
    SUM(P.Price * OD.Quantity) AS TotalRevenue
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductID, P.ProductName
ORDER BY TotalRevenue DESC;
GO

-- 3 List all customers who have made at least one purchase
PRINT 'Displaying customers who have made at least one purchase:';
SELECT 
    C.CustomerID, 
    C.FirstName + ' ' + C.LastName AS CustomerName, 
    C.Email, 
    C.Phone, 
    COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName, C.Email, C.Phone
HAVING COUNT(O.OrderID) > 0
ORDER BY NumberOfOrders DESC;
GO

-- 4 Find the most popular electronic gadget (highest total quantity ordered)
PRINT 'Displaying the most popular electronic gadget based on total quantity ordered:';
SELECT TOP 1 
    P.ProductID, 
    P.ProductName, 
    SUM(OD.Quantity) AS TotalQuantityOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductID, P.ProductName
ORDER BY TotalQuantityOrdered DESC;
GO

-- 5 Retrieve a list of electronic gadgets along with their corresponding categories
PRINT 'Displaying electronic gadgets along with their categories:';
SELECT 
    P.ProductID, 
    P.ProductName, 
    P.Description
FROM Products P
ORDER BY P.ProductName;
GO

-- 6 Calculate the average order value for each customer
PRINT 'Displaying average order value per customer:';
SELECT 
    C.CustomerID, 
    C.FirstName + ' ' + C.LastName AS CustomerName, 
    AVG(O.TotalAmount) AS AvgOrderValue
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY AvgOrderValue DESC;
GO

-- 7 Find the order with the highest total revenue
PRINT 'Displaying the order with the highest total revenue:';
SELECT TOP 1 
    O.OrderID, 
    O.OrderDate, 
    O.TotalAmount, 
    C.CustomerID, 
    C.FirstName + ' ' + C.LastName AS CustomerName, 
    C.Email
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
ORDER BY O.TotalAmount DESC;
GO

-- 8 List electronic gadgets and the number of times each product has been ordered
PRINT 'Displaying electronic gadgets and the number of times they have been ordered:';
SELECT 
    P.ProductID, 
    P.ProductName, 
    COUNT(OD.OrderID) AS NumberOfTimesOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductID, P.ProductName
ORDER BY NumberOfTimesOrdered DESC;
GO

-- 9 Find customers who have purchased a specific electronic gadget product (Dynamic Input)
PRINT 'Creating stored procedure to find customers who purchased a specific product...';
GO
CREATE OR ALTER PROCEDURE GetCustomersByProduct
    @ProductName NVARCHAR(100)
AS
BEGIN
    PRINT 'Retrieving customers who have purchased: ' + @ProductName;
    
    SELECT DISTINCT 
        C.CustomerID, 
        C.FirstName + ' ' + C.LastName AS CustomerName, 
        C.Email, 
        C.Phone
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.CustomerID
    JOIN OrderDetails OD ON O.OrderID = OD.OrderID
    JOIN Products P ON OD.ProductID = P.ProductID
    WHERE P.ProductName = @ProductName;
END;
GO

-- EXECUTE: Run this command to get customers who bought a specific product
EXEC GetCustomersByProduct @ProductName = 'Smartphone';
GO

-- 10 Calculate total revenue generated by orders placed within a specific time period (Dynamic Input)
PRINT 'Creating stored procedure to calculate total revenue in a given time period...';
GO
CREATE OR ALTER PROCEDURE GetTotalRevenueByDateRange
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    PRINT 'Calculating total revenue from ' + CAST(@StartDate AS NVARCHAR) + ' to ' + CAST(@EndDate AS NVARCHAR);
    
    SELECT 
        SUM(TotalAmount) AS TotalRevenue
    FROM Orders
    WHERE OrderDate BETWEEN @StartDate AND @EndDate;
END;
GO

-- EXECUTE: Run this command to get revenue for a date range
EXEC GetTotalRevenueByDateRange @StartDate = '2025-03-01', @EndDate = '2025-03-31';
GO

-- ============================================
-- TASK: Additional Aggregate Queries
-- ============================================

USE TechShop;
GO

-- 1 Find customers who have NOT placed any orders
PRINT 'Displaying customers who have not placed any orders:';
SELECT 
    C.CustomerID, 
    C.FirstName + ' ' + C.LastName AS CustomerName, 
    C.Email, 
    C.Phone
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;
GO

-- 2 Find the total number of products available for sale
PRINT 'Displaying total number of products available for sale:';
SELECT COUNT(ProductID) AS TotalProducts FROM Products;
GO

-- 3 Calculate the total revenue generated by TechShop
PRINT 'Displaying total revenue generated by TechShop:';
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders;
GO

-- 4 Calculate the average quantity ordered for products in a specific category (Dynamic Input)
PRINT 'Creating stored procedure to get average quantity ordered for a specific category...';
GO
CREATE OR ALTER PROCEDURE GetAverageQuantityByCategory
    @CategoryName NVARCHAR(100)
AS
BEGIN
    PRINT 'Retrieving average quantity ordered for category: ' + @CategoryName;
    
    SELECT 
        COALESCE(AVG(OD.Quantity), 0) AS AvgQuantityOrdered
    FROM OrderDetails OD
    JOIN Products P ON OD.ProductID = P.ProductID
    WHERE P.Description = @CategoryName;
END;
GO

-- EXECUTE: Run this command to get average quantity for a category
EXEC GetAverageQuantityByCategory @CategoryName = 'Smartphone';
GO

-- 5 Calculate the total revenue generated by a specific customer (Dynamic Input)
PRINT 'Creating stored procedure to calculate total revenue for a specific customer...';
GO
CREATE OR ALTER PROCEDURE GetTotalRevenueByCustomer
    @CustomerID INT
AS
BEGIN
    PRINT 'Calculating total revenue for Customer ID: ' + CAST(@CustomerID AS NVARCHAR);
    
    SELECT 
        C.CustomerID, 
        C.FirstName + ' ' + C.LastName AS CustomerName, 
        SUM(O.TotalAmount) AS TotalRevenue
    FROM Customers C
    JOIN Orders O ON C.CustomerID = O.CustomerID
    WHERE C.CustomerID = @CustomerID
    GROUP BY C.CustomerID, C.FirstName, C.LastName;
END;
GO

-- EXECUTE: Run this command to get revenue for a customer
EXEC GetTotalRevenueByCustomer @CustomerID = 5;
GO

-- 6 Find the customers who have placed the most orders
PRINT 'Displaying customers who have placed the most orders:';
SELECT TOP 5
    C.CustomerID, 
    C.FirstName + ' ' + C.LastName AS CustomerName, 
    COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY NumberOfOrders DESC;
GO

-- 7 Find the most popular product category (highest total quantity ordered)
PRINT 'Displaying the most popular product category based on total quantity ordered:';
SELECT TOP 1 
    P.Description AS Category, 
    SUM(OD.Quantity) AS TotalQuantityOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.Description
ORDER BY TotalQuantityOrdered DESC;
GO

-- 8 Find the customer who has spent the most money (highest total revenue)
PRINT 'Displaying the customer who has spent the most money:';
SELECT TOP 1 
    C.CustomerID, 
    C.FirstName + ' ' + C.LastName AS CustomerName, 
    SUM(O.TotalAmount) AS TotalSpending
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY TotalSpending DESC;
GO

-- 9 Calculate the average order value for all customers
PRINT 'Displaying the average order value for all customers:';
SELECT 
    SUM(TotalAmount) / NULLIF(COUNT(OrderID), 0) AS AverageOrderValue
FROM Orders;
GO

-- 10 Find the total number of orders placed by each customer
PRINT 'Displaying the total number of orders placed by each customer:';
SELECT 
    C.CustomerID, 
    C.FirstName + ' ' + C.LastName AS CustomerName, 
    COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY TotalOrders DESC;
GO

----for python execution---
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Products';
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'OrderDetails';
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Products';
