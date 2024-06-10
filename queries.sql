USE sql_store;
SELECT last_name,first_name, points * 10 AS discount, points
FROM customers
-- WHERE customer_id = 1
ORDER BY last_name;

SELECT name, unit_price, unit_price * 1.1 AS new_price FROM products;

SELECT * FROM customers;

SELECT DISTICT state FROM customers;

SELECT * FROM customers WHERE points > 3000;

SELECT * FROM customers WHERE state != 'va';

SELECT * FROM customers WHERE state <> 'va';

SELECT * FROM customers WHERE state = 'VA';

SELECT * FROM customers WHERE birth_date > '1990-01-01';

SELECT * FROM customers WHERE birth_date > '1990-01-01' AND  points > 1000;

SELECT * FROM customers WHERE birth_date > '1990-01-01' OR  points > 1000;

SELECT * FROM customers WHERE birth_date > '1990-01-01' OR  points > 1000 AND state = 'va';

SELECT * FROM customers WHERE NOT (birth_date > '1990-01-01' OR  points > 1000 AND state = 'va');

SELECT * FROM order_items WHERE order_id = 6 AND unit_price * quantity > 30;

SELECT * FROM customers WHERE state IN ('VA', 'FL', 'GA');

SELECT * FROM customers WHERE state NOT IN ('VA', 'FL', 'GA');

SELECT * FROM products WHERE quantity_in_stock IN (49, 38, 72);

SELECT * FROM customers WHERE points BETWEEN 1000 AND 3000;

SELECT * FROM customers WHERE last_name LIKE 'b%';

SELECT * FROM customers WHERE last_name LIKE '%b%';

SELECT * FROM customers WHERE last_name LIKE '_____y';

SELECT * FROM customers WHERE phone LIKE '%9';

SELECT * FROM customers WHERE last_name REGEXP 'field';

SELECT * FROM customers WHERE last_name REGEXP 'field$';

SELECT * FROM customers WHERE last_name REGEXP '^field';

SELECT * FROM customers WHERE last_name REGEXP 'mac|field';

SELECT * FROM customers WHERE last_name REGEXP '[gima]e';

SELECT * FROM customers WHERE last_name REGEXP '[a-j]e';

SELECT * FROM customers WHERE first_name REGEXP 'ELKA|ambur';

SELECT * FROM customers WHERE last_name REGEXP 'ey$|on$';

SELECT * FROM customers WHERE last_name REGEXP '^my|se';

SELECT * FROM customers WHERE phone IS NULL;

SELECT * FROM customers WHERE phone IS NOT NULL;

SELECT * FROM customers ORDER BY first_name;

SELECT * FROM customers ORDER BY first_name DESC;

SELECT * FROM customers ORDER BY state DESC, first_name DESC;

SELECT first_name FROM customers ORDER BY birth_date;

SELECT first_name, last_name FROM customers ORDER BY 1, 2;

SELECT * FROM customers LIMIT 5;

SELECT * FROM customers LIMIT 6, 3;

SELECT * FROM customers ORDER BY points DESC LIMIT 3;

SELECT order_id, first_name, last_name FROM orders
JOIN customers
	ON orders.customer_id = customers.customer_id;

SELECT order_id, customers.customer_id, first_name, last_name FROM orders
JOIN customers
	ON orders.customer_id = customers.customer_id;

SELECT order_id, c.customer_id, first_name, last_name FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;

SELECT * FROM order_items oi
JOIN sql_inventory.products p
ON oi.product_id = p.product_id;

SELECT * FROM employees e JOIN employees m ON e.reports_to = m.employee_id;

SELECT e.employee_id, e.first_name, m.first_name FROM employees e JOIN employees m ON e.reports_to = m.employee_id;

SELECT 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name
	FROM orders o
	JOIN customers c
		ON o.customer_id = c.customer_id
	JOIN order_statuses os
		ON o.status = os.order_status_id;

SELECT * FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;

SELECT * FROM orders o, customers c
	WHERE o.customer_id = c.customer_id;

SELECT c.customer_id,
	   c.first_name,
	   o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT c.customer_id,
	   c.first_name,
	   o.order_id
FROM orders o
RIGHT JOIN customers c
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT c.customer_id,
	   c.first_name,
	   o.order_id,
       sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;

SELECT
	o.order_id,
    c.first_name
FROM orders o
JOIN customers c
	USING (customer_id);

SELECT * FROM order_items oi
JOIN order_item_notes oin
	USING (order_id, product_id)

SELECT * FROM orders o
NATURAL JOIN customers c;

SELECT 
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name;

SELECT
	sh.name AS shipper,
    p.name AS product
FROM shippers sh, products p
ORDER BY sh.name;


SELECT
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';

INSERT INTO customers 
VALUES (DEFAULT, 'Pradyumna','KR', '1998-07-23',
		NULL, '2251 Pimmit DR','Falls Church', 'VA', 5000)

INSERT INTO customers (first_name, last_name, birth_date,address, city, state, points)
VALUES ('Pradyumna','KR', '1998-07-23',
		'2251 Pimmit DR','Falls Church', 'VA', 5000);

INSERT INTO shippers (name)
VALUES ('Shipper1'),
	   ('Shipper2');

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2024-06-09', 1);

INSERT INTO order_items VALUES (LAST_INSERT_ID(),1,1,2.95);

CREATE TABLE orders_archived AS
SELECT * FROM orders;

INSERT INTO orders_archived
SELECT * FROM
ORDERS WHERE order_date < '2019-01-01';

UPDATE invoices
SET payment_total = 10, payment_date = '2024-06-09'
WHERE invoice_id = 1;

UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE client_id = (SELECT client_id FROM clients WHERE name = 'Myworks');

DELETE FROM invoices
WHERE invoice_id = 1;





