                                     -- INNER JOINS
USE joins_ex;                                     
CREATE TABLE Cust (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50)
);

CREATE TABLE Ord (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Prod (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  price DECIMAL(10,2)
);

-- Insert data
INSERT INTO cust VALUES
(1, 'Arjun'), (2, 'Meera'), (3, 'Rahul');

INSERT INTO Prod VALUES
(101, 'Laptop', 45000),
(102, 'Phone', 15000),
(103, 'Tablet', 20000);

INSERT INTO Ord VALUES
(201, 1, 101, 2),
(202, 1, 102, 1),
(203, 3, 103, 1),
(204, 4, 101, 1); -- Note: invalid customer, testing join behavior

-- Exercise:
-- Q1.Show all customer names with the products they bought.
SELECT c.customer_name,p.product_name
FROM cust c
JOIN ord o
ON c.customer_id=o.customer_id
JOIN prod p
ON o.product_id=p.product_id;

-- Q2. Find the total amount each customer spent (join Orders + Products).
SELECT customer_id,SUM(quantity*price) as total_spent 
FROM ord o
JOIN prod p
ON o.product_id=p.product_id
group by  customer_id;

-- Q3.List customers who ordered more than 1 Laptop.
SELECT customer_name
FROM cust c
JOIN ord o
ON c.customer_id=o.customer_id
JOIN prod p
ON o.product_id=p.product_id
WHERE (product_name='Laptop') and quantity>1;

-- Q4.Find customers who never placed an order (hint: this needs LEFT JOIN comparison).
SELECT *
FROM cust c
LEFT JOIN ord o
ON c.customer_id=o.customer_id
WHERE order_id is NULL;

-- Q5. Show product names that were ordered at least once.
SELECT p.product_id,p.product_name,o.quantity
FROM cust c
JOIN ord o
ON c.customer_id=o.customer_id
JOIN prod p
ON o.product_id=p.product_id
WHERE o.quantity>=1;