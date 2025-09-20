# <span style="color:#a7c957" >**Lesson-25 SQL**</span>



## **1. What is a CTE (Common Table Expression)?**

👉 A **CTE** is like a **temporary named result set** that you define within a query and use immediately in the same query.

* Think of it as a **"named subquery"** that makes SQL more readable and reusable.
* Defined using `WITH` clause.

---

## **2. Syntax**

```sql
WITH cte_name (optional_column_list) AS (
    -- SQL query here (subquery)
)
SELECT ...
FROM cte_name;
```

🔑 Notes:

* `cte_name` = alias for the temporary result set.
* You can define **multiple CTEs** separated by commas.
* You can even create **recursive CTEs**.

---

## **3. Functions & Use Cases**

✅ **Break complex queries into readable steps**.
✅ **Re-use a computed result set multiple times** in a query.
✅ **Recursive queries** (hierarchies, organizational charts, tree traversal).
✅ Better than subqueries when:

* The same subquery is reused multiple times.
* Query is too long and messy.

---

## **4. Internal Working**

* A CTE is **evaluated once** (like a temporary view).
* The query optimizer may inline it (treat it like a subquery).
* Exists only during query execution — **not stored permanently**.
* For recursive CTEs → SQL engine repeatedly executes until termination condition is met.

---

## **5. Precautions**

⚠️ CTE is **not stored** → don’t confuse with temp tables.
⚠️ Recursive CTEs can lead to **infinite loops** → always add a termination condition.
⚠️ Some databases (older MySQL versions <8.0) did not support CTEs.
⚠️ For performance, large CTEs may be **recomputed multiple times** (depends on DB engine).

---

## **6. Analogy & Concept to Remember**

Think of a **CTE as giving a nickname to a subquery**.

* Without CTE → you repeat the same subquery multiple times.
* With CTE → you say *"I’ll name this subquery as `X` and reuse it wherever I need."*

👉 Analogy:
Like creating a **function in programming** instead of repeating the same code block.

---

## **7. Example**

Suppose we have **Employee** and **Department** tables:

```sql
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT,
    manager_id INT
);
```

### Insert sample data

```sql
INSERT INTO Department VALUES
(1, 'IT'), (2, 'HR'), (3, 'Finance');

INSERT INTO Employee VALUES
(101, 'Alice', 50000, 1, NULL),
(102, 'Bob', 60000, 1, 101),
(103, 'Charlie', 55000, 2, NULL),
(104, 'David', 70000, 3, NULL),
(105, 'Eva', 65000, 1, 101),
(106, 'Frank', 40000, 2, 103);
```

---

### Example 1: Simple CTE (Department total salary)

```sql
WITH DeptSalary AS (
    SELECT dept_id, SUM(salary) AS total_salary
    FROM Employee
    GROUP BY dept_id
)
SELECT e.emp_name, e.salary, d.total_salary
FROM Employee e
JOIN DeptSalary d ON e.dept_id = d.dept_id;
```

✔️ Instead of writing the salary `SUM` subquery multiple times, we defined it once in `DeptSalary`.

---

### Example 2: Recursive CTE (Find employee hierarchy)

```sql
WITH RECURSIVE EmpHierarchy AS (
    -- Anchor member (top managers)
    SELECT emp_id, emp_name, manager_id, 1 AS level
    FROM Employee
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive member (employees reporting to others)
    SELECT e.emp_id, e.emp_name, e.manager_id, eh.level + 1
    FROM Employee e
    JOIN EmpHierarchy eh ON e.manager_id = eh.emp_id
)
SELECT * FROM EmpHierarchy;
```

✔️ This will return hierarchy with levels (useful for org charts).

---

## **8. Practice Questions**

Using the `Employee` and `Department` schema:

1. Write a CTE to find average salary per department and list employees whose salary is above average.
2. Use a CTE to find the highest paid employee in each department.
3. Use a recursive CTE to list all employees under Alice (transitive reporting).
4. Create a CTE to count how many employees are in each department.
5. Find employees working in departments where total salary exceeds `100000`.

---

👉 So, CTEs are basically: **subqueries with a name** → improving readability, reusability, and recursive capability.

---



# **Dry Run**

# **Schema Assumption (Employee Table)**

Suppose we have this data:

| emp\_id | emp\_name | manager\_id |
| ------- | --------- | ----------- |
| 1       | Alice     | NULL        |
| 2       | Bob       | 1           |
| 3       | Carol     | 1           |
| 4       | David     | 2           |
| 5       | Eva       | 2           |
| 6       | Frank     | 3           |

* Alice = **top-level manager** (no manager).
* Bob & Carol report to Alice.
* David & Eva report to Bob.
* Frank reports to Carol.

---

# **Query**

```sql
WITH RECURSIVE EmpHierarchy AS (
    -- Anchor: top-level managers
    SELECT emp_id, emp_name, manager_id, 1 AS level
    FROM Employee
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive: employees reporting to previous set
    SELECT e.emp_id, e.emp_name, e.manager_id, eh.level + 1
    FROM Employee e
    JOIN EmpHierarchy eh ON e.manager_id = eh.emp_id
)
SELECT * FROM EmpHierarchy;
```

---

# **Execution Dry Run**

## **Step 1: Anchor Member**

```sql
SELECT emp_id, emp_name, manager_id, 1 AS level
FROM Employee
WHERE manager_id IS NULL;
```

👉 Returns **top-level manager(s):**

| emp\_id | emp\_name | manager\_id | level |
| ------- | --------- | ----------- | ----- |
| 1       | Alice     | NULL        | 1     |

➡️ These rows go into `EmpHierarchy` as the **initial dataset**.

---

