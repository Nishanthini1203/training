-- 1. Provide a SQL script to initialize the Hotel Management System database
CREATE DATABASE HotelManagement;
USE HotelManagement;

-- 2. Create tables for hotels, rooms, guests, bookings, payments, events, and event participants
CREATE TABLE Hotels (
    HotelID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Rating DECIMAL(2,1) CHECK (Rating BETWEEN 1 AND 5)
);

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY IDENTITY(1,1),
    HotelID INT,
    RoomNumber VARCHAR(50) NOT NULL,
    RoomType VARCHAR(50) NOT NULL,
    PricePerNight DECIMAL(10,2) NOT NULL,
    Available BIT NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);

CREATE TABLE Guests (
    GuestID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20) UNIQUE NOT NULL,
    CheckInDate DATETIME,
    CheckOutDate DATETIME
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    GuestID INT,
    RoomID INT,
    BookingDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Confirmed', 'Cancelled', 'Checked Out')),
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT,
    AmountPaid DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

CREATE TABLE Events (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    HotelID INT,
    EventName VARCHAR(255) NOT NULL,
    EventDate DATETIME NOT NULL,
    Venue VARCHAR(255) NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);

CREATE TABLE EventParticipants (
    ParticipantID INT PRIMARY KEY IDENTITY(1,1),
    ParticipantName VARCHAR(255) NOT NULL,
    ParticipantType VARCHAR(50) CHECK (ParticipantType IN ('Guest', 'Organization')),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- 3. Ensure the script handles potential errors
BEGIN TRY
    CREATE DATABASE HotelManagement;
    USE HotelManagement;
END TRY
BEGIN CATCH
    PRINT 'Database already exists or another error occurred';
END CATCH;

---trying to insert values---
-- Insert data into Hotels table
INSERT INTO Hotels (Name, Location, Rating)
VALUES 
('The Leela Kovalam', 'Kerala', 4.9),
('Taj Malabar Resort & Spa', 'Kochi', 4.8),
('Kumarakom Lake Resort', 'Kerala', 4.7),
('Vivanta Coimbatore', 'Tamil Nadu', 4.5),
('ITC Grand Chola', 'Chennai', 4.9),
('Radisson Blu', 'Coimbatore', 4.6),
('The Gateway Hotel', 'Madurai', 4.3),
('Le Méridien', 'Kochi', 4.4),
('Taj Fisherman’s Cove', 'Chennai', 4.8),
('Sterling Ooty Elk Hill', 'Tamil Nadu', 4.2);

-- Insert data into Rooms table
INSERT INTO Rooms (HotelID, RoomNumber, RoomType, PricePerNight, Available)
VALUES 
(1, '101', 'Sea View Suite', 18000.00, 1),
(1, '102', 'Deluxe Room', 12000.00, 1),
(2, '201', 'Luxury Room', 15000.00, 1),
(2, '202', 'Premium Suite', 22000.00, 1),
(3, '301', 'Lake View Villa', 25000.00, 1),
(3, '302', 'Garden Cottage', 18000.00, 1),
(4, '401', 'Deluxe Room', 10000.00, 1),
(4, '402', 'Executive Suite', 14000.00, 1),
(5, '501', 'Presidential Suite', 50000.00, 1),
(5, '502', 'Luxury Room', 35000.00, 1),
(6, '601', 'Standard Room', 8000.00, 1),
(6, '602', 'Business Suite', 12000.00, 1),
(7, '701', 'Classic Room', 7000.00, 1),
(7, '702', 'Heritage Suite', 13000.00, 1),
(8, '801', 'Club Room', 11000.00, 1),
(8, '802', 'Junior Suite', 15000.00, 1),
(9, '901', 'Beach View Cottage', 24000.00, 1),
(9, '902', 'Waterfront Villa', 28000.00, 1),
(10, '1001', 'Mountain View Room', 9000.00, 1),
(10, '1002', 'Royal Suite', 20000.00, 1);

-- Insert data into Guests table
INSERT INTO Guests (FullName, Email, PhoneNumber, CheckInDate, CheckOutDate)
VALUES 
('Nisha', 'nisha@mail.com', '9876543210', '2025-04-10', '2025-04-15'),
('Nikila', 'nikila@mail.com', '9876543211', '2025-04-12', '2025-04-18'),
('Nivetha', 'nivetha@mail.com', '9876543212', '2025-04-14', '2025-04-20'),
('Ajith', 'ajith@mail.com', '9876543213', '2025-04-16', '2025-04-22'),
('Rohith', 'rohith@mail.com', '9876543214', '2025-04-18', '2025-04-24'),
('Dharshan', 'dharshan@mail.com', '9876543215', '2025-04-20', '2025-04-25'),
('Sandeep', 'sandeep@mail.com', '9876543216', '2025-04-22', '2025-04-27'),
('Vicky', 'vicky@mail.com', '9876543217', '2025-04-24', '2025-04-30'),
('Aravind', 'aravind@mail.com', '9876543218', '2025-04-26', '2025-05-02'),
('Harish', 'harish@mail.com', '9876543219', '2025-04-28', '2025-05-05');

-- Insert data into Bookings table
INSERT INTO Bookings (GuestID, RoomID, BookingDate, TotalAmount, Status)
VALUES 
(1, 1, '2025-04-01', 90000.00, 'Confirmed'),
(2, 2, '2025-04-02', 60000.00, 'Confirmed'),
(3, 3, '2025-04-03', 75000.00, 'Confirmed'),
(4, 4, '2025-04-04', 88000.00, 'Confirmed'),
(5, 5, '2025-04-05', 250000.00, 'Confirmed'),
(6, 6, '2025-04-06', 40000.00, 'Checked Out'),
(7, 7, '2025-04-07', 35000.00, 'Cancelled'),
(8, 8, '2025-04-08', 48000.00, 'Confirmed'),
(9, 9, '2025-04-09', 112000.00, 'Confirmed'),
(10, 10, '2025-04-10', 60000.00, 'Checked Out');

-- Insert data into Payments table
INSERT INTO Payments (BookingID, AmountPaid, PaymentDate, PaymentMethod)
VALUES 
(1, 90000.00, '2025-04-11', 'Credit Card'),
(2, 60000.00, '2025-04-13', 'Debit Card'),
(3, 75000.00, '2025-04-15', 'UPI'),
(4, 88000.00, '2025-04-17', 'Net Banking'),
(5, 250000.00, '2025-04-19', 'Bank Transfer'),
(6, 40000.00, '2025-04-21', 'Cash'),
(7, 35000.00, '2025-04-23', 'UPI'),
(8, 48000.00, '2025-04-25', 'Credit Card'),
(9, 112000.00, '2025-04-27', 'Debit Card'),
(10, 60000.00, '2025-04-29', 'Net Banking');

-- Insert data into Events table
INSERT INTO Events (HotelID, EventName, EventDate, Venue)
VALUES 
(1, 'International Yoga Retreat', '2025-05-10', 'Beachfront'),
(2, 'Luxury Wine Tasting', '2025-06-15', 'Wine Lounge'),
(3, 'Kathakali Dance Festival', '2025-07-20', 'Open Stage'),
(4, 'Tech Startups Summit', '2025-08-25', 'Conference Hall'),
(5, 'Royal Wedding Expo', '2025-09-30', 'Grand Ballroom');

-- Insert data into EventParticipants table

SELECT name, definition 
FROM sys.check_constraints 
WHERE parent_object_id = OBJECT_ID('dbo.EventParticipants');

INSERT INTO EventParticipants (ParticipantName, ParticipantType, EventID)
VALUES 
('Gani', 'Participant', 1),
('Varshana', 'Participant', 2),
('Hairni', 'Organization', 3),
('Prabha', 'Organization', 4),
('Dharshan', 'Participant', 5);
ALTER TABLE EventParticipants DROP CONSTRAINT CK__EventPart__Parti__4BAC3F29;
ALTER TABLE EventParticipants 
ADD CONSTRAINT CK_EventParticipants_ParticipantType
CHECK (ParticipantType IN ('Organization', 'Participant', 'Guest', 'Organizer'));



-- 4. Retrieve a list of available rooms for booking
SELECT * FROM Rooms WHERE Available = 1;

-- 5. Retrieve names of participants for a specific event
SELECT ParticipantName FROM EventParticipants WHERE EventID = @EventID;

-- 6. Create a stored procedure to update hotel information
CREATE PROCEDURE UpdateHotelInfo @hotelID INT, @newName VARCHAR(255), @newLocation VARCHAR(255)
AS
BEGIN
    UPDATE Hotels SET Name = @newName, Location = @newLocation WHERE HotelID = @hotelID;
END;

-- 7. Calculate total revenue per hotel from confirmed bookings
SELECT h.Name, SUM(b.TotalAmount) AS TotalRevenue
FROM Hotels h
JOIN Rooms r ON h.HotelID = r.HotelID
JOIN Bookings b ON r.RoomID = b.RoomID
WHERE b.Status = 'Confirmed'
GROUP BY h.Name;

-- 8. Find rooms that have never been booked
SELECT * FROM Rooms WHERE RoomID NOT IN (SELECT RoomID FROM Bookings);

-- 9. Retrieve total payments per month and year
SELECT YEAR(PaymentDate) AS Year, MONTH(PaymentDate) AS Month, COALESCE(SUM(AmountPaid), 0) AS TotalPayments
FROM Payments
GROUP BY YEAR(PaymentDate), MONTH(PaymentDate)
ORDER BY Year, Month;

-- 10. Retrieve specific room types based on price range
SELECT DISTINCT RoomType FROM Rooms WHERE PricePerNight BETWEEN 50 AND 150 OR PricePerNight > 300;

-- 11. Retrieve occupied rooms along with guests
SELECT r.*, g.FullName FROM Rooms r
JOIN Bookings b ON r.RoomID = b.RoomID
JOIN Guests g ON b.GuestID = g.GuestID
WHERE b.Status = 'Confirmed';

-- 12. Find total event participants in a specific city
DECLARE @CityName NVARCHAR(100);
SET @CityName = 'Chennai'; -- Change to the desired city

SELECT COUNT(*) AS TotalParticipants 
FROM EventParticipants ep
JOIN Events e ON ep.EventID = e.EventID
JOIN Hotels h ON e.HotelID = h.HotelID
WHERE h.Location = @CityName;


-- 13. Retrieve unique room types available in a specific hotel
DECLARE @HotelID INT;
SET @HotelID = 1; -- Replace with the desired hotel ID

SELECT DISTINCT RoomType FROM Rooms WHERE HotelID = @HotelID;


-- 14. Find guests who never made a booking
INSERT INTO Guests (FullName, Email, PhoneNumber, CheckInDate, CheckOutDate)  
VALUES ('Aruna', 'aruna@example.com', '9678901234', NULL, NULL);
SELECT * FROM Guests WHERE GuestID NOT IN (SELECT GuestID FROM Bookings);

-- 15. Retrieve booked rooms and guests who booked them
SELECT r.RoomNumber, g.FullName FROM Bookings b
JOIN Rooms r ON b.RoomID = r.RoomID
JOIN Guests g ON b.GuestID = g.GuestID;

-- 16. Retrieve hotels with available room count
SELECT h.Name, COUNT(r.RoomID) AS AvailableRooms FROM Hotels h
JOIN Rooms r ON h.HotelID = r.HotelID
WHERE r.Available = 1
GROUP BY h.Name;

-- 17. Find room pairs in the same hotel with the same type
INSERT INTO Guests (FullName, Email, PhoneNumber, CheckInDate, CheckOutDate)  
VALUES ('Sneha', 'sneha@example.com', '9777886655', '2025-04-01', '2025-04-05');
SET IDENTITY_INSERT Rooms ON;

INSERT INTO Rooms (RoomID, HotelID, RoomNumber, RoomType, PricePerNight, Available)
VALUES 
(303, 3, 'D1', 'Deluxe', 200.00, 1),  -- Room in Hotel 3, Deluxe type, available
(304, 3, 'D2', 'Deluxe', 200.00, 1);  -- Another Deluxe room in the same hotel

SET IDENTITY_INSERT Rooms OFF;


SELECT r1.RoomID AS Room1, r2.RoomID AS Room2, r1.RoomType, r1.HotelID
FROM Rooms r1
JOIN Rooms r2 
ON r1.HotelID = r2.HotelID 
AND r1.RoomType = r2.RoomType 
AND r1.RoomID < r2.RoomID;


-- 18. List all possible combinations of hotels and events
SELECT h.Name AS Hotel, e.EventName FROM Hotels h CROSS JOIN Events e;

-- 19. Determine the hotel with the highest bookings
SELECT TOP 1 h.Name, COUNT(b.BookingID) AS TotalBookings
FROM Hotels h
JOIN Rooms r ON h.HotelID = r.HotelID
JOIN Bookings b ON r.RoomID = b.RoomID
GROUP BY h.Name
ORDER BY TotalBookings DESC;
