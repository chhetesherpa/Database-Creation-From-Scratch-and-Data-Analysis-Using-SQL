-- MySQL DBA and Data Analysis PROJECT
-- MySQL Database Administration
-- Creating schemas and made-up-data-tables from scratch
-- Using the made-up tables to perform analysis


/* 
Question 1
Bubs wants you to track information on his customers (first name, last name, email), his employees (first name, last name, start date, position held), 
his products, and the purchases customers make (which customer, when it was purchased, for how much money). Think about how many tables you should create.
Which data goes in which tables? How should the tables relate to one another?
*/
-- SOLUTION

-- For this purpose, we need to create 4 tables as below
-- 1. customers (Should have at least 4  columns: customer_id, first name, last name, email)
-- 2. employees (Should have at least 5 columns: employee_id, first name, last name, start date, position held)
-- 3. products ( Should have at least 3 columns: product_id, product_name, product_cogs)
-- 4. customer_purchase (Should have at least 5 columns: purchase_id, customer_id, date_of_purchase, purchase_amount, employee_id - to denote which employee closed the transaction)



/* 
Question 2

Draw the EER diagram
-- I did this using MySQL UI interface
*/


/* 
Question 3
Create a schema calleed BubsBusiness. Within the schema, create the tables that you have digramed out.
Make sure they relate to each other, and that they have the same reasonable data types you selected previously.
Also add any constraints you think your tables' columns should have. Think through which columns need to be unique, which ones are allowed to have NULL values, etc.

*/

CREATE SCHEMA bubsbusiness;
USE bubsbusiness;


CREATE TABLE customers (
	customer_id INT NOT NULL,
    first_name VARCHAR (55) NOT NULL,
    last_name VARCHAR (55) NOT NULL,
    email VARCHAR (55) NOT NULL,
    PRIMARY KEY (customer_id)
    );
    
SELECT * FROM customers;

CREATE TABLE employees (
	employee_id INT NOT NULL,
    first_name VARCHAR (55) NOT NULL,
    last_name VARCHAR (55) NOT NULL, 
    start_date DATE NOT NULL,
	position_held VARCHAR(55) NOT NULL,
	PRIMARY KEY (employee_id)
); 

SELECT * FROM employees;


CREATE TABLE products (
	product_id INT NOT NULL,
    product_name VARCHAR(55) NOT NULL,
    product_cost DECIMAL(10,2) NOT NULL,
	PRIMARY KEY (product_id)
);

SELECT * FROM products;

CREATE TABLE customer_purchases (
	customer_purchase_id INT NOT NULL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    purchase_amount DECIMAL(10,2) NOT NULL,
    employee_id INT NOT NULL,
	PRIMARY KEY (customer_purchase_id)
);


SELECT * FROM customer_purchases;

-- USING MySQL UI I have also established the foreign key relationships across all related tables


/* 
Question 5
Insert at least 3 records into each table. 

*/



INSERT INTO customers VALUES 
(1, 'Elon', 'Musk', 'elon.musk@elon.com'),
(2, 'Mark', 'Zuckerburg', 'm.zuck@zuck.com'),
(3, 'Bill', 'Gates', 'bill.gates@gates.com'),
(4, 'Jeff', 'Bezos', 'jess.bezos@jb.com'),
(5, 'Donald', 'Trump', 'd.t@dt.com')
;


INSERT INTO employees VALUES
(1, 'Steve', 'Joes', '2021-03-30', 'CEO'),
(2, 'Joe', 'Rogan', '2021-04-15', 'CFO'),
(3, 'Mark', 'Cuban', '2021-04-01', 'COO')
;


INSERT INTO products VALUES
(1, 'tech box', '5.99'),
(2, 'music mitra', '3.99'),
(3, 'selfie stick', '1.99'),
(4, 'tech mouse 202', '2.50'),
(5, 'innoTV', '0.5'),
(6, 'remote rec', '1.50')
;


INSERT INTO customer_purchases VALUES 
(1, 1, 1, '2024-09-10', '39.99', 1),
(2, 1, 1, '2024-09-11', '39.99', 2),
(3, 2, 2, '2024-09-12', '30.99', 1),
(4, 2, 2, '2024-09-01', '30.99', 2),
(5, 3, 3, '2024-10-03', '15.50', 1),
(6, 3, 3, '2024-10-30', '15.50', 3),
(7, 4, 4, '2024-10-21', '26.66', 3),
(8, 5, 1, '2024-10-12', '39.99', 1),
(9, 5, 2, '2024-11-05', '30.99', 3),
(10, 1, 2, '2024-11-03', '30.99', 1),
(11, 2, 3, '2024-11-13', '15.50', 1),
(12, 3, 4, '2024-11-16', '26.66', 1),
(13, 4, 5, '2024-08-01', '8.75', 1),
(14, 5, 6, '2024-08-09', '6.90', 1),
(15, 1, 6, '2024-08-10', '6.90', 1),
(16, 2, 4, '2024-08-21', '26.66', 1),
(17, 3, 3, '2024-10-22', '15.50', 1),
(18, 4, 4, '2024-10-23', '26.66', 1),
(19, 5, 1, '2024-10-24', '39.99', 1),
(20, 1, 5, '2024-11-04', '8.75', 1),
(21, 2, 6, '2024-10-30', '6.90', 1),
(22, 2, 2, '2024-09-09', '30.99', 1),
(23, 2, 3, '2024-07-30', '15.50', 1),
(24, 2, 6, '2024-08-12', '6.90', 1)
;


