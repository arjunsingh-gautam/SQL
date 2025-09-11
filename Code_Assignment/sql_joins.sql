CREATE DATABASE joins_ex;
USE joins_ex;


-- Insert Customers
INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Eva');

-- Insert Orders
INSERT INTO orders (order_id, customer_id, product) VALUES
(101, 1, 'Laptop'),
(102, 2, 'Phone'),
(103, 2, 'Tablet');

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO orders (order_id, customer_id, product)
VALUES (104, 6, 'Monitor');

SET FOREIGN_KEY_CHECKS = 1;




-- Tables
SELECT * FROM customers;
SELECT * FROM orders;

-- INNER Join
SELECT c.customer_id,c.customer_name,o.order_id,o.customer_id,o.product
FROM customers c
JOIN orders o -- Keep records where only join condition matches
ON c.customer_id=o.customer_id;

-- Left Outter Join/ Left Join
SELECT c.customer_id,c.customer_name,o.order_id,o.customer_id,o.product
FROM customers c
LEFT JOIN orders o -- Keep all records of Left table
ON c.customer_id=o.customer_id;

-- Right Outter Join/ Right Join
SELECT c.customer_id,c.customer_name,o.order_id,o.customer_id,o.product
FROM orders o
RIGHT JOIN customers c -- Keep all records of Right table
ON c.customer_id=o.customer_id;

-- Cross Join -- cartesian product between two tables
SELECT c.customer_id,c.customer_name,o.order_id,o.customer_id,o.product
FROM orders o
CROSS JOIN customers c;

ALTER TABLE returns 
CHANGE COLUMN `Order Id` order_id VARCHAR(255);

ALTER TABLE returns 
CHANGE COLUMN `Return Reason` return_reason VARCHAR(255);


-- Superstore database
USE select_exercise;
SELECT * from returns;
-- Inner Join
SELECT o.order_id,o.customer_name,r.return_reason
FROM orders o
Join returns r
ON o.order_id=r.order_id;

-- LEFT Join
SELECT o.order_id,o.customer_name,r.return_reason
FROM orders o
Left Join returns r
ON o.order_id=r.order_id
LIMIT 10000;
 
 -- Right Join
SELECT o.order_id,o.customer_name,r.order_id,r.return_reason
FROM orders o
Right Join returns r
ON o.order_id=r.order_id
WHERE o.customer_name is null;

-- CROSS Join
SELECT o.order_id,o.customer_name,r.order_id,r.return_reason
FROM orders o
Cross Join returns r
LIMIT 2866168;

-- Join Eg.
select r.return_reason,sum(sales) as total_sales
from orders o
inner join returns r on o.order_id=r.order_id
group by r.return_reason;


-- Join Assignment
-- Q1 write a query to get region wise count of return orders
select o.region,count(r.order_id) as return_orders
FROM orders o
JOIN returns r
ON o.order_id=r.order_id
GROUP BY o.region;

-- Q2. write a query to get category wise sales of orders that were not returned
SELECT o.category,sum(o.sales) as sales_orders_not_returned
FROM orders o
LEFT JOIN returns r
ON o.order_id=r.order_id
WHERE r.return_reason is null
GROUP BY o.category;

-- Employee Data
create table employee(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int,
    manager_id int,
    emp_age int
);


insert into employee values(1,'Ankit',100,10000,4,39);
insert into employee values(2,'Mohit',100,15000,5,48);
insert into employee values(3,'Vikas',100,10000,4,37);
insert into employee values(4,'Rohit',100,5000,2,16);
insert into employee values(5,'Mudit',200,12000,6,55);
insert into employee values(6,'Agam',200,12000,2,14);
insert into employee values(7,'Sanjay',200,9000,2,13);
insert into employee values(8,'Ashish',200,5000,2,12);
insert into employee values(9,'Mukesh',300,6000,6,51);
insert into employee values(10,'Rakesh',500,7000,6,50);
select * from employee;

create table dept(
    dep_id int,
    dep_name varchar(20)
);
insert into dept values(100,'Analytics');
insert into dept values(200,'IT');
insert into dept values(300,'HR');
insert into dept values(400,'Text Analytics');
select * from dept;



-- Q3.write a query to print dep name and average salary of employees in that dep
SELECT d.dep_name,AVG(e.salary) as avg_salary
FROM employee e
Join dept d
ON e.dept_id=d.dep_id
GROUP BY d.dep_name;

-- Q4. write a query to print dep names where none of the emplyees have same salary
SELECT d.dep_name,COUNT(e.salary),COUNT(DISTINCT e.salary)
FROM employee e
Join dept d
ON e.dept_id=d.dep_id
GROUP BY d.dep_name
HAVING NOT (COUNT(e.salary)>COUNT(DISTINCT e.salary));

-- Q5. write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
SELECT o.sub_category,COUNT(DISTINCT r.return_reason) as distinct_reason
FROM orders o
JOIN returns r
ON o.order_id=r.order_id
GROUP BY o.sub_category
HAVING  distinct_reason=3;

SELECT DISTINCT city from orders ORDER BY city;
-- Q6.write a query to find cities where not even a single order was returned.
SELECT o.city,COUNT(r.return_reason) as order_return
FROM orders o
LEFT JOIN returns r
ON o.order_id=r.order_id
GROUP BY o.city
HAVING COUNT(r.return_reason)=0;

-- Q7.write a query to find top 3 subcategories by sales of returned orders in east region
SELECT o.sub_category,SUM(o.sales),COUNT(r.order_id) as return_orders
FROM orders o
JOIN returns r
ON o.order_id=r.order_id
WHERE region='East'
GROUP BY o.sub_category
ORDER BY SUM(o.sales) DESC 
LIMIT 3;

-- Q8.write a query to print dep name for which there is no employee
SELECT d.dep_name,COUNT(e.emp_id)
FROM dept d
LEFT Join employee e
ON d.dep_id=e.dept_id
GROUP by dep_name
HAVING COUNT(e.emp_id)=0;

-- Q9.write a query to print employees name for dep id is not avaiable in dept table
SELECT e.emp_name,COUNT(d.dep_id)
FROM dept d
RIGHT Join employee e
ON d.dep_id=e.dept_id
GROUP by e.emp_name
HAVING COUNT(d.dep_id)=0;









SELECT COLUMNS
FROM table1 t1
JOIN table2 t2
ON Join condition