# <span style="color:#a7c957">**Lesson-2 SQL**</span>

## <span style="color:#0a9396">**DDL Commands in SQL**</span>

---

### 🔹 1. What is DDL?

**DDL (Data Definition Language)** is a category of SQL commands that are used to **define, modify, and manage the structure of database objects** (like databases, tables, schemas, views, indexes).

- DDL commands **deal with schema (structure)**, not the actual data inside.
- They are usually **auto-committed** → changes are permanent and cannot be rolled back in many RDBMS.

---

### 🔹 2. Common DDL Commands

### (a) **CREATE**

- Used to create a new database object (table, database, view, index, schema, user, etc.).

```sql
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Salary DECIMAL(10,2)
);
```

---

### (b) **ALTER**

- Used to **modify existing objects** like adding, dropping, or modifying columns in a table.

```sql
ALTER TABLE Employees
ADD COLUMN Department VARCHAR(50);

ALTER TABLE Employees
MODIFY COLUMN Salary DECIMAL(12,2);

ALTER TABLE Employees
DROP COLUMN Age;
```

---

### (c) **DROP**

- Used to **delete database objects** (tables, views, indexes, databases).
- ⚠️ Deletes the structure **and all data inside** (no undo).

```sql
DROP TABLE Employees;
DROP DATABASE CompanyDB;
```

---

### (d) **TRUNCATE**

- Used to **remove all rows** from a table but keep the structure.
- Faster than `DELETE` (no logging row by row).
- Cannot be rolled back (auto-commit in most RDBMS).

```sql
TRUNCATE TABLE Employees;
```

---

### (e) **RENAME** (DB-specific)

- Renames a table or object.

```sql
RENAME TABLE Employees TO Staff;
```

(or in Oracle)

```sql
ALTER TABLE Employees RENAME TO Staff;
```

---

### (f) **COMMENT** (DB-specific)

- Adds comments to schema objects.

```sql
COMMENT ON TABLE Employees IS 'Stores employee information';
```

---

### 🔹 3. Key Points about DDL

1. **Auto-commit nature** → Once executed, changes are permanent.
2. **Affects structure, not data** (except `TRUNCATE`, which removes data).
3. Requires **higher privileges** than DML (like `INSERT`, `UPDATE`).
4. DDL statements **lock schema objects** during execution.

---

### 🔹 4. Best Practices

✅ Always **backup important data** before using `DROP` or `TRUNCATE`.
✅ Use **meaningful names** for objects (tables, views, indexes).
✅ Prefer `ALTER` over dropping/re-creating tables → avoids data loss.
✅ Document schema changes with `COMMENT` if supported.
✅ Use **version control for schema changes** in big projects (migration scripts).

---

✨ **In short:**

- **DDL = commands that define/modify database structure**.
- Main commands: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`, `COMMENT`.

---

## <span style="color:#0a9396">**CREATE Command in SQL**</span>

### 1. What is `CREATE`?

The `CREATE` command in SQL is a **Data Definition Language (DDL)** statement used to create new database objects such as **databases, tables, views, indexes, schemas, procedures, triggers, etc.**

Once created, the object exists in the database until explicitly dropped (`DROP`) or altered (`ALTER`).

---

### 2. Syntax

The general syntax depends on what you are creating. The most common forms are:

### (a) Create Database

```sql
CREATE DATABASE database_name;
```

### (b) Create Table

```sql
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...
);
```

### (c) Create View

```sql
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

### (d) Create Index

```sql
CREATE INDEX index_name
ON table_name (column1, column2, ...);
```

### (e) Create User / Role (DB specific)

```sql
CREATE USER username IDENTIFIED BY password;
```

---

### 3. Use Cases with Examples

### (a) Create a Database

```sql
CREATE DATABASE CompanyDB;
```

👉 Creates a new database named `CompanyDB`.

---

### (b) Create a Table

```sql
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 18),
    Salary DECIMAL(10,2) DEFAULT 30000.00,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
```

👉 Creates an `Employees` table with constraints (`PRIMARY KEY`, `NOT NULL`, `CHECK`, `DEFAULT`, `FOREIGN KEY`).

---

### (c) Create a Table with Auto-Increment (MySQL/Postgres style)

```sql
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL
);
```

👉 `OrderID` auto-generates unique values.

---

### (d) Create a View

```sql
CREATE VIEW HighSalaryEmployees AS
SELECT Name, Salary
FROM Employees
WHERE Salary > 50000;
```

👉 A virtual table (`VIEW`) showing employees with salary > 50,000.

---

### (e) Create an Index

```sql
CREATE INDEX idx_emp_name
ON Employees(Name);
```

👉 Creates an index on `Name` column to speed up searching.

---

