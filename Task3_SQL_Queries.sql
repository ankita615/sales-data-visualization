
-- 1. Total revenue
SELECT SUM(revenue) AS total_revenue FROM orders;

-- 2. Average order revenue
SELECT AVG(revenue) AS avg_revenue FROM orders;

-- 3. Total orders per customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- 4. Join orders and customers
SELECT o.order_id, c.name, o.revenue
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 5. Subquery: Top 5 customers by revenue
SELECT name, total_spent FROM (
    SELECT c.name, SUM(o.revenue) AS total_spent
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.name
) AS customer_revenue
ORDER BY total_spent DESC
LIMIT 5;

-- 6. Revenue per product category
SELECT p.category, SUM(oi.quantity * oi.price) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- 7. View for monthly revenue
CREATE VIEW monthly_revenue AS
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(revenue) AS revenue
FROM orders
GROUP BY month;

-- 8. Handling nulls
SELECT * FROM customers WHERE email IS NULL;

-- 9. Index creation (for performance)
CREATE INDEX idx_customer_id ON orders(customer_id);
