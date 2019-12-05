
-- Creating the customer table with the columns heading
CREATE TABLE Customers_Table
(
    --Setting the customerID as primary key and 
    --Adding the auto increment function
    CustomerID SERIAL PRIMARY KEY,
    FirstName varchar(50),
    LastName varchar(50),
    Gender varchar,
    AddressLine varchar(255),
    Phone bigint,
    Email varchar(100),
    city varchar(20),
    country varchar(50)
);

-- Inserting values in the customer table
INSERT INTO Customers_Table
    (FirstName,LastName,Gender,AddressLine,Phone,Email,city,country)
VALUES('John', 'Hilbert', 'Male', '284 Chaucer st', 084789657, 'John@gmail.com', 'Johannesburg', 'South Africa');
INSERT INTO Customers_Table
    (FirstName,LastName,Gender,AddressLine,Phone,Email,city,country)
VALUES('Thando', 'Sithole', 'Female', '240 Sect 1', 0794445584, 'thando@gmail.com', 'Cape Town', 'South Africa');
INSERT INTO Customers_Table
    (FirstName,LastName,Gender,AddressLine,Phone,Email,city,country)
VALUES( 'Leon', 'Glen', 'Male', '81 Everton Rd,Gillits', 0820832830, 'Leaon@gmail.com', 'Durban', 'South Africa');
INSERT INTO Customers_Table
    (FirstName,LastName,Gender,AddressLine,Phone,Email,city,country)
VALUES('Charl', 'Muller', 'Male', '290 Dorset Ecke', 448568725, 'Charl.muller@yahoo.com', 'Berlin', 'Germany');
INSERT INTO Customers_Table
    (FirstName,LastName,Gender,AddressLine,Phone,Email,city,country)
VALUES( 'Julia', 'Stein', 'Female', '2 Wernerring', +448672445058, 'Js234@yahoo.com', 'Frankfurt', 'Germany');


-- Creating the Employees table
CREATE TABLE Employees_Table
(
    EmployeeID SERIAL PRIMARY KEY,
    FirstName varchar(50),
    LastName varchar(50),
    Email varchar(100),
    JobTitle varchar(20)
);

-- Inserting values into Employees table
INSERT INTO Employees_Table
    (FirstName,LastName,Email,JobTitle)
VALUES('Kani', 'Matthwe', 'mat@gmail.com', 'Manager');
INSERT INTO Employees_Table
    (FirstName,LastName,Email,JobTitle)
VALUES('Lesly', 'Cronje', 'LesC@gmail.com', 'Clerk');
INSERT INTO Employees_Table
    (FirstName,LastName,Email,JobTitle)
VALUES('Gideon', 'Maduku', 'm@gmail.com', 'Accountant');

-- NB(
-- Because Orders table has foreign keys of products table and payments table
-- First will create the product table together with the payments table and
-- thereafter the orders table so that it will reference and existing table)

-- Creating the products Table
CREATE TABLE Products_Table
(
    ProductID SERIAL PRIMARY KEY,
    ProductName varchar(100),
    Description varchar(300),
    BuyPrice decimal
);

-- Inserting values in the Products table
INSERT INTO Products_Table
    (ProductName,Description,BuyPrice)
VALUES('Harley Davidson Chopper', 'This replica features working kickstand, front suspension, gear-shift lever', 150.75);
INSERT INTO Products_Table
    (ProductName,Description,BuyPrice)
VALUES('Classic Car', 'Turnable front wheels, steering function', 550.75);
INSERT INTO Products_Table
    (ProductName,Description,BuyPrice)
VALUES('Sports car', 'Turnable front wheels, steering function', 700.60);



-- Creating the Payments table
CREATE TABLE Payments_Table
(
    CustomerID INTEGER REFERENCES Customers_Table(CustomerID),
    PaymentID SERIAL PRIMARY KEY,
    PaymentDate DATE,
    Amount decimal
);

-- Inserting values in the Payments table
INSERT INTO Payments_Table
    (CustomerID,PaymentDate,Amount)
VALUES(1, '2018-09-01', 150.75);
INSERT INTO Payments_Table
    (CustomerID,PaymentDate,Amount)