### (f) Create Schema

```sql
CREATE SCHEMA Sales AUTHORIZATION user1;
```

👉 Creates a schema named `Sales` under `user1`.

---

### (g) Create User (DB specific)

```sql
CREATE USER analyst IDENTIFIED BY 'StrongPass123';
```

👉 Creates a new database user.

---

### 4. Important Points while Using `CREATE`

1. **Permissions Required**

   - You need proper privileges (like `CREATE` privilege) to create objects.

2. **Naming Rules**

   - Names must be unique within their scope (e.g., table names unique within a schema).
   - Avoid SQL reserved keywords (`SELECT`, `USER`, etc.) as names.

3. **Constraints and Integrity**

   - Always define `PRIMARY KEY` for uniqueness.
   - Use `FOREIGN KEY` for relationships between tables.

4. **Data Types**

   - Choose correct `datatype` (e.g., `INT` for numbers, `VARCHAR` for text, `DATE` for dates).

5. **Indexes**

   - Indexes speed up reads but slow down writes → use wisely.

6. **Defaults & Nullability**

   - Define `DEFAULT` values to prevent `NULL` issues.
   - Set `NOT NULL` where applicable.

---

### 5. Best Practices

✅ **Use meaningful names**

- Example: `Employees` instead of `EmpTbl`, `CustomerOrders` instead of `C_Ord`.

✅ **Always specify constraints**

- Define `PRIMARY KEY`, `UNIQUE`, `NOT NULL`, and `CHECK` early.

✅ **Normalize your tables**

- Avoid storing redundant data. Split into multiple related tables.

✅ **Use schema for organization**

- Example: `Sales.Orders`, `HR.Employees`.

✅ **Index carefully**

- Create indexes only on frequently searched columns.

✅ **Set default values**

- Helps maintain data consistency.

✅ **Comment your schema** (if DB supports `COMMENT`)

```sql
COMMENT ON TABLE Employees IS 'Stores company employee details';
```

---

✨ So in short:

- `CREATE` is used to build **databases, tables, views, indexes, schemas, users, etc.**
- It’s powerful, but should be used carefully with **constraints, normalization, and indexing** in mind.

---

## <span style="color:#0a9396">**Naming Rules in SQL**</span>

### 1. What is a Database Object?

A **database object** is any structure created within a database such as:

- Database, Schema
- Table, View, Index
- Column, Constraint
- Stored Procedure, Function, Trigger
- User, Role

All these need **unique, valid names** following SQL standards.

### 2. General Naming Rules (apply across most RDBMS)

✅ **Length**

- Most SQL databases allow up to **30 characters** (Oracle), **63 characters** (Postgres), or **128 characters** (SQL Server/MySQL).
- Always check your DBMS limit.

✅ **Allowed Characters**

- Must **start with a letter or underscore (`_`)** (some DBs allow numbers if quoted).
- Can contain **letters, digits, and underscores (`_`)**.
- No spaces, hyphens, or special characters (`@ # $ % ^ & *`).

✅ **Case Sensitivity**

- **Oracle, SQL Server, MySQL (default):** Not case-sensitive (`Employee` = `EMPLOYEE`).
- **PostgreSQL:** Case-sensitive if double-quoted (`"Employee"` ≠ `"employee"`).

✅ **Reserved Keywords**

- Cannot use SQL keywords as object names (e.g., `SELECT`, `TABLE`, `USER`).
- If you must, enclose in quotes/brackets (not recommended).

```sql
CREATE TABLE "User" (id INT); -- Works but bad practice
```

✅ **Uniqueness**

- Must be unique within the same namespace/schema.

  - Example: Two tables cannot have the same name in the same schema.

---

### 3. Best Practices for Naming

### ✅ Tables

- Use **singular form** (represents one entity).

  - Good: `Employee`, `CustomerOrder`
  - Bad: `EmployeesList`, `OrdersTbl`

- Use descriptive names, avoid abbreviations unless standard.

### ✅ Columns

- Be descriptive, but concise.
- Include unit/context if relevant.

  - `Salary` → better as `SalaryUSD`.
  - `CreatedAt` → better than `CrtDt`.

### ✅ Constraints

- Prefix with type:

  - `PK_Employees` (Primary Key)
  - `FK_Orders_Customers` (Foreign Key)
  - `CHK_Employee_Age` (Check constraint)

### ✅ Indexes

- Prefix with `IX_` or `IDX_`:

  - `IX_Employees_Name`

### ✅ Stored Procedures/Functions

- Prefix with `sp_`, `fn_`, or project code.

  - `sp_GetEmployeeDetails`, `fn_CalcTax`.

### ✅ Avoid

