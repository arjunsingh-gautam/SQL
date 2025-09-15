# <span style="color:#a7c957">**Lesson-10 SQL**</span>

## <span style="color:#0a9396">**WHERE clause**</span>

## 🔹 1. Syntax of `WHERE`

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

- `condition` can include comparisons, logical operators, functions, and pattern matching.

---

## 🔹 2. Working of `WHERE`

- Filters rows **before grouping or aggregation** (important difference from `HAVING`).
- Only rows that satisfy the condition(s) appear in the result.
- Works with:

  - Comparison operators (`=`, `>`, `<`, `>=`, `<=`, `<>`)
  - Logical operators (`AND`, `OR`, `NOT`)
  - Pattern matching (`LIKE`, `REGEXP`)
  - NULL checks (`IS NULL`, `IS NOT NULL`)
  - Subqueries (`WHERE salary > (SELECT AVG(salary) FROM Employee)`)

---

## 🔹 3. Use cases

- Retrieve records meeting specific conditions:

  - Employees with salary above 50,000
  - Customers from a specific city
  - Orders placed after a certain date

---

## 🔹 4. Best practices

✅ Always use **indexed columns** in `WHERE` for better performance.
✅ Be careful with **functions on columns** (e.g., `WHERE YEAR(date) = 2025`) because they can prevent index usage.
✅ Use **`BETWEEN`** and **`IN`** for cleaner queries instead of multiple `OR`s.
✅ Always handle **NULL values** correctly (`IS NULL` instead of `= NULL`).

---

## 🔹 5. Precautions

⚠️ `WHERE` filters rows **before aggregation** — don’t confuse it with `HAVING`.
⚠️ Conditions with wildcards like `%abc%` can be **slow** if applied on large datasets.
⚠️ Case sensitivity depends on DB (MySQL is case-insensitive by default, PostgreSQL is case-sensitive).

---

## 🔹 6. Example Schema for Practice

```sql
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE,
    email VARCHAR(100)
);

INSERT INTO Employees VALUES
(1, 'Arjun', 'Sharma', 'IT', 60000, '2020-01-15', 'arjun.sharma@company.com'),
(2, 'Riya', 'Verma', 'HR', 45000, '2019-05-10', 'riya.verma@company.com'),
(3, 'Karan', 'Patel', 'Finance', 70000, '2021-03-20', 'karan.patel@company.com'),
(4, 'Meera', 'Singh', 'IT', 50000, '2022-07-12', 'meera.singh@company.com'),
(5, 'Sohan', 'Yadav', 'Marketing', 40000, '2018-09-30', NULL);
```

---

## 🔹 7. Practice Questions

1. Find all employees in the **IT department**.
2. Find employees with **salary greater than 50,000**.
3. Get employees who joined **after 2020-01-01**.
4. Find employees who **don’t have an email address**.
5. Get employees whose **salary is between 45,000 and 60,000**.
6. Find employees from **IT or HR department**.
7. Find employees whose **first name starts with 'M'**.
8. Retrieve employees hired in **2019 or 2021**.

---
