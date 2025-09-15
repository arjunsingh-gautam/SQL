                                         -- GROUP BY Clause

USE select_exercise;

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO Sales VALUES
(1, 'Arjun', 'Laptop', 1, 60000, '2023-01-10'),
(2, 'Arjun', 'Mouse', 2, 1200, '2023-01-15'),
(3, 'Riya', 'Laptop', 1, 60000, '2023-02-01'),
(4, 'Riya', 'Keyboard', 1, 2500, '2023-02-05'),
(5, 'Meera', 'Mouse', 3, 1800, '2023-03-12'),
(6, 'Karan', 'Laptop', 2, 120000, '2023-03-15'),
(7, 'Karan', 'Mouse', 1, 600, '2023-04-01');


-- Exercise:

-- Q1.Find total quantity of products sold by each customer.
SELECT customer_name,SUM(quantity) as total_quantity
FROM sales
GROUP BY customer_name;

-- Q2.Find total sales (quantity × price) per customer.
SELECT customer_name,SUM(quantity*price) as total_sales
FROM sales
GROUP BY customer_name;

-- Q3.Find how many times each product was sold 
SELECT product,COUNT(*) as times_sold
FROM sales
GROUP BY product;

-- Q4.Find the average price of items bought by each customer.
SELECT customer_name,AVG(price) as avg_price
FROM sales
GROUP BY customer_name;

-- Q5.Find the customer who spent the maximum amount.
SELECT customer_name, SUM(quantity*price) AS total_sales
FROM sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 1;
 
-- Q6.Show sales per month (group by month of sale_date). (IMP) 
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month, 
       SUM(quantity*price) AS total_sales
FROM sales
GROUP BY month;

-- Q7. Show which product type generated the highest total revenue
SELECT product,SUM(quantity*price) as total_sales
FROM sales
GROUP BY product
ORDER BY total_sales DESC
LIMIT 1;

-- Q8. Return unique customer names (using GROUP BY without aggregates).
SELECT customer_name FROM sales GROUP BY customer_name;