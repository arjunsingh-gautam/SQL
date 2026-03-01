style="color:#a7c957">**Lesson-16 SQL**</span>

## 🔹 What are String Functions?

- **String functions** are built-in SQL functions to manipulate, search, and transform text data.
- They take `CHAR`, `VARCHAR`, or `TEXT` as input and return a processed value.
- Used heavily in reporting, formatting, cleaning raw data, or building search queries.

---

## ✅ Common String Functions in MySQL

---

### 1. **LENGTH() / CHAR_LENGTH()**

👉 Returns string length.

**Syntax:**

```sql
LENGTH(str)        -- bytes
CHAR_LENGTH(str)   -- characters
```

**Example:**

```sql
SELECT LENGTH('Arjun'), CHAR_LENGTH('Arjun');
```

- Output → `5, 5`
- ⚠️ For multibyte chars (e.g., emojis), `LENGTH` ≠ `CHAR_LENGTH`.

---

### 2. **UPPER() / LOWER()**

👉 Convert to uppercase or lowercase.

**Syntax:**

```sql
UPPER(str)
LOWER(str)
```

**Example:**

```sql
SELECT UPPER('arjun'), LOWER('SQL Rocks');
```

---

### 3. **CONCAT() / CONCAT_WS()**

👉 Join strings.

**Syntax:**

```sql
CONCAT(str1, str2, ...)
CONCAT_WS(separator, str1, str2, ...)
```

**Example:**

```sql
SELECT CONCAT('Hello', ' ', 'World');
SELECT CONCAT_WS('-', '2025', '09', '17');  -- 2025-09-17
```

---

### 4. **SUBSTRING() / MID()**

👉 Extract part of string.

**Syntax:**

```sql
SUBSTRING(str, start, length)
MID(str, start, length)
```

**Example:**

```sql
SELECT SUBSTRING('Database', 1, 4); -- Data
```

---

### 5. **LEFT() / RIGHT()**

👉 Extract left/right portion.

**Syntax:**

```sql
LEFT(str, len)
RIGHT(str, len)
```

**Example:**

```sql
SELECT LEFT('Arjun', 2), RIGHT('Arjun', 2); -- Ar, un
```

---

### 6. **INSTR() / LOCATE() / POSITION()**

👉 Find substring position.

**Syntax:**

```sql
INSTR(str, substr)
LOCATE(substr, str)
POSITION(substr IN str)
```

**Example:**

```sql
SELECT INSTR('Arjun Kumar', 'Kumar'); -- 7
```

---

### 7. **REPLACE()**

👉 Replace substring with another.

**Syntax:**

```sql
REPLACE(str, from_substr, to_substr)
```

**Example:**

```sql
SELECT REPLACE('SQL is bad', 'bad', 'great');
```

---

### 8. **TRIM() / LTRIM() / RTRIM()**

👉 Remove spaces (or custom chars).

**Syntax:**

```sql
TRIM([LEADING|TRAILING|BOTH] remstr FROM str)
LTRIM(str)
RTRIM(str)
```

**Example:**

```sql
SELECT TRIM('   hello   '), LTRIM('   hello'), RTRIM('hello   ');
```

---

### 9. **REVERSE()**

👉 Reverse string.

**Syntax:**

```sql
REVERSE(str)
```

**Example:**

```sql
SELECT REVERSE('SQL'); -- LQS
```

---

### 10. **LPAD() / RPAD()**

👉 Pad string left or right to fixed length.

**Syntax:**

```sql
LPAD(str, len, padstr)
RPAD(str, len, padstr)
```

**Example:**

```sql
SELECT LPAD('25', 5, '0'); -- 00025
```

---

### 11. **FIELD() / FIND_IN_SET()**

👉 Search for string in list.

**Syntax:**

```sql
FIELD(str, str1, str2, ...)
FIND_IN_SET(str, strlist)
```

**Example:**

```sql
SELECT FIELD('b', 'a','b','c'); -- 2
SELECT FIND_IN_SET('b','a,b,c'); -- 2
```

---

### 12. **GROUP_CONCAT()**

👉 Concatenate multiple rows into one.

