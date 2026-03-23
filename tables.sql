-- Create tables 
-- 1) Departments table storing department details ddepartment id, name and location with unique constraint on department name

CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50) UNIQUE NOT NULL,
location VARCHAR(50)
);

INSERT INTO departments VALUES
(1,'HR','Pune'),
(2,'Development','Pune'),
(3,'Finance','Mumbai'),
(4,'QA','Pune'),
(5,'Management','Mumbai');

-- 2) Employee table with foreign key to departments and check constraints for job roles

CREATE TABLE employees (
emp_id INT PRIMARY KEY, 
emp_name VARCHAR(100) NOT NULL, 
email VARCHAR(100) UNIQUE,
phone VARCHAR(15), hire_date DATE NOT NULL,
dept_id INT,
job_role VARCHAR(50),
CONSTRAINT fk_dept FOREIGN KEY (dept_id)
REFERENCES departments(dept_id),
CONSTRAINT chk_role CHECK (job_role IN('Developer','Manager','HR','Accountant','Tester'))
);

INSERT INTO employees VALUES
(101, 'Amit Sharma','amit@company.com','9876543210','2022-01-10',2,'Developer'),
(102, 'Priya Singh','priya@company.com','9922334455','2021-03-15',1,'HR'),
(103, 'Rahul Verma','rahul@company.com','8811223344','2020-07-22',2,'Manager'),
(104, 'Neha Joshi','neha@company.com','9988776655','2023-02-10',4,'Tester'),
(105, 'Karan Patel','karan@company.com','9090909090','2019-11-01',3,'Accountant'),
(106, 'Sonia Mehta','sonia@company.com','8899001122','2021-04-19',2,'Developer');


-- 3) Projects table with project details for tracking employee assignments and project timelines

CREATE TABLE projects ( 
project_id INT PRIMARY KEY, 
project_name VARCHAR(100) NOT NULL,
start_date DATE,
end_date DATE
);

INSERT INTO projects VALUES
(1,'Payroll System','2023-01-01','2023-06-30'),
(2,'E-Commerce Portal','2023-02-01','2023-09-30'),
(3,'Mobile App','2023-03-15','2023-12-31');


-- 4) Employee_Projects table defining many-to-many relationship between employees and projects with role details 

CREATE TABLE employee_projects (
emp_id INT, 
project_id INT, 
role VARCHAR(50),
PRIMARY KEY(emp_id, project_id),
FOREIGN KEY (emp_id) REFERENCES employees(emp_id), 
FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO employee_projects VALUES
(101,1,'Developer'), 
(101,2,'Developer'),
(102,1,'HR Support'),
(103,2,'Manager'),
(106,3,'Developer'),
(104,2,'Tester');


-- 5) Salaries table with foreign key to employee and check constraints for salary components 

CREATE TABLE salaries ( 
salary_id INT PRIMARY KEY,
emp_id INT,
basic_salary DECIMAL(10,2) NOT NULL,
bonus DECIMAL(10,2) DEFAULT 0, 
deductions DECIMAL(10,2) DEFAULT 0,
FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO salaries VALUES
(1,101,60000,5000,2000),
(2,102,45000,3000,1000),
(3,103,80000,7000,5000),
(4,104,40000,2000,500),
(5,105,55000,4000,1500),
(6,106,62000,6000,2500);


-- 6) Attendance table with foreign key to employee and check constraints for attendence status

CREATE TABLE attendance ( 
attendance_id INT PRIMARY KEY,
emp_id INT,
date DATE,
status VARCHAR(10) CHECK (status IN('Present','Absent','Leave')),
FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO attendance VALUES
(1,101,'2023-12-01','Present'),
(2,102,'2023-12-01','Absent'),
(3,103,'2023-12-01','Present'),
(4,104,'2023-12-01','Leave'),
(5,105,'2023-12-01','Present'), 
(6,106,'2023-12-01','Present');
