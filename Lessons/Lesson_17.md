# <span style="color:#a7c957">**Lesson-17 SQL**</span>



# ✅ Review of Your Queries

---

### Q1. Total number of orders

✔ Correct

```sql
SELECT COUNT(*) AS total_orders FROM O;
```

---

### Q2. Total revenue generated

✔ Correct

```sql
SELECT SUM(quantity * price) AS total_revenue FROM O;
```

---

### Q3. Average order value

✔ Correct

```sql
SELECT AVG(quantity * price) AS avg_order_value FROM O;
```

---

### Q4. Most expensive product sold

⚠️ Issue:
You grouped by product, then used `MAX(price)`. That gives you **per-product max price** (not the single global max).
Better: Use `ORDER BY price` directly, or `MAX()` without `GROUP BY`.

✅ Fixed version:

```sql
SELECT product_name, price
FROM O
ORDER BY price DESC
LIMIT 1;
```

Or:

```sql
SELECT product_name, price
FROM O
WHERE price = (SELECT MAX(price) FROM O);
```

---

### Q5. Cheapest product sold

Same issue as Q4.

✅ Fixed version:

```sql
SELECT product_name, price
FROM O
ORDER BY price ASC
LIMIT 1;
```

Or:

```sql
SELECT product_name, price
FROM O
WHERE price = (SELECT MIN(price) FROM O);
```

---

### Q6. Total revenue per customer

✔ Correct

```sql
SELECT customer_name, SUM(quantity * price) AS total_revenue
FROM O
GROUP BY customer_name;
```

---

### Q7. Average spending per customer

⚠️ Careful with wording.

* Your query gives **avg order value per customer**.
* If the question means **(total spending / number of customers)** → needs subquery.

Your version (avg order value per customer):

```sql
SELECT customer_name, AVG(quantity * price) AS avg_order_value
FROM O
GROUP BY customer_name;
```

Alternative (overall avg customer spending):

```sql
SELECT customer_name, SUM(quantity * price) AS total_spent
FROM O
GROUP BY customer_name
HAVING SUM(quantity * price) < (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(quantity * price) AS customer_total
        FROM O
        GROUP BY customer_name
    ) AS sub
);
```

---

### Q8. Distinct products sold

✔ Correct

```sql
SELECT COUNT(DISTINCT product_name) AS distinct_products FROM O;
```

---

### Q9. Each customer and their products (GROUP\_CONCAT)

⚠️ Small mistake → you concatenated `customer_name` and `product_name`.
We need **one row per customer**, listing all their products.

✅ Fixed:

```sql
SELECT customer_name,
       GROUP_CONCAT(product_name SEPARATOR ', ') AS products_bought
FROM O
GROUP BY customer_name;
```

---

### Q10. Customer(s) with highest total orders

⚠️ Slightly incomplete → your query lists all customers ordered by revenue, but doesn’t **limit** to the highest.

✅ Option 1 (Top 1):

```sql
SELECT customer_name, SUM(quantity * price) AS total_spent
FROM O
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 1;
```

✅ Option 2 (All tied at max):

```sql
SELECT customer_name, SUM(quantity * price) AS total_spent
FROM O
GROUP BY customer_name
HAVING SUM(quantity * price) = (
    SELECT MAX(total)
    FROM (
        SELECT SUM(quantity * price) AS total
        FROM O
        GROUP BY customer_name
    ) AS sub
);
```

---

# 🚀 Key Takeaways

* Don’t **overuse `GROUP BY`** unless you need group-level results.
* For “global” min/max → just `ORDER BY ... LIMIT 1` or a `WHERE ... = (MAX())`.
* `GROUP_CONCAT` works best with one group column.
* When asked for *the top*, remember to use `LIMIT` or a subquery.

---


