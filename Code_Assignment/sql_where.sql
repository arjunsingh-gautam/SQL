                              -- WHERE Clause

USE select_exercise;

CREATE TABLE emp (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE,
    email VARCHAR(100)
);

INSERT INTO emp VALUES
(1, 'Arjun', 'Sharma', 'IT', 60000, '2020-01-15', 'arjun.sharma@company.com'),
(2, 'Riya', 'Verma', 'HR', 45000, '2019-05-10', 'riya.verma@company.com'),
(3, 'Karan', 'Patel', 'Finance', 70000, '2021-03-20', 'karan.patel@company.com'),
(4, 'Meera', 'Singh', 'IT', 50000, '2022-07-12', 'meera.singh@company.com'),
(5, 'Sohan', 'Yadav', 'Marketing', 40000, '2018-09-30', NULL);

-- Exercise:

-- Q1.Find all employees in the IT department. 
SELECT * from emp where department='IT';

-- Q2.Find employees with salary greater than 50,000.
SELECT * from emp where salary>50000;

-- Q3.Get employees who joined after 2020-01-01. 
SELECT * from emp where hire_date>"2020-01-01";

-- Q4.Find employees who don’t have an email address.
SELECT * from emp where email IS NULL;

-- Q5.Get employees whose Get employees whose salary is between 45,000 and 60,000..
SELECT * from emp Where salary between 45000 and 60000;

-- Q6. Find employees from IT or HR department.
SELECT * from emp where department in ('IT',"HR");

-- Q7. Find employees whose first name starts with 'M'.
SELECT * from emp where first_name LIKE 'M%';

-- Q8. Retrieve employees hired in 2019 or 2021.
SELECT * from emp where (hire_date between '2019-01-01' and '2019-12-31') or (hire_date between '2021-01-01' and '2021-12-31')
