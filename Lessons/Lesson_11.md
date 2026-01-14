### <span style="color:#a7c957">**Lesson-11 SQL**</span>

<span style="color:###0a9396">**GROUP BY clause**</span>

1.  Syntax of `GROUP BY`

```sql
SELECT column1, aggregate_function(column2)
FROM table_name
WHERE condition
GROUP BY column1;
```

- `column1`: the column you want to group by (like department).
- `aggregate_function`: e.g., `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`.

---

2.  Working of `GROUP BY`

- Groups rows that have the **same value** in specified column(s).
- Returns **one row per group**.
- Often combined with aggregate functions to perform calculations on each group.

---

3.  Use Cases

- Find total sales per customer.
- Count employees in each department.
- Find average marks per student.
- Summarize data into categories.

---

4.  Best Practices

✅ Always group by the **non-aggregated columns** you select.
✅ Use `HAVING` (not `WHERE`) to filter groups after aggregation.
✅ Keep grouping columns minimal for performance.
✅ When grouping by multiple columns, order matters: `GROUP BY department, hire_date`.

---

5.  Precautions

⚠️ If you select a non-aggregated column that’s not in `GROUP BY`, SQL will throw an error (except MySQL with `ONLY_FULL_GROUP_BY` off — but don’t rely on that).
⚠️ Too many grouping columns = performance hit.
⚠️ Grouping large datasets requires indexes or summary tables for optimization.

---

6.  Why does `GROUP BY` require aggregates?

- `GROUP BY` reduces **many rows → one row per group**.
- To decide _what to show_ for non-grouped columns, we need **aggregates** (SUM, MAX, etc.).

👉 Example:

```sql
SELECT department, salary
FROM Employees
GROUP BY department;
```

⚠️ Invalid — because _which salary_ should SQL pick from that department?

✅ Correct:

```sql
SELECT department, AVG(salary)
FROM Employees
GROUP BY department;
```

---

7.  Can grouping be done without aggregation?

Yes — but then it works like **`DISTINCT`**.

```sql
SELECT department
FROM Employees
GROUP BY department;
```

This simply returns **unique department names** (same as `SELECT DISTINCT department`).

---

8.  Example Schema

```sql
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO Sales VALUES
(1, 'Arjun', 'Laptop', 1, 60000, '2023-01-10'),
(2, 'Arjun', 'Mouse', 2, 1200, '2023-01-15'),
(3, 'Riya', 'Laptop', 1, 60000, '2023-02-01'),
(4, 'Riya', 'Keyboard', 1, 2500, '2023-02-05'),
(5, 'Meera', 'Mouse', 3, 1800, '2023-03-12'),
(6, 'Karan', 'Laptop', 2, 120000, '2023-03-15'),
(7, 'Karan', 'Mouse', 1, 600, '2023-04-01');
```

---

9. Practice Questions

1. Find total quantity of products sold by each customer.
1. Find total sales (quantity × price) per customer.
1. Find how many times each product was sold.
1. Find the average price of items bought by each customer.
1. Find the customer who spent the maximum amount.
1. Show sales per month (group by month of `sale_date`).
1. Show which product type generated the highest total revenue.
1. Return unique customer names (using `GROUP BY` without aggregates).

---

<span style="color:orange; font-size:28px; font-weight:bold">GROUP BY clause in SQL — First Principles Explanation</span>

---

<span style="color:red; font-size:22px; font-weight:bold"> 1. What problem does GROUP BY solve? (First principles)</span>

From **first principles**, a relational table is a **set of tuples (rows)**.
SQL normally works **row-by-row**.

But many real questions are **set-level questions**, for example:

- What is the **total salary per department**?
- How many **orders per customer**?
- Average marks **per subject**?

👉 These questions require:

1. **Partitioning** rows into groups
2. **Reducing** each group into a single value

This is exactly what **GROUP BY** does.

---

<span style="color:red; font-size:22px; font-weight:bold"> 2. Core idea of GROUP BY (mental model)</span>

**GROUP BY = Partition + Aggregate**

1. **Partition** the table using one or more attributes
2. Apply **aggregation functions** on each partition
3. Produce **one row per group**

---

<span style="color:red; font-size:22px; font-weight:bold"> 3. Why aggregation of attributes not being grouped is necessary?</span>

### Key rule (very important):

👉 **Every selected attribute must be either:**

- Used in `GROUP BY`, **or**
- Used inside an **aggregate function**

### Why? (First principle reasoning)

Suppose this table:

