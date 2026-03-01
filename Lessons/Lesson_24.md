# <span style="color:#a7c957" >**Lesson-23 SQL**</span>
# 1️⃣ FULL OUTER JOIN

### 🔹 **Working**

* Combines the results of **LEFT JOIN** and **RIGHT JOIN**.
* Returns **all rows** from both tables:

  * Matching rows where join condition is true.
  * Non-matching rows with `NULL` for missing values.

👉 Think of it as:
`FULL OUTER JOIN = LEFT JOIN ∪ RIGHT JOIN`

---

### 🔹 **Syntax**

```sql
SELECT columns
FROM tableA
FULL OUTER JOIN tableB
ON tableA.col = tableB.col;
```

⚠️ Note: MySQL does **not** support FULL OUTER JOIN directly.
We achieve it using `UNION`:

```sql
SELECT a.col, b.col
FROM tableA a
LEFT JOIN tableB b ON a.id = b.id
UNION
SELECT a.col, b.col
FROM tableA a
RIGHT JOIN tableB b ON a.id = b.id;
```

---

### 🔹 **Use Cases**

* Comparing **two datasets** (e.g., customers from two regions).
* Finding mismatched or missing data across systems.
* Merging logs/data where both sets must be preserved.

---

### 🔹 **Precautions & Limitations**

* **Not supported in MySQL directly** → must simulate with `UNION`.
* Can return **large result sets** with many NULLs.
* Harder to interpret if data is sparse.

---

# 2️⃣ SELF JOIN

### 🔹 **Working**

* A table joined with **itself**.
* You must use **aliases** to differentiate copies.
* Useful for hierarchical data (e.g., employees and managers).

---

### 🔹 **Syntax**

```sql
SELECT a.col, b.col
FROM table a
JOIN table b
ON a.some_col = b.some_col;
```

---

### 🔹 **Use Cases**

* Find employees who share the same manager.
* Find duplicate records in a table.
* Compare rows within the same table.

---

### 🔹 **Precautions & Limitations**

* Without proper aliases → ambiguous column errors.
* Large tables → performance heavy.
* Must clearly define join condition to avoid **Cartesian products**.

---

# 3️⃣ 📘 Practice Schema

```sql
-- Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Alice', 'Delhi'),
(2, 'Bob', 'Mumbai'),
(3, 'Charlie', 'Pune'),
(4, 'David', 'Delhi');

-- Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO Orders VALUES
(101, 1, 'Laptop', 45000.00),
(102, 2, 'Phone', 15000.00),
(103, 5, 'Tablet', 22000.00), -- customer_id 5 does NOT exist
(104, 4, 'Headphones', 3000.00);
```

---

# 4️⃣ Practice Questions

### FULL OUTER JOIN

1. Show **all customers and all orders**, including those without matches.
2. Find customers who have **never placed an order**.
3. Find orders that belong to **non-existent customers**.

👉 Example Query (FULL OUTER JOIN Simulation):

```sql
SELECT c.customer_id, c.customer_name, o.order_id, o.product
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_id, c.customer_name, o.order_id, o.product
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;
```

---

### SELF JOIN

1. Find customers who live in the **same city**.

```sql
SELECT a.customer_name AS customer1, b.customer_name AS customer2, a.city
FROM Customers a
JOIN Customers b
ON a.city = b.city AND a.customer_id < b.customer_id;
```

2. Detect **duplicate city entries** in the `Customers` table.
3. List customer pairs where one customer’s ID is exactly **1 greater** than another.

---

