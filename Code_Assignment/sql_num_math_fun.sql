                                     -- Math and Numerics Function
USE select_exercise;
CREATE TABLE sm (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    discount DECIMAL(5,2)
);

INSERT INTO sm (sale_id, product_name, quantity, price, discount) 
VALUES
(1, 'Laptop', 2, 45000.75, 200.50),
(2, 'Phone', 5, 15000.20, 500.25),
(3, 'Tablet', 3, 22000.99, 100.00),
(4, 'Headphones', 10, 2000.50, 150.75),
(5, 'Monitor', 1, 12000.00, 0.00);

SELECT * FROM sm;

-- Exercise:

-- Q1.Find absolute discount for each product.
SELECT ABS(discount) as abs_discount from sm;

-- Q2.Round product price to 0 and 2 decimals. 
SELECT ROUND(price,0) as round_price from sm;

-- Q3.Calculate total price = quantity * price, then round to nearest integer.
SELECT ROUND((quantity*price),0) as r_T_p from sm;

-- Q4. Find square root of average product price.
SELECT SQRT(AVG(quantity*price)) as sqrt_avg_price from sm;

-- Q5.Generate a random lucky draw discount between 100–500 for each row.
select sale_id,FLOOR(rand()*401) +100 as lucky_draw_discount from sm;

-- Q6.Show only products where price modulo 2 = 0 (even prices).
select product_name,price from sm
where MOD(price,2)=0;

-- Q7.Convert π into degrees and radians.
SELECT degrees(pi()),radians(pi());

-- Q8.Find log10 of product prices.
SELECT product_name,log10(price) from sm;

-- Q9.Identify whether discount values are negative/positive using SIGN().
SELECT discount,SIGN(discount) from sm;

-- Q10.Find the highest order amount using POWER(quantity,2) * price as metric.
SELECT price ,POWER(quantity,2)*price from sm
ORDER BY POWER(quantity,2)*price DESC
LIMIT 1;

