# <span style="color:#a7c957">**Lesson-19 SQL**</span>

## 🔢 1. What are Numeric / Math Functions?

SQL provides **built-in numeric functions** to:

* Perform calculations (absolute, round, square root, logs, power).
* Handle precision (rounding, truncating).
* Generate random numbers.
* Do trigonometric calculations.

They work **row-wise** (per value) and can also be used inside **aggregate/grouped queries**.

---

## 🔧 2. List of Common Math Functions

### 🔹 Absolute Value

```sql
ABS(number)
```

* Returns positive value.
* Eg: `ABS(-25)` → `25`.

---

### 🔹 Rounding Functions

```sql
ROUND(number, decimals)   -- rounds with given decimals
TRUNCATE(number, decimals) -- cuts off without rounding
CEIL(number)  -- smallest integer ≥ number
FLOOR(number) -- largest integer ≤ number
```

* Eg: `ROUND(123.456, 2)` → `123.46`
* Eg: `TRUNCATE(123.456, 2)` → `123.45`
* Eg: `CEIL(12.3)` → `13`
* Eg: `FLOOR(12.9)` → `12`

---

### 🔹 Power & Root

```sql
POWER(x, y)   -- x^y
SQRT(x)       -- square root
EXP(x)        -- e^x
```

* Eg: `POWER(2,3)` → `8`
* Eg: `SQRT(16)` → `4`
* Eg: `EXP(1)` → `2.718`

---

### 🔹 Logarithms

```sql
LOG(x)        -- natural log
LOG10(x)      -- base 10 log
```

* Eg: `LOG(2.718)` → `1`
* Eg: `LOG10(100)` → `2`

---

### 🔹 Trigonometric

```sql
SIN(x), COS(x), TAN(x)       -- input in radians
ASIN(x), ACOS(x), ATAN(x)    -- inverse trig
PI()                         -- returns π
RADIANS(x), DEGREES(x)       -- convert angle
```

* Eg: `SIN(PI()/2)` → `1`
* Eg: `DEGREES(PI())` → `180`

---

### 🔹 Random Numbers

```sql
RAND([seed])   -- 0 to 1 random
```

* Eg: `RAND()` → `0.3472`
* Eg: `FLOOR(RAND()*100)` → random integer 0-99.

---

### 🔹 Modulus & Sign

```sql
MOD(x,y)    -- remainder
SIGN(x)     -- -1 if neg, 0 if 0, 1 if pos
```

* Eg: `MOD(17,5)` → `2`
* Eg: `SIGN(-20)` → `-1`

---

## 🛠 3. Working & Limitations

* Math functions **work per row**, not on whole tables (except when combined with aggregates).
* **NULL input → NULL output** (watch out for missing data).
* Trig/log functions expect **radians/valid ranges** (e.g., `LOG(0)` → error).

---

## 📌 4. Use Cases

* Rounding currency/financial amounts.
* Generating random coupon codes.
* Statistical/ML calculations inside SQL.
* Geometry, distance, angles in GIS.
* Normalization (logs, scaling).

---

## 🗂 5. Schema for Practice

```sql
CREATE TABLE sales_math (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    discount DECIMAL(5,2)
);

INSERT INTO sales_math VALUES
(1, 'Laptop', 2, 45000.75, 2000.50),
(2, 'Phone', 5, 15000.20, 500.25),
(3, 'Tablet', 3, 22000.99, 1000.00),
(4, 'Headphones', 10, 2000.50, 150.75),
(5, 'Monitor', 1, 12000.00, 0.00);
```

---

## 📝 6. Practice Questions

### Q1. Find absolute discount for each product.

```sql
SELECT product_name, ABS(discount) AS abs_discount FROM sales_math;
```

### Q2. Round product price to 0 and 2 decimals.

### Q3. Calculate total price = `quantity * price`, then round to nearest integer.

### Q4. Find square root of average product price.

### Q5. Generate a random lucky draw discount between 100–500 for each row.

### Q6. Show only products where price modulo 2 = 0 (even prices).

### Q7. Convert π into degrees and radians.

### Q8. Find log10 of product prices.

### Q9. Identify whether discount values are negative/positive using `SIGN()`.

### Q10. Find the highest order amount using `POWER(quantity,2) * price` as metric.

---



