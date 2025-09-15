# <span style="color:orange">**COALESCE() and NULLIF() Operator**</span>

## 🔹 `COALESCE` Operator

### 1. Syntax

```sql
COALESCE(expr1, expr2, expr3, ..., exprN)
```

### 2. Working

- It **returns the first non-NULL expression** from the list.
- If **all values are NULL**, it returns **NULL**.
- Think of it like a **fallback chain**.

---

### 3. Dry Run Example

Suppose we have a table `Students`:

| id  | name  | nickname | alias |
| --- | ----- | -------- | ----- |
| 1   | Arjun | NULL     | AJ    |
| 2   | Riya  | NULL     | NULL  |
| 3   | Mohit | Mo       | NULL  |

Query:

```sql
SELECT id, COALESCE(nickname, alias, name) AS display_name
FROM Students;
```

Dry run:

- Row 1 → nickname = NULL → alias = "AJ" → returns "AJ"
- Row 2 → nickname = NULL → alias = NULL → name = "Riya" → returns "Riya"
- Row 3 → nickname = "Mo" → returns "Mo"

Result:

| id  | display_name |
| --- | ------------ |
| 1   | AJ           |
| 2   | Riya         |
| 3   | Mo           |

---

### 4. Use Cases & Best Practices

- Handle **NULL values gracefully** without using `CASE`.
- Useful in **reporting**: if salary_bonus is NULL, fallback to salary_base.
- Can act like a **default value assigner**.

✔ Best practice:

- Always order arguments from **most preferred to least preferred fallback**.
- Keep data types consistent (avoid mixing int with varchar).

---

### 5. Precautions

- Watch out: If all values are `NULL`, result = `NULL` (not a default unless you add one).
- Large `COALESCE` chains can be messy; sometimes better to normalize data.

---

### 6. Practice Questions

1. Write a query that shows employee’s `preferred_email`, but if it is NULL, use `work_email`, and if that is also NULL, use `"no_email@company.com"`.

- ANS:

```sql
SELECT COALESCE(preferred_email, work_email, "no_email@company.com") AS employee_mail
FROM Employee;
```

2. In a product table, if `discount_price` is NULL, fallback to `offer_price`, else to `regular_price`.

- ANS:

```sql
SELECT COALESCE(Discount_price, offer_price, regular_price) AS selling_price
FROM orders;
```

---

---

## 🔹 `NULLIF` Operator

### 1. Syntax

```sql
NULLIF(expr1, expr2)
```

### 2. Working

- If `expr1 = expr2` → returns **NULL**
- If `expr1 ≠ expr2` → returns **expr1**

So it’s like a **conditional NULL generator**.

---

### 3. Dry Run Example

```sql
SELECT NULLIF(10, 10), NULLIF(20, 10), NULLIF(NULL, 5);
```

Dry run:

- `NULLIF(10, 10)` → equal → NULL
- `NULLIF(20, 10)` → not equal → 20
- `NULLIF(NULL, 5)` → NULL ≠ 5 → returns NULL (since expr1 is NULL)

Result:

| col1 | col2 | col3 |
| ---- | ---- | ---- |
| NULL | 20   | NULL |

---

### 4. Use Cases & Best Practices

- Avoid **division by zero**:

```sql
SELECT salary / NULLIF(hours_worked, 0)
FROM Employees;
```

If `hours_worked = 0` → becomes NULL → avoids error.

- Transform "unwanted duplicates" into NULL to be ignored.

✔ Best practice:

- Use `NULLIF` mainly in **arithmetic or conditional expressions**.
- Don’t overuse it for general NULL handling (that’s `COALESCE`’s job).

---

### 5. Precautions

- If first argument is NULL, result is always NULL, no matter the second.
- Don’t confuse with `CASE`: `NULLIF(a,b)` is shorthand for `CASE WHEN a=b THEN NULL ELSE a END`.

---

### 6. Practice Questions

1. Use `NULLIF` to safely calculate average revenue per user when `num_users` could be zero.
2. Query orders where `NULLIF(status, 'pending')` helps ignore "pending" rows.

---

✅ Quick Check for You:
If you run `SELECT COALESCE(NULL, NULL, 5, 10);` → what will the output be?
And if you run `SELECT NULLIF(100, 200);` → what will the output be?

Would you like me to make a **side-by-side comparison table of COALESCE vs NULLIF** so it’s easier to revise?
