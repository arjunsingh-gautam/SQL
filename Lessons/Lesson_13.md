# <span style="color:#a7c957">**Lesson-13 SQL**</span>

## ORDER BY Clause in SQL

## 1. Syntax

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC];
```

- `ASC` = ascending (default)
- `DESC` = descending

---

## 2. Working

- SQL retrieves rows (possibly filtered, grouped, aggregated).
- `ORDER BY` sorts the final result set before returning it.
- Can sort by:

  - A column
  - A column alias
  - An expression (`salary*12`)
  - Column positions (`ORDER BY 2` → sorts by 2nd column in SELECT).

---

## 3. Use Cases

- Sort employees by salary (highest first).
- Sort sales by date (latest first).
- Sort products alphabetically.

---

## 4. Best Practices

✅ Always specify `ASC`/`DESC` explicitly for clarity.
✅ Use indexes on large tables to speed up sorting.
✅ Use `ORDER BY` on **final results only** — don’t rely on implicit order.

---

## 5. Precautions

⚠️ Without `ORDER BY`, SQL result order is **not guaranteed**, even if it looks sorted.
⚠️ Sorting large datasets is expensive — avoid unnecessary sorts.
⚠️ Using `ORDER BY` with multiple columns: order matters (first col sorted fully, then tie-breaker on second).

---

## 6. Limitations

- Performance overhead on very large result sets.
- In distributed databases, ordering can require extra shuffling.
- Cannot always `ORDER BY` aggregates unless grouped properly.

---

## 7. Why can ORDER BY use **aliases** or **group-level results**?

Because of **execution order**:

1. `FROM`
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. **SELECT (assigns aliases)**
6. **ORDER BY (runs after SELECT)**

👉 Since `ORDER BY` happens _after_ aliases are assigned, you can sort using them.
Example:

```sql
SELECT customer_name, SUM(amount) AS total_spent
FROM Orders
GROUP BY customer_name
ORDER BY total_spent DESC;   -- ✅ works, alias is known now
```

---

## DISTINCT Keyword

## Function:

- Removes duplicate rows from the result set.

## Syntax:

```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;
```

## Use:

- Get unique customer names.
- Find all unique product categories.

⚠️ Precaution: DISTINCT applies to the **entire row**, not just one column (unless only one column is selected).

---

## LIMIT & OFFSET

## 1. LIMIT

- Restricts the number of rows returned.

```sql
SELECT * FROM Orders LIMIT 5;
```

→ returns only 5 rows.

## 2. OFFSET

- Skips a number of rows before starting to return results.

```sql
SELECT * FROM Orders LIMIT 5 OFFSET 10;
```

→ skip 10 rows, then return next 5.

## 3. Use Cases

- Pagination in web apps.
- Showing top-N queries (top 10 salaries, top 5 products).

## 4. Best Practices

✅ Always use `ORDER BY` with `LIMIT` to ensure consistent results.
✅ Avoid very high offsets on huge tables (performance hit).

---

### 🧠 Mini Recap

- **ORDER BY** → sorting results (can use alias).
- **DISTINCT** → removes duplicates.
- **LIMIT/OFFSET** → control how many rows to fetch/skip.

---
