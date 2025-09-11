-- String Functions

-- Database:
CREATE DATABASE func;
USE func;
CREATE TABLE employees (
    emp_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    department VARCHAR(50)
);

INSERT INTO employees VALUES
(1, 'John', 'Doe', 'john.doe@gmail.com', '9876543210', 'Sales'),
(2, 'Alice', 'Smith', 'alice.smith@yahoo.com', '9123456789', 'HR'),
(3, 'Robert', 'Brown', 'rob.b@company.com', '9988776655', 'IT'),
(4, 'Émilie', 'Dubois', 'emilie.dubois@gmail.com', '9112233445', 'Finance');

-- LENGTH(str)
SELECT first_name,LENGTH(first_name) as name_len
FROM employees;

-- CHAR_LENGTH(str)
SELECT first_name,CHAR_LENGTH(first_name) as name_len
FROM employees;

-- UPPER(str) 
SELECT first_name,UPPER(first_name) as upp_name
FROM employees;

-- LOWER(str)
SELECT first_name,LOWER(first_name) as low_name
FROM employees;

-- SUBSTRING(str,start,length)/SUBSTR   : index --> start:1  end:-1 
SELECT email,SUBSTR(email,-6,5) as sub_email
FROM employees;

-- LEFT(str,n)/ RIGHT(str,n)
SELECT email,LEFT(email,5) as lef_email,RIGHT(email,5) rig_email
FROM employees;

-- CONCAT(str1,str2)
SELECT first_name,last_name,CONCAT(first_name,' ',last_name) as full_name FROM employees;

-- REPLACE(str,old_str,new_str)
SELECT email,REPLACE(email,'gmail','yahoo') as new_email FROM employees;

-- INSTR(str, substr) / LOCATE(substr, str)
SELECT email,INSTR(email,'gmail') AS indice FROM employees;

-- REVERSE(str)
SELECT email,REVERSE(email) AS rev_email FROM employees;