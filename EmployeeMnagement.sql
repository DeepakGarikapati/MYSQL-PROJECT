
--===============================  EMPLOYEE MANAGEMENT=================================
CREATE DATABASE IF NOT EXISTS EmployeeDB;
USE EmployeeDB;

-- Remove existing table to start fresh
DROP TABLE IF EXISTS Employee;

-- 1. CREATE EMPLOYEE TABLE
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    city VARCHAR(30),
    joining_date DATE
);

INSERT INTO Employee VALUES
(101, 'Manasa', 'IT', 60000, 'Chennai', '2022-01-15'),
(102, 'Deepak', 'HR', 45000, 'Bangalore', '2021-03-10'),
(103, 'Aravind', 'IT', 70000, 'Chennai', '2020-07-12'),
(104, 'Janani', 'Finance', 55000, 'Mumbai', '2023-01-20'),
(105, 'Manisha', 'HR', 48000, 'Delhi', '2022-05-05'),
(106, 'Ramesh', 'Finance', 65000, 'Mumbai', '2021-08-18'),
(107, 'NTR', 'IT', 75000, 'Hyderabad', '2022-06-10'),
(108, 'Ravi', 'HR', 52000, 'Chennai', '2023-02-15'),
(109, 'Priya', 'Finance', 58000, 'Bangalore', '2021-11-25'),
(110, 'Arun', 'IT', 42000, 'Delhi', '2024-01-05'),
(111, 'Sneha', 'Marketing', 62000, 'Mumbai', '2022-09-12'),
(112, 'Vamsi', 'Marketing', 68000, 'Hyderabad', '2023-04-20');

SELECT * FROM Employee;
-- Check total records
SELECT COUNT(*) AS total_employees
FROM Employee;

-- QUESTIONS 1-7: GROUP BY AND AGGREGATE FUNCTIONS
-- 1. Total number of employees in each department
SELECT department,
       COUNT(*) AS total_employees
FROM Employee
GROUP BY department;

-- 2. Average salary in each department
SELECT department,
       AVG(salary) AS average_salary
FROM Employee
GROUP BY department;

-- 3. Departments having more than one employee
SELECT department,
       COUNT(*) AS total_employees
FROM Employee
GROUP BY department
HAVING COUNT(*) > 1;

-- 4. Highest salary in each department
SELECT department,
       MAX(salary) AS highest_salary
FROM Employee
GROUP BY department;

-- 5. Lowest salary in each department
SELECT department,
       MIN(salary) AS lowest_salary
FROM Employee
GROUP BY department;

-- 6. Departments whose average salary is greater than 50,000
SELECT department,
       AVG(salary) AS average_salary
FROM Employee
GROUP BY department
HAVING AVG(salary) > 50000;

-- 7. Total salary expenditure for each department
SELECT department,
       SUM(salary) AS total_salary
FROM Employee
GROUP BY department;

-- QUESTIONS 8-12: ORDER BY AND GROUP BY
-- 8. Employees sorted by salary descending
SELECT *
FROM Employee
ORDER BY salary DESC;

-- 9. Sort by department and salary descending
SELECT *
FROM Employee
ORDER BY department ASC, salary DESC;

-- 10. Cities having more than one employee
SELECT city,
       COUNT(*) AS total_employees
FROM Employee
GROUP BY city
HAVING COUNT(*) > 1;

-- 11. Total salary paid in each city
SELECT city,
       SUM(salary) AS total_salary
FROM Employee
GROUP BY city;

-- 12. Departments ordered by total salary from highest to lowest
SELECT department,
       SUM(salary) AS total_salary
FROM Employee
GROUP BY department
ORDER BY total_salary DESC;
-- 13. Number of employees in each department
-- whose salary is greater than 50,000
SELECT department,
       COUNT(*) AS employee_count
FROM Employee
WHERE salary > 50000
GROUP BY department;

-- 14. Difference between highest and lowest salary
-- in each department
SELECT department,
       MAX(salary) - MIN(salary) AS salary_difference
FROM Employee
GROUP BY department;

-- 15. Display the top 3 highest-paid employees
SELECT *
FROM Employee
ORDER BY salary DESC
LIMIT 3;

--======================================= CUSTOMERS AND ORDERS=========================================
CREATE DATABASE IF NOT EXISTS CustomerOrdersDB;
USE CustomerOrdersDB;

-- Remove old tables if they exist
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    city VARCHAR(30)
);
INSERT INTO Customers (customer_name, city) VALUES
('Janani', 'Chennai'),
('Arun', 'Coimbatore'),
('Priya', 'Madurai'),
('Karthik', 'Salem'),
('Deepak', 'Hyderabad'),
('Ravi', 'Vijayawada'),
('Sneha', 'Bangalore'),
('Vamsi', 'Chennai'),
('Anjali', 'Pune'),
('Rahul', 'Delhi'),
('Keerthi', 'Mumbai'),
('Suresh', 'Hyderabad');
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);
INSERT INTO Orders (customer_id, amount, order_date) VALUES
(1, 2500, '2026-01-05'),
(1, 3500, '2026-01-10'),
(1, 1800, '2026-02-01'),
(2, 4000, '2026-01-15'),
(2, 3200, '2026-02-05'),
(3, 5500, '2026-01-20'),
(3, 2500, '2026-02-10'),
(4, 1500, '2026-01-25'),
(5, 6000, '2026-02-12'),
(5, 4500, '2026-02-20'),
(6, 2200, '2026-03-01'),
(7, 7000, '2026-03-05'),
(8, 1800, '2026-03-10'),
(9, 5200, '2026-03-15'),
(10, 3000, '2026-03-20');
-- 5. DISPLAY BOTH TABLE
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT COUNT(*) AS total_customers FROM Customers;
SELECT COUNT(*) AS total_orders FROM Orders;

