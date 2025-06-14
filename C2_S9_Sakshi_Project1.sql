-- PROJECT 1.1 --

-- TASK 1.1--
-- Find top 10 customers by credit limit
-- Select customer table
-- Order by creditlimit
-- and use LIMIT to find top 10 customers
SELECT customerName, creditLimit 
from customers
ORDER BY creditLimit DESC
LIMIT 10;


-- TASK 1.2 --
-- Find the average credit limit for each company
-- Use customers tablee
-- Use AVG func for creditlimit
-- group by country
SELECT AVG(creditLimit) AS Average_CreditLimit, Country
from customers
GROUP BY Country;


-- TASK 1.3 --
-- Find the number of customers in each state
-- Select customers table
-- Use count func to find Number Of Customers
-- And use group by for state
SELECT State, COUNT(*) AS NumberOfCustomers
from Customers
GROUP BY State;


-- TASK 1.4 --
-- Find the customers who haven't placed any orders
-- Use two tables here orders and customers
-- join using customerNumber
-- where o.orderNumber is NULL
SELECT c.customername, c.customerNumber from customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
where o.orderNumber is NULL;


-- TASk 1.5 --
-- Calculate total sales for each customer
-- consider three tables Customers orders orderdetails
-- use sum func to find total sales
-- use group by for customerNumber, customerName
-- ORDER BY totalsales
SELECT c.customerName, c.customerNumber,
SUM(quantityOrdered * priceEach) AS totalsales from Customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od. orderNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY totalsales DESC;


-- TASK 1.6 --
-- List customers with their assigned sales rep
-- JOIN two tables customers and employees to find assigned sales rep
-- Sort using order by customerName
SELECT c.customerName, 
e.firstName AS SalesRepFirstName,
e.lastName AS SalesRepLastName
from Customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY c.customerName;


-- TASK 1.7 --
-- Retrieve customer information with their most recent payment details
-- Retrieve columns from customers
-- JOIN customers and payments
-- ORDER BY paymentDate DESC to find most recent payment details
SELECT c.customerName, c.phone, paymentDate, amount
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
ORDER BY paymentDate DESC;


-- TASK 1.8 --
-- Identify the customers who have exceeded their credit limit
-- USE three tables and JOIN them
-- Group by customerNumber
-- HAVING creditLimit = 0
SELECT c.customerNumber, c.customerName, c.creditLimit
FROM Customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber
HAVING c.creditLimit = 0;


-- TASK 1.9 --
-- Find the names of all customers who have placed an order for a product from a specific product line
-- We start with the `customers` table to get customer names
-- Join with `orders` to find which customers placed orders
-- Join with `order_items` to see what products were ordered
-- Join with `products` to get product details
-- Join with `product_lines` to filter by the specific product line
-- The `WHERE` clause specifies which product line you're interested in
-- `DISTINCT` ensures each customer is listed only once
SELECT DISTINCT c.customerName
from Customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
JOIN productlines pl ON p.productLine = pl.productLine
where pl.productLine = 'Classic Cars'
ORDER BY c.customerName;


-- TASK 1.10 --
-- Find the names of  customers who have placed an order for the most expensive product
-- Here we need to use 4 tables
-- JOIN them using matching columns
--  Filter using MSRP = (SELECT MAX(MSRP) from products)
-- Sort by customername
SELECT DISTINCT c.customerName
from Customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
-- JOIN productlines pl ON p.productLine = pl.productLine
where p.MSRP = (SELECT MAX(MSRP) from products)
ORDER BY c.customerName;


-- TASK 2.1--
-- Count the no. of emp working in each office
-- Use employees table
-- use count func to find EmployeeCount
SELECT officeCode, COUNT(*) as EmployeeCount from employees
GROUP BY officeCode;

-- OR 

SELECT city, COUNT(e.employeeNumber) AS No_of_Employees 
from Offices o
JOIN employees e ON o.officeCode = e.officeCode
GROUP BY city;

