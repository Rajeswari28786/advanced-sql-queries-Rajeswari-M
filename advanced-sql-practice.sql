-- Create the online_store schema
CREATE SCHEMA online_store;

-- Select the database
USE online_store;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- Task 1: Create customers table
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Task 2: Create orders table
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT NULL,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Task 3: Insert sample customer data
INSERT INTO customers (id, first_name, last_name) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

-- Task 4: Insert sample order data
INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

-- Task 5: Group orders by customer and calculate total spent
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- Task 6: Group orders by customer and order date
SELECT customer_id, order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id, order_date;

-- Task 7: Use HAVING to find customers with more than $200 in orders
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200;

-- Task 8: INNER JOIN to show orders with matching customer details
SELECT
    orders.id,
    customers.first_name,
    customers.last_name,
    orders.order_date,
    orders.total_amount
FROM orders
INNER JOIN customers
    ON orders.customer_id = customers.id;

-- Task 9: LEFT JOIN to show all orders, including those without a customer
SELECT
    orders.id,
    customers.first_name,
    customers.last_name,
    orders.order_date,
    orders.total_amount
FROM orders
LEFT JOIN customers
    ON orders.customer_id = customers.id;

-- Task 10: Subquery to find orders at or above the average order amount
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount >= (
    SELECT AVG(total_amount)
    FROM orders
);

-- Task 11: Subquery to find orders belonging to customers with the last name Smith
SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (
    SELECT id
    FROM customers
    WHERE last_name = 'Smith'
);

-- Task 12: Subquery in the FROM clause to retrieve order dates
SELECT order_date
FROM (
    SELECT id, order_date, total_amount
    FROM orders
) AS order_summary;
