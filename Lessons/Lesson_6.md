# <span style="color:#a7c957">**Lesson-6 SQL**</span>

## <span style="color:#0a9396">**DML Commands in SQL**</span>

### What are DML Commands?

- **DML (Data Manipulation Language)** are SQL commands used to **manipulate (insert, modify, delete, and retrieve)** data stored in a database.
- They do **not change the structure** of the database objects (tables, schema, etc.) — only the **data inside tables**.
- Most DML operations are **transactional** (can be rolled back/committed).

---

### List of DML Commands

| Command  | Purpose                                          |
| -------- | ------------------------------------------------ |
| `SELECT` | Retrieve data from a table                       |
| `INSERT` | Insert new records into a table                  |
| `UPDATE` | Modify existing records in a table               |
| `DELETE` | Remove records from a table                      |
| `MERGE`  | Insert or update depending on condition (upsert) |

---

### 1. `SELECT` (Retrieve Data)

📌 **Syntax:**

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
ORDER BY column
LIMIT n;
```

📌 **Example:**

```sql
SELECT FirstName, Salary
FROM Employees
WHERE DepartmentID = 10
ORDER BY Salary DESC;
```

📌 **Use cases:**

- Fetching employee salary details
- Reporting and analytics
- Filtering data with `WHERE`, sorting with `ORDER BY`, aggregation with `GROUP BY`.

---

### 2. `INSERT` (Insert Data)

📌 **Syntax:**

```sql
INSERT INTO table_name (col1, col2, col3, ...)
VALUES (val1, val2, val3, ...);

-- Insert multiple rows
INSERT INTO table_name (col1, col2)
VALUES (val1, val2),
       (val3, val4);
```

📌 **Example:**

```sql
INSERT INTO Employees (EmpID, FirstName, Salary, DepartmentID)
VALUES (101, 'Arjun', 50000, 10);
```

📌 **Use cases:**

- Adding new employee records
- Bulk data loading
- Importing data from another system.

---

### 3. `UPDATE` (Modify Existing Data)

📌 **Syntax:**

```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

📌 **Example:**

```sql
UPDATE Employees
SET Salary = Salary * 1.1
WHERE DepartmentID = 10;
```

📌 **Use cases:**

- Increasing salaries by 10% for a department
- Correcting spelling errors in names
- Changing product prices.

⚠️ **Precaution**: Always use `WHERE`. Without it, **all rows** get updated.

---

### 4. `DELETE` (Remove Records)

📌 **Syntax:**

```sql
DELETE FROM table_name
WHERE condition;
```

📌 **Example:**

```sql
DELETE FROM Employees
WHERE EmpID = 101;
```

📌 **Use cases:**

- Removing employees who left
- Cleaning up invalid records
- Purging test data.

⚠️ **Precaution**: Without `WHERE`, **all rows are deleted** (similar to `TRUNCATE` but logged).

---

### 5. `MERGE` (UPSERT → Insert or Update)

📌 **Syntax:**

```sql
MERGE INTO target_table t
USING source_table s
ON (t.id = s.id)
WHEN MATCHED THEN
    UPDATE SET t.col1 = s.col1
WHEN NOT MATCHED THEN
    INSERT (id, col1) VALUES (s.id, s.col1);
```

📌 **Example:**

```sql
MERGE INTO Employees t
USING NewEmployees s
ON (t.EmpID = s.EmpID)
WHEN MATCHED THEN
    UPDATE SET t.Salary = s.Salary
WHEN NOT MATCHED THEN
    INSERT (EmpID, FirstName, Salary, DepartmentID)
    VALUES (s.EmpID, s.FirstName, s.Salary, s.DepartmentID);
```

📌 **Use cases:**

- Synchronizing two tables (staging → production)
- Data warehousing (upserts)
- Handling slowly changing dimensions.

---

### Best Practices & Precautions for DML

✔ Always use `WHERE` in `UPDATE` & `DELETE` to avoid unintended full-table modifications.
✔ Use **transactions** (`BEGIN`, `COMMIT`, `ROLLBACK`) when applying large updates/deletes.
✔ Prefer `MERGE` for synchronization rather than multiple `INSERT` + `UPDATE`.
✔ Use `SELECT` with `LIMIT` (or `TOP`) to test queries before applying large changes.
✔ Use `INSERT ... SELECT` for bulk inserts instead of row-by-row insertion.
✔ Consider performance → `DELETE` is logged row-by-row (slow for large datasets), while `TRUNCATE` is faster.

