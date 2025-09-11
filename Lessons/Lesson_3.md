# <span style="color:#a7c957">**Lesson-3 SQL**</span>

## <span style="color:#0a9396">**Data-Types in SQL**</span>

### 1. **Numeric Data Types**

Used to store numbers (integers, decimals, floating-point).

### (a) **INTEGER / INT**

- **Syntax:**

  ```sql
  column_name INT;
  ```

- **Example:**

  ```sql
  CREATE TABLE Employees (
      EmpID INT PRIMARY KEY,
      Age INT
  );
  ```

- **Storage:** Usually 4 bytes (`-2,147,483,648` to `2,147,483,647`).
- **Best Practice:** Use `INT` if you don’t need fractions. For very large numbers, use `BIGINT`.

---

### (b) **SMALLINT**

- **Syntax:**

  ```sql
  column_name SMALLINT;
  ```

- **Example:**

  ```sql
  CREATE TABLE Orders (
      Quantity SMALLINT
  );
  ```

- **Storage:** 2 bytes (`-32,768` to `32,767`).
- **Best Practice:** Use when you need small integers → saves space.

---

### (c) **BIGINT**

- **Syntax:**

  ```sql
  column_name BIGINT;
  ```

- **Example:**

  ```sql
  CREATE TABLE Transactions (
      TransactionID BIGINT
  );
  ```

- **Storage:** 8 bytes (`-9 quintillion to 9 quintillion`).
- **Best Practice:** Use for very large IDs or counters.

---

### (d) **DECIMAL / NUMERIC (Exact precision)**

- **Syntax:**

  ```sql
  column_name DECIMAL(p, s);
  ```

  - `p` = precision (total digits)
  - `s` = scale (digits after decimal)

- **Example:**

  ```sql
  Salary DECIMAL(10,2); -- up to 10 digits, 2 after decimal
  ```

- **Storage:** Depends on precision, typically 5–17 bytes.
- **Best Practice:** Use for money, accounting (exact values).

---

### (e) **FLOAT / REAL (Approximate values)**

- **Syntax:**

  ```sql
  column_name FLOAT;
  ```

- **Example:**

  ```sql
  Marks FLOAT;
  ```

- **Storage:** 4–8 bytes (approximate, not exact).
- **Best Practice:** Use when approximate precision is acceptable (e.g., scientific calculations). Avoid for money.

---

### 2. **Character/String Data Types**

Used to store text.

### (a) **CHAR(n)**

- **Fixed-length string**.
- **Syntax:**

  ```sql
  column_name CHAR(10);
  ```

- **Example:**

  ```sql
  Gender CHAR(1);  -- 'M' or 'F'
  ```

- **Storage:** Always `n` bytes (padded with spaces).
- **Best Practice:** Use for fixed-length data (e.g., country codes).

---

### (b) **VARCHAR(n)**

- **Variable-length string**.
- **Syntax:**

  ```sql
  column_name VARCHAR(50);
  ```

- **Example:**

  ```sql
  Name VARCHAR(100);
  ```

- **Storage:** Actual length + 1 or 2 bytes.
- **Best Practice:** Use for variable-length text. Don’t oversize unnecessarily.

---

### (c) **TEXT / CLOB**

- **Large text storage**.
- **Syntax:**

  ```sql
  column_name TEXT;
  ```

- **Example:**

  ```sql
  Description TEXT;
  ```

- **Storage:** Up to gigabytes depending on DB.
- **Best Practice:** Use for articles, logs, long strings. Don’t use for searchable short text.

---

### 3. **Date and Time Data Types**

### (a) **DATE**

- **Syntax:**

  ```sql
  column_name DATE;
  ```

- **Example:**

  ```sql
  BirthDate DATE;
  ```

- **Storage:** 3–4 bytes (format: YYYY-MM-DD).
- **Best Practice:** Use only when you need date, not time.

---

### (b) **TIME**

- **Syntax:**

  ```sql
  column_name TIME;
  ```

- **Example:**

  ```sql
  ShiftStart TIME;
  ```

- **Storage:** 3–5 bytes (HH\:MM\:SS).
- **Best Practice:** Use for events with only time-of-day.

---

### (c) **DATETIME / TIMESTAMP**

- **Syntax:**

  ```sql
  column_name DATETIME;
  ```

- **Example:**

  ```sql
  CreatedAt DATETIME;
  ```

- **Storage:** 8 bytes (date + time).
- **Best Practice:** Use for logs, auditing, transactions.

---

### (d) **INTERVAL** (in PostgreSQL/Oracle)

- **Syntax:**

  ```sql
  column_name INTERVAL;
  ```

- **Example:**

  ```sql
  INTERVAL '2 days';
  ```

- **Best Practice:** Useful for time differences (e.g., duration).

---

### 4. **Boolean Type**

### **BOOLEAN / BIT**

- **Syntax:**

  ```sql
  column_name BOOLEAN;
  ```

- **Example:**

  ```sql
  IsActive BOOLEAN;
  ```

- **Storage:** 1 bit (often stored as 1 byte).
- **Best Practice:** Use for Yes/No flags.

---

### 5. **Binary Data Types**

### (a) **BINARY / VARBINARY**

- Store raw binary (e.g., images, files).
- **Syntax:**

  ```sql
  ImageData VARBINARY(MAX);
  ```

- **Best Practice:** Store small binaries.

---

### (b) **BLOB (Binary Large Object)**

- Large binary storage.
- **Syntax:**

  ```sql
  column_name BLOB;
  ```

- **Best Practice:** For large files (e.g., media). Often better to store file path instead of huge blobs in DB.

---

### 6. **Special Types (DB-specific)**

- **ENUM** → predefined list of values (MySQL).

  ```sql
  Status ENUM('Active','Inactive','Pending');
  ```

- **UUID** → universal unique identifier (Postgres, SQL Server).

  ```sql
  UserID UUID DEFAULT gen_random_uuid();
  ```

- **JSON / XML** → structured data (Postgres, MySQL, SQL Server).

  ```sql
  Metadata JSON;
  ```

---

### 7. Best Practices for Choosing Data Types

✅ Pick the **smallest size** that fits your data (saves storage + improves performance).
✅ Use `DECIMAL` for money (not FLOAT).
✅ Avoid `TEXT`/`BLOB` in frequently queried columns (slows performance).
✅ Normalize → store large objects (images/files) outside DB, keep reference path in DB.
✅ Use proper **date/time types** instead of VARCHAR to avoid parsing issues.
✅ Define constraints (`NOT NULL`, `DEFAULT`, `CHECK`) to enforce data integrity.

---

### 8. Storage Summary (Quick Table)

| Data Type     | Storage (Typical)       | Example             |
| ------------- | ----------------------- | ------------------- |
| INT           | 4 bytes                 | `123`               |
| BIGINT        | 8 bytes                 | `9999999999`        |
| DECIMAL(10,2) | 5–17 bytes              | `12345.67`          |
| FLOAT/REAL    | 4–8 bytes               | `3.14159`           |
| CHAR(10)      | Fixed 10 bytes          | `"ABC       "`      |
| VARCHAR(50)   | Length + 1/2 bytes      | `"Hello"`           |
| TEXT          | Up to GBs (LOB storage) | `"Long article..."` |
| DATE          | 3–4 bytes               | `2025-08-20`        |
| DATETIME      | 8 bytes                 | `2025-08-20 10:30`  |
| BOOLEAN       | 1 byte                  | `TRUE` / `FALSE`    |
| BLOB          | Up to GBs (LOB storage) | Image/Video data    |

---