VALUES(5, '03-09-2018', 150.75);
INSERT INTO Payments_Table
    (CustomerID,PaymentDate,Amount)
VALUES(4, '03-09-2018', 700.60);


-- Creating the orders table
CREATE TABLE Orders_Table
(
    OrderID SERIAL PRIMARY KEY,
    ProductID INTEGER REFERENCES Products_Table(ProductID),
    PaymentID INTEGER REFERENCES Payments_Table(PaymentID),
    FulfilledByEmployeeID INTEGER REFERENCES Employees_Table(EmployeeID),
    DateRequired DATE,
    DateShipped DATE,
    Status varchar(20)
);

-- Inserting values into Orders table
INSERT INTO Orders_Table
    (ProductID,PaymentID,FulfilledByEmployeeID,DateRequired,Status)
VALUES(1, 1, 2, '05-09-2018', 'Not shipped');
INSERT INTO Orders_Table
    (ProductID,PaymentID,FulfilledByEmployeeID,DateRequired,DateShipped,Status)
VALUES(1, 2, 2, '04-09-2018', '03-09-2018', 'shipped');
INSERT INTO Orders_Table
    (ProductID,PaymentID,FulfilledByEmployeeID,DateRequired,Status)
VALUES(3, 3, 3, '06-09-2018', 'Not shipped');




-- Query
-- SELECT ALL records from table Customers
SELECT *
FROM Customers_Table;

-- SELECT records only from the name column in the Customers table
-- Show the name of the Customer whose CustomerID is 1.
SELECT
    FirstName, LastName
FROM Customers_Table
WHERE CustomerID=1;

-- UPDATE the record for CustomerID = 1 on the Customer table so that the name is “Lerato Mabitso”.
UPDATE Customers_Table
  SET FirstName = 'Lerato',LastName = 'Mabitso'
WHERE CustomerID=1;

-- DELETE the record from the Customers table for customer 2 (CustomerID = 2).
DELETE FROM Customers_Table
 WHERE CustomerID=2;


--  Select all unique statuses from the Orders table and get a count of the number
--  of orders for each unique status.
SELECT COUNT(DISTINCT Status)
FROM Orders_Table;

-- Return the MAXIMUM payment made on the PAYMENTS table
SELECT MAX(Amount)
FROM Payments_Table;

-- Select all customers from the “Customers” table, sorted by the “Country” column.
SELECT *
FROM Customers_Table
ORDER BY Country;

-- Select all products with a price BETWEEN R100 and R600
SELECT *
FROM Products_Table
WHERE BuyPrice BETWEEN 100 AND 600;

-- Select all fields from “Customers” where country is “Germany” AND city is “Berlin”.
SELECT *
FROM Customers_Table
WHERE Country ='Germany' AND City='Berlin';

-- Select all fields from “Customers” where city is “Cape Town” OR “Durban”.
SELECT *
FROM Customers_Table
WHERE City ='Germany' OR City='Berlin';

-- Select all records from Products where the Price is GREATER than R500.
SELECT *
FROM Products_Table
WHERE BuyPrice >=500;

-- Return the sum of the Amounts on the Payments table.
SELECT SUM(Amount)
FROM Payments_Table;

-- Count the number of shipped orders in the Orders table.
SELECT COUNT(Status)
FROM Orders_Table
WHERE Status='shipped';

-- Return the average price of all Products, 
-- in Rands 
SELECT AVG(BuyPrice)
FROM Products_Table;

-- and in Dollars (assume the exchange rate is R12 to the Dollar).
SELECT AVG(BuyPrice/12)
FROM Products_Table;

-- Using INNER JOIN create a query that selects all Payments with Customer information.

SELECT
    Customers_Table.CustomerID, Customers_Table.FirstName, Customers_Table.LastName, Customers_Table.Gender, Customers_Table.AddressLine, Customers_Table.Phone, Customers_Table.Email, Customers_Table.Country, Customers_Table.City
FROM Customers_Table
    INNER JOIN Payments_Table ON Payments_Table.CustomerID=Customers_Table.CustomerID;

-- Select all products that have turnable front wheels.
SELECT *
FROM Products_Table
WHERE Description > 'Turnable front wheels steering function';

