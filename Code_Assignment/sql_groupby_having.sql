-- GROUP BY Clause

USE select_exercise;

-- Regions in orders
SELECT region FROM orders GROUP BY region;

-- Groups of category and regions
SELECT category,region FROM orders GROUP BY category,region;

-- TOTAL sales of different regions
SELECT SUM(sales) AS total_sales,region FROM orders GROUP BY region;

-- Total sales per region and category
SELECT region, category, SUM(sales) AS total_sales
FROM orders
GROUP BY region, category;

-- Having Clause: Post Filter after Grouping

SELECT region, category, SUM(sales) AS total_sales
FROM orders
GROUP BY region, category
HAVING total_sales>200000;

-- customers grouped by segment,category,region having quantity >200
SELECT segment,region, category, COUNT(quantity) AS total_quantity
FROM orders
GROUP BY region, category,segment
HAVING total_quantity>200;