- Spaces (`Employee Name` ❌ → `Employee_Name` ✅)
- Mixed conventions (`EmpID` in one table, `EmployeeID` in another).
- Overly long names.

---

### 4. Examples

```sql
-- ✅ Good Naming
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    HireDate DATE,
    SalaryUSD DECIMAL(10,2)
);

-- ❌ Bad Naming
CREATE TABLE emp1 (
    e_id INT,
    fn VARCHAR(50),
    ln VARCHAR(50),
    hd DATE,
    s DECIMAL(10,2)
);
```

---

✨ **Summary:**

- Start with letter/underscore, allow letters/numbers/underscores.
- Avoid reserved words & special characters.
- Use consistent, descriptive names.
- Prefix constraints & indexes for clarity.
- Be mindful of case sensitivity in different DBMS.

---

## <span style="color:#0a9396">**ALTER Commands in SQL**</span>

### 1. What is `ALTER` in SQL?

The **`ALTER` command** is used to **modify the structure of existing database objects** such as **tables, views, schemas, indexes, triggers, etc.**

- Unlike `CREATE`, which makes a new object, `ALTER` changes an existing one.
- Unlike `DROP`, it doesn’t remove the object, just updates its definition.

---

### 2. Syntax

### General form:

```sql
ALTER object_type object_name action;
```

For tables (most common):

```sql
ALTER TABLE table_name
    ADD column_name datatype constraints,
    DROP COLUMN column_name,
    ALTER COLUMN column_name datatype,
    RENAME COLUMN old_name TO new_name,
    ADD CONSTRAINT constraint_name constraint_definition,
    DROP CONSTRAINT constraint_name;
```

---

### 3. Use Cases of `ALTER` with Examples

### (A) Add a New Column

```sql
ALTER TABLE Employees
ADD Email VARCHAR(100);
```

👉 Adds a new column `Email`.

---

### (B) Add Multiple Columns

```sql
ALTER TABLE Employees
ADD (JoiningDate DATE, PhoneNumber VARCHAR(15));
```

---

### (C) Modify Column Data Type

```sql
ALTER TABLE Employees
ALTER COLUMN Salary DECIMAL(12,2);  -- SQL Server, Postgres
-- or
MODIFY Salary DECIMAL(12,2);        -- MySQL, Oracle
```

👉 Changes `Salary` precision.

---

### (D) Rename Column

```sql
ALTER TABLE Employees
RENAME COLUMN Name TO FullName;   -- Oracle, Postgres

-- In SQL Server
EXEC sp_rename 'Employees.Name', 'FullName', 'COLUMN';
```

---

### (E) Drop a Column

```sql
ALTER TABLE Employees
DROP COLUMN Age;
```

---

### (F) Add a Constraint

```sql
ALTER TABLE Employees
ADD CONSTRAINT chk_salary CHECK (Salary > 0);

ALTER TABLE Employees
ADD CONSTRAINT fk_dept FOREIGN KEY (DeptID) REFERENCES Departments(DeptID);
```

---

### (G) Drop a Constraint

```sql
ALTER TABLE Employees
DROP CONSTRAINT chk_salary;   -- SQL Server, Oracle
ALTER TABLE Employees
DROP CHECK chk_salary;        -- MySQL
```

---

### (H) Rename a Table

```sql
ALTER TABLE Employees RENAME TO Staff;  -- Oracle, Postgres, MySQL
-- SQL Server:
EXEC sp_rename 'Employees', 'Staff';
```

---

### (I) Enable/Disable Constraints or Triggers

```sql
ALTER TABLE Employees DISABLE CONSTRAINT fk_dept;  -- Oracle
ALTER TABLE Employees ENABLE CONSTRAINT fk_dept;
```

---

### (J) Alter Default Value of a Column

```sql
ALTER TABLE Employees
ALTER COLUMN Salary SET DEFAULT 30000;   -- Postgres
ALTER TABLE Employees
ALTER COLUMN Salary DROP DEFAULT;
```

---

### 4. Important Points While Using `ALTER`

1. **DBMS Differences** → Syntax varies across Oracle, MySQL, SQL Server, PostgreSQL.
2. **Locks Objects** → `ALTER TABLE` usually locks the table until operation is complete.
3. **Large Tables = Expensive** → Adding/modifying columns in huge tables may take time and block queries.
4. **Data Compatibility** → Changing column type may fail if existing data cannot be converted.
5. **Constraints must be unique** → When adding constraints, names must not clash with existing ones.
6. **Indexes** may be rebuilt automatically when altering constraints or columns.

---

### 5. Precautions While Using `ALTER`

