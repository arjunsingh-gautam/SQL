CREATE DATABASE sql_dml_exercise;
USE sql_dml_exercise;

-- TABLE for Exercise
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(30),
    Salary DECIMAL(10,2),
    JoiningDate DATE
);

-- Sample data
INSERT INTO Employees (EmpID, Name, Department, Salary, JoiningDate) VALUES
(101, 'Alice', 'HR', 50000, '2021-01-15'),
(102, 'Bob', 'IT', 60000, '2022-03-20'),
(103, 'Charlie', 'Finance', 70000, '2020-07-10'),
(104, 'David', 'IT', 55000, '2023-01-01'),
(105, 'Eva', 'HR', 48000, '2019-11-25');

-- Q1. Add a new employee "Frank" in the Finance department with salary 65000 and joining date 2023-06-01.
INSERT INTO Employees (EmpID,Name,Department,Salary,JoiningDate) VALUES
(106,'Frank','Finance',65000,'2023-06-01');

-- Q2.Increase salary of all employees in IT department by 10%.
SET SQL_SAFE_UPDATES = 0; -- Turn off Safe Update Mode
UPDATE Employees
SET Salary=Salary+Salary*0.1 WHERE Department='IT';
SET SQL_SAFE_UPDATES = 1; -- Turn on Safe Update Mode

SELECT * FROM Employees WHERE Department='IT';

-- Q3.Delete employees who joined before 2020.
DELETE FROM Employees WHERE JoiningDate<'2020-01-01';
SELECT * FROM Employees ;

-- Q4.You have a new table NewSalaries with updated salaries. Update salaries if employee exists, otherwise insert new employees
CREATE TABLE NewSalaries (
    EmpID INT,
    Salary DECIMAL(10,2)
);

INSERT INTO NewSalaries VALUES
(101, 52000), -- Alice updated
(107, 75000); -- New employee

INSERT INTO Employees (EmpID, Name, Department, Salary, JoiningDate)
VALUES (101, 'Alice', 'HR', 52000, '2021-01-15'),
       (107, 'NewJoiner', 'Unknown', 75000, NOW()) -- NOW() returns the current date and time based on the system clock of the database server.
ON DUPLICATE KEY UPDATE
    Salary = VALUES(Salary);
/*
If EmpID already exists → it will update Salary.
If EmpID does not exist → it will insert a new row.
*/

SHOW COLUMNS in EMployees;