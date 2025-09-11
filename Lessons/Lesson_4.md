# <span style="color:#a7c957">**Lesson-4 SQL**</span>

## <span style="color:#0a9396">**Constraints in SQL**</span>

### 1. What are Constraints in SQL?

- **Constraints** are rules applied to table columns to enforce **data integrity, consistency, and accuracy** in the database.
- They **restrict invalid data** from being inserted, updated, or deleted.
- Constraints can be applied at:

  - **Column-level** → applied to a single column.
  - **Table-level** → applied across multiple columns.

---

### 2. Types of SQL Constraints

---

## 1. **NOT NULL Constraint**

👉 Ensures a column cannot store `NULL` values.

### Syntax:

```sql
CREATE TABLE Employees (
    EmpID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50)
);
```

### Example:

```sql
INSERT INTO Employees (EmpID, Name) VALUES (1, NULL);
-- ❌ Error: Name cannot be NULL
```

### Role: Guarantees that critical fields (like ID, Name) always contain a value.

### Best Practice: Use only where a column **must always have data**.

---

## 2. **UNIQUE Constraint**

👉 Ensures all values in a column (or combination of columns) are **unique**.

### Syntax:

```sql
CREATE TABLE Students (
    RollNo INT UNIQUE,
    Email VARCHAR(100) UNIQUE
);
```

### Example:

```sql
INSERT INTO Students VALUES (1, 'a@mail.com');
INSERT INTO Students VALUES (2, 'a@mail.com');
-- ❌ Error: Email must be unique
```

### Role: Prevents duplicate values.

### Best Practice: Use on business keys like email, phone, or username.

---

## 3. **PRIMARY KEY Constraint**

👉 Combination of **NOT NULL + UNIQUE**.
👉 Identifies each row uniquely in a table.
👉 A table can have **only one primary key** (can be composite across multiple columns).

### Syntax:

```sql
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);
```

### Example:

```sql
INSERT INTO Departments VALUES (1, 'HR');
INSERT INTO Departments VALUES (1, 'Finance');
-- ❌ Error: Duplicate DeptID not allowed
```

### Role: Main unique identifier for each record.

### Best Practice: Use a **surrogate key** (like auto-increment ID) instead of natural key to avoid future conflicts.

---

## 4. **FOREIGN KEY Constraint**

👉 Ensures a column’s value must exist in another table’s **Primary Key/Unique Key**.
👉 Enforces **referential integrity** (relationship between tables).

### Syntax:

```sql
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
```

### Example:

```sql
INSERT INTO Employees VALUES (101, 5);
-- ❌ Error: No DeptID=5 exists in Departments table
```

### Role: Maintains dependency between parent & child tables.

### Dependency: Child table depends on parent table → you cannot insert child records without parent existing.

### Best Practice: Use `ON DELETE CASCADE` or `ON UPDATE CASCADE` carefully, otherwise you may accidentally delete linked records.

---

## 5. **CHECK Constraint**

👉 Ensures a condition must be **true** for data to be accepted.

### Syntax:

```sql
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Price DECIMAL(10,2) CHECK (Price > 0),
    Quantity INT CHECK (Quantity >= 0)
);
```

### Example:

```sql
INSERT INTO Products VALUES (1, -100, 10);
-- ❌ Error: Price must be > 0
```

### Role: Prevents invalid range/condition values.

### Best Practice: Keep conditions simple and meaningful (complex conditions affect performance).

---

## 6. **DEFAULT Constraint**

👉 Assigns a default value if none is provided during insert.

### Syntax:

```sql
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    Status VARCHAR(20) DEFAULT 'Pending'
);
```

### Example:

```sql
INSERT INTO Orders (OrderID) VALUES (1001);
-- ✅ Status automatically set to 'Pending'
```

### Role: Avoids NULLs and ensures meaningful defaults.

### Best Practice: Use for system values (e.g., `CURRENT_TIMESTAMP`, `'Active'`, `0`).

---

## 7. **INDEX (not a constraint, but similar role)**

👉 Helps speed up queries but doesn’t enforce data rules.
👉 Sometimes confused with constraints like UNIQUE (which creates an index internally).

---

### 3. Dependencies with Constraints

- **PRIMARY KEY & FOREIGN KEY create dependencies**:

  - Parent table (with PK) must exist before creating child table with FK.
  - Cannot delete parent records if child records depend on them (unless `CASCADE` used).

- **UNIQUE, NOT NULL, CHECK** are local to the column and don’t create dependencies between tables.

---

### 4. Best Practices & Precautions

✅ Use **constraints instead of relying on application logic** → ensures data integrity at DB level.
✅ Keep **primary keys simple and stable** (avoid changing them).
✅ Always name constraints explicitly:

```sql
CONSTRAINT chk_salary CHECK (Salary > 0)
```

✅ Avoid too many CHECK constraints (slows inserts/updates).
✅ Be careful with **CASCADE actions** on foreign keys (could delete massive amounts unintentionally).
✅ Normalize data → use constraints to enforce rules, not hacks.

---

### 5. Summary Table

| Constraint  | Ensures                    | Dependency Created | Example Use                               |
| ----------- | -------------------------- | ------------------ | ----------------------------------------- |
| NOT NULL    | No NULL values             | No                 | Emp Name must not be null                 |
| UNIQUE      | No duplicates              | No                 | Email must be unique                      |
| PRIMARY KEY | Unique + Not Null          | Yes (child FKs)    | OrderID, StudentID                        |
| FOREIGN KEY | Value exists in parent     | Yes                | DeptID in Employees linked to Departments |
| CHECK       | Condition must hold true   | No                 | Age > 18                                  |
| DEFAULT     | Auto value when none given | No                 | Status = 'Pending'                        |