⚠️ **Always backup** before structural changes.
⚠️ **Check dependencies** (views, procedures, triggers may break if you rename/drop columns).
⚠️ **Avoid dropping columns lightly** → Data will be lost permanently.
⚠️ **Changing datatype** may cause truncation or conversion errors.
⚠️ **Use staging environments** before applying `ALTER` in production.

---

### 6. Best Practices for `ALTER`

✅ **Plan schema changes** → Use version control (migration scripts).
✅ **Use meaningful constraint/index names** (e.g., `FK_Orders_Customers`).
✅ **Keep changes atomic** → Prefer one `ALTER` per migration for rollback clarity.
✅ **Communicate changes** to developers/teams (renamed columns break queries).
✅ **Add defaults & constraints** proactively (avoid `NULL` chaos later).
✅ **Test after altering** → Run queries to validate integrity.

---

✨ **In short:**

- `ALTER` = modify existing DB objects (especially tables).
- Common uses → **add/modify/drop columns**, **rename objects**, **add/drop constraints**.
- Be careful → it can cause data loss, downtime, or dependency breakage.
- Best practice → **document and test changes** before deploying to production.

---

Perfect 👌 Let’s now go into **`DROP` command in SQL** in the same structured way.

---

### 1. What is `DROP` in SQL?

The **`DROP` command** is a **DDL (Data Definition Language)** statement used to **delete database objects permanently** (table, database, view, index, schema, trigger, user, etc.).

- Unlike `DELETE`, which removes only the **data**, `DROP` removes the **structure + data**.
- Once executed, it **cannot be rolled back** in most RDBMS (auto-commit).

---

### 2. Syntax

General syntax:

```sql
DROP object_type object_name;
```

---

### 3. Use Cases with Examples

### (A) Drop a Database

```sql
DROP DATABASE CompanyDB;
```

👉 Deletes the database `CompanyDB` along with all its objects.

---

### (B) Drop a Table

```sql
DROP TABLE Employees;
```

👉 Deletes the table `Employees` with all rows, indexes, constraints, and triggers.

---

### (C) Drop a View

```sql
DROP VIEW HighSalaryEmployees;
```

👉 Removes the view definition.

---

### (D) Drop an Index

```sql
DROP INDEX idx_emp_name;   -- MySQL, Oracle
DROP INDEX idx_emp_name ON Employees;  -- SQL Server, Postgres
```

👉 Removes the index, but table and data remain.

---

### (E) Drop a Schema

```sql
DROP SCHEMA Sales;
DROP SCHEMA Sales CASCADE;   -- Postgres (also drops dependent objects)
```

---

### (F) Drop a User / Role

```sql
DROP USER analyst;
DROP ROLE read_only_role;
```

---

### (G) Drop a Constraint (DB-specific)

```sql
ALTER TABLE Employees DROP CONSTRAINT fk_dept;  -- SQL Server, Oracle
ALTER TABLE Employees DROP FOREIGN KEY fk_dept; -- MySQL
```

---

### 4. Important Points while using `DROP`

1. **Auto-commit** → `DROP` is permanent and usually cannot be rolled back.
2. **Removes structure + data** (unlike `DELETE` or `TRUNCATE`).
3. **Dependencies matter** → If other objects (views, stored procedures, foreign keys) depend on the dropped object, the command may fail unless `CASCADE` is used.
4. **Locks schema objects** while dropping.
5. **Privileges required** → You need `DROP` privileges for the object.

---

### 5. Precautions while using `DROP`

⚠️ **Backup before dropping** → Once dropped, recovery is only possible from backup.
⚠️ **Check dependencies** → Use `CASCADE` carefully; it may drop unintended objects.
⚠️ **Avoid in production without approval** → Dropping a wrong table or DB can cause outages.
⚠️ **Never DROP in scripts blindly** → Prefer `IF EXISTS` to avoid runtime errors.

Example:

```sql
DROP TABLE IF EXISTS Employees;
```

---

### 6. Best Practices

✅ Use **`IF EXISTS`** (if supported) to avoid errors.
✅ Drop **test/staging objects** only after ensuring they are not needed.
✅ Use **CASCADE carefully** – double-check dependent objects first.
✅ Document and version-control schema changes.
✅ In production:

- Prefer **soft deletion** (mark as inactive) over `DROP` when possible.
- If dropping is required, get **team confirmation + backup snapshot**.

---

# ✨ In Short

- **`DROP` = permanently deletes database objects** (schema + data).
- Common uses: `DROP DATABASE`, `DROP TABLE`, `DROP VIEW`, `DROP INDEX`, `DROP SCHEMA`, `DROP USER`.
- **Dangerous if misused** → always check dependencies, backup, and use `IF EXISTS`.

---

## <span style="color:#0a9396">**CASCADE in SQL**</span>

