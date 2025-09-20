# <span style="color:#a7c957" >**Lesson-24 SQL**</span>


# **Subqueries in SQL**

A **subquery** (also called an inner query or nested query) is a query **inside another query**.
Subqueries can return a single value, a list of values, or a table depending on how they are used.

---

## **1. Scalar Subqueries**

### **Definition**

* Returns **a single value** (1 row, 1 column).
* Can be used in `SELECT`, `WHERE`, or `HAVING` clauses.

### **Syntax**

```sql
SELECT column1, 
       (SELECT column2 
        FROM table2 
        WHERE table2.id = table1.id) AS derived_column
FROM table1;
```

### **Working**

1. Inner query executes first.
2. Returns a single value.
3. Outer query uses that value like a constant.

### **Example**

```sql
-- Find all employees whose salary is greater than the average salary
SELECT emp_name, salary
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);
```

### **Execution Order**

1. Subquery: `SELECT AVG(salary) FROM Employee` → returns single value.
2. Outer query: compares each employee's salary to that value.

### **Precautions**

* Ensure the subquery returns **exactly one value**.
* If it returns more than one row → error.

---

## **2. Multi-row Subqueries**

### **Definition**

* Returns **multiple rows** (1 column) or **multiple columns** (rare).
* Often used with operators: `IN`, `ANY`, `ALL`, `EXISTS`.

---

### **2a. Using IN**

```sql
SELECT emp_name
FROM Employee
WHERE dept_id IN (SELECT dept_id FROM Department WHERE location='NY');
```

* Returns all employees working in departments located in NY.

---

### **2b. Using ANY / SOME**

```sql
SELECT emp_name, salary
FROM Employee
WHERE salary > ANY (SELECT salary FROM Employee WHERE dept_id=2);
```

* Returns employees whose salary is **greater than at least one employee** in dept 2.

---

### **2c. Using ALL**

```sql
SELECT emp_name, salary
FROM Employee
WHERE salary > ALL (SELECT salary FROM Employee WHERE dept_id=2);
```

* Returns employees whose salary is **greater than every employee** in dept 2.

---

### **Execution Order**

1. Subquery executes first → produces multiple rows.
2. Outer query compares each outer row against **set of results** from subquery.

### **Precautions**

* `IN` requires compatible types between outer column and subquery column.
* For `ANY/ALL`, use relational operators (`>`, `<`, `=`) carefully.

---

## **3. Correlated Subqueries**

### **Definition**

* Inner query **depends on outer query**.
* Evaluates **once per row** of outer query.

### **Syntax**

```sql
SELECT emp_name, salary
FROM Employee e
WHERE salary > (SELECT AVG(salary) 
                FROM Employee 
                WHERE dept_id = e.dept_id);
```

* Here, `e.dept_id` comes from the outer query → correlated.

### **Execution**

1. Outer query picks a row → passes its `dept_id` to inner query.
2. Inner query calculates AVG salary for that dept.
3. Outer query compares employee’s salary to that value.
4. Repeat for every row.

### **Use Cases**

* Filtering by group-based aggregate conditions.
* Conditional calculations.

### **Precautions**

* Can be **slow for large tables** (executes per outer row).
* Prefer **JOIN + GROUP BY** if performance is a concern.

---

## **Use Cases for Subqueries**

| Use Case          | Example                                                          |
| ----------------- | ---------------------------------------------------------------- |
| Filtering         | Employees with salary above average                              |
| Derived Column    | Show employee name + department budget (calculated via subquery) |
| Conditional Check | List customers with orders only in a specific month              |
| Exists Check      | Find products with no orders                                     |

---




## **Multi-row Subquery**

### **How it works internally**

1. The **subquery executes first**.
2. It produces a **set of values** (like a list or array).

   * Example: `SELECT dept_id FROM Department WHERE location='NY'` → `{1, 3}`
3. The **outer query** compares each row against this set using operators like:

   * `IN` → checks if outer value is in the set
   * `ANY/SOME` → checks if outer value satisfies condition with **any element in the set**
   * `ALL` → checks if outer value satisfies condition with **all elements in the set**

---

### **Example**

```sql
-- Departments in NY
SELECT dept_id FROM Department WHERE location='NY';
-- Output (conceptually as a list):
-- {1, 3}

-- Employees in those departments
SELECT emp_name
FROM Employee
WHERE dept_id IN (SELECT dept_id FROM Department WHERE location='NY');
```

* **Subquery result**: `{1, 3}`
* **Outer query**: `dept_id IN {1,3}` → matches Alice, Charlie, David

---

### **Key Points**

