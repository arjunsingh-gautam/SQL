# <span style="color:#a7c957">**Lesson-5 SQL**</span>

## <span style="color:#0a9396">**Operators in SQL**</span>

SQL operators are symbols or keywords used to perform operations on data (columns, literals, or expressions). They are used in SELECT, WHERE, JOIN, and other clauses to filter, compare, calculate, or combine data.

## <span style="color:#0a9396">**Arithmatic Operators in SQL**</span>

### 1. What are Arithmetic Operators in SQL?

Arithmetic operators are used in SQL to perform **basic mathematical calculations** on numeric data types (`INT`, `DECIMAL`, `FLOAT`, etc.).

They work in **`SELECT`, `WHERE`, `ORDER BY`, `UPDATE`**, and other SQL clauses.

---

### 2. Arithmetic Operators & Their Rules

| Operator | Meaning             | Example  | Result                                                                    |
| -------- | ------------------- | -------- | ------------------------------------------------------------------------- |
| `+`      | Addition            | `10 + 5` | `15`                                                                      |
| `-`      | Subtraction         | `10 - 5` | `5`                                                                       |
| `*`      | Multiplication      | `10 * 5` | `50`                                                                      |
| `/`      | Division            | `10 / 5` | `2`                                                                       |
| `%`      | Modulus (remainder) | `10 % 3` | `1` (works in SQL Server, Oracle uses `MOD()`, MySQL uses `MOD()` or `%`) |

---

### 3. Evaluation Rules (Operator Precedence)

Just like in mathematics (BODMAS/PEMDAS):

1. **Parentheses `()`** are evaluated first.
2. Then **Multiplication `*`, Division `/`, Modulus `%`**.
3. Then **Addition `+`, Subtraction `-`**.
4. Left-to-right for operators with the same precedence.

✅ Example:

```sql
SELECT 10 + 5 * 2 AS Result;
```

👉 Output = `20` (since `5*2=10`, then `10+10=20`)
Not `30`.

To change evaluation order:

```sql
SELECT (10 + 5) * 2 AS Result;
```

👉 Output = `30`.

---

### 4. Syntax

```sql
SELECT column1 + column2 AS Sum,
       column1 - column2 AS Difference,
       column1 * column2 AS Product,
       column1 / column2 AS Quotient,
       column1 % column2 AS Remainder
FROM table_name;
```

---

### 5. Use Cases

### ✅ Example 1: Salary Increment

```sql
SELECT EmpID, Name, Salary, Salary * 1.10 AS NewSalary
FROM Employees;
```

👉 Calculates a **10% increment**.

---

### ✅ Example 2: Discount on Products

```sql
SELECT ProductName, Price, Price - (Price * 0.20) AS DiscountedPrice
FROM Products;
```

👉 Apply **20% discount**.

---

### ✅ Example 3: Checking Remainder

```sql
SELECT OrderID, Quantity
FROM Orders
WHERE Quantity % 2 = 0;
```

👉 Get orders where **quantity is even**.

---

### ✅ Example 4: Safe Division (Avoid Divide by Zero)

```sql
SELECT OrderID,
       CASE WHEN Quantity = 0 THEN NULL
            ELSE TotalAmount / Quantity
       END AS PricePerUnit
FROM Orders;
```

👉 Prevents **divide-by-zero errors**.

---

### 6. Best Practices & Precautions

✅ **Use parentheses `()`** for clarity, even if not required.
✅ **Watch out for `NULL` values** → any arithmetic with `NULL` returns `NULL`.
Example: `10 + NULL = NULL`.
Handle with `COALESCE()`:

```sql
SELECT Price + COALESCE(Discount, 0) FROM Products;
```

✅ **Avoid division by zero** → use `CASE` or `NULLIF()`.

```sql
SELECT Total / NULLIF(Quantity, 0) FROM Orders;
```

✅ Be aware of **integer vs decimal division**.

- In SQL Server: `10 / 3 = 3` (integer division if both are integers).
- Use decimal cast: `10.0 / 3 = 3.3333`.
  ✅ **Check portability**: `%` operator may not work in all RDBMS (use `MOD()` in Oracle/MySQL).
  ✅ **Use aliases (`AS`)** to make results readable.

---

# ✨ Summary