Excellent question 👍 — **`CASCADE`** is one of those things that seems small in SQL but is **hugely important when dealing with dependencies**. Let’s break it down clearly.

---

### 1. What is `CASCADE` in SQL?

`CASCADE` is an **option/keyword** used with certain SQL commands (`DROP`, `DELETE`, `FOREIGN KEY` constraints) that tells the database to **automatically apply changes to dependent/child objects** when the parent object is modified or removed.

In short:
👉 **If you affect a parent object, CASCADE propagates that effect to dependent objects.**

---

### 2. Where is `CASCADE` Used?

### (A) With `DROP`

When dropping a database, schema, or table:

- `CASCADE` ensures that all dependent objects (tables, views, constraints, functions, triggers, etc.) are also dropped.

Example (Postgres):

```sql
DROP SCHEMA Sales CASCADE;
```

👉 Drops schema `Sales` **and all tables, views, and objects inside it**.

Without `CASCADE`, the DBMS will throw an error if dependencies exist.

---

### (B) With `DELETE` (Foreign Keys)

When you define a **foreign key**, you can specify **ON DELETE CASCADE**:

- If the parent row is deleted, all child rows referencing it are automatically deleted.

Example:

```sql
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID) ON DELETE CASCADE
);
```

Now:

```sql
DELETE FROM Departments WHERE DeptID = 101;
```

👉 Automatically deletes all employees in department `101`.

---

### (C) With `UPDATE` (Foreign Keys)

Similarly, **ON UPDATE CASCADE** means:

- If the parent key changes, the child’s foreign key updates automatically.

Example:

```sql
FOREIGN KEY (DeptID) REFERENCES Departments(DeptID) ON UPDATE CASCADE
```

👉 If `DeptID=101` changes to `201`, all child rows update their `DeptID` too.

---

### 3. Why is `CASCADE` Important?

1. **Maintains Referential Integrity**

   - Prevents “orphan” records (child records pointing to non-existent parents).

2. **Simplifies Operations**

   - You don’t need to manually delete/update dependent rows.

3. **Avoids Errors**

   - Without `CASCADE`, dropping or deleting might fail due to existing dependencies.

4. **Ensures Consistency**

   - Parent-child relationships stay in sync.

---

### 4. Precautions with `CASCADE`

⚠️ **Danger of unintended deletion/update**

- `ON DELETE CASCADE` can wipe out large amounts of data if a parent row is deleted.
- `DROP … CASCADE` can remove far more objects than expected.

⚠️ **Use only where logical**

- Example: Deleting a `Department` → maybe you want employees to be reassigned, not deleted. In such cases, avoid cascade.

⚠️ **Prefer explicit control in production**

- In critical systems, many DBAs prefer manual handling over automatic cascade.

---

### 5. Best Practices

✅ Use `CASCADE` in **lookup tables** (e.g., delete a product category → its products also removed).
✅ Avoid `CASCADE` in critical entities (e.g., deleting a customer → you don’t want to lose all their invoices).
✅ Document cascade relationships clearly.
✅ Test `CASCADE` effects in staging before applying to production.
✅ Use `DROP … CASCADE` carefully — check dependencies first using DB’s system catalog (`INFORMATION_SCHEMA`, `pg_depend`, etc.).

---

✨ **In short:**

- `CASCADE` = automatic propagation of changes from parent → child objects.
- Used in **`DROP`**, **foreign key constraints (DELETE/UPDATE)**.
- Important for **referential integrity & automation**, but risky if misused.

---

## <span style="color:#0a9396">**TRUNCATE Command in SQL**</span>

### 1. What is `TRUNCATE` in SQL?

- **`TRUNCATE`** is a **DDL (Data Definition Language)** command used to **remove all rows from a table instantly** while keeping the table structure intact.
- Unlike `DROP` (removes table structure + data) or `DELETE` (removes row-by-row), `TRUNCATE` is a **fast, bulk operation**.

---

### 2. Syntax

```sql
TRUNCATE TABLE table_name;
```

---

### 3. Use Cases with Examples

### (A) Remove All Records but Keep Table

```sql
TRUNCATE TABLE Employees;
```

👉 Deletes all rows in `Employees`, but the table still exists with its schema.

---

### (B) Reset Identity / Auto-increment Column

Most DBs reset the identity counter after truncate (DB-specific).

```sql
TRUNCATE TABLE Orders;
```

👉 Resets `OrderID` (auto-increment) back to 1 (in SQL Server, MySQL, Postgres).

---

### (C) Clear Temporary / Staging Tables

```sql
TRUNCATE TABLE Temp_Transactions;
```

👉 Used in ETL/data warehousing pipelines to clear staging tables before reloading fresh data.

---

### (D) Remove Records Faster than `DELETE`

