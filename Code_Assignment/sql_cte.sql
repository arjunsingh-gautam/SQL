                                      -- CTEs(Common Table Expression)
USE joins_ex;
CREATE TABLE Depart (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Emp (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT,
    manager_id INT
);

INSERT INTO Depart VALUES
(1, 'IT'), (2, 'HR'), (3, 'Finance');

INSERT INTO Emp VALUES
(101, 'Alice', 50000, 1, NULL),
(102, 'Bob', 60000, 1, 101),
(103, 'Charlie', 55000, 2, NULL),
(104, 'David', 70000, 3, NULL),
(105, 'Eva', 65000, 1, 101),
(106, 'Frank', 40000, 2, 103);

-- Recursive Query
WITH Recursive Numbers AS(
-- Anchor Member
	SELECT 1 as n
	UNION ALL
-- Recursive Member
	SELECT n+1
	FROM Numbers -- Recursive Call
	WHERE n<5
)
SELECT * FROM Numbers;

-- Exercise:

-- Q1.Department Total Salary:
WITH DeptSalary AS(
SELECT e.dept_id,SUM(salary)
FROM Emp e
GROUP BY dept_id)

SELECT * FROM DeptSalary;

-- Q2.
WITH RECURSIVE EmpHierarchy AS (
    -- Anchor: top-level managers
    SELECT emp_id, emp_name, manager_id, 1 AS level
    FROM Emp
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive: employees reporting to previous set
    SELECT e.emp_id, e.emp_name, e.manager_id, eh.level + 1
    FROM Emp e
    JOIN EmpHierarchy eh ON e.manager_id = eh.emp_id
)
SELECT * FROM EmpHierarchy;

-- Q3.Write a CTE to find average salary per department and list employees whose salary is above average.
-- Q3. Find employees whose salary is above their department's average
WITH avg_salary AS (
    SELECT dept_id, AVG(salary) AS dept_avg
    FROM Emp
    GROUP BY dept_id
)
SELECT e.emp_id, e.emp_name, e.dept_id, e.salary, a.dept_avg
FROM Emp e
JOIN avg_salary a 
  ON e.dept_id = a.dept_id
WHERE e.salary > a.dept_avg;

-- Q4.Use a CTE to find the highest paid employee in each department.


