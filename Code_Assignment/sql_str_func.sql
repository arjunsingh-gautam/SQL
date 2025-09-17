                                      -- String Function
USE select_exercise;


CREATE TABLE E (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    dept VARCHAR(50)
);

INSERT INTO E VALUES
(1, 'Arjun', 'Kumar', 'arjun.k@company.com', '9876543210', 'IT'),
(2, 'Riya', 'Sharma', 'riya_s@company.com', '98-765-432', 'HR'),
(3, 'Karan', 'Patel', NULL, '98765-43210', 'Finance'),
(4, 'Meera', 'Singh', 'meera@company.com', '1234567890', 'IT'),
(5, 'Amit', 'Verma', 'amitv@company.com', '   9876500000', 'Sales');

-- Exerice

-- Q1.Display full names of employees (CONCAT). 
SELECT CONCAT(first_name,' ',last_name) as full_name from  E;

-- Q2. Show employee emails in uppercase.
SELECT UPPER(email) as uppr_email FROM E;

-- Q3.Extract first 5 chars from employee emails. 
SELECT LEFT(email,5) as email_5 FROM E;

-- Q4. Find employees whose phone contains non-digit characters.
SELECT first_name,phone FROM E
WHERE phone NOT REGEXP "^[0-9]+$";

-- Q5.Replace @company.com with @corp.com in all emails.
SELECT REPLACE(email,'@company.com','@corp.com') as new_email FROM E;

-- Q6. Count number of characters in each employee’s name.
SELECT first_name,char_length(first_name) as no_character FROM E;

-- Q7.Find employees whose last name starts with 'S'.
SELECT first_name,last_name FROM E
WHERE LEFT(last_name,1)='s';

-- Q8. Trim spaces from phone numbers.
SELECT phone,TRIM(phone) as phone_trim from E;

-- Q9. Reverse each employee’s first name.
SELECT last_name,REVERSE(last_name) from E;

-- Show departments and employees in each (GROUP_CONCAT).
SELECT group_concat(CONCAT(first_name,' '),dept ) from E
group by first_name;