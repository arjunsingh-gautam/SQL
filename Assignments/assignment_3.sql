                                      -- Assignment 3:
                                      
-- Questions:	
/*								
1- write a query to get region wise count of return orders
2- write a query to get category wise sales of orders that were not returned
3- write a query to print dep name and average salary of employees in that dep .
4- write a query to print dep names where none of the employees have same salary.
5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)
6- write a query to find cities where not even a single order was returned.
7- write a query to find top 3 subcategories by sales of returned orders in east region
8- write a query to print dep name for which there is no employee
9- write a query to print employees name for dep id is not avaiable in dept table
*/

-- Q1:
SELECT o.region,COUNT(r.return_reason) as orders_returned
FROM orders o
JOIN returns r 
ON o.order_id=r.order_id
GROUP BY o.region
ORDER BY orders_returned DESC;

-- Q2.
SELECT *
FROM orders  o
LEFT JOIN returns r 
ON o.order_id=r.order_id
WHERE r.return_reason is null
GROUP BY o.category;

-- Inserting Table for queries:
create table empl(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int,
    manager_id int,
    emp_age int
);


insert into empl values(1,'Ankit',100,10000,4,39);
insert into empl values(2,'Mohit',100,15000,5,48);
insert into empl values(3,'Vikas',100,10000,4,37);
insert into empl values(4,'Rohit',100,5000,2,16);
insert into empl values(5,'Mudit',200,12000,6,55);
insert into empl values(6,'Agam',200,12000,2,14);
insert into empl values(7,'Sanjay',200,9000,2,13);
insert into empl values(8,'Ashish',200,5000,2,12);
insert into empl values(9,'Mukesh',300,6000,6,51);
insert into empl values(10,'Rakesh',500,7000,6,50);
select * from empl;

create table dep(
    dep_id int,
    dep_name varchar(20)
);
insert into dep values(100,'Analytics');
insert into dep values(200,'IT');
insert into dep values(300,'HR');
insert into dep values(400,'Text Analytics');
select * from dep;

-- Q3.
select d.dep_name,AVG(e.salary)
from empl e
JOIN dep d
on e.dept_id=d.dep_id
GROUP by d.dep_name;

-- Q4.
SELECT d.dep_name
FROM empl e
JOIN dep d ON e.dept_id = d.dep_id
GROUP BY d.dep_name
HAVING COUNT(e.salary) = COUNT(DISTINCT e.salary);

-- Q5.
SELECT o.city
FROM orders  o
LEFT JOIN returns r 
ON o.order_id=r.order_id
GROUP BY o.city
HAVING COUNT(Distinct r.return_reason)=0;

-- Q6.
SELECT o.sub_category,COUNT(DISTINCT r.return_reason)
FROM orders o
JOIN returns r 
ON o.order_id=r.order_id
GROUP BY o.sub_category
HAVING COUNT(DISTINCT r.return_reason)=3 ;

-- Q7.
SELECT o.sub_category,SUM(o.sales)
FROM orders o
JOIN returns r 
ON o.order_id=r.order_id
WHERE o.region='East'
GROUP BY o.sub_category
ORDER BY SUM(o.sales) DESC
LIMIT 3;

-- Q8.
SELECT d.dep_name,e.emp_name
From dep d
LEFT Join empl e
ON d.dep_id=e.dept_id
WHERE e.emp_name is null;

-- Q9.write a query to print employees name for dep id is not avaiable in dept table
SELECT e.emp_name,e.dept_id
From empl e
LEFT Join dep d
ON d.dep_id=e.dept_id
where d.dep_id is null;