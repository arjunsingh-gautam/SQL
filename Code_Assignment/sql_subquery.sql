                                       -- Sub-Query
use joins_ex;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

INSERT INTO Department VALUES
(1, 'HR', 'NY'),
(2, 'Finance', 'LA'),
(3, 'IT', 'NY');

INSERT INTO Employee VALUES
(101, 'Alice', 50000, 1),
(102, 'Bob', 60000, 2),
(103, 'Charlie', 55000, 1),
(104, 'David', 70000, 3),
(105, 'Eva', 65000, 2);

-- Exercise:

-- Q1.Find employees whose salary is above the average salary.
SELECT * 
FROM Employee
WHERE salary>(SELECT AVG(salary) FROM Employee);

-- Q2.List employees who work in departments located in 'NY'.
SELECT *
FROM Employee
WHERE dept_id IN (SELECT dept_id FROM Department WHERE location="NY");

-- Q3.Find employees whose salary is higher than all employees in HR department.
SELECT *
FROM  Employee
WHERE salary > ALL
(SELECT salary 
FROM Employee e
JOIN Department d
ON e.dept_id=d.dept_id
WHERE dept_name='HR');

-- Q4. Find employees whose salary is higher than any employee in Finance department.
SELECT *
FROM  Employee
WHERE salary > ANY
(SELECT salary 
FROM Employee e
JOIN Department d
ON e.dept_id=d.dept_id
WHERE dept_name='Finance');

-- Q5.Find employees whose salary is greater than the average salary in their department.
SELECT *
FROM Employee e
WHERE salary > 
(SELECT AVG(salary) FROM Employee WHERE dept_id=e.dept_id);

-- Q6.Show emp_name and total salary of the employee’s department.
SELECT e.emp_name, e.salary, e.dept_id,
       (SELECT SUM(salary)
        FROM Employee
        WHERE dept_id = e.dept_id) AS dept_total_salary
FROM Employee e;