**Syntax:**

```sql
GROUP_CONCAT(expr SEPARATOR ',')
```

**Example:**

```sql
SELECT customer_id, GROUP_CONCAT(product_name)
FROM Orders
GROUP BY customer_id;
```

---

## ⚡ Limitations of String Functions

- **Performance-heavy** on large text columns.
- `LENGTH` vs `CHAR_LENGTH` confusion in multibyte text.
- Case-sensitivity depends on collation.
- `GROUP_CONCAT` has length limit (`group_concat_max_len`).

---

## 🎯 Use Cases

- Formatting names, emails, IDs.
- Cleaning messy data (trimming spaces, replacing substrings).
- Pattern matching in validation (`LIKE`, `REGEXP`).
- Reporting (`GROUP_CONCAT`, padding).

---

# 🗂 Example Schema for Practice

```sql
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    dept VARCHAR(50)
);

INSERT INTO Employees VALUES
(1, 'Arjun', 'Kumar', 'arjun.k@company.com', '9876543210', 'IT'),
(2, 'Riya', 'Sharma', 'riya_s@company.com', '98-765-432', 'HR'),
(3, 'Karan', 'Patel', NULL, '98765-43210', 'Finance'),
(4, 'Meera', 'Singh', 'meera@company.com', '1234567890', 'IT'),
(5, 'Amit', 'Verma', 'amitv@company.com', '   9876500000', 'Sales');
```

---

# 📝 Practice Questions

1. Display **full names** of employees (`CONCAT`).
2. Show employee emails in **uppercase**.
3. Extract first 5 chars from employee emails.
4. Find employees whose phone **contains non-digit characters**.
5. Replace `@company.com` with `@corp.com` in all emails.
6. Count number of characters in each employee’s name.
7. Find employees whose last name **starts with 'S'**.
8. Trim spaces from phone numbers.
9. Reverse each employee’s first name.
10. Show departments and employees in each (`GROUP_CONCAT`).

---

## First: what `GROUP_CONCAT` actually does

Think of `GROUP_CONCAT` as:

> **“Take multiple rows → compress them into ONE string”**

But **the scope of compression depends on `GROUP BY`.**

---

## Query 1

```sql
SELECT GROUP_CONCAT(CONCAT(first_name,' '), dept)
FROM E
GROUP BY first_name;
```

### What happens conceptually

1. `GROUP BY first_name` splits the table into **multiple groups**
   - one group per unique `first_name`

2. For **each group**:
   - `GROUP_CONCAT(...)` is applied **independently**
   - rows inside the group are concatenated into **one string**

### Mental model

```
E table
↓
partition rows by first_name
↓
apply GROUP_CONCAT inside each partition
↓
one output row per first_name
```

### Result shape

| first_name | GROUP_CONCAT(...)  |
| ---------- | ------------------ |
| Alice      | Alice HR, Alice IT |
| Bob        | Bob Sales          |

👉 **Multiple rows returned — one per group**

---

## Query 2

```sql
SELECT GROUP_CONCAT(CONCAT(first_name,' '), dept)
FROM E;
```

### What happens conceptually

1. ❌ No `GROUP BY`
2. Entire table is treated as **one single group**
3. `GROUP_CONCAT` runs **once** over all rows

### Mental model

```
E table
↓
single implicit group (whole table)
↓
GROUP_CONCAT over all rows
↓
one single string
```

### Result shape

| GROUP_CONCAT(...)             |
| ----------------------------- |
| Alice HR, Alice IT, Bob Sales |

👉 **Exactly one row, one string**

---

## Core difference (this is the key insight)

| Aspect            | With `GROUP BY`     | Without `GROUP BY`  |
| ----------------- | ------------------- | ------------------- |
| Number of groups  | Many                | One                 |
| GROUP_CONCAT runs | Once per group      | Once total          |
| Rows returned     | Multiple            | One                 |
| Concept           | Reduce per category | Reduce entire table |

---

## Why your statement is correct

> **“first return concatenated row per group and return concatenated rows concatenated as a single string”**

Yes — precisely:

- **Query 1** → _“concatenate rows inside each group”_
- **Query 2** → _“concatenate all rows globally”_

