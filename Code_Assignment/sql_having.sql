                                                      -- HAVING CLAUSE
USE select_exercise;
CREATE TABLE ord (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO ord VALUES
(1, 'Arjun', 'Laptop', 60000),
(2, 'Arjun', 'Mouse', 1200),
(3, 'Riya', 'Laptop', 60000),
(4, 'Riya', 'Keyboard', 2500),
(5, 'Meera', 'Mouse', 1800),
(6, 'Karan', 'Laptop', 120000),
(7, 'Karan', 'Mouse', 600);

-- Exercise

-- Q1.Find customers who placed more than 1 order. 
SELECT customer_name,COUNT(*) 
FROM ord
GROUP BY customer_name
HAVING COUNT(*)>1;

-- Q2.Find customers whose total purchase amount > ₹70,000.
SELECT customer_name,SUM(amount) as total_purchase
FROM ord
group by customer_name
HAVING SUM(amount)>70000;

-- Q3.Show products that earned more than ₹60,000 in total.
SELECT product,SUM(amount) as total_purchase
FROM ord
group by product
HAVING SUM(amount)>60000;

-- Q4.Show customers who bought at least 2 different product types.
SELECT customer_name,COUNT(distinct product) as total_purchase
FROM ord
group by customer_name
HAVING COUNT(distinct product)>=2;

-- Q5.Find customers who spent less than the average total spending of all customers. (IMP)
SELECT customer_name, SUM(amount) AS total_spending
FROM Ord
GROUP BY customer_name
HAVING SUM(amount) < (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(amount) AS customer_total
        FROM Ord
        GROUP BY customer_name
    ) AS sub
);
