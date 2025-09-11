-- DDL Commands Practice Exercise

CREATE DATABASE sql_ddl_practice;
USE sql_ddl_practice;

-- Create a table students with columns: id, name, age, and grade
CREATE TABLE students(
student_id INT PRIMARY KEY,
student_name VARCHAR(100) UNIQUE,
age SMALLINT,
GRADE DECIMAL(4,2));

SHOW COLUMNS IN  students;

-- Q2:Create a table departments with dept_id, dept_name
CREATE TABLE departments(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(100)
);
SHOW COLUMNS IN  departments;

-- Q3:Create a table employees with:
/*id (INT, primary key),name (VARCHAR),salary (DECIMAL),hire_date (DATE),dept_id (INT)*/

CREATE TABLE employees(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(100),
salary DECIMAL(10,2),
hire_date DATE,
dept_id INT);
SHOW COLUMNS IN  employees;

-- Q4: Add constraints: NOT NULL, UNIQUE, DEFAULT to the employees table.
ALTER TABLE employees
-- ADD CONSTRAINT emp_name NOT NULL;  
-- You can't use ADD CONSTRAINT for NOT NULL; instead, modify the column definition.
MODIFY COLUMN emp_name VARCHAR(100) NOT NULL;
ALTER TABLE employees
MODIFY COLUMN emp_name VARCHAR(100) NOT NULL UNIQUE,
MODIFY COLUMN salary INT DEFAULT 0;
SHOW COLUMNS in employees;

-- Q5:Create a products table with id, name, price, and a check constraint price > 0.
CREATE TABLE products(
product_id INT PRIMARY KEY,
product_name VARCHAR(100) NOT NULL,
price DECIMAL(10,2) CHECK (price>0));
SHOW COLUMNS in products;

-- Q6:Create a table orders with a FOREIGN KEY referencing products.
CREATE TABLE orders(
order_id INT PRIMARY KEY,
product_id INT,
quantity INT NOT NULL,
order_amt DECIMAL(10,2) NOT NULL,
FOREIGN KEY (product_id) REFERENCES products(product_id));
SHOW COLUMNS in orders;

-- Q7:Create a table transactions with:UUID transaction_id,
/*ENUM transaction_type ('credit', 'debit'),timestamp column with default current time,Unique constraint on transaction_id*/
CREATE TABLE transactions(
transaction_id CHAR(36) PRIMARY KEY, -- UUID is stored in CHAR(36) Data type
transaction_type ENUM('credit','debit') NOT NULL, -- ENUM provieds a list and maintains data-integrity as it allows only values from it's list
transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
SHOW COLUMNS in transactions;

-- Q8:Add a column email to students.
ALTER TABLE students
ADD COLUMN email TEXT;
SHOW COLUMNS in students;

-- Q9:Add a default value 'active' to a column status in employees.
ALTER TABLE employees
ADD COLUMN status VARCHAR(100) DEFAULT 'active';

-- Q10:Modify column age from SMALLINT to INT
ALTER TABLE students
MODIFY COLUMN age INT;

-- Q11:Drop Column grade from students
ALTER TABLE students
DROP COLUMN GRADE;

-- Q12:Rename column name to full_name in employees.
ALTER TABLE employees
RENAME COLUMN emp_name TO emp_fullname;

-- Q13:Add a FOREIGN KEY from employees.dept_id to departments.dept_id.
ALTER TABLE employees
ADD CONSTRAINt FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Q14:Drop the table orders.
DROP TABLE orders;
SHOW TABLES;

-- Q15:Drop the database test_db.
DROP DATABASE test_db;

-- Q16:Drop the FOREIGN KEY constraint from employees.
ALTER TABLE employees
DROP CONSTRAINT employees_ibfk_1; -- First find default generated foreign key name

-- Q17:Rename table students to school_students.
RENAME TABLE students TO school_students;

-- Q18:Rename column full_name in employees back to name.
ALTER TABLE employees
RENAME COLUMN emp_fullname TO emp_name;
