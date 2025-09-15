                                -- Exercise on Pattern Matching
USE select_exercise;

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    email VARCHAR(50)
);

INSERT INTO Employees VALUES
(1, 'Arjun Mehta', 'IT', 'arjun.mehta@company.com'),
(2, 'Riya Sharma', 'HR', 'riya.sharma@company.com'),
(3, 'Mohit Rao', 'Finance', 'mohit@company.com'),
(4, 'Ananya Roy', 'IT', 'ananya.roy@company.com'),
(5, 'Amit Kumar', 'Finance', 'amit.k@company.com'),
(6, 'Priya Nair', 'HR', 'priya.nair@company.com');

-- Exercise

-- Q1.Find all employees whose names start with ‘A’.
SELECT * FROM Employees
WHERE emp_name LIKE "A%";

-- Q2.Find employees whose email ends with ‘@company.com’.
SELECT * FROM Employees
WHERE email LIKE "%@company.com";

-- Q3. Find employees whose names have ‘ya’ in them
SELECT * FROM Employees
WHERE emp_name LIKE "%ya%";

-- Q4. Find employees where the third letter in name is ‘i’.
SELECT * FROM Employees
WHERE emp_name LIKE "__i%";

-- Q5. Find employees in IT department whose names end with ‘a’.
SELECT * FROM Employees
WHERE emp_name LIKE "%a" AND department='IT';

-- Q6. Find all employees whose email starts with their first name (hint: LIKE 'arjun%').
SELECT emp_name, email
FROM Employees
WHERE email LIKE CONCAT(LOWER(SUBSTRING_INDEX(emp_name, ' ', 1)), '%');


                                  -- REGEXP Pattern-Matching
CREATE TABLE Customers (
    cust_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15)
);

INSERT INTO Customers VALUES
(1, 'Arjun Mehta', 'arjun.mehta@gmail.com', '9876543210'),
(2, 'Riya Sharma', 'riya_2024@yahoo.com', '9123456789'),
(3, 'Mohit Rao', 'mohit@company.org', '9999999999'),
(4, 'Ananya Roy', 'ananya.roy@company.com', '98-7654321'),
(5, 'Amit Kumar', 'amit123@company.com', '8000000000'),
(6, 'Priya Nair', 'priya.nair@company', 'abc12345');

-- Exercise

-- Q1.Find customers whose email starts with 'a'.
SELECT * FROM customers
WHERE email REGEXP '^a';
-- Q2.Find customers whose email domain is gmail or yahoo
SELECT * FROM customers
WHERE email REGEXP 'gmail|yahoo';
-- Q3.Find customers whose phone contains only digits.
SELECT * FROM customers
WHERE phone REGEXP '^[0-9]+$';
-- Q4.Find customers whose name ends with 'Roy' or 'Rao'
SELECT * FROM customers
WHERE name REGEXP 'Roy$|Rao$';
-- Q5.Find customers with emails missing .com at the end.
SELECT name, email
FROM Customers
WHERE email NOT REGEXP '\\.com$'; -- \\. --> .
-- Q6.Find customers whose phone number contains non-digit characters.
SELECT name, phone
FROM Customers
WHERE phone REGEXP '[^0-9]';
