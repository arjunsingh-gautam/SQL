                                                          -- Assignment 4
USE select_exercise;    

alter table  empl add dob date;
SET sql_safe_updates = 0;
UPDATE empl
SET dob = DATE_SUB(CURDATE(), INTERVAL emp_age YEAR);
SET sql_safe_updates = 1;

-- Questions:
/*
1- write a query to print emp name , their manager name and diffrence in their age (in days) 
for employees whose year of birth is before their managers year of birth
2- write a query to find subcategories who never had any return orders in the month of november (irrespective of years)
3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
write a query to find order ids where there is only 1 product bought by the customer.
4- write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.
5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
Assume that all order date and ship date are on weekdays only
6- write a query to print 3 columns : category, total_sales and (total sales of returned orders)
7- write a query to print below 3 columns
category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)
8- write a query print top 5 cities in west region by average no of days between order date and ship date.
9- write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)
*/							

-- Q1
SELECT e1.emp_name,e2.emp_name,ABS(e1.emp_age-e2.emp_age) as age_diff
FROM empl e1
JOIN empl e2
ON e1.manager_id=e2.emp_id;

-- Q2.
SELECT o.sub_category,COUNT(DISTINCT r.return_reason)
FROM orders o
LEFT JOIN returns r 
ON o.order_id=r.order_id
WHERE MONTH(o.order_date)=8
GROUP BY o.sub_category
HAVING COUNT(DISTINCT r.return_reason)=0;

-- Q3. 
SELECT order_id,COUNT(DISTINCT product_id)
FROM orders
GROUP BY order_id
HAVING COUNT(DISTINCT product_id)=1;

-- Q4.
SELECT e2.emp_name,group_concat(e1.salary SEPARATOR ',')
FROM empl e1
JOIN empl e2
ON e1.manager_id=e2.emp_id
GROUP BY e2.emp_name;

-- Q5. 
SELECT 
    order_date,
    ship_date,
    DATEDIFF(ship_date, order_date) + 1
    - (WEEK(order_date) - WEEK(ship_date)) * 2
    - (CASE WHEN DAYOFWEEK(order_date) = 1 THEN 1 ELSE 0 END)
    - (CASE WHEN DAYOFWEEK(ship_date) = 7 THEN 1 ELSE 0 END) AS business_days
FROM orders;

-- Q6.
SELECT 
    o.category,
    SUM(o.sales) AS total_sales,
    SUM(CASE WHEN r.order_id IS NOT NULL THEN o.sales ELSE 0 END) AS return_sales
FROM orders o
LEFT JOIN returns r 
    ON o.order_id = r.order_id
GROUP BY o.category;

-- Q7.
SELECT category,SUM(CASE WHEN YEAR(order_date)=2019 THEN sales ELSE 0 END) as total_sales_2019,
SUM(CASE WHEN YEAR(order_date)=2020 THEN sales ELSE 0 END) as total_sales_2020 
FROM orders
GROUP BY category;

-- Q8.
SELECT city,AVG(DATEDIFF(ship_date,order_date))
FROM orders
WHERE region='West'
GROUP BY city
ORDER BY AVG(DATEDIFF(ship_date,order_date)) DESC
LIMIT 5;

-- Q9.
SELECT e1.emp_name,e2.emp_name as manager,e3.emp_name as senior_manager
FROM empl e1
JOIN empl e2
ON e1.manager_id=e2.emp_id
JOIN empl e3
ON e2.manager_id=e3.emp_id;