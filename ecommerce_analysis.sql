```sql
-- 1. Create Tables
CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    joined_date TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name TEXT NOT NULL,
    price REAL NOT NULL,
    stock_quantity INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    order_date TEXT DEFAULT CURRENT_TIMESTAMP,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 2. Insert Sample Data
INSERT INTO customers (name, email) VALUES ('Ahmed Ali', 'ahmed@example.com');
INSERT INTO customers (name, email) VALUES ('Sara Mohamed', 'sara@example.com');

INSERT INTO products (product_name, price, stock_quantity) VALUES ('Wireless Mouse', 25.50, 100);
INSERT INTO products (product_name, price, stock_quantity) VALUES ('Mechanical Keyboard', 75.00, 45);

INSERT INTO orders (customer_id, total_amount) VALUES (1, 100.50);
INSERT INTO orders (customer_id, total_amount) VALUES (2, 75.00);

-- 3. Analytical Query: Total spending per customer
SELECT 
    c.name AS customer_name,
    c.email,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;
-- Additional Analytical Queries for Reporting
-- 4. Find products with low stock (less than 50 units)
SELECT product_name, stock_quantity 
FROM products 
WHERE stock_quantity < 50;

-- 5. Calculate average order amount
SELECT AVG(total_amount) AS average_order_value 
FROM orders;