```sql
DELETE FROM Employees;   -- Slow for millions of rows
TRUNCATE TABLE Employees; -- Much faster
```

---

### 4. Important Points While Using `TRUNCATE`

1. **DDL Command**

   - It’s a **DDL** command, not DML like `DELETE`.

2. **Auto-commit**

   - In most RDBMS, `TRUNCATE` cannot be rolled back (though PostgreSQL allows rollback inside a transaction).

3. **Faster than DELETE**

   - Doesn’t log row-by-row deletions → only logs deallocation of data pages.

4. **Keeps Structure**

   - Table schema, constraints, indexes remain intact.

5. **Resets Identity**

   - Auto-increment columns are reset (in most DBs).

6. **No WHERE clause**

   - `TRUNCATE` removes **all rows** → cannot filter like `DELETE`.

7. **Constraints Check**

   - Cannot truncate a table if it’s referenced by a **foreign key** (unless you drop/disable it first).

---

### 5. Precautions While Using `TRUNCATE`

⚠️ **Irrecoverable Data Loss**

- All data is gone instantly. No `WHERE` clause, no selective delete.

⚠️ **Foreign Key Restrictions**

- If a table is referenced by another (via FK), you can’t truncate it unless constraints are dropped or disabled.

⚠️ **Identity Reset**

- May cause unexpected behavior if applications rely on sequence values.

⚠️ **Production Danger**

- Truncating the wrong table in production = catastrophic.

---

### 6. Best Practices

✅ Use `TRUNCATE` only when you need to **clear entire tables quickly**.
✅ Avoid on **critical transactional tables** unless you’re 100% sure.
✅ Use it in **staging/temp tables** where resetting is routine.
✅ For selective deletion → use `DELETE` with `WHERE`, not `TRUNCATE`.
✅ Always take a **backup** or snapshot before truncating production tables.
✅ If possible, run inside a **transaction (if supported)** so you can rollback.

---

# ✨ In Short

- **`TRUNCATE` = removes all rows instantly, keeps structure**.
- Faster than `DELETE`, but more dangerous since it’s **auto-commit**.
- Common use cases: resetting staging tables, clearing old data, resetting identity.
- **Be very careful in production** → one wrong command wipes everything.

---

## <span style="color:#0a9396">**RENAME Command in SQL**</span>

### 1. What is `RENAME` in SQL?

The **`RENAME` command** is a **DDL (Data Definition Language)** operation used to **change the name of an existing database object** such as a **table, column, index, view, schema, or database** (depending on the RDBMS).

👉 Some DBMS (Oracle, MySQL, PostgreSQL) support a direct `RENAME` command.
👉 Others (SQL Server) use **`sp_rename`** procedure or `ALTER` statement instead.

---

### 2. Syntax

### (A) Rename a Table (Oracle, Postgres, MySQL ≥ 8)

```sql
RENAME old_table_name TO new_table_name;
```

### (B) Rename a Column

- **Oracle / PostgreSQL**

```sql
ALTER TABLE table_name RENAME COLUMN old_col_name TO new_col_name;
```

- **SQL Server**

```sql
EXEC sp_rename 'table_name.old_col_name', 'new_col_name', 'COLUMN';
```

### (C) Rename an Index (DB-specific)

```sql
ALTER INDEX old_index_name RENAME TO new_index_name;   -- PostgreSQL
ALTER INDEX old_index_name RENAME TO new_index_name;   -- Oracle (from 12c)
EXEC sp_rename 'old_index_name', 'new_index_name', 'INDEX'; -- SQL Server
```

### (D) Rename a Database (MySQL)

```sql
RENAME DATABASE old_db_name TO new_db_name;  -- Deprecated in MySQL
```

👉 Instead: create a new DB and move objects.

---

### 3. Use Cases with Examples

### (A) Rename a Table

```sql
RENAME Employees TO Staff;
```

👉 Table `Employees` is now `Staff`.

---

### (B) Rename a Column

```sql
ALTER TABLE Staff RENAME COLUMN Name TO FullName;
```

👉 Column `Name` renamed to `FullName`.

---

### (C) Rename an Index

```sql
ALTER INDEX idx_emp_name RENAME TO idx_staff_name;
```

👉 Index renamed for clarity.

---

### (D) Rename in SQL Server

```sql
EXEC sp_rename 'Employees.Salary', 'BaseSalary', 'COLUMN';
EXEC sp_rename 'Employees', 'Staff'; -- renames table
```

---

### 4. Important Points while Using `RENAME`

1. **DBMS-specific syntax** → Not all RDBMS support `RENAME` directly. SQL Server uses `sp_rename`.
2. **Renaming doesn’t change data or constraints**, only the object identifier.
3. **Dependencies may break** → Queries, views, stored procedures, triggers, and applications referring to old names may fail.
4. **Locks object** → Renaming typically requires schema lock (other queries may wait).
5. **No rollback** → Once renamed, it’s auto-commit.

