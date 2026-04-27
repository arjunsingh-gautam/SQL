# Write your MySQL query statement below
select e2.unique_id,e1.name
from employeeuni as e2
right join employees as e1
on e2.id=e1.id;
