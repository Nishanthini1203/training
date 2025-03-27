-- 1. SQL Schema Creation
CREATE DATABASE PetCare;
USE PetCare;

-- 2. Create Tables with IDENTITY
CREATE TABLE Shelters (
    ShelterID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(255) UNIQUE NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Pets (
    PetID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Breed VARCHAR(100) NOT NULL,
    Type VARCHAR(50) NOT NULL,
    AvailableForAdoption BIT DEFAULT 1,
    ShelterID INT,
    OwnerID INT DEFAULT NULL,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

CREATE TABLE Donations (
    DonationID INT IDENTITY(1,1) PRIMARY KEY,
    DonorName VARCHAR(255) NOT NULL,
    DonationType VARCHAR(100) NOT NULL,
    DonationAmount DECIMAL(10,2) DEFAULT 0.00,
    DonationItem VARCHAR(255) NULL,
    DonationDate DATE NOT NULL,
    ShelterID INT,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

CREATE TABLE AdoptionEvents (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventName VARCHAR(255) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Participants (
    ParticipantID INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantName VARCHAR(255) NOT NULL,
    ParticipantType VARCHAR(100) NOT NULL,
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);

-- Insert Sample Data (No Need to Specify IDs)
INSERT INTO Shelters (Name, Location) VALUES
('Happy Paws', 'New York'),
('Furry Friends', 'Los Angeles'),
('Paw Haven', 'Chicago');

INSERT INTO Pets (Name, Age, Breed, Type, AvailableForAdoption, ShelterID) VALUES
('Buddy', 2, 'Labrador', 'Dog', 1, 1),
('Milo', 3, 'Golden Retriever', 'Dog', 1, 2),
('Whiskers', 1, 'Siamese', 'Cat', 1, 3),
('Charlie', 5, 'Beagle', 'Dog', 1, 1),
('Bella', 6, 'Persian', 'Cat', 0, 2),
('Max', 4, 'Bulldog', 'Dog', 1, 3),
('Oscar', 2, 'Sphynx', 'Cat', 0, 1),
('Rocky', 7, 'Husky', 'Dog', 1, 2),
('Simba', 3, 'Maine Coon', 'Cat', 1, 3),
('Daisy', 8, 'Poodle', 'Dog', 1, 1);

INSERT INTO AdoptionEvents (EventName, EventDate, Location) VALUES
('Pet Carnival', '2025-04-10', 'New York'),
('Adopt-A-Pet', '2025-05-15', 'Los Angeles'),
('Furry Fest', '2025-06-20', 'Chicago');

INSERT INTO Participants (ParticipantName, ParticipantType, EventID) VALUES
('Alice', 'Volunteer', 1),
('Bob', 'Adopter', 1),
('Charlie', 'Adopter', 2),
('Daisy', 'Volunteer', 2),
('Edward', 'Adopter', 3);

INSERT INTO Donations (DonorName, DonationType, DonationAmount, DonationItem, DonationDate, ShelterID) VALUES
('John Doe', 'Money', 100.00, NULL, '2025-01-10', 1),
('Jane Smith', 'Food', NULL, 'Dog Food', '2025-02-12', 2),
('Michael Johnson', 'Money', 50.00, NULL, '2025-03-15', 3);

-- 3. Retrieve Available Pets
SELECT Name, Age, Breed, Type FROM Pets WHERE AvailableForAdoption = 1;

-- 4. Retrieve Event Participants
SELECT ParticipantName, ParticipantType FROM Participants WHERE EventID = 1;

-- 5. Update Shelter Information (Stored Procedure)
CREATE PROCEDURE UpdateShelterInfo
    @ShelterID INT,
    @NewName VARCHAR(255),
    @NewLocation VARCHAR(255)
AS
BEGIN
    UPDATE Shelters SET Name = @NewName, Location = @NewLocation WHERE ShelterID = @ShelterID;
END;
EXEC UpdateShelterInfo @ShelterID = 1, @NewName = 'Paw Paradise', @NewLocation = 'San Francisco';
SELECT * FROM Shelters WHERE ShelterID = 1;

-- 6. Calculate Shelter Donations
SELECT s.Name AS ShelterName, SUM(d.DonationAmount) AS TotalDonationAmount
FROM Shelters s
LEFT JOIN Donations d ON s.ShelterID = d.ShelterID
GROUP BY s.Name;

-- 7. Retrieve Pets Without Owners
SELECT Name FROM Pets WHERE OwnerID IS NULL;

-- 8. Monthly Donation Summary
SELECT YEAR(DonationDate) AS Year, MONTH(DonationDate) AS Month, SUM(DonationAmount) AS TotalAmount
FROM Donations
GROUP BY YEAR(DonationDate), MONTH(DonationDate);

-- 9. Filter Pets by Age
SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 3 OR Age > 5;

-- 10. Pets and Their Shelters
SELECT p.Name AS PetName, s.Name AS ShelterName 
FROM Pets p 
JOIN Shelters s ON p.ShelterID = s.ShelterID 
WHERE p.AvailableForAdoption = 1;

-- 11. Count Event Participants by City
SELECT Location, COUNT(ParticipantID) AS TotalParticipants 
FROM AdoptionEvents 
JOIN Participants ON AdoptionEvents.EventID = Participants.EventID 
GROUP BY Location;

-- 12. Unique Breeds of Young Pets
SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 5;

-- 13. Find Pets Not Yet Adopted
SELECT Name FROM Pets WHERE AvailableForAdoption = 1;

-- 14. Retrieve Adopted Pets and Adopters
-- Assign an adopter to a pet (setting OwnerID)
UPDATE Pets 
SET OwnerID = 3  -- This should be an existing Adopter's ParticipantID
WHERE Name = 'Buddy';  -- Replace 'Buddy' with any pet that exists in the Pets table

SELECT p.Name AS PetName, par.ParticipantName AS AdopterName 
FROM Pets p 
JOIN Participants par ON p.OwnerID = par.ParticipantID;

-- 15. Count Available Pets in Shelters
SELECT s.Name AS ShelterName, COUNT(p.PetID) AS AvailablePets 
FROM Shelters s 
LEFT JOIN Pets p ON s.ShelterID = p.ShelterID 
WHERE p.AvailableForAdoption = 1 
GROUP BY s.Name;

-- 16. Find Matching Pet Pairs in Shelters
-- Update existing pets to have the same breed in the same shelter
UPDATE Pets SET Breed = 'Golden Retriever', ShelterID = 1 WHERE Name = 'Buddy';
UPDATE Pets SET Breed = 'Golden Retriever', ShelterID = 1 WHERE Name = 'Charlie';

UPDATE Pets SET Breed = 'Beagle', ShelterID = 2 WHERE Name = 'Rocky';
UPDATE Pets SET Breed = 'Beagle', ShelterID = 2 WHERE Name = 'Max';

SELECT p1.Name AS Pet1, p2.Name AS Pet2, p1.Breed, s.Name AS ShelterName 
FROM Pets p1 
JOIN Pets p2 ON p1.Breed = p2.Breed AND p1.PetID < p2.PetID 
JOIN Shelters s ON p1.ShelterID = s.ShelterID;

-- 17. Find All Shelter-Event Combinations
SELECT s.Name AS ShelterName, e.EventName 
FROM Shelters s 
CROSS JOIN AdoptionEvents e;

-- 18. Identify the Most Successful Shelter
SELECT TOP 1 s.Name AS ShelterName, COUNT(p.PetID) AS AdoptedPets 
FROM Shelters s 
JOIN Pets p ON s.ShelterID = p.ShelterID 
WHERE p.AvailableForAdoption = 0 
GROUP BY s.Name 
ORDER BY AdoptedPets DESC;

-- 19. Trigger for Adoption Status Update
CREATE TRIGGER UpdateAdoptionStatus 
ON Pets
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE OwnerID IS NOT NULL)
    BEGIN
        UPDATE Pets SET AvailableForAdoption = 0 WHERE PetID IN (SELECT PetID FROM inserted WHERE OwnerID IS NOT NULL);
    END;
END;

-- 20. Data Integrity Check (Ensuring Unique Adoption)
ALTER TABLE Pets ADD CONSTRAINT UniqueAdoption UNIQUE (PetID, OwnerID);








