                                          -- Aggregate Function
USE select_exercise;

CREATE TABLE O (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    order_date DATE
);

INSERT INTO O VALUES
(1, 'Arjun', 'Laptop', 1, 60000, '2025-09-01'),
(2, 'Riya', 'Phone', 2, 25000, '2025-09-02'),
(3, 'Meera', 'Headphones', 3, 2000, '2025-09-02'),
(4, 'Arjun', 'Mouse', 2, 1200, '2025-09-03'),
(5, 'Karan', 'Laptop', 2, 60000, '2025-09-03'),
(6, 'Riya', 'Tablet', 1, 18000, '2025-09-04'),
(7, 'Karan', 'Keyboard', 1, 4000, '2025-09-04');

-- Exercise

-- Q1.Find the total number of orders placed.
SELECT COUNT(*) as total_orders from O;

-- Q2.Find the total revenue generated.
SELECT SUM(quantity*price) as total_revenue FROM O;

-- Q3. Find the average order value.
SELECT AVG(quantity*price) as avg_order_value FROM O;

-- Q4.Find the most expensive product sold.
SELECT product_name ,MAX(price) FROM O
Group by product_name
ORDER BY MAX(price) DESC
LIMIT 1;

-- or
SELECT product_name, price
FROM O
ORDER BY price DESC
LIMIT 1;


-- Q5. Find the cheapest product sold.
SELECT product_name ,MAX(price) FROM O
Group by product_name
ORDER BY MAX(price) ASC
LIMIT 1;

-- or
SELECT product_name, price
FROM O
WHERE price = (SELECT MIN(price) FROM O);

-- Q6.Find the total revenue per customer
SELECT customer_name,SUM(quantity*price) as total_revenue FROM O
group by customer_name;

-- Q7. Find the average spending per customer.
SELECT customer_name,AVG(quantity*price) as avg_order_value FROM O
GROUP BY customer_name;

-- Q8. Count how many distinct products were sold.
SELECT COUNT(DISTINCT product_name) as distinct_products from O;

-- Q9. List each customer and the products they purchased (GROUP_CONCAT).
SELECT customer_name, group_concat(product_name SEPARATOR ',') as products FROM O
group by customer_name;

-- Q10. Find the customer(s) who placed the highest total orders.
SELECT customer_name,SUM(quantity*price) as total_price FROM O
GROUP BY customer_name
ORDER BY total_price DeSC;