-- Create the 'ecommerce' database
CREATE DATABASE ecommerce;

-- Use the 'ecommerce' database
USE ecommerce;
-- Create the 'gold_member_users' table to store gold member user data
CREATE TABLE gold_member_users (
    userid INT PRIMARY KEY,
    user_name VARCHAR(50),
    signup_date DATE
);
-- Create the 'users' table to store regular user data

CREATE TABLE users (
    userid INT PRIMARY KEY,
    user_name VARCHAR(50),
    signup_date DATE
);

-- Create the 'sales' table to store sales data

CREATE TABLE sales (
    userid INT,
    user_name VARCHAR(50),
    created_date DATE,
    product_id INT,
    FOREIGN KEY (userid) REFERENCES users(userid)
);
-- Create the 'product' table to store product data

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);
-- Insert data into the 'gold_member_users' table

INSERT INTO gold_member_users VALUES
    (001, 'John', '2017-09-22'),
    (002, 'Mary', '2017-04-21');
-- Insert data into the 'users' table
INSERT INTO users VALUES
    (001, 'John', '2014-09-02'),
    (003, 'Michel', '2015-01-15'),
    (002, 'Mary', '2014-04-11');
-- Insert data into the 'sales' table
INSERT INTO sales VALUES
    (001, 'John', '2017-04-19', 2),
    (002, 'Mary', '2019-12-18', 1),
    (003, 'Michel', '2020-07-20', 3),
    (001, 'John', '2019-10-23', 2),
    (001, 'John', '2018-03-19', 3),
    (002, 'Mary', '2016-12-20', 2),
    (001, 'John', '2016-11-09', 1),
    (001, 'John', '2016-05-20', 3),
    (002, 'Michel', '2017-09-24', 1),
    (001, 'John', '2017-03-11', 2),
    (001, 'John', '2016-03-11', 1),
    (002, 'Mary', '2016-11-10', 1),
    (002, 'Mary', '2017-12-07', 2),
    (003, 'Michel', '2020-05-20', 1),
    (003, 'Michel', '2020-01-20', 3);
-- Insert data into the 'product' table
INSERT INTO product VALUES
    (1, 'Mobile', 980),
    (2, 'Ipad', 870),
    (3, 'Laptop', 330);
-- Show all tables in the current database
SELECT tables FROM SYS.TABLES;

-- Retrieve counts of records in different tables

SELECT
    (SELECT COUNT(*) FROM gold_member_users) AS gold_member_users_count,
    (SELECT COUNT(*) FROM users) AS users_count,
    (SELECT COUNT(*) FROM sales) AS sales_count,
    (SELECT COUNT(*) FROM product) AS product_count;

-- Retrieve the total amount spent by each user

SELECT users.user_name, SUM(product.price) AS total_spent
FROM users
JOIN sales ON users.userid = sales.userid
JOIN product ON sales.product_id = product.product_id
GROUP BY users.user_name;

-- Retrieve distinct sales with user names, ordered by user names and created dates

SELECT DISTINCT created_date, user_name
FROM sales
ORDER BY user_name, created_date;

-- Retrieve the first purchased product for each user

SELECT u.user_name, p.product_name
FROM users u
JOIN (
    SELECT userid, product_id, MIN(created_date) AS min_date
    FROM sales
    GROUP BY userid, product_id
) s ON u.userid = s.userid
JOIN product p ON s.product_id = p.product_id
WHERE s.min_date = (
    SELECT MIN(created_date)
    FROM sales
    WHERE userid = u.userid
);

-- Retrieve the user who purchased the maximum number of items

SELECT user_name, MAX(purchase_count) AS item_count
FROM (
    SELECT user_name, product_id, COUNT(*) AS purchase_count
    FROM sales
    GROUP BY user_name, product_id
) t
GROUP BY user_name;

-- Retrieve users who are not gold members

SELECT u.user_name
FROM users u
LEFT JOIN gold_member_users g ON u.userid = g.userid
WHERE g.userid IS NULL;

-- Retrieve the total amount spent by each user who signed up after becoming a gold member

SELECT u.user_name, SUM(p.price) AS amount_spent
FROM sales s
JOIN users u ON s.userid = u.userid
JOIN product p ON s.product_id = p.product_id
JOIN gold_member_users g ON u.userid = g.userid
WHERE s.created_date >= g.signup_date
GROUP BY u.user_name;

-- Retrieve users whose names start with 'M'

SELECT user_name
FROM users
WHERE user_name LIKE 'M%';

-- Retrieve distinct user ID's

SELECT DISTINCT userid
FROM users;

-- Change the column name 'price' to 'price_value' in the 'product' table

ALTER TABLE product
CHANGE COLUMN price price_value DECIMAL(10, 2);

-- Update product name from 'Ipad' to 'Iphone' in the 'product' table

UPDATE product
SET product_name = 'Iphone'
WHERE product_name = 'Ipad';

-- Rename the table 'gold_member_users' to 'gold_membership_users'

RENAME TABLE gold_member_users TO gold_membership_users;

-- Add a new column 'Status' to the 'gold_membership_users' table

ALTER TABLE gold_membership_users
ADD COLUMN Status VARCHAR(3);

-- Update the 'Status' column in the 'gold_membership_users' table to 'Yes'

UPDATE gold_membership_users
SET Status = 'Yes';

-- Update the 'Status' column in the 'gold_membership_users' table to 'No' for users who are not gold members

UPDATE users u
JOIN gold_membership_users g ON u.userid = g.userid
SET g.Status = 'No'
WHERE g.userid IS NULL;

-- Insert a new record into the 'product' table

INSERT INTO product VALUES (3, 'Laptop', 330);

-- Retrieve duplicate products from the 'product' table

SELECT product_id, product_name, price, COUNT(*) AS count
FROM product
GROUP BY product_id, product_name, price
HAVING COUNT(*) > 1;