## **Step 2: Recursive Member (1st Iteration)**

```sql
SELECT e.emp_id, e.emp_name, e.manager_id, eh.level + 1
FROM Employee e
JOIN EmpHierarchy eh ON e.manager_id = eh.emp_id;
```

Now `eh` = `{ Alice }`.

* Alice’s emp\_id = 1.
* Find employees with `manager_id = 1`.

👉 Matches Bob (2) and Carol (3).

| emp\_id | emp\_name | manager\_id | level |
| ------- | --------- | ----------- | ----- |
| 2       | Bob       | 1           | 2     |
| 3       | Carol     | 1           | 2     |

➡️ Added to results.

---

## **Step 3: Recursive Member (2nd Iteration)**

Now `eh` = `{ Bob, Carol }`.

* For Bob (emp\_id=2) → find employees with `manager_id=2` → David (4), Eva (5).
* For Carol (emp\_id=3) → find employees with `manager_id=3` → Frank (6).

| emp\_id | emp\_name | manager\_id | level |
| ------- | --------- | ----------- | ----- |
| 4       | David     | 2           | 3     |
| 5       | Eva       | 2           | 3     |
| 6       | Frank     | 3           | 3     |

➡️ Added to results.

---

## **Step 4: Recursive Member (3rd Iteration)**

Now `eh` = `{ David, Eva, Frank }`.

* Check if anyone has `manager_id = 4, 5, 6`.
* None found.

👉 Recursion stops.

---

# **Final Result Set**

| emp\_id | emp\_name | manager\_id | level |
| ------- | --------- | ----------- | ----- |
| 1       | Alice     | NULL        | 1     |
| 2       | Bob       | 1           | 2     |
| 3       | Carol     | 1           | 2     |
| 4       | David     | 2           | 3     |
| 5       | Eva       | 2           | 3     |
| 6       | Frank     | 3           | 3     |

---

# **Key Intuition**

* **Anchor query** = starting point (`manager_id IS NULL`).
* **Recursive query** = expands row by row, level by level.
* The **level column** helps visualize the hierarchy depth.
* Recursion ends when no more matches exist.

---





# **1. Syntax of Recursive CTE**

```sql
WITH RECURSIVE cte_name (col1, col2, ...) AS (
    -- 1. Anchor member (base query)
    SELECT ...

    UNION ALL

    -- 2. Recursive member (references the CTE itself)
    SELECT ...
    FROM cte_name
    JOIN ...
    WHERE ...
)
SELECT * FROM cte_name;
```

🔑 Points:

* `WITH RECURSIVE` keyword is mandatory (at least in MySQL & PostgreSQL).
* You need **two parts**:

  * **Anchor member** → gives the starting point.
  * **Recursive member** → repeatedly executed using results of previous step.
* Must be joined with **`UNION ALL`** (to accumulate results).

---

# **2. Internal Working (Step-by-step Execution)**

👉 Think of recursion in programming:

* Base case → recursion → stop condition.

SQL engine does something similar:

1. **Execute the Anchor query** → output forms the first set of rows.
2. **Feed those rows into the Recursive query**.
3. Append the new rows to the result set.
4. Keep repeating until recursive query returns no new rows.
5. Final result = Anchor + all recursive steps combined.

---

# **3. Precautions**

⚠️ Must have a **termination condition**, otherwise → infinite loop.
⚠️ Some DBs limit recursion depth (e.g., SQL Server default = 100, PostgreSQL/MySQL can be set).
⚠️ Recursive CTEs can get expensive with large hierarchies (many iterations).
⚠️ Always test with small dataset before applying to production.

---

# **4. Simple Dry Run Example**

Suppose we want to print numbers from **1 to 5**.

### Table (dummy doesn’t matter here)

```sql
WITH RECURSIVE Numbers AS (
    -- Anchor member (start at 1)
    SELECT 1 AS n
    
    UNION ALL
    
    -- Recursive member (increment by 1 each time)
    SELECT n + 1
    FROM Numbers
    WHERE n < 5
)
SELECT * FROM Numbers;
```

---

### **Dry Run**

* **Step 1 (Anchor):**
  `n = 1` → first row.

* **Step 2 (Recursive):**
  Take `n=1`, apply recursion → `1+1=2`.
  Now we have `{1, 2}`.

* **Step 3:**
  Take `n=2`, apply recursion → `2+1=3`.
  Result = `{1, 2, 3}`.

* **Step 4:**
  Take `n=3`, apply recursion → `3+1=4`.
  Result = `{1, 2, 3, 4}`.

* **Step 5:**
  Take `n=4`, apply recursion → `4+1=5`.
  Result = `{1, 2, 3, 4, 5}`.

* **Step 6:**
  Now `n=5` but recursion condition is `n < 5`. So recursion stops.

✔️ Final Output: `1, 2, 3, 4, 5`.

---

# **5. Practical Example: Employee Hierarchy**

```sql
WITH RECURSIVE EmpHierarchy AS (
    -- Anchor: top-level managers
    SELECT emp_id, emp_name, manager_id, 1 AS level
    FROM Employee
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive: employees reporting to previous set
    SELECT e.emp_id, e.emp_name, e.manager_id, eh.level + 1
    FROM Employee e
    JOIN EmpHierarchy eh ON e.manager_id = eh.emp_id
)
SELECT * FROM EmpHierarchy;
```

### Dry Run (simplified)

* Start with Alice (manager\_id = NULL).
* Then find who reports to Alice → Bob, Eva.
* Then find who reports to Bob → (none), Eva → (none).
* Stop when no more employees found.

---

✅ **Key intuition:** Recursive CTE = SQL’s way of doing loops/recursion.

---

