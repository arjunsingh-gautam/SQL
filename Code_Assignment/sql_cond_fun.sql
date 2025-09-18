                                 -- Conditional Functions:
USE select_exercise;

CREATE TABLE s (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    discount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO s VALUES
(1, 'Laptop', 2, 45000.75, 2000.50, '2025-09-01'),
(2, 'Phone', 5, 15000.20, NULL, '2025-09-05'),
(3, 'Tablet', 3, 22000.99, 1000.00, '2025-09-10'),
(4, 'Monitor', 1, 12000.00, 500.00, '2025-09-12'),
(5, 'Headphones', 8, 3000.50, NULL, '2025-09-15');

-- Exercise:

/*Q1. Show all sales and categorize them into:
"High Value" if price > 20000
"Medium Value" if 10000–20000
"Low Value" otherwise.*/

SELECT * ,
CASE 
	WHEN price>20000 THEN "High Value"
    WHEN price BETWEEN 1000 and 2000 THEN "Medium Value"
    ELSE "LOW VALUE"
END as category
FROM s;

-- Q2. Show product name and discount. If discount is NULL, display "No Discount".
SELECT product_name,ifnull(discount,"No Discount") from s;

-- Q3. For each sale, calculate price/quantity. But avoid divide-by-zero error.
select sale_id, (price/NULLIF(quantity,0)) as  price_perquantity from s;

-- Q4. Count how many products fall under "Premium", "Mid-range", "Budget" categories using CASE.
SELECT 
    CASE
        WHEN price > 40000 THEN 'Premium'
        WHEN price BETWEEN 20000 AND 40000 THEN 'Mid-range'
        ELSE 'Budget'
    END AS category,
    COUNT(*) AS product_count
FROM s
GROUP BY category;

-- Q5.Calculate total revenue, but give "0" if revenue is NULL.
SELECT IFNULL(SUM((price*quantity)-discount),0) as total_revenue from s;