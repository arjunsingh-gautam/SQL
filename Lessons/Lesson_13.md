# <span style="color:#a7c957">**Lesson-13 SQL**</span>

## ORDER BY Clause in SQL

## 1. Syntax

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC];
```

- `ASC` = ascending (default)
- `DESC` = descending

---

## 2. Working

- SQL retrieves rows (possibly filtered, grouped, aggregated).
- `ORDER BY` sorts the final result set before returning it.
- Can sort by:
  - A column
  - A column alias
  - An expression (`salary*12`)
  - Column positions (`ORDER BY 2` → sorts by 2nd column in SELECT).

---

## 3. Use Cases

- Sort employees by salary (highest first).
- Sort sales by date (latest first).
- Sort products alphabetically.

---

## 4. Best Practices

✅ Always specify `ASC`/`DESC` explicitly for clarity.
✅ Use indexes on large tables to speed up sorting.
✅ Use `ORDER BY` on **final results only** — don’t rely on implicit order.

---

## 5. Precautions

⚠️ Without `ORDER BY`, SQL result order is **not guaranteed**, even if it looks sorted.
⚠️ Sorting large datasets is expensive — avoid unnecessary sorts.
⚠️ Using `ORDER BY` with multiple columns: order matters (first col sorted fully, then tie-breaker on second).

---

## 6. Limitations

- Performance overhead on very large result sets.
- In distributed databases, ordering can require extra shuffling.
- Cannot always `ORDER BY` aggregates unless grouped properly.

---

## 7. Why can ORDER BY use **aliases** or **group-level results**?

Because of **execution order**:

1. `FROM`
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. **SELECT (assigns aliases)**
6. **ORDER BY (runs after SELECT)**

👉 Since `ORDER BY` happens _after_ aliases are assigned, you can sort using them.
Example:

```sql
SELECT customer_name, SUM(amount) AS total_spent
FROM Orders
GROUP BY customer_name
ORDER BY total_spent DESC;   -- ✅ works, alias is known now
```

---

## DISTINCT Keyword

## Function:

- Removes duplicate rows from the result set.

## Syntax:

```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;
```

## Use:

- Get unique customer names.
- Find all unique product categories.

⚠️ Precaution: DISTINCT applies to the **entire row**, not just one column (unless only one column is selected).

---

## LIMIT & OFFSET

## 1. LIMIT

- Restricts the number of rows returned.

```sql
SELECT * FROM Orders LIMIT 5;
```

→ returns only 5 rows.

## 2. OFFSET

- Skips a number of rows before starting to return results.

```sql
SELECT * FROM Orders LIMIT 5 OFFSET 10;
```

→ skip 10 rows, then return next 5.

## 3. Use Cases

- Pagination in web apps.
- Showing top-N queries (top 10 salaries, top 5 products).

## 4. Best Practices

✅ Always use `ORDER BY` with `LIMIT` to ensure consistent results.
✅ Avoid very high offsets on huge tables (performance hit).

---

### 🧠 Mini Recap

- **ORDER BY** → sorting results (can use alias).
- **DISTINCT** → removes duplicates.
- **LIMIT/OFFSET** → control how many rows to fetch/skip.

---

# <span style="color:orange; font-size:28px; font-weight:bold">ORDER BY with Multiple Columns — Internal Working (First Principles + Dry Run)</span>

---

## <span style="color:red; font-size:22px; font-weight:bold">1. The core question (reframed)</span>

When we write:

```sql
ORDER BY col1, col2, col3
```

**How does SQL decide the final order?**
Does it sort multiple times?
Does it merge?
Does it compare tuples?

Let’s answer this **from first principles**, not syntax.

---

## <span style="color:red; font-size:22px; font-weight:bold">2. First principle: What does ORDER BY actually do?</span>

At the deepest level:

> **ORDER BY defines a total ordering on rows using a comparison function.**

Each row is treated as a **tuple of sort keys**:

```text
(col1_value, col2_value, col3_value)
```

SQL does **lexicographical (dictionary-style) comparison**.

This is the _same idea_ as:

- Sorting words in a dictionary
- Sorting version numbers like `1.2.10`

---

## <span style="color:red; font-size:22px; font-weight:bold">3. Mental model (very important)</span>

Think of each row as transformed into:

```text
ROW → (key1, key2, key3, original_row)
```

SQL sorts **only using the keys**, not the whole row.

---

## <span style="color:red; font-size:22px; font-weight:bold">4. Comparison rule (the heart of ORDER BY)</span>

For two rows A and B:

1. Compare `A.col1` vs `B.col1`
   - If different → decision made ❌ stop

2. If equal → compare `A.col2` vs `B.col2`
3. If equal → compare `A.col3` vs `B.col3`
4. Continue until:
   - Difference found → decide order
   - All equal → rows are **tie-equivalent**

⚠️ SQL **never jumps ahead**.
It is strictly **left-to-right**.

---

## <span style="color:red; font-size:22px; font-weight:bold">5. Dry run example (step-by-step)</span>

### Table: `students`

| name | dept | marks |
| ---- | ---- | ----- |
| A    | CS   | 80    |
| B    | CS   | 70    |
| C    | EE   | 90    |
| D    | CS   | 80    |
| E    | EE   | 85    |

---

### Query:

```sql
ORDER BY dept ASC, marks DESC, name ASC;
```

---

### Step 1: Construct sort keys

Each row becomes:

| Row | Sort key tuple |
| --- | -------------- |
| A   | (CS, 80, A)    |
| B   | (CS, 70, B)    |
| C   | (EE, 90, C)    |
| D   | (CS, 80, D)    |
| E   | (EE, 85, E)    |

---

### Step 2: Compare by `dept` (primary key)

Ordering:

```
CS < EE
```

So split into buckets:

**Bucket 1 (CS)**:

- A (80)
- B (70)
- D (80)

**Bucket 2 (EE)**:

- C (90)
- E (85)

---

### Step 3: Resolve ties using `marks DESC`

#### CS bucket:

- A → 80
- D → 80
- B → 70

Sorted:

```
80, 80, 70
```

Still a tie between A and D.

#### EE bucket:

- C → 90
- E → 85

Sorted:

```
90, 85
```

---

### Step 4: Resolve remaining ties using `name ASC`

CS group (80 marks):

- A
- D

Alphabetical order:

```
A < D
```

---

### Step 5: Final output order

| name | dept | marks |
| ---- | ---- | ----- |
| A    | CS   | 80    |
| D    | CS   | 80    |
| B    | CS   | 70    |
| C    | EE   | 90    |
| E    | EE   | 85    |

---

## <span style="color:red; font-size:22px; font-weight:bold">6. Important internal insight (how DB engines really do it)</span>

SQL **does NOT** run multiple sorts like:

❌ Sort by name
❌ Then sort by marks
❌ Then sort by dept

Instead, it builds a **single composite comparator**:

```text
compare(r1, r2):
  if r1.dept != r2.dept:
      return r1.dept < r2.dept
  else if r1.marks != r2.marks:
      return r1.marks > r2.marks
  else:
      return r1.name < r2.name
```

One comparator → one sort operation.

---

## <span style="color:red; font-size:22px; font-weight:bold">7. Is ORDER BY stable?</span>

### Key fact:

SQL **does NOT guarantee stable sorting**.

If all ORDER BY columns are equal:

- Final order is **undefined**
- Depends on execution plan, indexes, disk layout

✔️ If you care about stability → **add a tie-breaker column**

```sql
ORDER BY col1, col2, primary_key;
```

---

## <span style="color:red; font-size:22px; font-weight:bold">8. Common mistakes & misconceptions</span>

### ❌ Mistake 1: Thinking later columns have equal priority

They don’t. Priority strictly decreases left → right.

---

### ❌ Mistake 2: Assuming GROUP BY ordering

```sql
GROUP BY col1
```

❌ No ordering guaranteed.

---

### ❌ Mistake 3: Expecting NULLs to behave intuitively

- Some DBs: NULLs first
- Others: NULLs last

✔️ Use:

```sql
ORDER BY col NULLS LAST;
```

---

## <span style="color:red; font-size:22px; font-weight:bold">9. One-line intuition (lock this in)</span>

> **ORDER BY sorts rows by comparing tuples left-to-right until a difference is found.**

---
