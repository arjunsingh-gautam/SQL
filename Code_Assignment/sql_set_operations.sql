-- SET Operations

USE func;

-- Tables:
CREATE TABLE branch1_customers (
    id INT,
    customer_name VARCHAR(50)
);

CREATE TABLE branch2_customers (
    id INT,
    customer_name VARCHAR(50)
);

INSERT INTO branch1_customers VALUES
(1, 'John'),
(2, 'Alice'),
(3, 'Robert'),
(4, 'David');

INSERT INTO branch2_customers VALUES
(1, 'Alice'),
(2, 'Robert'),
(3, 'Maria'),
(4, 'John');


-- Union: Remove Duplicates
SELECT customer_name FROM branch1_customers
UNION
SELECT customer_name FROM branch2_customers;

-- Union ALL: Preserve Duplicates
SELECT customer_name FROM branch1_customers
UNION ALL
SELECT customer_name FROM branch2_customers;
