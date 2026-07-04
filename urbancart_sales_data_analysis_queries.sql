CREATE DATABASE urbancart_db;
USE urbancart_db;
RENAME TABLE `products (1)` TO products;
RENAME TABLE `customers (1)` TO customers;
RENAME TABLE `orders (1)` TO orders;

-- a. SELECT, WHERE, ORDER BY, GROUP BY

-- 1. Products in Electronics, sorted by price descending
SELECT 
    *
FROM
    products
WHERE
    category = 'Electronics'
ORDER BY price DESC;

-- 2. Orders placed after a certain date
SELECT 
    *
FROM
    orders
WHERE
    order_date > '2023-01-01';
    
-- 3. Count of products per category
SELECT 
    category, COUNT(*) AS total_products
FROM
    products
GROUP BY category;

-- 4. Top 5 most expensive products
SELECT 
    *
FROM
    products
ORDER BY price DESC
LIMIT 5;

-- JOINS

-- 5. Orders with customer city (INNER JOIN)
SELECT 
    o.order_id, c.customer_id, c.city, o.order_date
FROM
    orders o
        INNER JOIN
    customers c ON o.customer_id = c.customer_id;
    
-- 6. All customers, including those with no orders (LEFT JOIN)
SELECT 
    c.customer_id, c.city, o.order_id
FROM
    customers c
        LEFT JOIN
    orders o ON c.customer_id = o.customer_id;
    
-- 7. All products, including those never ordered (RIGHT JOIN)
SELECT 
    p.product_name, o.order_id
FROM
    orders o
        RIGHT JOIN
    products p ON o.product_id = p.product_id;
    
-- 8. Order details with product name and price
SELECT 
    o.order_id, p.product_name, p.price, o.quantity
FROM
    orders o
        JOIN
    products p ON o.product_id = p.product_id;
    
-- Subqueries

-- 9. Customers who never placed an order
SELECT 
    *
FROM
    customers
WHERE
    customer_id NOT IN (SELECT 
            customer_id
        FROM
            orders);
            
-- 10. Products priced above average
SELECT 
    *
FROM
    products
WHERE
    price > (SELECT 
            AVG(price)
        FROM
            products);
            
-- 11. Customer with the most orders
SELECT 
    customer_id, COUNT(*) AS order_count
FROM
    orders
GROUP BY customer_id
ORDER BY order_count DESC
LIMIT 1;

-- Aggregate functions

-- 12. Total revenue (quantity * price)
SELECT 
    SUM(o.quantity * p.price) AS total_revenue
FROM
    orders o
        JOIN
    products p ON o.product_id = p.product_id;
    
-- 13. Average order value
SELECT 
    AVG(o.quantity * p.price) AS avg_order_value
FROM
    orders o
        JOIN
    products p ON o.product_id = p.product_id;
    
-- 14. Orders per customer
SELECT 
    customer_id, COUNT(*) AS total_orders
FROM
    orders
GROUP BY customer_id;

-- 15. Revenue by category
SELECT 
    p.category, SUM(o.quantity * p.price) AS category_revenue
FROM
    orders o
        JOIN
    products p ON o.product_id = p.product_id
GROUP BY p.category;

-- Views

-- 16. Customer order summary view
CREATE VIEW customer_order_summary AS
SELECT c.customer_id, c.city, COUNT(o.order_id) AS total_orders,
       SUM(o.quantity * p.price) AS total_spend
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.city;

-- 17. Top selling products view
CREATE VIEW top_selling_products AS
SELECT p.product_name, SUM(o.quantity) AS total_quantity_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

-- Indexes

-- 18. Add index on customer_id in orders
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_customer_id ON orders(customer_id(20));

-- 19. Check query plan before/after
EXPLAIN SELECT * FROM orders WHERE customer_id = 'C001';