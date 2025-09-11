CREATE DATABASE sql_operators;
USE sql_operators;



-- Create `users` table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    city VARCHAR(50),
    email VARCHAR(100)
);

-- Create `products` table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    in_stock BOOLEAN
);

-- Create `orders` table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10,2),
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert into users
INSERT INTO users (name, age, city, email) VALUES
('Arjun', 24, 'Delhi', 'arjun@example.com'),
('Riya', 30, 'Mumbai', 'riya@example.com'),
('Kabir', 19, 'Delhi', 'kabir@example.com'),
('Aanya', 26, 'Pune', 'aanya@example.com'),
('Dev', 40, 'Bangalore', 'dev@example.com');

-- Insert into products
INSERT INTO products (name, category, price, in_stock) VALUES
('Laptop', 'Electronics', 55000.00, TRUE),
('Smartphone', 'Electronics', 22000.00, TRUE),
('Table', 'Furniture', 5000.00, FALSE),
('Chair', 'Furniture', 2000.00, TRUE),
('Book', 'Stationery', 300.00, TRUE);

-- Insert into orders
INSERT INTO orders (user_id, product_id, quantity, total_price, order_date, status) VALUES
(1, 1, 1, 55000.00, '2025-07-01', 'Delivered'),
(2, 2, 2, 44000.00, '2025-07-03', 'Pending'),
(3, 5, 3, 900.00, '2025-07-02', 'Shipped'),
(4, 4, 4, 8000.00, '2025-07-04', 'Delivered'),
(5, 3, 1, 5000.00, '2025-07-05', 'Cancelled');

ALTER TABLE users ADD COLUMN nickname VARCHAR(100);
UPDATE users SET nickname = 'AJ' WHERE name = 'Arjun';
-- Rest remain NULL
SET SQL_SAFE_UPDATES = 0; -- Turn off Safe Update Mode
SET SQL_SAFE_UPDATES = 1; -- Turn on Safe Update Mode



-- Exercise:

-- Q1:Fetch all products with price greater than 5000.
SELECT * FROM products WHERE price>5000;

-- Q2:Get all users whose age is not equal to 24
SELECT * FROM users WHERE age<>24;

-- Q3:Find orders where quantity >= 3
SELECT * FROM orders WHERE quantity>=3;

-- Q4:List users who are older than 25
SELECT user_id,name,age FROM users WHERE age>25;

-- Q5:Get users from Delhi OR Pune.
SELECT * FROM users WHERE (city='Delhi') or (city='Pune');

-- Q6:Get users from Delhi AND age < 25.
SELECT * FROM users WHERE (city='Delhi') and (age<25);

-- Q7:Get orders where status is NOT 'Delivered'.
SELECT * FROM orders WHERE (NOT(status='Delivered'));

-- Q8:Find products that are Electronics AND in stock.
SELECT * FROM products WHERE (category='Electronics') AND (in_stock);

-- Q9:Get all orders with total_price / quantity as unit_price
SELECT *,total_price/quantity AS unit_price FROM orders;

-- Q10:Display each user's age + 5 (for a future prediction)
SELECT *,age+5 AS new_age FROM users;

-- Q11.Find product cost after 10% discount
SELECT *,(price - price*0.1) AS discounted_price FROM products;

-- Q12.Find users whose age is between 20 and 35.
SELECT * FROM users WHERE age BETWEEN 20 AND 35;

-- Q13.Find users from cities: 'Delhi', 'Mumbai' using IN.
SELECT * FROM users WHERE city IN('Delhi','Mumbai');

-- Q14.Find users whose email ends with '@example.com'.
SELECT * FROM users WHERE email LIKE '%example.com';

-- Q15:Get products whose name starts with 'S
SELECT * FROM products WHERE name LIKE 'S%';

-- Q16:Find users whose nickname IS NULL.
SELECT * FROM users WHERE nickname IS NULL;

-- Q17:Find users whose nickname IS NOT NULL
SELECT * FROM users WHERE nickname IS NOT NULL;