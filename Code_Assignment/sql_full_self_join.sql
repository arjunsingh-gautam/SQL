                                     -- Full Outter and Self Joins
USE joins_ex;
-- Customers table
CREATE TABLE C1 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO C1 VALUES
(1, 'Alice', 'Delhi'),
(2, 'Bob', 'Mumbai'),
(3, 'Charlie', 'Pune'),
(4, 'David', 'Delhi');

-- Orders table
CREATE TABLE O1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO O1 VALUES
(101, 1, 'Laptop', 45000.00),
(102, 2, 'Phone', 15000.00),
(103, 5, 'Tablet', 22000.00), -- customer_id 5 does NOT exist
(104, 4, 'Headphones', 3000.00);

-- Exercise:
-- Q1.Show all customers and all orders, including those without matches.
SELECT *
FROM c1 c
LEFT JOIN o1 o
ON c.customer_id=o.customer_id
UNION
SELECT *
FROM c1 c
RIGHT JOIN o1 o
ON c.customer_id=o.customer_id;

-- Q2.Find customers who have never placed an order.
SELECT *
FROM c1 c
LEFT JOIN o1 o
ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL;

-- Q3. Find Self Join
SELECT a.customer_name AS customer1, b.customer_name AS customer2, a.city
FROM C1 a
JOIN C1 b
ON a.city = b.city AND a.customer_id < b.customer_id;


