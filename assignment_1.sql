CREATE DATABASE ecommerce;

USE ecommerce;

CREATE TABLE gold_member_users (
    userid INT PRIMARY KEY,
    user_name VARCHAR(50),
    signup_date DATE
);

CREATE TABLE users (
    userid INT PRIMARY KEY,
    user_name VARCHAR(50),
    signup_date DATE
);

CREATE TABLE sales (
    userid INT,
    user_name VARCHAR(50),
    created_date DATE,
    product_id INT,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

INSERT INTO gold_member_users VALUES
    (001, 'John', '2017-09-22'),
    (002, 'Mary', '2017-04-21');

INSERT INTO users VALUES
    (001, 'John', '2014-09-02'),
    (003, 'Michel', '2015-01-15'),
    (002, 'Mary', '2014-04-11');

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

INSERT INTO product VALUES
    (1, 'Mobile', 980),
    (2, 'Ipad', 870),
    (3, 'Laptop', 330);

SHOW ;

SELECT
    (SELECT COUNT(*) FROM gold_member_users) AS gold_member_users_count,
    (SELECT COUNT(*) FROM users) AS users_count,
    (SELECT COUNT(*) FROM sales) AS sales_count,
    (SELECT COUNT(*) FROM product) AS product_count;

SELECT users.user_name, SUM(product.price) AS total_spent
FROM users
JOIN sales ON users.userid = sales.userid
JOIN product ON sales.product_id = product.product_id
GROUP BY users.user_name;

SELECT DISTINCT created_date, user_name
FROM sales
ORDER BY user_name, created_date;

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

SELECT user_name, MAX(purchase_count) AS item_count
FROM (
    SELECT user_name, product_id, COUNT(*) AS purchase_count
    FROM sales
    GROUP BY user_name, product_id
) t
GROUP BY user_name;

SELECT u.user_name
FROM users u
LEFT JOIN gold_member_users g ON u.userid = g.userid
WHERE g.userid IS NULL;

SELECT u.user_name, SUM(p.price) AS amount_spent
FROM sales s
JOIN users u ON s.userid = u.userid
JOIN product p ON s.product_id = p.product_id
JOIN gold_member_users g ON u.userid = g.userid
WHERE s.created_date >= g.signup_date
GROUP BY u.user_name;

SELECT user_name
FROM users
WHERE user_name LIKE 'M%';

SELECT DISTINCT userid
FROM users;

ALTER TABLE product
CHANGE COLUMN price price_value DECIMAL(10, 2);

UPDATE product
SET product_name = 'Iphone'
WHERE product_name = 'Ipad';

RENAME TABLE gold_member_users TO gold_membership_users;

ALTER TABLE gold_membership_users
ADD COLUMN Status VARCHAR(3);

UPDATE gold_membership_users
SET Status = 'Yes';

UPDATE users u
JOIN gold_membership_users g ON u.userid = g.userid
SET g.Status = 'No'
WHERE g.userid IS NULL;

INSERT INTO product VALUES (3, 'Laptop', 330);

SELECT product_id, product_name, price, COUNT(*) AS count
FROM product
GROUP BY product_id, product_name, price
HAVING COUNT(*) > 1;

