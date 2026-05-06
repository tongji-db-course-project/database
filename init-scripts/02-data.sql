INSERT INTO customers (customer_name, phone, email)
VALUES ('张三', '13800000001', 'zhangsan@example.com');

INSERT INTO customers (customer_name, phone, email)
VALUES ('李四', '13800000002', 'lisi@example.com');

INSERT INTO customers (customer_name, phone, email)
VALUES ('王五', '13800000003', 'wangwu@example.com');

INSERT INTO products (product_name, category, price, stock_quantity)
VALUES ('数据库教材', '图书', 59.90, 120);

INSERT INTO products (product_name, category, price, stock_quantity)
VALUES ('无线鼠标', '数码', 89.00, 80);

INSERT INTO products (product_name, category, price, stock_quantity)
VALUES ('机械键盘', '数码', 299.00, 45);

INSERT INTO orders (customer_id, order_status)
VALUES (1, 'PAID');

INSERT INTO orders (customer_id, order_status)
VALUES (2, 'CREATED');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (1, 1, 2, 59.90);

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (1, 2, 1, 89.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (2, 3, 1, 299.00);

COMMIT;