- Arithmetic operators: `+`, `-`, `*`, `/`, `%`.
- Follow **mathematical precedence rules** (BODMAS).
- Use in `SELECT`, `WHERE`, `ORDER BY`, `UPDATE`.
- Handle `NULL` and `divide-by-zero`.
- Use parentheses and aliases for clarity.

---

## <span style="color:#0a9396">**Comparison Operators in SQL**</span>

### 1. What are Comparison Operators?

Comparison operators in SQL are used to **compare two expressions (column values, constants, or expressions)** and return a **Boolean result (`TRUE`, `FALSE`, or `UNKNOWN` when `NULL` is involved)**.

They are mostly used in:

- `WHERE` clause (filtering)
- `HAVING` clause (group filtering)
- `JOIN` conditions
- `CASE` expressions

---

### 2. List of Comparison Operators

| Operator              | Meaning                    | Example                              | Result                            |
| --------------------- | -------------------------- | ------------------------------------ | --------------------------------- |
| `=`                   | Equal to                   | `Price = 100`                        | TRUE if Price = 100               |
| `<>` / `!=`           | Not equal to               | `Price <> 100`                       | TRUE if Price is not 100          |
| `>`                   | Greater than               | `Salary > 5000`                      | TRUE if Salary > 5000             |
| `<`                   | Less than                  | `Age < 18`                           | TRUE if Age is less than 18       |
| `>=`                  | Greater than or equal to   | `Marks >= 50`                        | TRUE if Marks ≥ 50                |
| `<=`                  | Less than or equal to      | `Marks <= 50`                        | TRUE if Marks ≤ 50                |
| `BETWEEN … AND …`     | Within a range (inclusive) | `Age BETWEEN 18 AND 30`              | TRUE if Age is 18–30              |
| `NOT BETWEEN … AND …` | Outside a range            | `Salary NOT BETWEEN 20000 AND 50000` | TRUE if Salary < 20000 or > 50000 |
| `IN (…)`              | Match any from a list      | `Dept IN ('HR','IT')`                | TRUE if Dept is HR or IT          |
| `NOT IN (…)`          | Not in list                | `Dept NOT IN ('HR','IT')`            | TRUE if Dept is not HR or IT      |
| `LIKE`                | Pattern matching           | `Name LIKE 'A%'`                     | Names starting with A             |
| `NOT LIKE`            | Exclude pattern            | `Name NOT LIKE '%x'`                 | Names not ending with x           |
| `IS NULL`             | Checks NULL                | `Email IS NULL`                      | TRUE if Email has no value        |
| `IS NOT NULL`         | Checks not NULL            | `Email IS NOT NULL`                  | TRUE if Email has value           |

---

### 3. Evaluation Rules

1. **NULL handling**:

   - Any comparison with `NULL` returns `UNKNOWN` (not `TRUE`/`FALSE`).
     Example: `Salary = NULL` → always `UNKNOWN`.
     Use `IS NULL` or `IS NOT NULL` instead.

2. **Precedence**:

   - Arithmetic (`+ - * /`) is evaluated before comparison.
     Example:

   ```sql
   SELECT * FROM Employees WHERE Salary + Bonus > 50000;
   ```

3. **Set-based operators (`IN`, `BETWEEN`)** are evaluated after individual comparisons.

4. Comparisons are **case-sensitive or case-insensitive** depending on the database collation (MySQL is case-insensitive by default for text).

---

### 4. Syntax

```sql
SELECT column1, column2
FROM table_name
WHERE column1 operator value;
```

Examples:

```sql
WHERE Salary > 50000
WHERE Dept IN ('HR','Finance')
WHERE Age BETWEEN 18 AND 30
WHERE Name LIKE 'J%'
```

---

### 5. Use Cases

### ✅ Example 1: Filtering by salary

```sql
SELECT EmpID, Name, Salary
FROM Employees
WHERE Salary >= 60000;
```

### ✅ Example 2: Range search

```sql
SELECT * FROM Students
WHERE Marks BETWEEN 50 AND 75;
```

### ✅ Example 3: Pattern matching

```sql
SELECT * FROM Customers
WHERE Email LIKE '%@gmail.com';
```

### ✅ Example 4: NULL check

```sql
SELECT * FROM Orders
WHERE ShippedDate IS NULL;
```

### ✅ Example 5: Multiple conditions

```sql
SELECT * FROM Employees
WHERE Dept IN ('IT','Finance') AND Age < 30;
```

---

### 6. Best Practices & Precautions

