# <span style="color:#a7c957">**Lesson-21 SQL**</span>
# 🔹 **Introduction to Joins**

### Why we need Joins

* In **relational databases**, data is normalized → broken into multiple tables to reduce redundancy.
  Example:

  * A `customers` table stores customer details.
  * An `orders` table stores purchases, referencing customers via `customer_id`.

👉 To answer real-world questions like *“Which customer placed which order?”*, we need **Joins**.

---

### Difference between **Joins vs Subqueries**

* **Joins** → Combine rows from multiple tables *horizontally* (side by side).
* **Subqueries** → Use the result of one query *inside another* (nested).

**Example**:

🟢 Join:

```sql
SELECT c.customer_name, o.order_id
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;
```

🟡 Subquery:

```sql
SELECT customer_name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);
```

---

# 🔹 **INNER JOIN**

### Syntax

```sql
SELECT table1.column1, table2.column2, ...
FROM table1
INNER JOIN table2
ON table1.common_column = table2.common_column;
```

---

### Working (Dry Run Example)

**Table: Customers**

| customer\_id | customer\_name |
| ------------ | -------------- |
| 1            | Arjun          |
| 2            | Meera          |
| 3            | Rahul          |

**Table: Orders**

| order\_id | customer\_id | product |
| --------- | ------------ | ------- |
| 101       | 1            | Laptop  |
| 102       | 1            | Phone   |
| 103       | 3            | Tablet  |
| 104       | 4            | TV      |

**Query:**

```sql
SELECT c.customer_name, o.product
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;
```

**Dry Run:**

1. Take each row of `customers`.
2. Match with rows of `orders` where `customer_id` is equal.
3. If match found → merge row. If not → ignore.

**Result:**

| customer\_name | product |
| -------------- | ------- |
| Arjun          | Laptop  |
| Arjun          | Phone   |
| Rahul          | Tablet  |

👉 Notice: `Meera` is missing (no order), `TV` is missing (no matching customer).

---

### Precautions & Limitations

1. **Precaution:** Always specify `ON` condition → else you’ll get a **Cartesian product** (huge, incorrect results).
2. **Limitation:** INNER JOIN only shows **matching rows**, so unmatched data is lost.

   * Example: If you want customers with no orders → need LEFT JOIN, not INNER JOIN.
3. **Precaution:** Use table aliases (`c`, `o`) to avoid ambiguity.

---

# 🔹 Practice Schema for INNER JOIN

Let’s create **Customers**, **Orders**, and **Products**:

```sql
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50)
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  price DECIMAL(10,2)
);

-- Insert data
INSERT INTO Customers VALUES
(1, 'Arjun'), (2, 'Meera'), (3, 'Rahul');

INSERT INTO Products VALUES
(101, 'Laptop', 45000),
(102, 'Phone', 15000),
(103, 'Tablet', 20000);

INSERT INTO Orders VALUES
(201, 1, 101, 2),
(202, 1, 102, 1),
(203, 3, 103, 1),
(204, 4, 101, 1); -- Note: invalid customer, testing join behavior
```

---

# 🔹 Practice Questions for INNER JOIN

1. Show all customer names with the products they bought.
2. Find the total amount each customer spent (join `Orders` + `Products`).
3. List customers who ordered *more than 1 Laptop*.
4. Find customers who never placed an order (hint: this needs LEFT JOIN comparison).
5. Show product names that were ordered at least once.

---




# 🔹 1. Do we always need **Foreign Key** constraints for Joins?

* **No.**
* For joins, we only need **columns with matching data** (same domain/logical meaning).
* A **foreign key constraint** is **not mandatory**; it’s a database design best practice to maintain **referential integrity** (ensuring no orphan rows).

👉 Example without FK:

```sql
SELECT e.emp_name, d.dept_name
FROM employees e
JOIN departments d
ON e.dept_code = d.dept_code;
```

Even if `dept_code` isn’t declared as FK, join works as long as data matches.

✅ **Best practice:** Define FK when modeling → helps avoid invalid data & ensures correct joins.

---

# 🔹 2. What if we join on different common attributes?

Yes, **different join conditions lead to different results.**

Example:

**Employees**

| emp\_id | emp\_name | dept\_id | manager\_id |
| ------- | --------- | -------- | ----------- |
| 1       | Arjun     | 10       | 100         |
| 2       | Meera     | 20       | 101         |
| 3       | Rahul     | 10       | 101         |

**Departments**

| dept\_id | dept\_name | manager\_id |
| -------- | ---------- | ----------- |
| 10       | IT         | 100         |
| 20       | HR         | 101         |

---

### Join on `dept_id`:

```sql
SELECT e.emp_name, d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;
```

**Result:**

| emp\_name | dept\_name |
| --------- | ---------- |
| Arjun     | IT         |
| Meera     | HR         |
| Rahul     | IT         |

---

### Join on `manager_id`:

```sql
SELECT e.emp_name, d.dept_name
FROM employees e
JOIN departments d
ON e.manager_id = d.manager_id;
```

**Result:**

| emp\_name | dept\_name |
| --------- | ---------- |
| Arjun     | IT         |
| Meera     | HR         |
| Rahul     | HR         |

👉 Same two tables, **different join condition → different relationships**.

---

# 🔹 3. Execution Order of a SQL Query (including Joins)

When you write a SQL query:

```sql
SELECT c.customer_name, o.order_id
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_date > '2025-01-01'
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 2
ORDER BY c.customer_name;
```

