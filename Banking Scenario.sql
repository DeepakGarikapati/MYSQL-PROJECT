

-- ===============================================BANKING SCENARIO========================================

-- Create database
CREATE DATABASE IF NOT EXISTS BankingDB;
USE BankingDB;

-- Remove old tables if they exist
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customers;

-- 1. CREATE CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- 2. INSERT 12 CUSTOMERS
INSERT INTO customers (name, city) VALUES
('Deepak', 'Hyderabad'),
('Janani', 'Chennai'),
('Arun', 'Coimbatore'),
('Priya', 'Madurai'),
('Karthik', 'Salem'),
('Ravi', 'Vijayawada'),
('Sneha', 'Bangalore'),
('Vamsi', 'Chennai'),
('Anjali', 'Pune'),
('Rahul', 'Delhi'),
('Keerthi', 'Mumbai'),
('Suresh', 'Hyderabad');

-- 3. CREATE ACCOUNTS TABLE
CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10,2),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- 4. INSERT 15 ACCOUNTS

INSERT INTO accounts (customer_id, account_type, balance) VALUES
(1, 'Savings', 50000),
(1, 'Current', 20000),
(2, 'Savings', 30000),
(3, 'Savings', 15000),
(4, 'Current', 40000),
(5, 'Savings', 25000),
(6, 'Current', 60000),
(7, 'Savings', 18000),
(8, 'Current', 35000),
(9, 'Savings', 75000),
(10, 'Savings', 12000),
(11, 'Current', 45000),
(12, 'Savings', 28000);

SELECT * FROM customers;
SELECT * FROM accounts;

SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_accounts FROM accounts;

-- BASIC + WHERE + OPERATORS (1-15)
-- 1. Accounts with balance greater than 20,000
SELECT * FROM accounts
WHERE balance > 20000;

-- 2. Customers living in Chennai
SELECT * FROM customers
WHERE city = 'Chennai';

-- 3. Accounts with balance between 20,000 and 50,000
SELECT * FROM accounts
WHERE balance BETWEEN 20000 AND 50000;

-- 4. Customers whose names start with J
SELECT * FROM customers
WHERE name LIKE 'J%';

-- 5. Accounts of type Savings or Current
SELECT * FROM accounts
WHERE account_type IN ('Savings', 'Current');

-- 6. Accounts that are not Savings
SELECT * FROM accounts
WHERE account_type <> 'Savings';

-- 7. Customers whose names contain the letter a
SELECT * FROM customers
WHERE name LIKE '%a%';

-- 8. Accounts with balance <= 30,000
SELECT * FROM accounts
WHERE balance <= 30000;

-- 9. Customers not from Madurai
SELECT * FROM customers
WHERE city <> 'Madurai';

-- 10. Accounts with balance outside 10,000 to 40,000
SELECT * FROM accounts
WHERE balance NOT BETWEEN 10000 AND 40000;

-- 11. Customers whose names end with i
SELECT * FROM customers
WHERE name LIKE '%i';

-- 12. Accounts with balance equal to 50,000
SELECT * FROM accounts
WHERE balance = 50000;

-- 13. Customers from Chennai or Salem
SELECT * FROM customers
WHERE city IN ('Chennai', 'Salem');

-- 14. Accounts with balance greater than 10,000
-- and less than 40,000
SELECT * FROM accounts
WHERE balance > 10000 AND balance < 40000;

-- 15. Accounts whose type is not Current
SELECT * FROM accounts
WHERE account_type NOT IN ('Current');

-- ORDER BY (16-18)
-- 16. Accounts sorted by balance descending
SELECT * FROM accounts
ORDER BY balance DESC;

-- 17. Customers sorted alphabetically
SELECT * FROM customers
ORDER BY name ASC;

-- 18. Sort by account type and balance descending
SELECT * FROM accounts
ORDER BY account_type ASC, balance DESC;

-- AGGREGATE FUNCTIONS (19-23)
-- 19. Total balance of all accounts
SELECT SUM(balance) AS total_balance
FROM accounts;

-- 20. Average account balance
SELECT AVG(balance) AS average_balance
FROM accounts;

-- 21. Maximum account balance
SELECT MAX(balance) AS maximum_balance
FROM accounts;

-- 22. Minimum account balance
SELECT MIN(balance) AS minimum_balance
FROM accounts;

-- 23. Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- GROUP BY + HAVING (24-28)
-- 24. Total balance by account type
SELECT account_type, SUM(balance) AS total_balance
FROM accounts
GROUP BY account_type;

-- 25. Average balance by account type
SELECT account_type, AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type;

-- 26. Account types with average balance > 20,000
SELECT account_type, AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type
HAVING AVG(balance) > 20000;

-- 27. Number of accounts for each customer
SELECT customer_id, COUNT(*) AS account_count
FROM accounts
GROUP BY customer_id;

-- 28. Customers having more than one account
SELECT customer_id, COUNT(*) AS account_count
FROM accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- JOINS (29-35)
-- 29. Customer names and account balances
SELECT c.name, a.balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id;

-- 30. All customers and their accounts,
-- including customers without accounts
SELECT c.customer_id, c.name, c.city,
       a.account_id, a.account_type, a.balance
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id;

-- 31. All accounts and corresponding customer details
SELECT a.account_id, a.account_type, a.balance,
       c.name, c.city
FROM accounts a
INNER JOIN customers c
ON a.customer_id = c.customer_id;

-- 32. Customer names and account types
-- where balance > 20,000
SELECT c.name, a.account_type, a.balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
WHERE a.balance > 20000;

-- 33. Customers with their total balance using JOIN
SELECT c.customer_id, c.name,
       SUM(a.balance) AS total_balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name;

-- 34. Customer names and balances sorted by balance
SELECT c.name, a.balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
ORDER BY a.balance ASC;

-- 35. Number of accounts for each city
SELECT c.city, COUNT(a.account_id) AS account_count
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.city;

-- SUBQUERIES (36-40)
-- 36. Accounts with balance above the average
SELECT *
FROM accounts
WHERE balance > (
    SELECT AVG(balance)
    FROM accounts
);

-- 37. Customers who have accounts
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM accounts
);

-- 38. Customers without accounts
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM accounts
);

-- 39. Account(s) with the maximum balance
SELECT *
FROM accounts
WHERE balance = (
    SELECT MAX(balance)
    FROM accounts
);

-- 40. Customers whose total balance > 40,000
SELECT c.customer_id, c.name,
       SUM(a.balance) AS total_balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(a.balance) > 40000;

USE BankingDB;

-- Display customers and their account details together
SELECT
    c.customer_id,
    c.name,
    c.city,
    a.account_id,
    a.account_type,
    a.balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id;