SELECT * FROM customer_purchases;

/* 
Question 6
Add new column on product table called 'product_description'

*/

ALTER TABLE products
ADD COLUMN product_description VARCHAR(255) AFTER product_name;

SELECT * FROM products;

/* 
Question 7
Populate data onto the new column 'product_description' on products table
*/

SELECT @@autocommit;
SET autocommit = OFF;

UPDATE products 
SET product_description = CASE (product_id)
	WHEN 1 THEN 'awesome portable 2*2 audio device'
    WHEN 2 THEN 'mp3 player'
    WHEN 3 THEN 'american (not chinese) selfie stick'
    WHEN 4 THEN 'advanced LED mouse'
    WHEN 5 THEN '55 inch futuristic paper-thin TV'
    WHEN 6 THEN 'recorder device'
END;

COMMIT;

SET autocommit = ON;
SELECT @@autocommit;

/* 
Question 6
How many products does the bubsbusiness sell?
*/

SELECT 
	COUNT(*)
FROM products;

-- Looks like bubsbusiness sells 6 different products

/* 
Question 7
What was the total_cost of the tech mouse 202 (product_id = 4)
*/

SELECT 
	product_name,
	product_cost
FROM products
WHERE product_id = 4;

-- The cost of tech mouse 202 was 2.5

/* 
Question 8
Identify the most selling products

*/
SELECT
	customer_purchases.product_id,
	products.product_name,
	COUNT(customer_purchases.customer_purchase_id) AS total_count
FROM customer_purchases
LEFT JOIN products ON customer_purchases.product_id = products.product_id
GROUP BY
	customer_purchases.product_id
ORDER BY
	total_count DESC;

-- It was observed Product 'Music Mitra' and 'Selfie Stick' both were sold the highest with a total_count of 5 each.


/* 
Question 9
Identify the best employee. Best employee is who made the most revenue
*/

SELECT 
	customer_purchases.employee_id,
    employees.first_name,
    employees.last_name,
	SUM(customer_purchases.purchase_amount) AS total_revenue
FROM customer_purchases
LEFT JOIN employees ON customer_purchases.employee_id = employees.employee_id
GROUP BY employee_id
ORDER BY total_revenue DESC;


-- It was found that Steve Joes (employee_id = 1) brought a revenue of 400.02 and was the best employee. 
    

/* 
Question 10
In one output, find the second best employee who made the most revenue
*/

SELECT 
	customer_purchases.employee_id,
    employees.first_name,
    employees.last_name,
	SUM(customer_purchases.purchase_amount) AS total_revenue
FROM customer_purchases
LEFT JOIN employees ON customer_purchases.employee_id = employees.employee_id
GROUP BY employee_id
ORDER BY total_revenue DESC
LIMIT 1
OFFSET 1;

-- The above query will show the second best top-seller, who in this case is 'Mark Cuban'

/* 
Question 11
Give a summary of customer_purchases by month.
The summary should show a monthly sales trend and determine which month was the most profitable for the business
*/

SELECT * FROM customer_purchases;

SELECT 
	MONTH(customer_purchases.purchase_date) AS purchase_month,
	COUNT(customer_purchases.product_id) AS total_quantity_sold,
    SUM(customer_purchases.purchase_amount) AS total_revenue,
    SUM(products.product_cost) AS total_cost,
    SUM(customer_purchases.purchase_amount) - SUM(products.product_cost) AS gross_profit
FROM customer_purchases
LEFT JOIN products ON customer_purchases.product_id = products.product_id
GROUP BY purchase_month
ORDER BY gross_profit DESC;
	
-- It was observed that Month 10 i.e. October was the best performing month for the business with a total profit of 162.25
-- July was the least profitable month. This is actually expected since the earlierst purchase date was made in July indicating the business has started 
-- recording transaction since July only (or that the business only started in July)

SELECT 
	purchase_date
FROM customer_purchases
ORDER BY purchase_date
LIMIT 1;

SELECT 
	purchase_date
FROM customer_purchases
WHERE MONTH(purchase_date) = 7
ORDER BY purchase_date;


-- Specifically the earliest data date was on 2024-07-30 with only one transaction.

/* 
Question 11
Is there a way to use one single line of query to generate a summary report? So each time business needs this report, the analyst doesn't have to rewrite all the queries.
*/

DELIMITER //

CREATE PROCEDURE MonthlySummary()
BEGIN
	SELECT 
	MONTH(customer_purchases.purchase_date) AS purchase_month,
	COUNT(customer_purchases.product_id) AS total_quantity_sold,
    SUM(customer_purchases.purchase_amount) AS total_revenue,
    SUM(products.product_cost) AS total_cost,
    SUM(customer_purchases.purchase_amount) - SUM(products.product_cost) AS gross_profit
FROM customer_purchases
LEFT JOIN products ON customer_purchases.product_id = products.product_id
GROUP BY purchase_month
ORDER BY gross_profit DESC;
END//

DELIMITER ;

CALL MonthlySummary();