---

### 5. Precautions while Using `RENAME`

⚠️ **Check Dependencies**

- Ensure no active code depends on the old name (procedures, views, triggers, APIs).

⚠️ **Consistent Naming Conventions**

- Renaming inconsistently may confuse developers.

⚠️ **Backwards Compatibility**

- If renaming in production, update all applications & reports.

⚠️ **Privileges Required**

- Need `ALTER` or `DROP/CREATE` privileges for object renaming.

⚠️ **Avoid Frequent Renames**

- Causes maintenance headaches.

---

### 6. Best Practices

✅ Use **meaningful, consistent names** from the start → avoid frequent renaming.
✅ If renaming is necessary, **update all references** (queries, code, views).
✅ Maintain a **migration/change log** documenting renamed objects.
✅ Test renaming in a **staging environment** before applying in production.
✅ For big projects, introduce **database abstraction layers** (ORM, views) to minimize direct dependency on raw table/column names.

---

# ✨ In Short

- **`RENAME` = change the identifier (name) of a DB object**.
- Supported objects vary: **tables, columns, indexes, schemas**.
- Syntax differs by DBMS (direct `RENAME` vs `ALTER` vs `sp_rename`).
- Be careful → **dependencies may break** if you rename without updating references.
- Best practice: **choose good names upfront**, rename only when necessary, and always communicate/document schema changes.

---

## <span style="color:#0a9396">**Auto Commit in SQL**</span>

### 1. What is Auto-Commit in SQL?

- **Auto-commit = every SQL statement is immediately committed to the database as soon as it is executed.**
- This means the changes become **permanent** (saved) automatically, **without requiring an explicit `COMMIT` command**.
- In auto-commit mode, you **cannot roll back** once a statement is executed (unless your DB supports it in limited cases).

👉 In most relational databases, **DDL commands (`CREATE`, `DROP`, `ALTER`, `TRUNCATE`) are auto-committed** by default.
👉 In many SQL clients (MySQL CLI, SQL Server Management Studio, etc.), DML (`INSERT`, `UPDATE`, `DELETE`) also runs in auto-commit mode unless you disable it.

---

### 2. Example of Auto-Commit

### Case 1: Auto-Commit ON (Default in MySQL, SQL Server, Oracle clients)

```sql
INSERT INTO Employees (EmpID, Name, Salary) VALUES (101, 'Alice', 50000);
```

👉 The row is **immediately saved**.

- Even if your program crashes right after, the record remains in the database.
- You cannot `ROLLBACK` this change because it’s already committed.

---

### Case 2: DDL Auto-Commit

```sql
CREATE TABLE Test (id INT);
DROP TABLE Test;
```

👉 Both `CREATE` and `DROP` are **auto-committed by nature** in almost all RDBMS.

---

### 3. How to Manually Control Auto-Commit

You can **disable auto-commit mode** to gain manual control over transactions.
This allows you to decide when to `COMMIT` (make permanent) or `ROLLBACK` (undo).

---

### (A) In MySQL

- By default: auto-commit is **ON**.
- To disable:

```sql
SET autocommit = 0;
START TRANSACTION;

INSERT INTO Employees VALUES (102, 'Bob', 60000);
-- Not yet permanent

ROLLBACK;  -- Undo the insert
```

- To re-enable:

```sql
SET autocommit = 1;
```

---

### (B) In PostgreSQL

- Auto-commit is always ON by default.
- To control manually:

```sql
BEGIN;

INSERT INTO Employees VALUES (103, 'Charlie', 70000);

COMMIT;   -- make changes permanent
-- or
ROLLBACK; -- undo changes
```

---

### (C) In SQL Server

- Auto-commit is ON by default.
- To control manually:

```sql
BEGIN TRANSACTION;

UPDATE Employees SET Salary = Salary + 5000 WHERE EmpID = 101;

ROLLBACK;   -- undo the update
-- or
COMMIT;     -- save permanently
```

---

### (D) In Oracle

- Works similar to PostgreSQL (implicit auto-commit unless inside `BEGIN` / `SAVEPOINT` / `ROLLBACK`).

---

### 4. Key Points about Auto-Commit

1. **DDL statements** (`CREATE`, `DROP`, `ALTER`, `TRUNCATE`) are **always auto-committed** in most DBMS.
2. **DML statements** (`INSERT`, `UPDATE`, `DELETE`) depend on session mode:

   - Auto-commit ON → each statement is committed instantly.
   - Auto-commit OFF → grouped inside a transaction until `COMMIT` or `ROLLBACK`.

