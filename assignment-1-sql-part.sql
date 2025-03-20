-- Task1
-- 1. Create the database named "TechShop"
CREATE DATABASE TechShop;
USE TechShop;

-- 2. Define the schema for the Customers, Products, Orders, OrderDetails, and Inventory tables

-- Creating Customers Table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(15) UNIQUE
);

-- Creating Products Table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL
);

-- Creating Orders Table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),
    OrderStatus VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- Creating OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Creating Inventory Table
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    QuantityAvailable INT NOT NULL,
    LastStockUpdate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 5. Insert at least 10 sample records into each table

-- Inserting sample data into Customers
INSERT INTO Customers (FirstName, LastName, Email, Address, Phone) VALUES
('John', 'Doe', 'john.doe@example.com', '123 Main St, NY', '1234567890'),
('Alice', 'Smith', 'alice.smith@example.com', '456 Park Ave, LA', '2345678901'),
('Michael', 'Brown', 'michael.brown@example.com', '789 Elm St, TX', '3456789012'),
('Sarah', 'Johnson', 'sarah.johnson@example.com', '147 Pine St, FL', '4567890123'),
('Robert', 'Williams', 'robert.williams@example.com', '369 Cedar St, WA', '5678901234'),
('Emma', 'Davis', 'emma.davis@example.com', '258 Oak St, IL', '6789012345'),
('David', 'Miller', 'david.miller@example.com', '963 Maple St, OH', '7890123456'),
('Sophia', 'Wilson', 'sophia.wilson@example.com', '741 Birch St, NV', '8901234567'),
('James', 'Anderson', 'james.anderson@example.com', '852 Cherry St, MI', '9012345678'),
('Olivia', 'Taylor', 'olivia.taylor@example.com', '159 Walnut St, AZ', '0123456789');

-- Inserting sample data into Products
INSERT INTO Products (ProductName, Category, Price, StockQuantity) VALUES
('Laptop', 'Electronics', 1200.00, 50),
('Smartphone', 'Electronics', 800.00, 100),
('Tablet', 'Electronics', 600.00, 70),
('Headphones', 'Accessories', 100.00, 200),
('Smartwatch', 'Electronics', 250.00, 80),
('Keyboard', 'Accessories', 40.00, 150),
('Mouse', 'Accessories', 30.00, 180),
('Monitor', 'Electronics', 300.00, 40),
('Printer', 'Electronics', 200.00, 30),
('External Hard Drive', 'Storage', 150.00, 60);

-- Inserting sample data into Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, OrderStatus) VALUES
(1, '2024-03-01', 2000.00, 'Completed'),
(2, '2024-03-02', 800.00, 'Pending'),
(3, '2024-03-03', 1200.00, 'Shipped'),
(4, '2024-03-04', 600.00, 'Completed'),
(5, '2024-03-05', 100.00, 'Cancelled'),
(6, '2024-03-06', 250.00, 'Completed'),
(7, '2024-03-07', 70.00, 'Pending'),
(8, '2024-03-08', 40.00, 'Shipped'),
(9, '2024-03-09', 30.00, 'Completed'),
(10, '2024-03-10', 300.00, 'Pending');

-- Inserting sample data into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1200.00),
(1, 2, 1, 800.00),
(2, 2, 1, 800.00),
(3, 3, 2, 600.00),
(4, 4, 6, 100.00),
(5, 5, 1, 250.00),
(6, 6, 2, 40.00),
(7, 7, 3, 30.00),
(8, 8, 1, 300.00),
(9, 9, 1, 200.00);

-- Inserting sample data into Inventory
INSERT INTO Inventory (ProductID, QuantityAvailable, LastStockUpdate) VALUES
(1, 49, '2024-03-01'),
(2, 98, '2024-03-02'),
(3, 68, '2024-03-03'),
(4, 194, '2024-03-04'),
(5, 79, '2024-03-05'),
(6, 148, '2024-03-06'),
(7, 177, '2024-03-07'),
(8, 39, '2024-03-08'),
(9, 29, '2024-03-09'),
(10, 59, '2024-03-10');
 
--Print All Tables at the End
PRINT 'Customers Table:';
SELECT * FROM Customers;
PRINT 'Products Table:';
SELECT * FROM Products;
PRINT 'Orders Table:';
SELECT * FROM Orders;
PRINT 'OrderDetails Table:';
SELECT * FROM OrderDetails;
PRINT 'Inventory Table:';
SELECT * FROM Inventory;

--Task2
-- 1. Retrieve the names and emails of all customers
SELECT FirstName, LastName, Email FROM Customers;

-- 2. List all orders with their order dates and corresponding customer names
SELECT 
    o.OrderID, 
    o.OrderDate, 
    c.FirstName, 
    c.LastName 
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 3. Insert a new customer record into the "Customers" table
INSERT INTO Customers (FirstName, LastName, Email, Address)
VALUES ('John', 'Doe', 'johndoe@example.com', '123 Main St, New York, NY');

-- 4. Update the prices of all electronic gadgets in the "Products" table by increasing them by 10%
UPDATE Products
SET Price = Price * 1.10
WHERE Category = 'Electronics';

-- 5. Delete a specific order and its associated order details using OrderID as a parameter
DELETE FROM OrderDetails WHERE OrderID = @OrderID;
DELETE FROM Orders WHERE OrderID = @OrderID;

