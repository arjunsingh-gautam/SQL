# <span style="color:#a7c957">**Lesson-15 SQL**</span>
# ✅ SQL Built-in Functions

## 1. **What are SQL Built-in Functions?**

* Predefined functions provided by SQL to perform **common operations** such as calculations, string manipulation, date/time handling, aggregation, and more.
* They **save time**, reduce code repetition, and ensure **database independence** (instead of writing complex procedural code).

---

## 2. **How do they work?**

* You call them directly inside your SQL queries.
* They **take input values** (arguments) → perform operations → **return a single value**.
* Can be used in `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING` etc.

---

## 3. **Categories of SQL Functions**

SQL functions are broadly divided into:

1. **Aggregate Functions** (work on a group of rows → return one result per group).
   Examples: `SUM()`, `AVG()`, `COUNT()`, `MAX()`, `MIN()`.

2. **Scalar Functions** (work on individual values → return single value per row).
   Examples: `UPPER()`, `LOWER()`, `ROUND()`, `NOW()`.

3. **String Functions** (manipulate text).
   Examples: `CONCAT()`, `SUBSTRING()`, `TRIM()`.

4. **Date & Time Functions** (work on date/time).
   Examples: `NOW()`, `DATEADD()`, `DATEDIFF()`, `MONTH()`.

5. **Mathematical Functions** (work on numbers).
   Examples: `ROUND()`, `CEIL()`, `FLOOR()`, `POWER()`.

6. **System Functions** (return system info).
   Examples: `USER()`, `DATABASE()`, `VERSION()`.

---

## 4. **Demo Schema for Practice**

```sql
CREATE TABLE sales (
    id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales VALUES
(1,'Alice','Laptop',2,50000,'2025-01-10'),
(2,'Bob','Mouse',5,500,'2025-02-15'),
(3,'Alice','Keyboard',3,1500,'2025-02-20'),
(4,'Charlie','Monitor',1,12000,'2025-03-01'),
(5,'Bob','Laptop',1,52000,'2025-03-15');
```

---

## 5. **Examples of Built-in Functions**

### 🔹 Aggregate Functions

```sql
-- Find total sales amount
SELECT SUM(quantity * price) AS total_sales FROM sales;

-- Find average product price
SELECT AVG(price) AS avg_price FROM sales;

-- Count distinct customers
SELECT COUNT(DISTINCT customer_name) AS unique_customers FROM sales;

-- Max sale price
SELECT MAX(price) FROM sales;
```

---

### 🔹 String Functions

```sql
-- Uppercase customer names
SELECT UPPER(customer_name) FROM sales;

-- First 3 letters of product name
SELECT SUBSTRING(product, 1, 3) FROM sales;

-- Concatenate name and product
SELECT CONCAT(customer_name, ' bought ', product) FROM sales;

-- Remove spaces
SELECT TRIM('   hello   ');
```

---

### 🔹 Date & Time Functions

```sql
-- Current system date
SELECT NOW();

-- Extract month from sale_date
SELECT MONTH(sale_date) FROM sales;

-- Difference between two dates
SELECT DATEDIFF('2025-03-15','2025-01-10');
```

---

### 🔹 Math Functions

```sql
-- Round average price to nearest integer
SELECT ROUND(AVG(price)) FROM sales;

-- Ceiling and floor
SELECT CEIL(AVG(price)), FLOOR(AVG(price)) FROM sales;

-- Power
SELECT POWER(2, 3); -- 2^3 = 8
```

---

### 🔹 System Functions

```sql
SELECT USER();       -- current user
SELECT DATABASE();   -- current database
SELECT VERSION();    -- SQL version
```

---

## 6. **Limitations**

* Functions may be **database-specific** (e.g., MySQL `CONCAT()` vs SQL Server `+`).
* Overuse of functions (especially in `WHERE` clauses) can **reduce performance** since they prevent index usage.
* Not all functions can be used with **GROUP BY** (only aggregates or group-safe functions).
* Some date/math functions vary in syntax across DBMS.

---

## 7. **Best Practices**

* Use functions only when necessary (to keep queries **efficient**).
* Prefer **aggregate functions with GROUP BY** instead of doing manual loops in code.
* Be aware of **NULL handling** (e.g., `SUM(NULL)` = NULL → use `COALESCE`).
* Keep functions database-agnostic when possible (portable code).
* Always **alias computed values** for readability.

---

🔥 Pro Tip: When writing queries with functions, always **think in layers**:

* Row-level → apply scalar functions.
* Group-level → apply aggregate functions.
* System-level → apply system functions.

---


## ✅ Categories of Functions in MySQL

MySQL provides a **rich set of built-in functions**. These can be broadly classified as:

---

## 1. **Aggregate Functions**

Work on **groups of rows** and return a single value.

🔹 Examples:

```sql
SELECT COUNT(*) FROM sales;               -- total rows
SELECT SUM(price * quantity) FROM sales;  -- total sales
SELECT AVG(price) FROM sales;             -- avg price
SELECT MIN(price), MAX(price) FROM sales; -- lowest & highest price
```

---

## 2. **String Functions**

Manipulate text strings.

🔹 Common Functions:

```sql
SELECT LENGTH('hello');                  -- 5
SELECT UPPER('mysql');                   -- MYSQL
SELECT LOWER('MYSQL');                   -- mysql
SELECT CONCAT('My','SQL');               -- MySQL
SELECT SUBSTRING('Database', 1, 4);      -- Data
SELECT TRIM('   hello   ');              -- hello
SELECT REPLACE('abcabc','a','z');        -- zbczbc
SELECT LEFT('abcdef', 3), RIGHT('abcdef', 2); -- abc, ef
SELECT REVERSE('abc');                   -- cba
```

---

## 3. **Numeric / Mathematical Functions**

Perform calculations on numbers.

🔹 Examples:

```sql
SELECT ABS(-10);         -- 10
SELECT ROUND(12.345, 2); -- 12.35
SELECT CEIL(4.2);        -- 5
SELECT FLOOR(4.9);       -- 4
SELECT MOD(10, 3);       -- 1
SELECT POWER(2, 3);      -- 8
SELECT SQRT(16);         -- 4
```

---

## 4. **Date & Time Functions**

Work with date and time values.

🔹 Examples:

```sql
SELECT CURDATE();                        -- today's date
SELECT NOW();                            -- current date & time
SELECT YEAR(NOW()), MONTH(NOW()), DAY(NOW());
SELECT DATE_ADD('2025-09-17', INTERVAL 10 DAY);
SELECT DATE_SUB('2025-09-17', INTERVAL 2 MONTH);
SELECT DATEDIFF('2025-09-17','2025-01-01'); -- difference in days
SELECT DAYNAME('2025-09-17');            -- Wednesday
SELECT LAST_DAY('2025-09-17');           -- 2025-09-30
```

---

## 5. **Control Flow Functions**

Allow conditional logic.

🔹 Examples:

```sql
SELECT IF(10 > 5, 'YES', 'NO');       -- YES
SELECT IFNULL(NULL, 'Default');       -- Default
SELECT NULLIF(5, 5);                  -- NULL
SELECT CASE 
         WHEN price > 50000 THEN 'Expensive'
         ELSE 'Affordable'
       END AS category
FROM sales;
```

---

## 6. **System Information Functions**

Return info about MySQL environment.

🔹 Examples:

```sql
SELECT USER();        -- current user
SELECT DATABASE();    -- current database
SELECT VERSION();     -- MySQL version
SELECT CONNECTION_ID(); -- connection id
```

---

## 7. **Encryption, Hashing & Security Functions**

Used for security-related tasks.

🔹 Examples:

```sql
SELECT MD5('hello');        -- md5 hash
SELECT SHA1('hello');       -- sha1 hash
SELECT SHA2('hello', 256);  -- sha2 hash
SELECT PASSWORD('mypwd');   -- password hash (deprecated in new MySQL)
```

---

## 8. **JSON Functions (MySQL 5.7+)**

Work with JSON data types.

🔹 Examples:

```sql
SELECT JSON_OBJECT('name','Arj','age',22); -- {"name": "Arj", "age": 22}
SELECT JSON_EXTRACT('{"a":1,"b":2}', '$.a'); -- 1
SELECT JSON_SET('{"a":1}', '$.a', 100);      -- {"a": 100}
```

---

## 9. **Window Functions (MySQL 8.0+)**

Operate over **a window of rows** (advanced analytics).

🔹 Examples:

```sql
SELECT customer_name, 
       SUM(price*quantity) OVER(PARTITION BY customer_name) AS total_spent
FROM sales;

SELECT customer_name,
       RANK() OVER(ORDER BY SUM(price*quantity) DESC) AS rank
FROM sales
GROUP BY customer_name;
```

---

## 10. **Other Utility Functions**

* **Conversion functions**

```sql
SELECT CAST('2025-09-17' AS DATE);
SELECT CONVERT('123', UNSIGNED);
```

* **NULL-related**

```sql
SELECT COALESCE(NULL, NULL, 'default'); -- default
```

---

## 🔥 Limitations & Precautions

* Some functions are **DBMS-specific** (MySQL ≠ SQL Server/PostgreSQL).
* Functions inside `WHERE` clauses **may prevent index usage** → performance hit.
* `NULL` handling can be tricky — always test with `COALESCE()` or `IFNULL()`.
* Window functions need **MySQL 8+**.
* JSON functions only in **MySQL 5.7+**.

---

## ✅ Best Practices

1. Use **aliases** for function results → improves readability.
2. Avoid unnecessary function nesting.
3. Push heavy transformations to **application layer** if performance critical.
4. Use **aggregate + GROUP BY** carefully (HAVING for post-aggregation conditions).
5. Test for `NULL` explicitly when using functions.

---