✅ **Use `IS NULL` / `IS NOT NULL`** instead of `= NULL` or `<> NULL`.
✅ **Avoid `NOT IN` with NULL values** — it can return unexpected results. Use `NOT EXISTS` instead.

```sql
-- Risky
WHERE Dept NOT IN (SELECT Dept FROM Employees);
-- Better
WHERE NOT EXISTS (SELECT 1 FROM Employees e WHERE e.Dept = d.Dept);
```

✅ Use **`BETWEEN` for inclusive ranges**, but be careful with dates (`BETWEEN '2025-01-01' AND '2025-01-31'` includes both ends).
✅ Use **`LIKE` carefully**:

- `'A%'` = starts with A
- `'%A'` = ends with A
- `'%A%'` = contains A
  But it is **slow** for large data (no index use). Prefer **full-text search** if needed.
  ✅ Prefer **`IN`** over multiple `OR` conditions for readability.

```sql
-- Better
WHERE Dept IN ('HR','IT','Finance')
-- Instead of
WHERE Dept = 'HR' OR Dept = 'IT' OR Dept = 'Finance'
```

✅ Be aware of **case sensitivity** based on DB collation.
✅ Always test comparisons involving **dates and times** carefully (boundary values, time zones).

---

# ✨ Summary

- Comparison operators (`=, <>, >, <, >=, <=, IN, BETWEEN, LIKE, IS NULL`) return `TRUE/FALSE/UNKNOWN`.
- They are widely used in `WHERE`, `HAVING`, and `JOIN`.
- Handle `NULL` values correctly (`IS NULL` instead of `= NULL`).
- Use parentheses for clarity in complex conditions.
- Be cautious with performance when using `LIKE '%pattern%'`.

---

## <span style="color:#0a9396">**Logical Operators in SQL**</span>

### 1. What are Logical Operators?

Logical operators in SQL are used to **combine multiple conditions** in queries.
They return a **Boolean result (`TRUE`, `FALSE`, or `UNKNOWN`)**.

They are mostly used in:

- `WHERE` clause
- `HAVING` clause
- `CASE` expressions
- `JOIN` conditions

---

### 2. Types of Logical Operators

| Operator       | Meaning                                                | Example                                                         | Result                                            |
| -------------- | ------------------------------------------------------ | --------------------------------------------------------------- | ------------------------------------------------- |
| `AND`          | TRUE if **all** conditions are TRUE                    | `Salary > 50000 AND Dept = 'IT'`                                | TRUE only if both are true                        |
| `OR`           | TRUE if **at least one** condition is TRUE             | `Dept = 'IT' OR Dept = 'HR'`                                    | TRUE if either is true                            |
| `NOT`          | Reverses result of a condition                         | `NOT (Age < 18)`                                                | TRUE if Age ≥ 18                                  |
| `ALL`          | Compares a value with all values of a subquery         | `Salary > ALL (SELECT Salary FROM Interns)`                     | TRUE if greater than every intern’s salary        |
| `ANY` / `SOME` | Compares a value with at least one value from subquery | `Salary > ANY (SELECT Salary FROM Interns)`                     | TRUE if greater than at least one intern’s salary |
| `EXISTS`       | Checks if a subquery returns rows                      | `EXISTS (SELECT 1 FROM Orders WHERE CustomerID = C.CustomerID)` | TRUE if at least one row exists                   |

---

### 3. Evaluation Rules

✅ **Truth Table (3-valued logic in SQL: `TRUE`, `FALSE`, `UNKNOWN`)**

### `AND`

| A       | B       | A AND B |
| ------- | ------- | ------- |
| TRUE    | TRUE    | TRUE    |
| TRUE    | FALSE   | FALSE   |
| FALSE   | TRUE    | FALSE   |
| FALSE   | FALSE   | FALSE   |
| TRUE    | UNKNOWN | UNKNOWN |
| FALSE   | UNKNOWN | FALSE   |
| UNKNOWN | TRUE    | UNKNOWN |
| UNKNOWN | FALSE   | FALSE   |
| UNKNOWN | UNKNOWN | UNKNOWN |

### `OR`

| A       | B       | A OR B  |
| ------- | ------- | ------- |
| TRUE    | TRUE    | TRUE    |
| TRUE    | FALSE   | TRUE    |
| FALSE   | TRUE    | TRUE    |
| FALSE   | FALSE   | FALSE   |
| TRUE    | UNKNOWN | TRUE    |
| FALSE   | UNKNOWN | UNKNOWN |
| UNKNOWN | TRUE    | TRUE    |
| UNKNOWN | FALSE   | UNKNOWN |
| UNKNOWN | UNKNOWN | UNKNOWN |

