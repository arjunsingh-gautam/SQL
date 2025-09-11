-- Aggregate Functions:

USE select_exercise;

-- COUNT()
SELECT COUNT(*) AS total_records FROM orders;

-- COUNT(column) : Return total row having non-null values for the column passed as argument
SELECT  COUNT(customer_name) AS total_customers FROM orders;

-- SUM()
SELECT SUM(sales) AS total_sales FROM orders;

-- AVG() 
SELECT AVG(sales) AS avg_sales FROM orders;

-- MAX()
SELECT MAX(sales) AS max_sales FROM orders;

-- MIN()
SELECT MIN(sales) AS min_sales FROM orders;

-- VARIANCE()
SELECT VARIANCE(sales) AS var_sales FROM orders;

-- STDDEV()
SELECT STDDEV(sales) AS std_sales FROM orders;

-- GROUP_CONCAT()
SELECT GROUP_CONCAT(DISTINCT customer_name ORDER BY customer_name SEPARATOR ',') AS customer_list FROM orders;