-- TASK 2.2 --
-- Indetify the office with less than a certain number of employees
-- Select employees table
-- use count func to find No_of_Employees
-- Group by officeCode
-- use having to find offices less than a certain no.of emp
SELECT officeCode, COUNT(*) AS No_of_Employees
from employees
GROUP BY officeCode
HAVING COUNT(*) < 6;


-- Task 2.3--
-- List offices along with their assigned territories
-- Use offices table
-- And retrieve officecode, city, territory
-- Only single table is used
-- The output will the the city with their assigned territory
SELECT officeCode, city, territory
FROM offices
Order BY city;

-- Task 2.4--
-- Find the offices that have no employees assigned to them
-- Retrieve officecode and city from offices tables
-- Join two tables, employees and offices using column officecode
-- Use where clause to determine employeeNumber as NULL
-- It will return a list of officeCode and city for all offices that do not have any employees listed in the employees table with a matching officeCode.

SELECT o.city
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
WHERE e.employeeNumber IS NULL;


-- TASK 2.5 --
-- Retrieve the most profitable office based on total sales
-- we have 5 tables involved here 
-- consider office code use formula sum(priceEach * quantityOrdered) for total sales from order table
-- join order with order detials via order no
-- join order details with customers with customer no
-- join customer with employees via salesrepemployeeno with emp no
-- join employees with office via office code
-- group by office code
-- order by total sales apply desc and limit function
SELECT off.city, off.officecode, SUM(quantityOrdered * priceEach) AS total_sales
from orderdetails od
JOIN orders o ON o.orderNumber = od.orderNumber
JOIN customers c ON c.customerNumber = o.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices off ON off.officeCode = e.officeCode
GROUP BY officeCode
ORDER BY total_sales DESC
LIMIT 1;


-- TASK 2.6 --
-- FInd the offices with the highest number of emplotee
-- retrieve info from offices
-- JOIN two tables  offices employees
-- GROUP BY off.officeCode
-- ORDER BY city DESC
SELECT city, off.officeCode, COUNT(e.employeeNumber) as No_of_employees
from offices off
JOIN employees e ON off.officeCode = e.officeCode
GROUP BY off.officeCode
ORDER BY city DESC
LIMIT 1;


-- TASK 2.7 --
-- Find the average credit limit for customers in each office
-- retrieve info from offices
-- Join offices and employees
-- to get customer details JOIN customers table
-- GROUP BY off.officecode
-- ORDER BY off.city;
SELECT off.city, off.officecode, AVG(creditLimit) AS AverageCreditLimit
from offices off
JOIN employees e ON e.officeCode = off.officeCode
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY off.officecode
ORDER BY off.city;


-- TASk 2.8 --
-- Find the number of offices in each country
-- Use single table country
-- Use count func to find No_Of_offices
SELECT COUNT(officecode) AS No_Of_offices , country from offices 
GROUP BY country; 


-- TASK 3.1 -- 
-- Count the number of product in each productline
-- Use count func to find No_of_Products
-- Retrieve productline from products
-- GROUP BY productline
SELECT COUNT(productName) as No_of_Products, productline
from products
GROUP BY productline;


-- TASK 3.2 --
-- Find the productline with the highest avg product price
-- Select product table
-- Retrieve productLine
-- Use avg func to find AverageproductPrice
-- sort productLine in ASC LIMIT 1 to find highest avg productline
SELECT AVG(MSRP) AS AverageproductPrice, productLine
from products
GROUP BY productLine
ORDER BY productLine ASC
LIMIT 1;


-- TASK 3.3 --
-- Find all products with a price above or below a certain amount 
-- We will retrieve productname
-- by using where clause we can find price above or below a certain amount
SELECT productCode, productName, MSRP
FROM products
WHERE MSRP BETWEEN 50 AND 100;

-- TASK 3.4 --
-- FInd the total sales amount for each product line
-- Consider two tables orderdetails and products
-- Join them using productcode
-- Use SUM to find total sales
-- Use group by for prductline
SELECT p.productline, SUM(quantityordered * priceeach) AS Total_sales
from products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productline;


