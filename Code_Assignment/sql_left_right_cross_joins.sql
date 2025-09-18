                                                    -- Left,Right,Cross Joins
USE joins_ex;
-- Customers Table
CREATE TABLE Custo(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO Custo VALUES
(1, 'Alice', 'Delhi'),
(2, 'Bob', 'Mumbai'),
(3, 'Charlie', 'Bangalore'),
(4, 'David', 'Chennai'),
(5, 'Eva', 'Kolkata');

-- Orders Table
CREATE TABLE Orde (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orde VALUES
(101, 1, 'Laptop', 45000.00),
(102, 2, 'Mobile', 15000.00),
(103, 1, 'Tablet', 22000.00),
(104, 3, 'Headphones', 3000.00);

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO Orde VALUES
(105, 6, 'Camera', 35000.00);

SET FOREIGN_KEY_CHECKS = 1;

-- Exercise:

-- Q1.LEFT JOIN (All customers + their orders if any)
SELECT *
FROM Custo c
LEFT Join Orde o
ON c.customer_id=o.customer_id;

-- Q2. RIGHT JOIN (All orders + customer info if available)
SELECT * 
FROM Custo c
RIGHT Join Orde o
ON c.customer_id=o.customer_id;

-- Q3. Find Cross Join
SELECT *
FROM custo c
JOIN orde o
ORDER BY c.customer_name,o.order_id;

