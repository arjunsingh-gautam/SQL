-- Assignment of GROUP BY and HAVING
USE select_exercise;

-- Q1.write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909
SET SQL_SAFE_UPDATES = 0; -- Turn off Safe Update Mode
UPDATE orders
SET city=NULL 
WHERE order_id IN ('CA-2020-161389' , 'US-2021-156909');
SET SQL_SAFE_UPDATES = 1; -- Turn on Safe Update Mode;

SELECT city FROM orders
WHERE order_id IN ('CA-2020-161389' , 'US-2021-156909');

SELECT order_id FROM orders
WHERE city IS NULL;

-- Q2.write a query to find orders where city is null (2 rows)
SELECT order_id FROM orders
WHERE city IS NULL;

-- Q3. write a query to get total profit, first order date and latest order date for each category
SELECT category,SUM(profit) AS total_profit,MIN(order_date) AS first_order_date,
MAX(order_date) AS latest_order_date
FROM orders
GROUP BY category;

-- Q4. write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category
SELECT sub_category,AVG(profit) as avg_profit,MAX(profit) as max_profit
FROM orders
GROUP BY sub_category
HAVING avg_profit>(0.5*max_profit);



-- Q5.create the exams table with below script (IMP)
-- write a query to find students who have got same marks in Physics and Chemistry.

create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

select student_id , marks
from exams
where subject in ('Physics','Chemistry')
group by student_id , marks
having count(student_id)=2;

select * from orders;
-- Q6. write a query to find total number of products in each category.
SELECT category,COUNT( DISTINCT product_id) AS total_products
FROM orders
GROUP BY category;


-- Q7. write a query to find top 5 sub categories in west region by total quantity sold
SELECT sub_category,SUM(quantity) AS total_quantity
FROM orders
WHERE region='West'
GROUP BY sub_category
ORDER BY total_quantity DESC
LIMIT 5;

-- Q8. write a query to find total sales for each region and ship mode combination for orders in year 2020

SELECT region,ship_mode,SUM(sales) AS total_sales 
FROM orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY region,ship_mode;