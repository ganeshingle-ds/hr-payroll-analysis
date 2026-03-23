select * from departments; 

select * from employees; 

select * from projects; 

select * from employee_projects;

select * from salaries; 

select * from attendance;


-- A. Basic Queries

-- 1. List all employees

SELECT * FROM employees;

-- 2. Employees hired after 2021

SELECT emp_name, hire_date
FROM employees
WHERE hire_date > '2021-12-31';

-- 3. HR department employees

SELECT e.emp_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_name ='HR';

-- B. Filtering & Sorting

-- 4. Employees with salary > 50,000

SELECT e.emp_name, s.basic_salary
FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.basic_salary > 50000;

-- 5. Order employees by hire date

SELECT emp_name, hire_date
FROM employees
ORDER BY hire_date;

-- 6. Employees not in Development department

SELECT e.emp_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_name <> 'Development';

-- C. Aggregate Functions

--7. Count employees in each department

SELECT dept_id, COUNT(*) AS emp_count
FROM employees
GROUP BY dept_id;

8. Average salary of Developers

SELECT AVG(s.basic_salary) AS avg_salary
FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
WHERE e.job_role ='Developer';

-- 9. Maximum salary in company

SELECT MAX(basic_salary) AS max_salary
FROM salaries;

-- D. GROUP BY & HAVING

-- 10. Average salary per department

SELECT d.dept_name, AVG(s.basic_salary) AS avg_salary
FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 11. Departments with more than 2 employees

SELECT dept_id, COUNT(*) AS total
FROM employees
GROUP BY dept_id
HAVING COUNT(*) > 2;

-- E. Joins (All Types)

-- 12. Employees with departments

SELECT e.emp_name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- 13. Employees with salary details

SELECT e.emp_name, s.basic_salary, s.bonus, s.deductions
FROM employees e
LEFT JOIN salaries s ON e.emp_id = s.emp_id;

-- 14. Projects with assigned employees

SELECT p.project_name, e.emp_name
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.emp_id = e.emp_id;

-- 15. Departments with no employees (RIGHT JOIN)

SELECT d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;

-- 16. FULL JOIN alternative using UNION

SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION 
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- F. Subqueries

-- 17. Employees earning more than company average

SELECT emp_id, basic_salary
FROM salaries
WHERE basic_salary >
(SELECT AVG(basic_salary) FROM salaries);

-- 18. Highest earning employee

SELECT emp_id, basic_salary
FROM salaries
WHERE basic_salary =
(SELECT MAX(basic_salary) FROM salaries);

-- 19. Employees not assigned to any project

SELECT emp_name
FROM employees
WHERE emp_id NOT IN
(SELECT emp_id FROM employee_projects);

-- G. Nested Subqueries

-- 20. Second highest salary

SELECT MAX(basic_salary)
FROM salaries
WHERE basic_salary <
(SELECT MAX(basic_salary) FROM salaries);

-- 21. Projects with more than 2 employees

SELECT project_id
FROM employee_projects
GROUP BY project_id
HAVING COUNT(emp_id) > 2;

-- 22. Departments with avg salary > Finance

SELECT dept_id
FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY dept_id

HAVING AVG(s.basic_salary) >
(
SELECT AVG(s.basic_salary)
FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_name ='Finance');

-- H. Advanced (Optional)

-- 23. Total payroll cost per employee

SELECT emp_id, basic_salary + bonus - deductions AS total_salary
FROM salaries;

-- 24. Rank employees by salary

SELECT emp_id, basic_salary,
RANK() OVER (ORDER BY basic_salary DESC) AS
salary_rank FROM salaries;

-- 25. Month-wise attendance summary

SELECT MONTH(date) AS month,
COUNT(*) AS total_present
FROM attendance
WHERE status =

'Present'GROUP BY MONTH(date);

-- J. DML Operations

-- 26. Update salary

UPDATE salaries
SET basic_salary = 65000
WHERE emp_id = 101;

-- 27. Delete all Absent attendance

DELETE FROM attendance WHERE
status ='Absent';

-- 28. Insert new project

INSERT INTO projects
VALUES (4,'AI HR System','2024-01-01','2024-12-31');

-- 29. Transfer employee to another department

UPDATE employees
SET dept_id = 5
WHERE emp_id = 103;

-- K. Constraints & Index

-- 30. Create index on email

CREATE INDEX idx_email ON employees(email);

-- 31. Add CHECK constraint for minimum salary

ALTER TABLE salaries
ADD CONSTRAINT chk_salary CHECK (basic_salary >= 18000);

-- 32. Add NOT NULL to phone

ALTER TABLE employees
MODIFY phone VARCHAR(15) NOT NULL;

-- L. Case Study Queries

-- 33. Total payroll cost of company

SELECT SUM(basic_salary + bonus - deductions) AS total_payroll
FROM salaries;

-- 34. Employee working on maximum projects

SELECT emp_id, COUNT(project_id) AS project_count
FROM employee_projects
GROUP BY emp_id
ORDER BY project_count DESC LIMIT 1;

-- 35. Department with highest employee count

SELECT dept_id, COUNT(*) AS total
FROM employees
GROUP BY dept_id
ORDER BY total DESC
LIMIT 1;

-- 36. Least busy project

SELECT project_id, COUNT(emp_id) AS emp_count
FROM employee_projects
GROUP BY project_id
ORDER BY emp_count
LIMIT 1;

-- 37. Employees with 100% attendance

SELECT emp_id
FROM attendance
GROUP BY emp_id
HAVING SUM(status='Absent') = 0;