-- Display customers and orders together using JOIN
SELECT c.customer_id, c.customer_name, c.city,
       o.order_id, o.amount, o.order_date
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id;
-- QUESTIONS 16-30: CUSTOMERS AND ORDERS
-- 16. Total order amount for each customer
SELECT c.customer_id, c.customer_name,
       COALESCE(SUM(o.amount), 0) AS total_amount
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 17. Customers who have placed more than 3 orders
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 3;

-- 18. Average order amount for each customer
SELECT c.customer_name,
       AVG(o.amount) AS average_amount
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 19. Highest order amount for each customer
SELECT c.customer_name,
       MAX(o.amount) AS highest_order
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 20. Customers sorted by total purchase amount
SELECT c.customer_name,
       COALESCE(SUM(o.amount), 0) AS total_purchase
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC;

-- 21. Customers whose total purchase exceeds 10,000
SELECT c.customer_name,
       SUM(o.amount) AS total_purchase
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 10000;

-- 22. Customer names and total number of orders
SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 23. Customer who spent the highest total amount
SELECT c.customer_id, c.customer_name,
       SUM(o.amount) AS total_spent
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) = (
    SELECT MAX(total_amount)
    FROM (
        SELECT SUM(amount) AS total_amount
        FROM Orders
        GROUP BY customer_id
    ) AS customer_totals
);

-- 24. Customer who placed the maximum number of orders
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) = (
    SELECT MAX(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM Orders
        GROUP BY customer_id
    ) AS order_counts
);

-- 25. Customers whose average order amount > 2,000
SELECT c.customer_name,
       AVG(o.amount) AS average_amount
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING AVG(o.amount) > 2000;

-- 26. Top 5 customers based on total purchase amount
SELECT c.customer_id, c.customer_name,
       SUM(o.amount) AS total_purchase
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC
LIMIT 5;

-- 27. Minimum order amount for each customer
SELECT c.customer_name,
       MIN(o.amount) AS minimum_order
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 28. Customers whose total orders exceed 5,000
SELECT c.customer_name,
       SUM(o.amount) AS total_purchase
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 5000;

-- 29. Customer-wise total orders and purchase amount
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS total_orders,
       COALESCE(SUM(o.amount), 0) AS total_purchase
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 30. Customers with more than 2 orders
-- and total spending greater than 8,000
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.amount) AS total_purchase
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 2
   AND SUM(o.amount) > 8000;

-- =======================================STUDENTS MANAGEMENT============================
CREATE DATABASE IF NOT EXISTS StudentsDB;
USE StudentsDB;

-- Remove existing table if it exists
DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50),
    department VARCHAR(30),
    marks INT
);
INSERT INTO Students (student_name, department, marks) VALUES
('Arun', 'CSE', 85),
('Priya', 'CSE', 92),
('Deepak', 'CSE', 78),
('Sneha', 'ECE', 88),
('Ravi', 'ECE', 72),
('Anjali', 'ECE', 95),
('Vamsi', 'IT', 81),
('Keerthi', 'IT', 76),
('Rahul', 'IT', 89),
('Janani', 'EEE', 68),
('Karthik', 'EEE', 74),
('Meena', 'EEE', 91);
SELECT * FROM Students;

-- Check total records
SELECT COUNT(*) AS total_students
FROM Students;
-- 31. Average marks in each department
SELECT department,
       AVG(marks) AS average_marks
FROM Students
GROUP BY department;

-- 32. Departments whose average marks are above 75
SELECT department,
       AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) > 75;

-- 33. Highest mark in each department
SELECT department,
       MAX(marks) AS highest_marks
FROM Students
GROUP BY department;

-- 34. Total number of students in each department
SELECT department,
       COUNT(*) AS total_students
FROM Students
GROUP BY department;

-- 35. Departments having more than 5 students
SELECT department,
       COUNT(*) AS total_students
FROM Students
GROUP BY department
HAVING COUNT(*) > 5;

-- 36. Departments sorted by average marks descending
SELECT department,
       AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC;

-- 37. Top 3 departments based on average marks
SELECT department,
       AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC
LIMIT 3;

-- 38. Departments whose average marks are between 70 and 90
SELECT department,
       AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) BETWEEN 70 AND 90;

-- 39. Total marks in each department
SELECT department,
       SUM(marks) AS total_marks
FROM Students
GROUP BY department;

-- 40. Departments sorted by total number of students
SELECT department,
       COUNT(*) AS total_students
FROM Students
GROUP BY department
ORDER BY total_students DESC;

-- 41. Lowest mark in each department
SELECT department,
       MIN(marks) AS lowest_marks
FROM Students
GROUP BY department;

-- 42. Departments where highest mark is greater than 90
SELECT department,
       MAX(marks) AS highest_marks
FROM Students
GROUP BY department
HAVING MAX(marks) > 90;

-- 43. Number of students scoring above 80 in each department
SELECT department,
       COUNT(*) AS students_above_80
FROM Students
WHERE marks > 80
GROUP BY department;

-- 44. Departments where more than 3 students scored above 75
SELECT department,
       COUNT(*) AS students_above_75
FROM Students
WHERE marks > 75
GROUP BY department
HAVING COUNT(*) > 3;

-- 45. Departments ordered by highest mark descending
SELECT department,
       MAX(marks) AS highest_marks
FROM Students
GROUP BY department
ORDER BY highest_marks DESC;