* The subquery **does not literally store an array in memory**, but conceptually you can think of it as a **list/set of values** that the outer query uses for comparison.
* **IN** expects **single-column subquery**.
* `ANY` and `ALL` also operate over the “list” returned by the subquery.

---



## **Correlated Subquery Execution**

A **correlated subquery** depends on the outer query. Example:

```sql
SELECT emp_name, salary
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE dept_id = e.dept_id
);
```

* `e.dept_id` comes from the **outer row** → subquery must evaluate **per row**.

---

### **How MySQL Executes It**

1. **Outer query picks the first row** of `Employee`.
2. **Subquery executes** using the outer row’s value (`e.dept_id`).
3. Subquery returns a value (scalar in this case).
4. Outer query uses that value to **filter the current row**.
5. Repeat steps 1–4 for every row in the outer query.

✅ So the subquery is executed **iteration by iteration**, not once for all rows.

---

### **Virtual Table / Temporary Storage**

* The server **does not store all subquery results in a virtual table beforehand** because each subquery execution depends on the current outer row.
* Conceptually, you can think of it as **“per-row evaluation with immediate projection”**.
* Some optimizations (like **semi-join transformations**) may happen internally, but the logical behavior is **per-row execution**.

---

### **Key Points**

| Point        | Explanation                                                                                  |
| ------------ | -------------------------------------------------------------------------------------------- |
| Iteration    | Subquery runs once per outer row.                                                            |
| Projection   | Result of subquery is immediately used to filter or calculate for that outer row.            |
| Optimization | MySQL may rewrite correlated subqueries as JOINs for performance internally.                 |
| Caution      | For large tables, correlated subqueries can be **slow**. Prefer JOIN + GROUP BY if possible. |

---

### **Example Execution**

| Outer Row | dept\_id | Subquery AVG(salary) for that dept | Outer row passes filter? |
| --------- | -------- | ---------------------------------- | ------------------------ |
| Alice     | 1        | AVG(salary where dept\_id=1)=52500 | Yes/No                   |
| Bob       | 2        | AVG(salary where dept\_id=2)=62500 | Yes/No                   |
| Charlie   | 1        | AVG(salary where dept\_id=1)=52500 | Yes/No                   |
| …         | …        | …                                  | …                        |

* Notice how **each outer row triggers a separate subquery execution**.

---



## **1. Think “Step-by-Step Filtering or Aggregation”**

A subquery is useful when you want to **compute something first** and then use it in another query.

### **Pattern**

1. Compute a value or set of values.
2. Use that result to filter, compare, or calculate in the outer query.

**Example:**

> “Get all employees whose salary is above the average.”

* Step 1: Compute `AVG(salary)` → **subquery**
* Step 2: Filter employees using that value → **outer query**

```sql
SELECT emp_name, salary
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);
```

---

## **2. When You Need Multi-Row Comparison**

If you need to compare against a **set of values**, a subquery is very natural.

**Example:**

> “Find employees who work in departments located in NY.”

```sql
SELECT emp_name
FROM Employee
WHERE dept_id IN (SELECT dept_id FROM Department WHERE location='NY');
```

* Inner query produces a **set/list of dept\_id**
* Outer query checks membership → perfect subquery use case

---

## **3. When Outer Row Depends on Inner Calculation (Correlated Subquery)**

If a row’s filtering or derived value depends on **its own group or context**, use a correlated subquery.

**Example:**

> “Find employees whose salary is higher than the **average salary of their department**.”

```sql
SELECT emp_name, salary
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE dept_id = e.dept_id
);
```

* Inner query depends on `e.dept_id` → correlated subquery.

---

## **4. When You Need Derived Columns**

Subqueries are very useful to **compute a value and display it as a column**:

```sql
SELECT emp_name,
       (SELECT dept_name FROM Department d WHERE d.dept_id = e.dept_id) AS dept_name
FROM Employee e;
```

* Instead of a JOIN, a scalar subquery can sometimes be simpler.

---

## **5. When Not to Use Subqueries**

* Large datasets with correlated subqueries → slow performance.
* Can often be rewritten using **JOIN + GROUP BY**, which is more efficient.

---

## **Intuition Framework**

1. **“Compute first, use later?”** → think **subquery**.
2. **“Compare to a set/list?”** → think **multi-row subquery (IN/ANY/ALL)**.
3. **“Need row-by-row context?”** → think **correlated subquery**.
4. **“Derive a column?”** → think **scalar subquery**.
5. **“Can it be a JOIN?”** → always consider JOIN first for performance.

---

### **Tip for Developing Intuition**

* Ask: *“Can I solve this in one step, or do I need an intermediate result?”*
* If intermediate result needed → subquery fits naturally.

---