| dept | emp | salary |
| ---- | --- | ------ |
| IT   | A   | 50     |
| IT   | B   | 70     |

Query:

```sql
SELECT dept, emp, SUM(salary)
FROM employee
GROUP BY dept;
```

❌ **Problem:**

- `dept = IT` → fine (grouped)
- `SUM(salary)` → fine (aggregated)
- `emp = ?` → **Which one? A or B?**

👉 SQL **cannot invent values**.
This violates **determinism**.

### Conclusion:

Attributes **not used for grouping must be aggregated**, otherwise result is ambiguous.

---

<span style="color:red; font-size:22px; font-weight:bold"> 4. Can we group without aggregation?</span>

### Technically: YES

### Practically: NOT useful

Example:

```sql
SELECT dept
FROM employee
GROUP BY dept;
```

This is equivalent to:

```sql
SELECT DISTINCT dept FROM employee;
```

👉 GROUP BY without aggregation only **removes duplicates**.

---

<span style="color:red; font-size:22px; font-weight:bold"> 5. Why grouping attribute does NOT need aggregation?</span>

### First principles explanation

- A **grouping attribute defines the identity of a group**
- It has the **same value for all rows in that group**

Example:

```sql
GROUP BY dept
```

Inside each group:

```
dept = IT, IT, IT
```

Since the value is **constant**, aggregation is meaningless.

👉 Aggregation is only needed when:

- Multiple different values exist
- You want to reduce them to one

---

<span style="color:red; font-size:22px; font-weight:bold"> 6. Necessary conditions for GROUP BY to work properly</span>

### Condition 1: SELECT rule

Every column in `SELECT` must be:

- In `GROUP BY`, or
- Inside an aggregate function

---

### Condition 2: Aggregates operate per group

Aggregate functions (`SUM`, `COUNT`, `AVG`, `MIN`, `MAX`) operate **within each group**, not globally.

---

### Condition 3: WHERE vs HAVING

- `WHERE` → filters rows **before grouping**
- `HAVING` → filters groups **after aggregation**

---

### Condition 4: GROUP BY columns define uniqueness

Number of output rows = number of **distinct group keys**

---

### Condition 5: Functional dependency (advanced but important)

If column `B` is functionally dependent on column `A`, then:

```sql
GROUP BY A
```

can safely include `B` (allowed in MySQL, not in strict SQL).

---

<span style="color:red; font-size:22px; font-weight:bold"> 7. Step-by-step working of GROUP BY (with example)</span>

### Table: `sales`

| region | product | amount |
| ------ | ------- | ------ |
| North  | Pen     | 10     |
| North  | Pen     | 20     |
| South  | Pen     | 15     |
| South  | Pencil  | 25     |

---

### Query:

```sql
SELECT region, SUM(amount)
FROM sales
GROUP BY region;
```

---

### Step 1: FROM

Load entire table.

---

### Step 2: WHERE (if present)

(Filter rows — none here)

---

### Step 3: GROUP BY

Partition rows:

- Group 1 → region = North → {10, 20}
- Group 2 → region = South → {15, 25}

---

### Step 4: Aggregation

Apply `SUM(amount)`:

- North → 30
- South → 40

---

### Step 5: SELECT projection

Output:

| region | sum |
| ------ | --- |
| North  | 30  |
| South  | 40  |

---

<span style="color:red; font-size:22px; font-weight:bold"> 8. Precautions and common mistakes</span>

### ❌ Mistake 1: Selecting non-grouped column

```sql
SELECT region, product, SUM(amount)
FROM sales
GROUP BY region;
```

✔️ Fix: Add `product` to GROUP BY or aggregate it.

---

### ❌ Mistake 2: Using WHERE with aggregate

```sql
WHERE SUM(amount) > 50   -- ❌ invalid
```

✔️ Use:

```sql
HAVING SUM(amount) > 50
```

---

### ❌ Mistake 3: Thinking GROUP BY sorts data

GROUP BY **does not guarantee ordering**.

✔️ Use:

```sql
ORDER BY
```

---

### ❌ Mistake 4: Misunderstanding COUNT(\*)

- `COUNT(*)` → counts rows
- `COUNT(column)` → ignores NULLs

---

### ❌ Mistake 5: Assuming SQL allows chaining logic

```sql
GROUP BY a > b > c  -- ❌ invalid logic
```

---

<span style="color:red; font-size:22px; font-weight:bold"> 9. One-line intuition (remember this)</span>

> **GROUP BY converts a table into a set of smaller tables and collapses each using aggregation.**

---
