# <span style="color:#a7c957">**Lesson-20 SQL**</span>
## Conditional Functions in MySQL

MySQL provides **functions to apply conditional logic inside queries**, similar to `if-else` in programming.

---

## 1. **IF() Function**

👉 Syntax:

```sql
IF(condition, value_if_true, value_if_false)
```

### Dry Run:

* If the `condition` is **TRUE** → returns `value_if_true`.
* Else → returns `value_if_false`.

### Example:

```sql
SELECT product_name,
       price,
       IF(price > 20000, 'Expensive', 'Affordable') AS price_category
FROM products;
```

✅ **Working**: For each row, checks if `price > 20000`. If true → "Expensive", else "Affordable".
⚠️ **Limitation**: Can only handle *binary conditions* (true/false).
📌 **Use Case**: Categorizing data into two groups.

---

## 2. **IFNULL() Function**

👉 Syntax:

```sql
IFNULL(expression, alternative_value)
```

### Dry Run:

* If `expression` is **NOT NULL** → returns it.
* Else → returns `alternative_value`.

### Example:

```sql
SELECT customer_name,
       IFNULL(phone_number, 'Not Provided') AS contact_number
FROM customers;
```

✅ **Working**: Replaces `NULL` values with `"Not Provided"`.
⚠️ **Limitation**: Only handles **NULL** checking.
📌 **Use Case**: Data cleaning, filling missing values.

---

## 3. **NULLIF() Function**

👉 Syntax:

```sql
NULLIF(expr1, expr2)
```

### Dry Run:

* If `expr1 = expr2` → returns `NULL`.
* Else → returns `expr1`.

### Example:

```sql
SELECT sale_id,
       NULLIF(quantity, 0) AS non_zero_qty
FROM sales;
```

✅ **Working**: Returns `NULL` if `quantity=0`, otherwise `quantity`.
⚠️ **Limitation**: Only compares **two values**.
📌 **Use Case**: Avoiding divide-by-zero errors. Example:

```sql
SELECT price / NULLIF(quantity,0) FROM sales;
```

---

## 4. **CASE Expression** (Most Powerful)

👉 Syntax:

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE resultN
END
```

### Dry Run:

* Evaluates conditions **top to bottom**.
* First condition that is TRUE → returns corresponding result.
* If none → returns `ELSE` value.

### Example:

```sql
SELECT product_name, price,
CASE
    WHEN price > 40000 THEN 'Premium'
    WHEN price BETWEEN 20000 AND 40000 THEN 'Mid-range'
    ELSE 'Budget'
END AS category
FROM products;
```

✅ **Working**: Multi-level conditional logic.
⚠️ **Limitation**: Gets **long & messy** if too many conditions.
📌 **Use Case**: Complex business rules, categorization, tiering.

---

## Summary of Conditional Functions

| Function   | Purpose                                   |
| ---------- | ----------------------------------------- |
| `IF()`     | Binary condition (like ternary operator). |
| `IFNULL()` | Replace NULL values.                      |
| `NULLIF()` | Return NULL if two values are equal.      |
| `CASE`     | Multi-condition handling.                 |

---

## Practice Schema (for Aggregate + Conditional Functions)

```sql
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    discount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales VALUES
(1, 'Laptop', 2, 45000.75, 2000.50, '2025-09-01'),
(2, 'Phone', 5, 15000.20, NULL, '2025-09-05'),
(3, 'Tablet', 3, 22000.99, 1000.00, '2025-09-10'),
(4, 'Monitor', 1, 12000.00, 500.00, '2025-09-12'),
(5, 'Headphones', 8, 3000.50, NULL, '2025-09-15');
```

---

## Practice Questions

1. Show all sales and categorize them into:

   * `"High Value"` if price > 20000
   * `"Medium Value"` if 10000–20000
   * `"Low Value"` otherwise.

2. Show product name and discount. If discount is NULL, display `"No Discount"`.

3. For each sale, calculate `price/quantity`. But avoid divide-by-zero error.

4. Count how many products fall under `"Premium"`, `"Mid-range"`, `"Budget"` categories using `CASE`.

5. Calculate total revenue, but give `"0"` if revenue is NULL.

---

