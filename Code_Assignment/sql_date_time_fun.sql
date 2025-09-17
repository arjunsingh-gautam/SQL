                                    -- Date-Time Function
USE select_exercise;
CREATE TABLE t (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    delivery_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO t VALUES
(1, 'Alice', '2025-09-01', '2025-09-05', 500),
(2, 'Bob', '2025-09-10', '2025-09-13', 1200),
(3, 'Charlie', '2025-08-25', '2025-08-30', 700),
(4, 'Diana', '2025-07-15', '2025-07-20', 1500),
(5, 'Evan', '2025-09-17', '2025-09-25', 900);

-- Exercise:

-- Q1.Find the current system date and time.
SELECT current_timestamp();

-- Q2.Extract year and month of all orders.
SELECT year(order_date) as years,month(order_date) as months FROM t;

-- Q3. Show the dayname of each order_date.
SELECT dayname(order_date) as dayname from t;

-- Q4.Find how many days it took for each order to deliver (DATEDIFF).
SELECT datediff(delivery_date,order_date) as order_duration from t;

-- Q5. Find total sales per month.
SELECT Month(order_date) as Months,SUM(amount) as total_sales FROM t
Group by Month(order_date);

-- Q6.Find customers whose order was placed in September 2025.
SELECT customer_name,Month(order_date) from t
where Month(order_date)=9;

-- Q7. Find all orders placed in the last 30 days.
SELECT order_id, customer_name, order_date
FROM t
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) ;

-- Q8.Format order_date as "17-Sep-2025".
SELECT DATE_format(order_date,'%d-%M-%Y') from t;

-- Q9.Find the last day of each order_date month
SELECT order_date,LAST_DAy(order_date) from t;

-- Q10.Add 15 days to delivery_date and show extended delivery date.
SELECT delivery_date, DATE_ADD(delivery_date, INTERVAL 15 DAY) FROM t;