### `NOT`

| A       | NOT A   |
| ------- | ------- |
| TRUE    | FALSE   |
| FALSE   | TRUE    |
| UNKNOWN | UNKNOWN |

---

### 4. Short-Circuit Evaluation Rule

SQL **evaluates logical expressions left-to-right** and may **stop early** if result is already known:

- For `AND`: If the first condition is `FALSE`, SQL **does not check** the rest (because overall result will be `FALSE`).
- For `OR`: If the first condition is `TRUE`, SQL **does not check** the rest (because overall result will be `TRUE`).

⚡ This improves performance when queries are written smartly.

---

### 5. Syntax

```sql
SELECT column1, column2
FROM table_name
WHERE condition1 [AND|OR|NOT] condition2;
```

Examples:

```sql
-- AND
WHERE Salary > 50000 AND Dept = 'IT';

-- OR
WHERE Age < 18 OR Age > 60;

-- NOT
WHERE NOT (Dept = 'HR');

-- EXISTS
WHERE EXISTS (SELECT 1 FROM Orders WHERE Orders.CustomerID = Customers.CustomerID);

-- ALL
WHERE Salary > ALL (SELECT Salary FROM Interns);

-- ANY
WHERE Salary > ANY (SELECT Salary FROM Employees WHERE Dept = 'Finance');
```

---

### 6. Use Cases

✅ **Filtering rows with multiple conditions**

```sql
SELECT * FROM Employees
WHERE Dept = 'IT' AND Salary > 60000;
```

✅ **Checking ranges with OR**

```sql
SELECT * FROM Students
WHERE Grade = 'A' OR Grade = 'B';
```

✅ **Negating condition**

```sql
SELECT * FROM Products
WHERE NOT (Price BETWEEN 100 AND 500);
```

✅ **Checking existence**

```sql
SELECT * FROM Customers c
WHERE EXISTS (SELECT 1 FROM Orders o WHERE o.CustomerID = c.CustomerID);
```

✅ **Comparing against all/any**

```sql
-- Highest salary check
SELECT * FROM Employees
WHERE Salary >= ALL (SELECT Salary FROM Employees WHERE Dept = 'HR');
```

---

### 7. Best Practices & Precautions

✅ **Use parentheses `()`** for clarity with multiple logical operators.

```sql
-- Ambiguous
WHERE Age > 18 AND Age < 30 OR Dept = 'IT'

-- Clear
WHERE (Age > 18 AND Age < 30) OR Dept = 'IT'
```

✅ Place **most restrictive condition first** (to benefit from short-circuit evaluation).

```sql
-- Better: Salary check first (likely fails fast)
WHERE Salary > 100000 AND Dept = 'HR';
```

✅ Avoid mixing **NULLs** without handling (`IS NULL` / `IS NOT NULL`).

```sql
-- Wrong
WHERE Salary = NULL
-- Correct
WHERE Salary IS NULL
```

✅ Use `EXISTS` instead of `IN` for large subqueries (performance gain).

```sql
-- Slower
WHERE CustomerID IN (SELECT CustomerID FROM Orders)

-- Faster
WHERE EXISTS (SELECT 1 FROM Orders o WHERE o.CustomerID = c.CustomerID)
```

✅ Use `ALL` and `ANY` carefully — they are powerful but often slower; use aggregates (`MAX`, `MIN`) when possible.

✅ Always test **logical operator precedence**:

- `NOT` → highest
- `AND` → medium
- `OR` → lowest

---

# ✨ Summary

- Logical operators (`AND, OR, NOT, ALL, ANY, EXISTS`) combine conditions.
- SQL uses **3-valued logic (TRUE, FALSE, UNKNOWN)**.
- **Short-circuiting** stops evaluation early for performance.
- Always use **parentheses, IS NULL, EXISTS** for clarity and correctness.
- Be careful with `NULL`, as it can change expected outcomes.

---

## <span style="color:#0a9396">**Bitwise Operators in SQL**</span>

### 1. What are Bitwise Operators in SQL?

Bitwise operators operate on the **binary representation (bits)** of integers.
They **compare/manipulate each bit** individually (unlike arithmetic or logical operators which work on whole values).

