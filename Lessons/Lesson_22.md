# <span style="color:#a7c957">**Lesson-22 SQL**</span>

# 🔹 1. LEFT JOIN

### ✅ Syntax

```sql
SELECT columns
FROM tableA
LEFT JOIN tableB
ON tableA.col = tableB.col;
```

### ✅ Working

* Returns **all rows from the LEFT table (tableA)**.
* Matching rows from tableB are included; if no match, `NULL` is returned for tableB’s columns.

---

### Example Schema

**Customers**

| cust\_id | name  |
| -------- | ----- |
| 1        | Arjun |
| 2        | Meera |
| 3        | Rahul |

**Orders**

| order\_id | cust\_id | amount |
| --------- | -------- | ------ |
| 101       | 1        | 5000   |
| 102       | 1        | 2000   |
| 103       | 2        | 3000   |

---

### ✅ Dry Run

```sql
SELECT c.name, o.order_id, o.amount
FROM customers c
LEFT JOIN orders o
ON c.cust_id = o.cust_id;
```

Result:

| name  | order\_id | amount |
| ----- | --------- | ------ |
| Arjun | 101       | 5000   |
| Arjun | 102       | 2000   |
| Meera | 103       | 3000   |
| Rahul | NULL      | NULL   |

👉 Rahul appears with NULLs because he has no orders.

---

### ✅ Use Cases

* Show all customers even if they haven’t placed an order.
* Audit reports where missing data must be highlighted.

### ✅ Precautions

* Watch out for **NULL values** — must handle them (e.g., with `COALESCE`).
* Can produce **larger result sets** than INNER JOIN.

---

# 🔹 2. RIGHT JOIN

### ✅ Syntax

```sql
SELECT columns
FROM tableA
RIGHT JOIN tableB
ON tableA.col = tableB.col;
```

### ✅ Working

* Opposite of LEFT JOIN.
* Returns **all rows from RIGHT table (tableB)** and only matching rows from tableA.

---

### ✅ Dry Run

```sql
SELECT c.name, o.order_id, o.amount
FROM customers c
RIGHT JOIN orders o
ON c.cust_id = o.cust_id;
```

Result:

| name  | order\_id | amount |
| ----- | --------- | ------ |
| Arjun | 101       | 5000   |
| Arjun | 102       | 2000   |
| Meera | 103       | 3000   |

👉 All orders appear. If there’s an order with invalid `cust_id`, customer will be NULL.

---

### ✅ Use Cases

* Ensure you capture **all sales/orders**, even if customer data is missing.
* Useful when RIGHT table (e.g., orders) is primary.

### ✅ Precautions

* Harder to read (LEFT JOIN is more intuitive).
* Many companies avoid RIGHT JOIN and just swap table order + use LEFT JOIN.

---

# 🔹 3. CROSS JOIN

### ✅ Syntax

```sql
SELECT columns
FROM tableA
CROSS JOIN tableB;
```

### ✅ Working

* Produces **Cartesian product** → every row in tableA paired with every row in tableB.
* No join condition needed.

---

### Example

**Products**

| prod\_id | product |
| -------- | ------- |
| 1        | Laptop  |
| 2        | Phone   |

**Colors**

| color\_id | color  |
| --------- | ------ |
| 1         | Black  |
| 2         | Silver |
| 3         | Blue   |

```sql
SELECT p.product, c.color
FROM products p
CROSS JOIN colors c;
```

Result (2 × 3 = 6 rows):

| product | color  |
| ------- | ------ |
| Laptop  | Black  |
| Laptop  | Silver |
| Laptop  | Blue   |
| Phone   | Black  |
| Phone   | Silver |
| Phone   | Blue   |

---

### ✅ Use Cases

* Generate **combinations** (e.g., product × color, employee × shift).
* Useful in simulations/testing.

### ✅ Precautions

* Output grows **multiplicatively** (dangerous for large tables!).
* Should be used carefully with small datasets.

---

# 🔹 Practice Schema

### Customers

| cust\_id | name  |
| -------- | ----- |
| 1        | Arjun |
| 2        | Meera |
| 3        | Rahul |

### Orders

| order\_id | cust\_id | amount |                    |
| --------- | -------- | ------ | ------------------ |
| 101       | 1        | 5000   |                    |
| 102       | 1        | 2000   |                    |
| 103       | 2        | 3000   |                    |
| 104       | 99       | 2500   | ← invalid customer |

### Products

| prod\_id | product |
| -------- | ------- |
| 1        | Laptop  |
| 2        | Phone   |

### Colors

| color\_id | color  |
| --------- | ------ |
| 1         | Black  |
| 2         | Silver |
| 3         | Blue   |

---

# 🔹 Practice Questions

1. **LEFT JOIN** → Find all customers and their orders, including customers with no orders.
2. **RIGHT JOIN** → Show all orders and their customers, including orders with invalid customer IDs.
3. **CROSS JOIN** → Generate all product-color combinations.
4. **LEFT JOIN + COALESCE** → Replace NULL order amounts with 0 for customers with no orders.
5. **RIGHT JOIN** → List all order IDs where customer info is missing (name is NULL).

---


