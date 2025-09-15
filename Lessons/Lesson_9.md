# <span style="color:purple">**Pattern Matching in SQL**</span>

## 🔹 `LIKE` Operator in SQL

### 1. Syntax

```sql
SELECT column_name
FROM table_name
WHERE column_name LIKE pattern;
```

### 2. How Patterns Work

The **`LIKE`** operator uses **wildcards**:

- `%` → matches **zero or more characters**
- `_` → matches **exactly one character**

👉 Optional: some DBs (like PostgreSQL, Oracle) also allow character ranges `[ ]` inside `SIMILAR TO` or regex-like operators, but **basic SQL** usually sticks to `%` and `_`.

---

### 3. Examples

Suppose we have a `Customers` table:

| id  | name        | city      |
| --- | ----------- | --------- |
| 1   | Arjun Mehta | Mumbai    |
| 2   | Riya Sharma | Delhi     |
| 3   | Mohit Rao   | Chennai   |
| 4   | Ananya Roy  | New Delhi |
| 5   | Amit Kumar  | Bengaluru |

#### Example Queries:

```sql
-- Names starting with 'A'
SELECT name FROM Customers WHERE name LIKE 'A%';

-- Names ending with 'a'
SELECT name FROM Customers WHERE name LIKE '%a';

-- Names containing 'ya'
SELECT name FROM Customers WHERE name LIKE '%ya%';

-- Names where second letter is 'm'
SELECT name FROM Customers WHERE name LIKE '_m%';

-- Cities starting with 'New'
SELECT city FROM Customers WHERE city LIKE 'New%';
```

---

### 4. Best Practices

- Use `%` carefully:

  - `'%word%'` is expensive (can’t use index efficiently).
  - Prefer `'word%'` if possible.

- Case sensitivity depends on DB:

  - MySQL → case-insensitive by default.
  - PostgreSQL/Oracle → case-sensitive (use `ILIKE` in Postgres).

- Avoid overusing wildcards; for complex patterns use **regular expressions** (`REGEXP` in MySQL, `~` in Postgres).

---

### 5. Use Cases

- Searching for customers by partial name, email, phone number.
- Filtering addresses or products with a certain keyword.
- Finding records where format is known (e.g., phone number pattern).

---

### 6. Practice Database Schema

Let’s create a small schema `Employees`:

```sql
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    email VARCHAR(50)
);

INSERT INTO Employees VALUES
(1, 'Arjun Mehta', 'IT', 'arjun.mehta@company.com'),
(2, 'Riya Sharma', 'HR', 'riya.sharma@company.com'),
(3, 'Mohit Rao', 'Finance', 'mohit@company.com'),
(4, 'Ananya Roy', 'IT', 'ananya.roy@company.com'),
(5, 'Amit Kumar', 'Finance', 'amit.k@company.com'),
(6, 'Priya Nair', 'HR', 'priya.nair@company.com');
```

---

### 7. Practice Questions

1. Find all employees whose names start with **‘A’**.
2. Find employees whose email ends with **‘@company.com’**.
3. Find employees whose names have **‘ya’** in them.
4. Find employees where the **third letter in name is ‘i’**.
5. Find employees in **IT department** whose names end with **‘a’**.
6. Find all employees whose email **starts with their first name** (hint: `LIKE 'arjun%'`).

---

✅ Quick Check for You:
If you write

```sql
SELECT emp_name FROM Employees WHERE emp_name LIKE '__i%';
```

---

## 🔹 `REGEXP` Operator in SQL

### 1. Syntax

```sql
SELECT column_name
FROM table_name
WHERE column_name REGEXP 'pattern';
```

- Some databases use `RLIKE` as a synonym for `REGEXP`.
- Patterns are **regular expressions (regex)**, which are richer than simple `%` and `_`.

---

### 2. Techniques to Write Patterns

Regex lets us define complex matching rules. Common ones in SQL:

- **`.`** → matches **any single character**
- **`[...]`** → matches any character inside brackets
- **`[^...]`** → matches any character NOT inside brackets
- **`^`** → matches the **beginning** of string
- **`$`** → matches the **end** of string
- **`*`** → zero or more occurrences of preceding character
- **`+`** → one or more occurrences of preceding character
- **`?`** → zero or one occurrence of preceding character
- **`|`** → OR (alternative)
- **`{n,m}`** → between n and m repetitions

---

### 3. Examples

Suppose we have a `Users` table:

| id  | username   |
| --- | ---------- |
| 1   | arjun123   |
| 2   | riya_2024  |
| 3   | mohit\@dev |
| 4   | ananyaRoy  |
| 5   | amit       |
| 6   | Priya99    |

Queries:

```sql
-- Usernames starting with 'a'
SELECT username FROM Users WHERE username REGEXP '^a';

-- Usernames ending with digits
SELECT username FROM Users WHERE username REGEXP '[0-9]$';

-- Usernames containing only alphabets
SELECT username FROM Users WHERE username REGEXP '^[A-Za-z]+$';

-- Usernames containing 'riya' or 'priya'
SELECT username FROM Users WHERE username REGEXP 'riya|priya';

-- Usernames with special character '@'
SELECT username FROM Users WHERE username REGEXP '@';
```

---

### 4. Best Practices

- ✅ Use `^` and `$` when you need full match instead of partial match.
- ✅ Be explicit with character classes (`[A-Za-z0-9_]`).
- ⚠️ Avoid overly complex regex in frequently run queries (performance hit).
- ⚠️ Remember: regex syntax can differ slightly between databases (MySQL vs PostgreSQL vs Oracle).

---

### 5. Use Cases

- Validate data format (emails, phone numbers, postal codes).
- Search text fields for flexible matches.
- Clean data: identify rows with “bad” formats.
- Advanced filtering when `LIKE` is too limited.

---

### 6. Practice Database Schema

Let’s create a `Customers` table:

```sql
CREATE TABLE Customers (
    cust_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15)
);

INSERT INTO Customers VALUES
(1, 'Arjun Mehta', 'arjun.mehta@gmail.com', '9876543210'),
(2, 'Riya Sharma', 'riya_2024@yahoo.com', '9123456789'),
(3, 'Mohit Rao', 'mohit@company.org', '9999999999'),
(4, 'Ananya Roy', 'ananya.roy@company.com', '98-7654321'),
(5, 'Amit Kumar', 'amit123@company.com', '8000000000'),
(6, 'Priya Nair', 'priya.nair@company', 'abc12345');
```

---

### 7. Practice Questions

1. Find customers whose **email starts with 'a'**.
2. Find customers whose **email domain is gmail or yahoo**.
3. Find customers whose **phone contains only digits**.
4. Find customers whose **name ends with 'Roy' or 'Rao'**.
5. Find customers with **emails missing `.com`** at the end.
6. Find customers whose **phone number contains non-digit characters**.

---

✅ Quick Check for You:
Using the above table, what would this return?

```sql
SELECT name, email
FROM Customers
WHERE email REGEXP '^[A-Za-z0-9._%+-]+@gmail\\.com$';
```

---
