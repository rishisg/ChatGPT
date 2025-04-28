-- Step 1: Database Setup
-- 1. Create the database
CREATE DATABASE IF NOT EXISTS company_management;
USE company_management;

-- 2. Show all databases (verification)
SHOW DATABASES;

-- Step 2: Create All 5 Tables
-- 1. Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);

-- 2. Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    JoiningDate DATE
);

-- 3. Projects Table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 4. Salaries Table (for salary history)
CREATE TABLE Salaries (
    SalaryID INT PRIMARY KEY,
    EmployeeID INT,
    SalaryAmount DECIMAL(10,2),
    EffectiveDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- 5. Clients Table
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    ClientName VARCHAR(100) NOT NULL,
    Industry VARCHAR(50),
    ContactPerson VARCHAR(100)
);

-- Show all tables (verification)
SHOW TABLES;

-- Step 3: Insert Sample Data (10+ Records per Table)
-- 1. Insert into Departments
INSERT INTO Departments VALUES
(1, 'HR', 'Floor 1'),
(2, 'IT', 'Floor 2'),
(3, 'Finance', 'Floor 3'),
(4, 'Marketing', 'Floor 1'),
(5, 'Operations', 'Floor 4');

-- 2. Insert into Employees
INSERT INTO Employees VALUES
(101, 'John', 'Doe', 'IT', 75000.00, '2020-05-15'),
(102, 'Jane', 'Smith', 'HR', 65000.00, '2019-11-20'),
(103, 'Robert', 'Johnson', 'Finance', 82000.00, '2018-03-10'),
(104, 'Emily', 'Williams', 'IT', 78000.00, '2021-01-25'),
(105, 'Michael', 'Brown', 'Marketing', 72000.00, '2020-07-30'),
(106, 'Sarah', 'Davis', 'HR', 68000.00, '2019-09-12'),
(107, 'David', 'Miller', 'Finance', 85000.00, '2018-06-05'),
(108, 'Jessica', 'Wilson', 'IT', 80000.00, '2021-03-18'),
(109, 'Thomas', 'Moore', 'Operations', 70000.00, '2020-09-22'),
(110, 'Lisa', 'Taylor', 'Marketing', 73000.00, '2021-02-14');

-- 3. Insert into Projects
INSERT INTO Projects VALUES
(1, 'Website Redesign', '2023-01-10', '2023-06-15', 2),
(2, 'Payroll System Upgrade', '2023-02-20', '2023-08-30', 1),
(3, 'Financial Audit', '2023-03-05', '2023-05-20', 3),
(4, 'Social Media Campaign', '2023-04-12', '2023-09-25', 4),
(5, 'Supply Chain Optimization', '2023-05-15', '2023-11-10', 5),
(6, 'Mobile App Development', '2023-06-01', '2023-12-15', 2),
(7, 'Employee Training Program', '2023-07-10', '2023-10-30', 1),
(8, 'Tax Compliance Review', '2023-08-05', '2023-11-20', 3),
(9, 'Product Launch', '2023-09-12', '2024-02-28', 4),
(10, 'Logistics Automation', '2023-10-01', '2024-03-15', 5);

-- 4. Insert into Salaries
INSERT INTO Salaries VALUES
(1, 101, 70000.00, '2020-05-15'),
(2, 101, 75000.00, '2022-01-01'),
(3, 102, 60000.00, '2019-11-20'),
(4, 102, 65000.00, '2021-07-01'),
(5, 103, 80000.00, '2018-03-10'),
(6, 103, 82000.00, '2022-01-01'),
(7, 104, 75000.00, '2021-01-25'),
(8, 104, 78000.00, '2023-01-01'),
(9, 105, 70000.00, '2020-07-30'),
(10, 105, 72000.00, '2022-07-01');

-- 5. Insert into Clients
INSERT INTO Clients VALUES
(1, 'ABC Corp', 'Technology', 'Alex Johnson'),
(2, 'XYZ Ltd', 'Finance', 'Maria Garcia'),
(3, 'Tech Solutions', 'IT', 'Raj Patel'),
(4, 'Global Retail', 'Retail', 'Sophie Martin'),
(5, 'Blue Ocean', 'Manufacturing', 'James Wilson'),
(6, 'Sunrise Health', 'Healthcare', 'Emma Davis'),
(7, 'Green Earth', 'Environmental', 'Lucas Brown'),
(8, 'Future Kids', 'Education', 'Olivia Taylor'),
(9, 'Star Hotels', 'Hospitality', 'Daniel Lee'),
(10, 'Quick Delivery', 'Logistics', 'Ava Martinez');

-- Step 4: Run Required SQL Operations
-- 1. Basic Data Retrieval
-- Retrieve all employees
SELECT * FROM Employees;

-- Retrieve all projects
SELECT * FROM Projects;

-- Retrieve all clients in Technology industry
SELECT * FROM Clients WHERE Industry = 'Technology';

-- 2. Data Filtering (WHERE Clause)
-- Employees earning more than 75k
SELECT FirstName, LastName, Salary 
FROM Employees 
WHERE Salary > 75000;

-- Projects ending in 2024
SELECT ProjectName, EndDate 
FROM Projects 
WHERE EndDate LIKE '2024%';

-- 3. Sorting (ORDER BY)
-- Employees sorted by highest salary
SELECT * FROM Employees 
ORDER BY Salary DESC;

-- Clients sorted alphabetically
SELECT * FROM Clients 
ORDER BY ClientName ASC;

-- 4. Data Modification (UPDATE, DELETE)
-- Give IT employees a 5% raise
-- Safe method to update IT department salaries
SET SQL_SAFE_UPDATES = 0;

UPDATE Employees 
SET Salary = Salary * 1.05 
WHERE Department = 'IT';

SET SQL_SAFE_UPDATES = 1;

-- Verify the update
SELECT FirstName, LastName, Department, Salary 
FROM Employees 
WHERE Department = 'IT';

-- Delete a client
DELETE FROM Clients 
WHERE ClientID = 10;

-- 5. JOIN Operations
-- Employees with their department locations
SELECT e.FirstName, e.LastName, d.DepartmentName, d.Location
FROM Employees e
JOIN Departments d ON e.Department = d.DepartmentName;

-- Projects with department names
SELECT p.ProjectName, d.DepartmentName, p.StartDate, p.EndDate
FROM Projects p
JOIN Departments d ON p.DepartmentID = d.DepartmentID;

-- 6. Aggregation (GROUP BY)
-- Average salary by department
SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;

-- Number of projects per department
SELECT d.DepartmentName, COUNT(p.ProjectID) AS TotalProjects
FROM Departments d
LEFT JOIN Projects p ON d.DepartmentID = p.DepartmentID
GROUP BY d.DepartmentName;

-- Step 5: Verification & Cleanup (Optional)
-- Display table structures
DESCRIBE Employees;
DESCRIBE Projects;

-- Count records in each table
SELECT 'Employees' AS TableName, COUNT(*) AS RecordCount FROM Employees
UNION ALL
SELECT 'Projects', COUNT(*) FROM Projects
UNION ALL
SELECT 'Clients', COUNT(*) FROM Clients;

-- (Optional) Drop a table example
-- DROP TABLE Salaries;