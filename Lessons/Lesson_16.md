style="color:#a7c957">**Lesson-16 SQL**</span>

## 🔹 What are String Functions?

* **String functions** are built-in SQL functions to manipulate, search, and transform text data.
* They take `CHAR`, `VARCHAR`, or `TEXT` as input and return a processed value.
* Used heavily in reporting, formatting, cleaning raw data, or building search queries.

---

## ✅ Common String Functions in MySQL

---

### 1. **LENGTH() / CHAR\_LENGTH()**

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

* Output → `5, 5`
* ⚠️ For multibyte chars (e.g., emojis), `LENGTH` ≠ `CHAR_LENGTH`.

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

### 3. **CONCAT() / CONCAT\_WS()**

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

### 11. **FIELD() / FIND\_IN\_SET()**

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

### 12. **GROUP\_CONCAT()**

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

* **Performance-heavy** on large text columns.
* `LENGTH` vs `CHAR_LENGTH` confusion in multibyte text.
* Case-sensitivity depends on collation.
* `GROUP_CONCAT` has length limit (`group_concat_max_len`).

---

## 🎯 Use Cases

* Formatting names, emails, IDs.
* Cleaning messy data (trimming spaces, replacing substrings).
* Pattern matching in validation (`LIKE`, `REGEXP`).
* Reporting (`GROUP_CONCAT`, padding).

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


