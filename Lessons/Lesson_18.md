# <span style="color:#a7c957">**Lesson-17 SQL**</span>

# 📅 Date & Time Functions in MySQL

Date and time functions allow us to **manipulate, format, extract, and compare** date/time values.

---

## 1. **CURRENT\_DATE / CURDATE**

* **Syntax**:

  ```sql
  SELECT CURRENT_DATE();
  SELECT CURDATE();
  ```
* **Usage**: Returns the current system date.
* **Example**: `2025-09-17`
* **Working**: Reads from the system clock.
* **Limitation**: Cannot manipulate directly, only retrieves current date.
* **Use Case**: Track when a record was inserted, filter by today.

---

## 2. **CURRENT\_TIME / CURTIME**

* **Syntax**:

  ```sql
  SELECT CURRENT_TIME();
  SELECT CURTIME();
  ```
* **Usage**: Returns current system time.
* **Example**: `20:10:25`

---

## 3. **NOW() / CURRENT\_TIMESTAMP()**

* **Syntax**:

  ```sql
  SELECT NOW();
  SELECT CURRENT_TIMESTAMP();
  ```
* **Usage**: Returns both date and time.
* **Example**: `2025-09-17 20:10:25`
* **Use Case**: Record creation timestamp.

---

## 4. **DATE()**

* **Syntax**:

  ```sql
  SELECT DATE('2025-09-17 20:10:25');
  ```
* **Usage**: Extracts only the date from datetime.
* **Example**: `2025-09-17`

---

## 5. **TIME()**

* **Syntax**:

  ```sql
  SELECT TIME('2025-09-17 20:10:25');
  ```
* **Usage**: Extracts only the time.
* **Example**: `20:10:25`

---

## 6. **YEAR(), MONTH(), DAY()**

* **Syntax**:

  ```sql
  SELECT YEAR('2025-09-17');   -- 2025
  SELECT MONTH('2025-09-17');  -- 9
  SELECT DAY('2025-09-17');    -- 17
  ```
* **Usage**: Extract parts of a date.
* **Use Case**: Group sales by year, month, or day.

---

## 7. **MONTHNAME(), DAYNAME()**

* **Syntax**:

  ```sql
  SELECT MONTHNAME('2025-09-17'); -- September
  SELECT DAYNAME('2025-09-17');   -- Wednesday
  ```
* **Use Case**: Reports like “Which weekday has highest sales?”.

---

## 8. **DATEDIFF()**

* **Syntax**:

  ```sql
  SELECT DATEDIFF('2025-09-17','2025-09-10');
  ```
* **Usage**: Returns difference in days.
* **Example**: `7`
* **Use Case**: Calculate subscription duration, project deadlines.

---

## 9. **TIMEDIFF()**

* **Syntax**:

  ```sql
  SELECT TIMEDIFF('10:10:00','08:00:00');
  ```
* **Example**: `02:10:00`
* **Use Case**: Calculate working hours.

---

## 10. **ADDDATE() / DATE\_ADD()**

* **Syntax**:

  ```sql
  SELECT ADDDATE('2025-09-17', INTERVAL 10 DAY);
  SELECT DATE_ADD('2025-09-17', INTERVAL 2 MONTH);
  ```
* **Usage**: Add interval to date.

---

## 11. **SUBDATE() / DATE\_SUB()**

* **Syntax**:

  ```sql
  SELECT DATE_SUB('2025-09-17', INTERVAL 15 DAY);
  ```
* **Example**: `2025-09-02`

---

## 12. **EXTRACT()**

* **Syntax**:

  ```sql
  SELECT EXTRACT(YEAR FROM '2025-09-17');  -- 2025
  SELECT EXTRACT(DAY FROM '2025-09-17');   -- 17
  ```
* **Use Case**: More flexible than `YEAR()`, `MONTH()`.

---

## 13. **LAST\_DAY()**

* **Syntax**:

  ```sql
  SELECT LAST_DAY('2025-09-17');
  ```
* **Example**: `2025-09-30`
* **Use Case**: Billing cycle reports.

---

## 14. **DATE\_FORMAT()**

* **Syntax**:

  ```sql
  SELECT DATE_FORMAT('2025-09-17', '%W %M %Y');
  ```
* **Output**: `Wednesday September 2025`
* **Use Case**: User-friendly reporting.

---

## 15. **STR\_TO\_DATE()**

* **Syntax**:

  ```sql
  SELECT STR_TO_DATE('17-09-2025', '%d-%m-%Y');
  ```
* **Use Case**: Convert string → date.

---

# ⚡ Limitations of Date-Time Functions

1. Dependent on system clock (not always synchronized).
2. MySQL dates range only from `'1000-01-01'` to `'9999-12-31'`.
3. Timezone handling may cause confusion in distributed systems.

---

# 📊 Practice Schema

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    delivery_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1, 'Alice', '2025-09-01', '2025-09-05', 500),
(2, 'Bob', '2025-09-10', '2025-09-13', 1200),
(3, 'Charlie', '2025-08-25', '2025-08-30', 700),
(4, 'Diana', '2025-07-15', '2025-07-20', 1500),
(5, 'Evan', '2025-09-17', '2025-09-25', 900);
```

---

# 📝 Practice Questions

1. Find the **current system date and time**.
2. Extract **year and month** of all orders.
3. Show the **dayname** of each order\_date.
4. Find how many days it took for each order to deliver (`DATEDIFF`).
5. Find total sales **per month**.
6. Find customers whose order was placed in **September 2025**.
7. Find all orders placed in the **last 30 days**.
8. Format `order_date` as `"17-Sep-2025"`.
9. Find the last day of each `order_date` month.
10. Add 15 days to `delivery_date` and show extended delivery date.

---


