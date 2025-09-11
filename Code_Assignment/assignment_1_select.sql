USE select_exercise;
SHOW COLUMNS in orders;
-- Q1. write a sql to get all the orders where customers name has "a" as second character and "d" as fourth character (58 rows)

SELECT order_id,customer_id,customer_name 
FROM orders
WHERE customer_name LIKE '_a_d%';

-- Q2. write a sql to get all the orders placed in the month of dec 2020 (352 rows)
SELECT * FROM orders
WHERE order_date  BETWEEN '2020-12-01' AND '2020-12-31' ORDER BY order_date;

-- Q3.  write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and ship_date is after nov 2020 (944 rows)
SELECT * FROM orders
WHERE (ship_mode NOT IN ('Standard Class','First Class')) and (ship_date > '2020-11-30');

-- Q4. write a query to get all the orders where customer name neither start with "A" and nor ends with "n" (9815 rows)
SELECT * FROM orders
WHERE customer_name NOT LIKE 'A%' AND customer_name NOT Like '%n' ORDER BY customer_name LIMIT 10000;

-- Correct Solution:
select * from orders where customer_name not like 'A%n' LIMIT 10000;
-- Q5. write a query to get all the orders where profit is negative (1871 rows)
SELECT profit FROM orders
WHERE profit<0
LIMIT 2000;


-- Q6. write a query to get all the orders where either quantity is less than 3 or profit is 0 (3348)
SELECT quantity,profit FROM orders
WHERE quantity<3 OR profit=0
LIMIT 4000;

-- Q7. your manager handles the sales for South region and he wants you to create a report of all the orders in his region where some discount is provided to the customers (815 rows)
SELECT region,discount FROM orders
WHERE region='South' AND discount>0;

-- Q8.write a query to find top 5 orders with highest sales in furniture category
SELECT order_id,category,sales FROM orders
WHERE category= 'Furniture' ORDER BY sales DESC LIMIT 5;

-- Q9. write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only (1021 rows)
SELECT * FROM orders
WHERE category IN ('Furniture','Technology') AND order_date BETWEEN '2020-01-01' AND '2020-12-31' LIMIT 1500;

-- Q10. write a query to find all the orders where order date is in year 2020 but ship date is in 2021 (33 rows)
SELECT order_date,ship_date FROM orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31' AND ship_date BETWEEN '2021-01-01' AND '2021-12-31';