-- 6. Insert a new order into the "Orders" table
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, GETDATE(), 250.00);

-- 7. Update the contact information (email and address) of a specific customer
DECLARE @CustomerID INT = 1; -- Change this to the actual Customer ID
DECLARE @NewEmail VARCHAR(100) = 'new.email@example.com';

UPDATE Customers
SET Email = @NewEmail
WHERE CustomerID = @CustomerID;


-- 8. Recalculate and update the total cost of each order in the "Orders" table
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(od.Quantity * p.Price)
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE od.OrderID = Orders.OrderID
);

-- 9. Delete all orders and associated order details for a specific customer
DECLARE @CustomerID INT = 1;  -- Change this to the actual Customer ID

DELETE FROM OrderDetails 
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerID);

DELETE FROM Orders WHERE CustomerID = @CustomerID;


-- 10. Insert a new electronic gadget product into the "Products" table
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES ('Smartphone X', 'Electronics', 699.99, 50);

-- 11. Update the status of a specific order in the "Orders" table
DECLARE @OrderID INT = 1;  -- Change this to the actual Order ID
DECLARE @NewStatus VARCHAR(50) = 'Shipped';  -- Change to the desired status

UPDATE Orders
SET OrderStatus = @NewStatus
WHERE OrderID = @OrderID;


-- 12. Calculate and update the number of orders placed by each customer
ALTER TABLE Customers ADD OrderCount INT DEFAULT 0;
UPDATE Customers
SET OrderCount = (
    SELECT COUNT(*) FROM Orders WHERE Orders.CustomerID = Customers.CustomerID
);

--Task3
-- 1. Retrieve a list of all orders along with customer information for each order
SELECT 
    o.OrderID, 
    o.OrderDate, 
    o.TotalAmount, 
    c.FirstName, 
    c.LastName, 
    c.Email, 
    c.Phone 
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 2. Find the total revenue generated by each electronic gadget product
SELECT 
    p.ProductName, 
    SUM(od.Quantity * od.Price) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Electronics'
GROUP BY p.ProductName;

-- 3. List all customers who have made at least one purchase, including their names and contact info
SELECT DISTINCT 
    c.CustomerID, 
    c.FirstName, 
    c.LastName, 
    c.Email, 
    c.Phone 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 4. Find the most popular electronic gadget (highest total quantity ordered)
SELECT TOP 1 
    p.ProductName, 
    SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Electronics'
GROUP BY p.ProductName
ORDER BY TotalQuantityOrdered DESC;

-- 5. Retrieve a list of electronic gadgets along with their corresponding categories
SELECT 
    ProductName, 
    Category 
FROM Products 
WHERE Category = 'Electronics';

-- 6. Calculate the average order value for each customer
SELECT 
    c.CustomerID, 
    c.FirstName, 
    c.LastName, 
    AVG(o.TotalAmount) AS AverageOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 7. Find the order with the highest total revenue
SELECT TOP 1 
    o.OrderID, 
    c.FirstName, 
    c.LastName, 
    o.TotalAmount 
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY o.TotalAmount DESC;

-- 8. List electronic gadgets and the number of times each product has been ordered
SELECT 
    p.ProductName, 
    COUNT(od.OrderID) AS TimesOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TimesOrdered DESC;

-- 9. Find customers who have purchased a specific electronic gadget product (using a parameter)
DECLARE @ProductName VARCHAR(100) = 'Laptop'; -- Change this value as needed

SELECT DISTINCT 
    c.CustomerID, 
    c.FirstName, 
    c.LastName, 
    c.Email 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = @ProductName;

-- 10. Calculate the total revenue generated by all orders placed within a specific time period (using parameters)
DECLARE @StartDate DATE = '2024-03-01';
DECLARE @EndDate DATE = '2024-03-31';

SELECT 
    SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN @StartDate AND @EndDate;

--Task4
-- 1. Find out which customers have not placed any orders
SELECT c.CustomerID, c.FirstName, c.LastName, c.Email
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 FROM Orders o WHERE o.CustomerID = c.CustomerID
);

-- 2. Find the total number of products available for sale
SELECT COUNT(*) AS TotalProducts FROM Products;

-- 3. Calculate the total revenue generated by TechShop
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders;

-- 4. Calculate the average quantity ordered for products in a specific category
DECLARE @CategoryName VARCHAR(50) = 'Electronics';  -- Change category as needed

SELECT AVG(od.Quantity) AS AverageQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = @CategoryName;

-- 5. Calculate the total revenue generated by a specific customer
DECLARE @CustomerID INT = 1;  -- Change customer ID as needed

SELECT c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.CustomerID = @CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 6. Find the customers who have placed the most orders
SELECT TOP 1 c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY OrderCount DESC;

-- 7. Find the most popular product category (highest total quantity ordered)
SELECT TOP 1 p.Category, SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalQuantityOrdered DESC;

-- 8. Find the customer who has spent the most money on electronic gadgets
SELECT TOP 1 c.CustomerID, c.FirstName, c.LastName, SUM(od.Quantity * od.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Electronics'
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

-- 9. Calculate the average order value (total revenue divided by the number of orders)
SELECT AVG(TotalAmount) AS AverageOrderValue FROM Orders;

-- 10. Find the total number of orders placed by each customer and list their names along with the order count
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;