---

## <span style="color:#0a9396">**Table Level Constraints in SQL**</span>

Excellent question 👍 — this is one of the **main powers of table-level constraints**: they let you enforce rules that involve **multiple columns together**, something column-level constraints cannot do.

---

### 1. What is a Table-Level Constraint?

- A **table-level constraint** is defined **after all columns** in the `CREATE TABLE` or via `ALTER TABLE`.
- It can reference **one or more columns**.
- Useful for rules like:

  - Primary key on multiple columns.
  - Unique combination of multiple columns.
  - Check conditions involving relationships between columns.
  - Foreign keys.

---

### 2. Syntax

```sql
CREATE TABLE table_name (
    col1 datatype,
    col2 datatype,
    col3 datatype,
    ...
    CONSTRAINT constraint_name constraint_type (col1, col2, ...)
);
```

or via `ALTER TABLE`:

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (col1, col2, ...);
```

---

### 3. Examples of Multi-Column (Table-Level) Constraints

### ✅ (a) Composite Primary Key

- Ensures uniqueness across **a combination of columns**.

```sql
CREATE TABLE Orders (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    CONSTRAINT pk_order_product PRIMARY KEY (OrderID, ProductID)
);
```

👉 Here, neither `OrderID` nor `ProductID` alone is unique, but together they form a unique record.

---

### ✅ (b) Multi-Column UNIQUE Constraint

- Ensures a **combination** of columns is unique.

```sql
CREATE TABLE Students (
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    CONSTRAINT uq_student UNIQUE (FirstName, LastName, Department)
);
```

👉 Prevents inserting two students with the **same full name in the same department**.

---

### ✅ (c) Multi-Column CHECK Constraint

- Enforces a condition involving multiple columns.

```sql
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    Balance DECIMAL(10,2),
    MinBalance DECIMAL(10,2),
    CONSTRAINT chk_balance CHECK (Balance >= MinBalance)
);
```

👉 Ensures that `Balance` must always be **greater than or equal** to `MinBalance`.

Another example:

```sql
CREATE TABLE Employee_Shifts (
    EmpID INT,
    ShiftStart TIME,
    ShiftEnd TIME,
    CONSTRAINT chk_shift CHECK (ShiftEnd > ShiftStart)
);
```

👉 Prevents invalid shifts where the end time is earlier than the start time.

---

### ✅ (d) Multi-Column FOREIGN KEY

- Enforces a relationship using more than one column.

```sql
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    CONSTRAINT fk_order FOREIGN KEY (OrderID, ProductID)
        REFERENCES Orders (OrderID, ProductID)
);
```

👉 Ensures that only valid `(OrderID, ProductID)` pairs from the parent `Orders` table exist.

---

### 4. Why Table-Level Constraints Are Important

- Allow **relational integrity** rules that involve multiple columns.
- Enforce **business logic** at the database level.
- Prevent bad data from entering the system even if application logic misses it.

---

### 5. Best Practices

✅ Always **name constraints** (`CONSTRAINT chk_balance`) → easy to manage later.
✅ Use **table-level constraints** for rules involving more than one column.
✅ Keep **business rules in DB** when data integrity is critical.
✅ Avoid overly complex checks in SQL — leave heavy logic to the application.

---

✨ **In short:**

- Column-level constraints = enforce rules **on a single column**.
- Table-level constraints = enforce rules **on multiple columns together**.

---

## <span style="color:#0a9396">**NOT NULL Table Level Constraints in SQL**</span>

### Can we define **NOT NULL** as a **table-level constraint**?

- **No.**
- In SQL standards and all major RDBMS (Oracle, MySQL, PostgreSQL, SQL Server), **`NOT NULL` can only be defined at the column level**, not at the table level.

👉 Reason:
`NOT NULL` is a **property of a single column** (it ensures that column cannot have NULL values).
Since it applies only to **one column at a time**, SQL designers restricted it to column-level definitions.

---

### Example (Valid - Column Level `NOT NULL`)

```sql
CREATE TABLE Employees (
    EmpID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50)
);
```

✅ Here `EmpID` and `Name` cannot have `NULL`, but `Department` can.

---

### What if you try `NOT NULL` at the table-level?

```sql
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    CONSTRAINT nn_empid CHECK (EmpID IS NOT NULL)
);
```

- Some RDBMS may accept this, but it’s not the same as a **true `NOT NULL` constraint**.
- Here you’re **emulating `NOT NULL`** with a `CHECK` constraint.

---

### Table-Level Alternatives to `NOT NULL`

If you want "multi-column NOT NULL behavior" → use `CHECK`:

```sql
CREATE TABLE Orders (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    CONSTRAINT chk_not_null CHECK (OrderID IS NOT NULL AND ProductID IS NOT NULL)
);
```

👉 This ensures that **both columns must be non-null together**.

But note:

- This does not enforce `NOT NULL` at column definition level.
- Performance-wise, **column-level `NOT NULL`** is more efficient.

---

### Best Practices

✅ Always use **column-level `NOT NULL`**.
✅ Use table-level `CHECK` only if the condition involves multiple columns (e.g., `(col1 IS NOT NULL OR col2 IS NOT NULL)`).
✅ Don’t replace `NOT NULL` with `CHECK` unnecessarily — DB engines optimize `NOT NULL` much better.

---

✨ **In summary:**

- **`NOT NULL` cannot be declared as a table-level constraint.**
- Use **column-level `NOT NULL`** for single columns.
- If you need multi-column null rules, use a **table-level `CHECK` constraint**.

---