---

✅ **Summary:**

- DML = Data Manipulation Language
- Main commands → `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `MERGE`
- They deal only with **data inside tables**, not structure.
- Use carefully with `WHERE` and transactions to prevent data loss.

---

## <span style="color:#0a9396">**DELETE vs DROP vs TRUNCATE**</span>

Perfect 👌 this is a **very common interview question**. Let’s go deep into **DELETE vs TRUNCATE vs DROP** in SQL.

---

### 1. **DELETE**

- **Definition**: DML (Data Manipulation Language) command used to remove **specific rows** from a table.
- **Syntax**:

```sql
DELETE FROM table_name WHERE condition;
```

- **Example**:

```sql
DELETE FROM Employees WHERE DepartmentID = 10;
```

- **Key Points**:

  - Deletes **row-by-row** (logged in transaction log).
  - Can use `WHERE` clause to filter.
  - Can be **rolled back** if inside a transaction.
  - Table structure, schema, and indexes remain intact.
  - Triggers (`AFTER DELETE`) **do fire**.

---

### 2. **TRUNCATE**

- **Definition**: DDL (Data Definition Language) command used to **remove all rows** from a table (but keep structure).
- **Syntax**:

```sql
TRUNCATE TABLE table_name;
```

- **Example**:

```sql
TRUNCATE TABLE Employees;
```

- **Key Points**:

  - Removes all rows (faster than `DELETE`).
  - Cannot use `WHERE`.
  - **Minimal logging** (deallocation of data pages instead of row-by-row logging).
  - Cannot be used if the table is referenced by a **foreign key constraint**.
  - Table structure remains → can still insert new rows.
  - Triggers (`AFTER DELETE`) usually **do not fire**.
  - Transactional (can rollback in most DBMS like SQL Server, Oracle, but not all).

---

### 3. **DROP**

- **Definition**: DDL command that completely **removes a database object** (table, view, index, schema, database).
- **Syntax**:

```sql
DROP TABLE table_name;
```

- **Example**:

```sql
DROP TABLE Employees;
```

- **Key Points**:

  - Deletes both **data and table structure**.
  - Cannot be rolled back once committed.
  - All dependent objects (indexes, constraints, triggers) are removed.
  - Frees up storage space.

---

### Comparison Table: DELETE vs TRUNCATE vs DROP

| Feature                  | DELETE               | TRUNCATE                               | DROP                                 |
| ------------------------ | -------------------- | -------------------------------------- | ------------------------------------ |
| **Command Type**         | DML                  | DDL                                    | DDL                                  |
| **Removes Rows**         | Yes (selected)       | Yes (all rows)                         | Yes (entire table + data)            |
| **WHERE Clause**         | ✅ Supported         | ❌ Not supported                       | ❌ Not supported                     |
| **Transaction Rollback** | ✅ Yes               | ✅ Yes (in most DBs)                   | ❌ No (cannot rollback after commit) |
| **Triggers Fired**       | ✅ Yes               | ❌ No                                  | ❌ No                                |
| **Structure Remains**    | ✅ Yes               | ✅ Yes                                 | ❌ No                                |
| **Logging**              | Row by row (slow)    | Page deallocation (fast)               | Entire object removal                |
| **Use Case**             | Delete selected rows | Quickly clear table but keep structure | Completely remove table              |

---

### Best Practices & Precautions

✔ Use **DELETE** when you need selective row removal with `WHERE`.
✔ Use **TRUNCATE** when you want to clear all rows but keep structure (reset table).
✔ Use **DROP** when you want to completely remove the table (schema + data).
✔ Always check **dependencies** before `DROP` (foreign keys, views, triggers).
✔ Wrap `DELETE` or `TRUNCATE` in **transactions** when working in production.
✔ For large datasets, prefer `TRUNCATE` over `DELETE` (performance).

---

✅ **In short:**

- **DELETE** → Row-level removal (slow but flexible, logged).
- **TRUNCATE** → Fast removal of all rows (table reset, minimal logging).
- **DROP** → Removes table itself (data + structure).

---