-- TASK 3.5 --
-- Identify products with low inventory level
-- Select product table
-- use where clause to show quantityinstcok less than 10
SELECT productCode, productLine, quantityInStock 
from products
WHERE quantityInStock < 10;


-- TASK 3.6 --
-- Retrieve the most expensive product based on MSRP
-- retrieve productName, MSRP
-- From product table
-- Sort MSRP using order by
-- LIMIT to 1 to find most expensive product
SELECT productName, productLine, MSRP
from products
ORDER BY MSRP DESC
LIMIT 1;


-- TASk 3.7 -- 
-- Calculate total sales for each product
-- JOIN two tables by using productcode
-- SUM(quantityordered * priceeach) to find total sales
-- use group by for product
SELECT p.productName, SUM(quantityordered * priceeach) as Total_sales
from products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName;


-- TASK 3.8 --
-- Identify the top selling product based on total quantity ordered using a stored procedure. The procedure should accept an input parameter to specify number of top selling products to retrive
-- Create procedure Gettopsellingrpoduct
-- pass input parameter
-- use sum func to find totalQuantityOrdered
-- JOIN two tables orderdetails and products
-- GROUP BY p.productName
-- ORDER BY totalQuantityOrdered DESC
-- LIMIT top_prod;

DELIMITER //
CREATE PROCEDURE Gettopsellingrpoduct(IN top_prod INT)
BEGIN
	SELECT  p.productName, SUM(od.quantityOrdered) AS totalQuantityOrdered
    FROM orderdetails od
    JOIN products p ON od.productCode = p.productCode
    GROUP BY p.productName
    ORDER BY totalQuantityOrdered DESC
    LIMIT top_prod;
END //
DELIMITER ;

-- Call procedure to get top selling products
CALL Gettopsellingrpoduct(5);


-- TASK 3.9 --
-- retrive products with low inventory levels within specific product line
-- quantity in stock is present in the products table 
-- we use just the products table 
-- select the columns u want to  display from the products table 
-- where quantityinstock is less than 10 
-- and use include (in) for clasic cars and motorcycles
SELECT productCode, productLine, quantityInStock 
from products
WHERE quantityInStock < 10 and productLine IN("Classic Cars" , "Motorcycles");


-- TASK 3.10 -- 
-- Find the names of all products that have been  ordered more than average number of orders  for their product line
-- there is no direct conect between the product table and the orders table 
-- we need to join the order table and the order details table 
-- then join the order details table on product table 
-- group by product name 
-- having count(order.customernumber) > 10
SELECT p.productName, count(o.customernumber) AS numberOfCustomers
from orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON p.productCode = od.productCode
GROUP BY p.productName
HAVING count(o.customernumber) > 10;


-- TASK 3.11 --
-- Find the name of all products that have been ordered more than average number of orders for their product line	
-- Needs subquery
-- Outerquery: Show the list of the products from Products table. Join it on Order_details table on ProductCode field. sum(quantity_ordered) > Avg(write a subquery to get avg of total orders)
-- Innerquery: Get Productline, sum(quantity_ordered) get this information from products and Order_details tables join it on productcode 
-- to get avg order quantity by all products in the same productline.
-- group by productline, productcode
-- HAVING clause: Filters products whose total quantity ordered is above the average for their product line.
SELECT p.productName
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.productLine
HAVING SUM(od.quantityOrdered) > (
    SELECT AVG(product_total)
    FROM (
        SELECT SUM(od2.quantityOrdered) AS product_total
        FROM products p2
        JOIN orderdetails od2 ON p2.productCode = od2.productCode
        WHERE p2.productLine = p.productLine
        GROUP BY p2.productCode
    ) AS avg_sub
);


-- SUMMARY --
/*
The MySQL db, modelcarsdb, contains business data pertaining to scale model cars, inclusing customers, products, sales orders, payment, etc. 
The db will be utilized in this project to execute various mySQL tasks involving different queries and features.
The db has almost 8 tables with different data stored in each table
Performed more than 25 tasks with the help of JOINS, Subquery, Aggregation and filtering
*/







