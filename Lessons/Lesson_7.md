# <span style="color:#a7c957">**Lesson-7 SQL**</span>

## <span style="color:#0a9396">**SELECT Query Clause in SQL**</span>

### 1. `SELECT`

- **Syntax:**

  ```sql
  SELECT column1, column2, ...
  ```

- **Working:** Defines which columns (or expressions) you want in the result.
- **Use case:** Projection (choose only the data you care about).

---

### 2. `FROM`

- **Syntax:**

  ```sql
  FROM table_name
  ```

- **Working:** Tells SQL where the data comes from (tables, views, subqueries).
- **Use case:** Pick dataset to query from.

---

### 3. `WHERE`

- **Syntax:**

  ```sql
  WHERE condition
  ```

- **Working:** Filters rows **before grouping**.
- **Use case:** Only retrieve rows that match criteria (e.g., salary > 50000).

---

### 4. `GROUP BY`

- **Syntax:**

  ```sql
  GROUP BY column
  ```

- **Working:** Groups rows into buckets based on column values.
- **Use case:** Needed when using aggregate functions (SUM, AVG, COUNT).

---

### 5. `HAVING`

- **Syntax:**

  ```sql
  HAVING condition
  ```

- **Working:** Filters groups **after aggregation**.
- **Use case:** Find groups that meet certain conditions (e.g., departments with avg salary > 60000).

---

### 6. `ORDER BY`

- **Syntax:**

  ```sql
  ORDER BY column ASC|DESC
  ```

- **Working:** Sorts result set.
- **Use case:** Display data in meaningful order.

---

### 7. `LIMIT` / `OFFSET` (MySQL, Postgres, etc.)

- **Syntax:**

  ```sql
  LIMIT n OFFSET m
  ```

- **Working:** Restricts number of rows returned.
- **Use case:** Pagination (show top 10 rows).

---

## 🔹 Execution Order (Logical Steps SQL Follows)

Even though we **write** `SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY ...`,
SQL **executes** in this order:

1. `FROM` (get the data)
2. `WHERE` (filter rows)
3. `GROUP BY` (make groups)
4. `HAVING` (filter groups)
5. `SELECT` (pick columns/aggregates)
6. `ORDER BY` (sort results)
7. `LIMIT` (restrict rows)

---

## 🔹 Dry Run Example

Say we have:

| emp_id | dept  | salary |
| ------ | ----- | ------ |
| 1      | HR    | 40000  |
| 2      | HR    | 50000  |
| 3      | IT    | 60000  |
| 4      | IT    | 80000  |
| 5      | Sales | 30000  |

Query:

```sql
SELECT dept, AVG(salary) AS avg_sal
FROM Employees
WHERE salary > 35000
GROUP BY dept
HAVING AVG(salary) > 45000
ORDER BY avg_sal DESC
LIMIT 2;
```

**Step by Step Dry Run:**

1. `FROM Employees` → take full table.
2. `WHERE salary > 35000` → removes emp_id=5 (Sales, 30000).
3. `GROUP BY dept` → groups into HR, IT.
4. `HAVING AVG(salary) > 45000` → HR (avg 45000) excluded; IT (avg 70000) kept.
5. `SELECT dept, AVG(salary)` → output IT, 70000.
6. `ORDER BY` → only one row, so nothing changes.
7. `LIMIT 2` → still IT only.

✅ Final Result:

| dept | avg_sal |
| ---- | ------- |
| IT   | 70000   |

---

## 🔹 Use Cases

- `WHERE`: Filter individual rows (e.g., employees in IT dept).
- `GROUP BY`: Summarize (e.g., sales per region).
- `HAVING`: Filter summaries (e.g., regions with sales > \$1M).
- `ORDER BY`: Ranking (e.g., top 10 highest salaries).
- `LIMIT`: Pagination for apps/websites.

---
