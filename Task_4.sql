-- 1. List customers who placed their first order in December 2010, ordered by last_order_date
SELECT * 
FROM customers
WHERE MONTH(first_order_date) = 12 AND YEAR(first_order_date) = 2010
ORDER BY last_order_date;


-- 2. Total revenue generated each month across all customers
SELECT 
    DATE_FORMAT(first_order_date, '%Y-%m') AS order_month,
    SUM(revenue) AS total_revenue
FROM customers
GROUP BY order_month
ORDER BY order_month;


-- 3. Total quantity of items bought per country (from order_items)
SELECT country, SUM(qty) AS total_quantity
FROM order_items
GROUP BY country
ORDER BY total_quantity DESC;


-- 4. LEFT JOIN to show all customers and their order info (even if they made no orders)
SELECT c.customer_id, c.revenue, oi.invoice, oi.qty
FROM customers c
LEFT JOIN order_items oi ON c.customer_id = oi.customer_id
ORDER BY c.customer_id;


-- 5. Subquery: Find customers who bought more than 100 units (total from order_items)
SELECT customer_id
FROM (
    SELECT customer_id, SUM(qty) AS total_units
    FROM order_items
    GROUP BY customer_id
) AS sub
WHERE total_units > 100;


-- 6. Create a view to show total revenue and number of orders per customer
CREATE VIEW customer_summary AS
SELECT customer_id, revenue, orders
FROM customers;

-- View the data from the view created above
SELECT * FROM customer_summary;


-- 7. Create an index on customer_id in order_items to speed up joins and filters
CREATE INDEX idx_customer_id ON order_items(customer_id);


-- 8. Bonus: Show top 5 products by revenue
SELECT sku, revenue
FROM products
ORDER BY revenue DESC
LIMIT 5;
