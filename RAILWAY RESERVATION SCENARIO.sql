
-- =============================================RAILWAY RESERVATION SCENARIO======================================

CREATE DATABASE IF NOT EXISTS RailwayDB;
USE RailwayDB;

-- Drop existing tables to start fresh
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS trains;

-- 1. CREATE TRAINS TABLE
CREATE TABLE trains (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(50),
    source VARCHAR(50),
    destination VARCHAR(50)
);

-- 2. INSERT 12 TRAINS

INSERT INTO trains (train_name, source, destination) VALUES
('Express1', 'Chennai', 'Madurai'),
('Express2', 'Coimbatore', 'Salem'),
('Express3', 'Madurai', 'Chennai'),
('Express4', 'Hyderabad', 'Bangalore'),
('Express5', 'Vijayawada', 'Chennai'),
('Express6', 'Mumbai', 'Pune'),
('Express7', 'Delhi', 'Jaipur'),
('Express8', 'Bangalore', 'Mysore'),
('Express9', 'Kochi', 'Trivandrum'),
('Express10', 'Pune', 'Mumbai'),
('Express11', 'Salem', 'Coimbatore'),
('Express12', 'Chennai', 'Bangalore');

-- 3. CREATE BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    train_id INT,
    passenger_name VARCHAR(50),
    fare DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (train_id) REFERENCES trains(train_id)
);

-- 4. INSERT EXACTLY 10 BOOKINGS
-- EACH BOOKING HAS A DIFFERENT TRAIN_ID

INSERT INTO bookings (train_id, passenger_name, fare, status) VALUES
(1, 'Janani', 500, 'Confirmed'),
(2, 'Arun', 500, 'Waiting'),
(3, 'Priya', 300, 'Confirmed'),
(4, 'Karthik', 450, 'Cancelled'),
(5, 'Meena', 300, 'Confirmed'),
(6, 'Deepak', 650, 'Confirmed'),
(7, 'Ravi', 550, 'Waiting'),
(8, 'Sneha', 400, 'Confirmed'),
(9, 'Vamsi', 700, 'Confirmed'),
(10, 'Anjali', 250, 'Cancelled');

-- 5. VERIFY TABLES AND RECORDS

SELECT * FROM trains ORDER BY train_id;
SELECT * FROM bookings ORDER BY booking_id;

SELECT COUNT(*) AS total_trains FROM trains;
SELECT COUNT(*) AS total_bookings FROM bookings;

-- QUESTIONS 41-45: WHERE AND OPERATORS
-- 41. Bookings with fare greater than 400
SELECT *
FROM bookings
WHERE fare > 400;

-- 42. Bookings where status is not Confirmed
SELECT *
FROM bookings
WHERE status <> 'Confirmed';

-- 43. Trains starting from Chennai
SELECT *
FROM trains
WHERE source = 'Chennai';

-- 44. Bookings with fare between 300 and 500
SELECT *
FROM bookings
WHERE fare BETWEEN 300 AND 500;

-- 45. Passengers whose names start with A
SELECT *
FROM bookings
WHERE passenger_name LIKE 'A%';

-- QUESTIONS 46-48: JOINS AND GROUP BY
-- 46. Train names along with passenger names
SELECT t.train_name, b.passenger_name
FROM trains t
INNER JOIN bookings b
ON t.train_id = b.train_id;

-- 47. Count bookings for each train
SELECT t.train_name,
       COUNT(b.booking_id) AS total_bookings
FROM trains t
LEFT JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name
ORDER BY t.train_id;

-- 48. Train names and total fare for each train
SELECT t.train_name,
       COALESCE(SUM(b.fare), 0) AS total_fare
FROM trains t
LEFT JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name
ORDER BY t.train_id;

-- SUBQUERIES
-- 49. Bookings with the highest fare
SELECT *
FROM bookings
WHERE fare = (
    SELECT MAX(fare)
    FROM bookings
);

-- 50. Trains having more than one booking
SELECT t.train_id,
       t.train_name,
       COUNT(b.booking_id) AS total_bookings
FROM trains t
INNER JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name
HAVING COUNT(b.booking_id) > 1;

SELECT
    t.train_id,
    t.train_name,
    t.source,
    t.destination,
    b.booking_id,
    b.passenger_name,
    b.fare,
    b.status
FROM trains t
INNER JOIN bookings b
ON t.train_id = b.train_id;