👉 **Logical Execution Order** (not the order you write):

1. **FROM & JOIN** → Build intermediate table by joining tables.
2. **ON** → Apply join condition to filter rows.
3. **WHERE** → Apply row-level filtering on joined table.
4. **GROUP BY** → Group remaining rows.
5. **Aggregate Functions** → SUM, COUNT, etc. applied per group.
6. **HAVING** → Filter groups based on aggregate conditions.
7. **SELECT** → Pick required columns & compute expressions.
8. **DISTINCT** → Remove duplicates (if specified).
9. **ORDER BY** → Sort results.
10. **LIMIT/OFFSET** → Apply pagination.

---

### Dry Run Example

**Tables:**

Customers

| id | name  |
| -- | ----- |
| 1  | Arjun |
| 2  | Meera |

Orders

| id | cust\_id | amount |
| -- | -------- | ------ |
| 10 | 1        | 5000   |
| 11 | 1        | 2000   |
| 12 | 2        | 3000   |

**Query:**

```sql
SELECT c.name, SUM(o.amount) AS total
FROM customers c
JOIN orders o
ON c.id = o.cust_id
WHERE o.amount > 2000
GROUP BY c.name
HAVING SUM(o.amount) > 4000
ORDER BY total DESC;
```

**Execution:**

1. **FROM + JOIN** → Combine customers + orders.

   ```
   Arjun - 5000
   Arjun - 2000
   Meera - 3000
   ```
2. **WHERE o.amount > 2000** → filter row with 2000.

   ```
   Arjun - 5000
   Meera - 3000
   ```
3. **GROUP BY name** → Group rows:

   * Arjun → 5000
   * Meera → 3000
4. **HAVING SUM > 4000** → Keep only Arjun.
5. **SELECT** → Project `name, SUM(amount)`.
6. **ORDER BY** → Sort if multiple rows.

**Final Result:**

| name  | total |
| ----- | ----- |
| Arjun | 5000  |

---

✅ So yes: *First join builds a virtual table, then projection (`SELECT`) happens after grouping/filters.*

---



## 1. What are Nested Joins?

When you have more than 2 tables, joins are evaluated in **nested order**:

* First join creates a temporary result set (a “virtual table”).
* Next join uses that result set with the next table.
* This continues until all joins are resolved.

👉 SQL doesn’t explicitly tell *which* join happens first (that’s decided by the **optimizer**), but logically it’s **left to right** unless overridden with parentheses.

---

## 2. Example with 3 Tables

### Tables

**Customers**

| cust\_id | name  |
| -------- | ----- |
| 1        | Arjun |
| 2        | Meera |
| 3        | Rahul |

**Orders**

| order\_id | cust\_id | prod\_id |
| --------- | -------- | -------- |
| 101       | 1        | 501      |
| 102       | 1        | 502      |
| 103       | 2        | 503      |

**Products**

| prod\_id | product | price |
| -------- | ------- | ----- |
| 501      | Laptop  | 45000 |
| 502      | Phone   | 15000 |
| 503      | Tablet  | 20000 |

---

### Query with Nested Joins

```sql
SELECT c.name, p.product, p.price
FROM customers c
JOIN orders o ON c.cust_id = o.cust_id
JOIN products p ON o.prod_id = p.prod_id;
```

---

## 3. Dry Run (Execution Order)

### Step 1: `customers JOIN orders`

Join `customers` and `orders` using `cust_id`.
Result (virtual table T1):

| cust\_id | name  | order\_id | prod\_id |
| -------- | ----- | --------- | -------- |
| 1        | Arjun | 101       | 501      |
| 1        | Arjun | 102       | 502      |
| 2        | Meera | 103       | 503      |

(Rahul dropped, no orders.)

---

### Step 2: `(T1) JOIN products`

Now, take result T1 and join with `products` using `prod_id`.
Result (final):

| name  | product | price |
| ----- | ------- | ----- |
| Arjun | Laptop  | 45000 |
| Arjun | Phone   | 15000 |
| Meera | Tablet  | 20000 |

---

## 4. Execution Rules

1. **Join order**: SQL logically processes joins **from left to right** unless parentheses force different order.

   ```sql
   (customers JOIN orders) JOIN products
   ```

   is not the same as

   ```sql
   customers JOIN (orders JOIN products)
   ```

   if join conditions differ.

2. **Temporary virtual tables**: Each join creates an intermediate set before the next join.

3. **Optimizer freedom**: In reality, DB optimizers may reorder joins for performance (based on indexes, statistics). But logically, it’s nested as explained.

---

## 5. Example of Changing Join Order

```sql
-- First join customers + orders
SELECT c.name, p.product
FROM (customers c
      JOIN orders o ON c.cust_id = o.cust_id)
JOIN products p ON o.prod_id = p.prod_id;

-- First join orders + products
SELECT c.name, p.product
FROM customers c
JOIN (orders o
      JOIN products p ON o.prod_id = p.prod_id)
ON c.cust_id = o.cust_id;
```

Both may give the same result **if FK integrity holds**, but can differ if data is missing.

---

## 6. Analogy

Think of nested joins like **assembling Lego blocks**:

* First, attach block A with block B.
* Then, attach the combined piece with block C.
* Finally, attach with block D (if more joins).

---

✅ **Summary:**

* Nested joins are evaluated step by step: join 2 tables → create virtual table → join with next.
* Order matters logically (parentheses can control it).
* Optimizer may reorder internally for speed, but logically it’s left-to-right nested.

---