---

## Important correction (syntax detail)

In MySQL, the usual syntax is:

```sql
GROUP_CONCAT(expr SEPARATOR ', ')
```

So more standard versions would be:

```sql
SELECT first_name,
       GROUP_CONCAT(dept SEPARATOR ', ')
FROM E
GROUP BY first_name;
```

and

```sql
SELECT GROUP_CONCAT(CONCAT(first_name, ' ', dept) SEPARATOR ', ')
FROM E;
```

---

## First-principle takeaway (very interview-relevant)

> **`GROUP BY` controls the “unit of aggregation”**
> Aggregate functions don’t decide scope — **GROUP BY does**

This applies to:

- `COUNT`
- `SUM`
- `AVG`
- `MAX / MIN`
- `GROUP_CONCAT`

---

## One-line rule to remember

> **No `GROUP BY` → whole table is one group**
> **With `GROUP BY` → one result row per group**

---

## First-principle definition of `COUNT(*)`

> **`COUNT(*)` returns the number of rows (tuples) in the current result set or group.**

Key word: **rows**, not values, not columns.

---

## Mental model (very important)

Think of SQL execution as producing an **intermediate table**:

```
FROM + JOIN + WHERE
↓
(filtered rows / tuples)
↓
GROUP BY (optional)
↓
aggregation functions (COUNT, SUM, etc.)
```

`COUNT(*)` operates **after filtering, after grouping**.

---

## Case 1: No `GROUP BY`

```sql
SELECT COUNT(*)
FROM E;
```

### What happens

- SQL takes **all rows in E**
- Counts how many tuples exist
- Returns **one number**

### Equivalent conceptual model

```
rows = [t1, t2, t3, t4]
COUNT(*) = length(rows) = 4
```

✔ Your “list of tuples → length” idea matches here.

---

## Case 2: With `WHERE`

```sql
SELECT COUNT(*)
FROM E
WHERE dept = 'HR';
```

### Execution logic

1. Remove rows where `dept != 'HR'`
2. Remaining tuples → count them

```
filtered_rows = [t1, t3]
COUNT(*) = 2
```

---

## Case 3: With `GROUP BY` (THIS IS THE BIG ONE)

```sql
SELECT dept, COUNT(*)
FROM E
GROUP BY dept;
```

### Conceptual model

1. Partition rows into groups
2. Apply `COUNT(*)` **inside each group**

```
HR     → [t1, t3] → COUNT = 2
IT     → [t2]     → COUNT = 1
Sales  → [t4]     → COUNT = 1
```

### Output

| dept  | COUNT(\*) |
| ----- | --------- |
| HR    | 2         |
| IT    | 1         |
| Sales | 1         |

---

## Crucial distinction: `COUNT(*)` vs `COUNT(column)`

### `COUNT(*)`

- Counts **rows**
- Includes rows with `NULL` in any column
- Does **not inspect column values**

### `COUNT(column)`

- Counts **non-NULL values in that column**
- Ignores rows where `column IS NULL`

#### Example

| id  | manager_id |
| --- | ---------- |
| 1   | 10         |
| 2   | NULL       |
| 3   | 11         |

```sql
COUNT(*)        → 3
COUNT(manager_id) → 2
```

---

## Why `COUNT(*)` is not literally “counting a list”

SQL engines **do not materialize lists** unless needed.

Internally:

- The engine increments a **counter**
- For each row produced by the execution plan

Conceptually:

```
counter = 0
for each row:
    counter++
```

But your abstraction — _“length of tuple list”_ — is **perfectly valid for reasoning**.

---

## Common misconception (important)

❌ `COUNT(*)` counts columns
❌ `COUNT(*)` counts non-NULL cells

✔ `COUNT(*)` counts **rows**

---

## First-principle one-liner

> **`COUNT(*)` = number of tuples in the current group or result set**

---

## Interview-level takeaway

If someone asks:

> _Why does `COUNT(_)` with GROUP BY return multiple rows?\*

Answer:

> Because `GROUP BY` defines multiple independent tuple sets, and `COUNT(*)` is applied to each set separately.

---