3. **Safer with manual control** in critical apps → prevents partial updates.
4. **Performance benefit** → Disabling auto-commit can speed up batch inserts/updates (fewer commits).

---

### 5. Best Practices

✅ For **production applications**, keep auto-commit **OFF** and control transactions manually → ensures atomicity.
✅ For **ad-hoc queries/testing**, auto-commit ON is fine (less hassle).
✅ Always `ROLLBACK` after testing queries if you didn’t mean to commit.
✅ In multi-statement operations (e.g., money transfers), **disable auto-commit** so you can rollback if something fails.

---

# ✨ In Short

- **Auto-commit ON** → every statement is permanent instantly.
- **Auto-commit OFF** → you control permanence using `COMMIT` / `ROLLBACK`.
- Always ON for **DDL**, configurable for **DML**.
- Best practice: **turn OFF for critical apps, ON for testing/simple queries**.

---

## <span style="color:#0a9396">**Lock in SQL**</span>

### 1. What is a Lock in SQL?

- A **lock** is a mechanism used by the database to **control access** to a resource (like a row, table, or schema) when multiple transactions/users are working at the same time.
- Locks prevent **conflicts** (e.g., one transaction reading while another is deleting).

---

### 2. What is a Schema/Object Lock?

A **Schema Lock (SCH)** or **Object Lock** is a **special type of lock** placed by the database engine to **protect database objects themselves (tables, indexes, views, etc.)** from being modified while they are in use.

- Unlike row-level or page-level locks (which protect data), **schema/object locks protect the structure/definition of objects**.
- For example:

  - If you are reading from a table, SQL may place a **schema stability lock (SCH-S)** so that no one can `DROP` or `ALTER` that table.
  - If you are running an `ALTER TABLE`, SQL places a **schema modification lock (SCH-M)**, which blocks other queries until the alteration finishes.

---

### 3. Types of Schema/Object Locks (SQL Server terminology, but similar in other DBs)

1. **Schema Stability Lock (SCH-S)**

   - Taken when an object (table/view/procedure) is being **queried**.
   - Ensures no other transaction can change its structure while it is being used.
   - Example:

     ```sql
     SELECT * FROM Employees;
     ```

     👉 Places a **SCH-S lock** on `Employees` table so nobody can `ALTER`/`DROP` it mid-query.

2. **Schema Modification Lock (SCH-M)**

   - Taken when an object is being **modified (DDL operations)**.
   - Blocks all other queries (both reads and writes) on that object until modification is done.
   - Example:

     ```sql
     ALTER TABLE Employees ADD Department VARCHAR(50);
     ```

     👉 Places a **SCH-M lock** → prevents SELECT/INSERT/UPDATE/DELETE on `Employees` until alter completes.

---

### 4. Examples of Schema/Object Lock in Action

### Example 1: Query Locking Schema

```sql
BEGIN TRANSACTION;

SELECT * FROM Employees;  -- Puts SCH-S lock

-- In another session, try:
ALTER TABLE Employees ADD Age INT;
-- ❌ Blocked, because SCH-S prevents schema modification
```

### Example 2: Altering Table

```sql
BEGIN TRANSACTION;

ALTER TABLE Employees ADD Address VARCHAR(100);  -- Puts SCH-M lock

-- In another session:
SELECT * FROM Employees;
-- ❌ Blocked, because SCH-M prevents even reading
```

---

### 5. Why Schema/Object Locks are Important

- **Ensure consistency** → You don’t want a table being dropped while you’re reading from it.
- **Prevent corruption** → Protects structural integrity of objects.
- **Handle concurrency** → Manages conflicts between DDL (schema changes) and DML (data changes).

---

### 6. Precautions while Dealing with Schema/Object Locks

- Long-running queries may block schema modifications.
- DDL changes (like `ALTER TABLE`) block even readers, so avoid running them during peak hours.
- Always use **transactions carefully** to avoid holding schema locks longer than necessary.

---

### 7. Best Practices

✅ Run DDL operations (ALTER, DROP, RENAME) during **maintenance windows**.
✅ Keep transactions **short-lived** to avoid holding schema locks for long.
✅ Use **`WITH (NOLOCK)`** (in SQL Server) cautiously if you want to read without waiting for locks.
✅ Monitor locks with system views (`sys.dm_tran_locks` in SQL Server, `pg_locks` in PostgreSQL).

---

### ✨ In short:

- **Schema/Object lock** = lock on database structure (not just data).
- **SCH-S** (stability) → placed when reading, prevents schema changes.
- **SCH-M** (modification) → placed when altering, prevents any access.
- **Important** because they protect object definitions and prevent corruption in concurrent environments.

---