They are used mainly when working with **flags, permissions, status codes, compression, and low-level operations**.

---

### 2. Bitwise Operators in SQL

| Operator | Meaning                      | Example                  | Result (Binary → Decimal)            |     |     |                        |
| -------- | ---------------------------- | ------------------------ | ------------------------------------ | --- | --- | ---------------------- |
| `&`      | Bitwise AND                  | `6 & 3`                  | `110 & 011 = 010 → 2`                |     |     |                        |
| \`       | `(or sometimes`              | `/`OR\` depending on DB) | Bitwise OR                           | \`6 | 3\` | `110 OR 011 = 111 → 7` |
| `^`      | Bitwise XOR (exclusive OR)   | `6 ^ 3`                  | `110 XOR 011 = 101 → 5`              |     |     |                        |
| `~`      | Bitwise NOT (complement)     | `~6`                     | flips bits of 6 (DB-specific result) |     |     |                        |
| `<<`     | Left shift (multiply by 2^n) | `6 << 1`                 | `110 → 1100 = 12`                    |     |     |                        |
| `>>`     | Right shift (divide by 2^n)  | `6 >> 1`                 | `110 → 011 = 3`                      |     |     |                        |

⚠️ Note: Some RDBMS (like MySQL, SQL Server, PostgreSQL) support all these operators, but **Oracle only supports `BITAND()` function** (not the usual operators).

---

### 3. Evaluation Rules

- Works only on **integer types** (INT, BIGINT, SMALLINT, etc.).
- Operands are converted into **binary**.
- Each corresponding bit is compared and result stored back as integer.
- `NULL` with bitwise operator → result is `NULL`.

Example:

```sql
SELECT 6 & 3 AS BitwiseAND, 6 | 3 AS BitwiseOR, 6 ^ 3 AS BitwiseXOR;
```

Output:

```
BitwiseAND = 2
BitwiseOR  = 7
BitwiseXOR = 5
```

---

### 4. Syntax

```sql
-- AND
SELECT value1 & value2;

-- OR
SELECT value1 | value2;

-- XOR
SELECT value1 ^ value2;

-- NOT
SELECT ~value;

-- Left Shift
SELECT value << shift_amount;

-- Right Shift
SELECT value >> shift_amount;
```

---

### 5. Use Cases

✅ **Checking flags/permissions (bitmasking)**
Suppose we store access rights as bits:

- 1 = Read, 2 = Write, 4 = Execute

User with rights = `5 (101 binary)` → Read + Execute.

```sql
-- Check if user has Execute permission
SELECT CASE WHEN (Permissions & 4) > 0 THEN 'Yes' ELSE 'No' END AS CanExecute
FROM Users;
```

✅ **Combining multiple flags**

```sql
-- Give Read + Write access
SELECT 1 | 2; -- Result = 3 (binary 011)
```

✅ **Efficient storage**
Instead of storing multiple boolean columns (`is_admin`, `can_edit`, `can_view`),
we can use one integer with bit flags.

✅ **Performance tricks**
Used in indexing, compression, hashing, low-level database functions.

✅ **Shifts for fast math**

```sql
SELECT 5 << 1; -- 5*2 = 10
SELECT 20 >> 2; -- 20/4 = 5
```

---

### 6. Best Practices & Precautions

✔ **Use only on integers** → Avoid applying on floating types.
✔ **Be careful with NOT (`~`)** → Different databases may handle signed integers differently (2’s complement representation).
✔ **Document bitmask meanings** → Store mapping of flags (1=Read, 2=Write, etc.) in metadata tables.
✔ **Prefer readability over compactness** → Bitwise logic can confuse teammates; comment your queries.
✔ **Indexing caution** → Bitwise operations in `WHERE` clauses may **prevent index usage** (can slow down queries).
✔ **Cross-database portability** → Not all RDBMS support full set (Oracle uses `BITAND()` instead of `&`).

---

# ✨ Summary

- **Bitwise operators** manipulate integer values at binary level.
- Useful for **flags, permissions, compact data storage, fast math (shift)**.
- Must be used with care (readability, indexing, portability issues).
- Very powerful in **system-level databases, security, and performance tuning**.

---

## <span style="color:#0a9396">**Set Operators in SQL**</span>

Perfect question 👍 Let’s go deep into **Set Operators in SQL**.

---

### 1. What are Set Operators in SQL?

Set operators are used to **combine the results of two or more `SELECT` statements** into a single result set.

They treat query results as **sets** (like in mathematics) and apply union, intersection, or difference rules.

---

### 2. Types of Set Operators

Most RDBMS support these 4 main set operators:

| Operator                        | Meaning                                     | Duplicate Handling |
| ------------------------------- | ------------------------------------------- | ------------------ |
| `UNION`                         | Combines results of both queries            | Removes duplicates |
| `UNION ALL`                     | Combines results of both queries            | Keeps duplicates   |
| `INTERSECT`                     | Returns common rows from both queries       | Removes duplicates |
| `EXCEPT` (or `MINUS` in Oracle) | Returns rows from first query not in second | Removes duplicates |

---

### 3. Evaluation Rules

1. **Number of Columns must match** in all queries.

   ```sql
   SELECT col1, col2 FROM table1
   UNION
   SELECT colA, colB FROM table2; -- OK (both 2 columns)
   ```

2. **Data types must be compatible** in corresponding columns (e.g., INT with INT, VARCHAR with VARCHAR).

3. **Column names in final result** come from the first `SELECT` query.

4. By default, **duplicates are removed** (`UNION`, `INTERSECT`, `EXCEPT`).
   Use `ALL` if you want duplicates preserved.

5. Set operators apply **after WHERE, GROUP BY, HAVING**, but before `ORDER BY`.
   Only one final `ORDER BY` is allowed at the end of the entire query.

---

### 4. Syntax

```sql
-- UNION
SELECT column_list FROM table1
UNION
SELECT column_list FROM table2;

-- UNION ALL
SELECT column_list FROM table1
UNION ALL
SELECT column_list FROM table2;

-- INTERSECT
SELECT column_list FROM table1
INTERSECT
SELECT column_list FROM table2;

-- EXCEPT (SQL Server / PostgreSQL) or MINUS (Oracle)
SELECT column_list FROM table1
EXCEPT
SELECT column_list FROM table2;
```

---

### 5. Use Cases

✅ **`UNION` / `UNION ALL` → Combine multiple sources**

```sql
-- Get all customer IDs from online and offline sales
SELECT CustomerID FROM OnlineSales
UNION
SELECT CustomerID FROM StoreSales;
```

✅ **`INTERSECT` → Find common records**

```sql
-- Customers who bought both online and offline
SELECT CustomerID FROM OnlineSales
INTERSECT
SELECT CustomerID FROM StoreSales;
```

✅ **`EXCEPT` (or `MINUS`) → Find differences**

```sql
-- Customers who bought online but not offline
SELECT CustomerID FROM OnlineSales
EXCEPT
SELECT CustomerID FROM StoreSales;
```

✅ **`UNION ALL` → Keep duplicates** (e.g., frequency analysis)

```sql
-- Count total purchases from both sources
SELECT CustomerID FROM OnlineSales
UNION ALL
SELECT CustomerID FROM StoreSales;
```

---

### 6. Best Practices & Precautions

✔ **Use `UNION ALL` when duplicates don’t matter** – it is faster (avoids costly duplicate elimination).
✔ **Ensure column compatibility** – mismatched datatypes cause errors.
✔ **Use meaningful column aliases** in the first `SELECT` (since result takes column names from it).
✔ **Filter early** – apply `WHERE` before set operator to reduce data processed.
✔ **Be cautious with performance** – set operators may require sorting & deduplication.
✔ **Indexing** – ensure columns involved are indexed for faster comparisons.
✔ **Use `EXCEPT`/`INTERSECT` carefully** – not available in older versions of MySQL (requires `JOIN` workaround).

---

# ✨ Quick Summary

- **Set operators** = combine results of multiple `SELECT` queries.
- **UNION / UNION ALL** → combine rows (duplicates removed vs kept).
- **INTERSECT** → common rows.
- **EXCEPT / MINUS** → difference.
- Must have **same number of columns & compatible datatypes**.
- Use **ALL** for performance when duplicates are not a concern.

---

Great question 👍 — Let’s cover **Special & Remaining Operators in SQL** in detail.
These are operators that don’t fall into **Arithmetic, Comparison, Logical, Bitwise, or Set** categories, but are still widely used in SQL.

---

## <span style="color:#0a9396">**Special Operators in SQL**</span>

### 1. Types of Special / Remaining Operators

| Operator                  | Meaning                                        | Example                                   |
| ------------------------- | ---------------------------------------------- | ----------------------------------------- |
| `IN`                      | Check if value exists in a list/subquery       | `WHERE dept_id IN (1,2,3)`                |
| `BETWEEN`                 | Check if value lies within a range             | `salary BETWEEN 3000 AND 8000`            |
| `LIKE`                    | Pattern matching with wildcards (`%`, `_`)     | `name LIKE 'A%'`                          |
| `IS NULL` / `IS NOT NULL` | Check for NULL values                          | `WHERE phone IS NULL`                     |
| `EXISTS`                  | Check if a subquery returns rows               | `WHERE EXISTS (SELECT 1 …)`               |
| `ANY`                     | Compare a value with any result from subquery  | `salary > ANY (SELECT salary FROM dept2)` |
| `ALL`                     | Compare a value with all results from subquery | `salary > ALL (SELECT salary FROM dept2)` |

---

### 2. Evaluation Rules

1. **`IN`** works like multiple OR conditions.

   - `x IN (1,2,3)` → equivalent to `(x=1 OR x=2 OR x=3)`

2. **`BETWEEN`** is inclusive of boundary values.

   - `BETWEEN a AND b` = `>= a AND <= b`

3. **`LIKE`** uses wildcards:

   - `%` → any number of characters
   - `_` → exactly one character
   - `[ ]` → character range (in some DBs, like SQL Server)

4. **`IS NULL`** needed because `NULL` cannot be compared with `=, <, >`.

   - `x = NULL` ❌ Wrong → must use `x IS NULL`

5. **`EXISTS`** returns TRUE if subquery returns **at least one row**.

   - Often used with correlated subqueries.

6. **`ANY` / `ALL`** compare values against subquery results.

   - `= ANY` → same as `IN`.
   - `> ALL` → greater than the maximum value.

---

### 3. Syntax & Examples

✅ **IN**

```sql
SELECT * FROM Employees
WHERE DepartmentID IN (1, 3, 5);
```

✅ **BETWEEN**

```sql
SELECT * FROM Employees
WHERE Salary BETWEEN 3000 AND 8000;
```

✅ **LIKE**

```sql
SELECT * FROM Customers
WHERE Name LIKE 'A%';   -- Names starting with A
```

✅ **IS NULL**

```sql
SELECT * FROM Employees
WHERE ManagerID IS NULL;
```

✅ **EXISTS**

```sql
SELECT * FROM Customers c
WHERE EXISTS (SELECT 1 FROM Orders o WHERE o.CustomerID = c.CustomerID);
```

✅ **ANY**

```sql
SELECT * FROM Employees
WHERE Salary > ANY (SELECT Salary FROM Employees WHERE DepartmentID = 2);
-- Employee earning more than at least one person in dept 2
```

✅ **ALL**

```sql
SELECT * FROM Employees
WHERE Salary > ALL (SELECT Salary FROM Employees WHERE DepartmentID = 2);
-- Employee earning more than everyone in dept 2
```

---

### 4. Use Cases

- **IN** → Filtering against a predefined set or subquery.
- **BETWEEN** → Range-based filtering (salaries, dates).
- **LIKE** → Searching text/patterns.
- **IS NULL** → Handling missing data.
- **EXISTS** → Checking relationships (customers with orders).
- **ANY / ALL** → Advanced comparisons with subqueries.

---

### 5. Best Practices & Precautions

✔ **Use `IN` for short lists**, but for long lists use `JOIN` with a lookup table for performance.
✔ **Avoid `NOT IN` with NULLs** → leads to unexpected results. Prefer `NOT EXISTS`.
✔ **Use `BETWEEN` carefully** with dates → remember it includes both ends (may cause off-by-one issues with timestamps).
✔ **Use `LIKE` with caution** → leading wildcard (`%abc`) disables index usage (slow).
✔ Prefer **`EXISTS` over `IN`** when subquery is large → `EXISTS` stops at first match, `IN` checks all values.
✔ **ANY / ALL** are powerful but less readable → use only if really needed, otherwise rewrite with `MIN` / `MAX`.

---

✅ **Quick Summary**

- **IN** = multiple ORs
- **BETWEEN** = range check (inclusive)
- **LIKE** = pattern matching
- **IS NULL** = test for NULLs
- **EXISTS** = check if subquery returns rows
- **ANY / ALL** = compare against subquery result set

---
