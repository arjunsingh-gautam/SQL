# <span style="color:#a7c957">**Lesson-12 SQL**</span>

## <span style="color:#0a9396">**HAVING clause**</span>

### 1. Syntax

```sql
SELECT column1, aggregate_function(column2)
FROM table_name
WHERE condition       -- filters before grouping
GROUP BY column1
HAVING condition;     -- filters after grouping
```

---

### 2. Working

- **WHERE** filters rows **before grouping**.
- **GROUP BY** groups rows into buckets.
- **HAVING** filters **groups after aggregation**.

👉 Think:

- WHERE → "row-level filter"
- HAVING → "group-level filter"

---

### 3. Use Cases

- Show departments with more than 5 employees.
- Show customers whose total purchase value > ₹50,000.
- Show products that were sold more than 3 times.

---

### 4. Best Practices

✅ Use `WHERE` whenever possible (faster — reduces rows before grouping).
✅ Use `HAVING` only for aggregate conditions.
✅ Keep conditions simple (complex aggregates in HAVING may hurt performance).

---

### 5. Precautions

⚠️ Don’t confuse `WHERE` vs `HAVING`.
⚠️ Using HAVING without GROUP BY still works, but it acts like a **post-filter** on the entire result.
⚠️ In some databases, you can’t directly use an alias in `HAVING` (depends on engine).

---

### 6. Limitations

- Slower than `WHERE` since it runs **after grouping**.
- Not all SQL dialects allow aliases in HAVING (e.g., Oracle, SQL Server need raw aggregate expressions).

---

### 7. Why can’t `HAVING` always use aliases or group-level results?

- **Group-level results** = values produced by aggregation (`SUM()`, `COUNT()`, `AVG()`).
- `HAVING` is processed **before SELECT aliases are assigned** in execution order.
- Example:

  ```sql
  SELECT SUM(sales) AS total_sales
  FROM Orders
  GROUP BY customer_id
  HAVING total_sales > 50000;  -- ❌ error in some SQL engines
  ```

  - Because `total_sales` alias is defined _after_ HAVING executes.
  - You need:

  ```sql
  HAVING SUM(sales) > 50000;
  ```

---

### 8. Example Schema

```sql
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO Orders VALUES
(1, 'Arjun', 'Laptop', 60000),
(2, 'Arjun', 'Mouse', 1200),
(3, 'Riya', 'Laptop', 60000),
(4, 'Riya', 'Keyboard', 2500),
(5, 'Meera', 'Mouse', 1800),
(6, 'Karan', 'Laptop', 120000),
(7, 'Karan', 'Mouse', 600);
```

---

### 9. Practice Questions

1. Find customers who placed more than 1 order.
2. Find customers whose total purchase amount > ₹70,000.
3. Show products that earned more than ₹60,000 in total.
4. Show customers who bought **at least 2 different product types**.
5. Find customers who spent less than the average total spending of all customers.

---
