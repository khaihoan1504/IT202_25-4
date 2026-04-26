CREATE DATABASE MiniMartDB;
USE MiniMartDB;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(255),
    customer_type ENUM('Normal', 'VIP') DEFAULT 'Normal'
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10, 2) CHECK (price > 0),
    stock INT DEFAULT 0
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('completed', 'cancelled') DEFAULT 'completed',
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),
    total_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO customers (full_name, phone, address, customer_type) VALUES
('Phạm Công Khải Hoàn', '0912345678', 'Hà Nội', 'VIP'),
('Nguyễn Văn A', '0988888888', 'Hải Phòng', 'VIP'),
('Trần Thị B', '0977777777', 'Đà Nẵng', 'Normal'),
('Lê Văn C', '0966666666', 'TP.HCM', 'Normal'),
('Hoàng Thị D', '0955555555', 'Quảng Ninh', 'Normal'),
('Chu Văn E', '0944444444', 'Nghệ An', 'Normal'),
('Đặng Thị F', '0933333333', 'Cần Thơ', 'Normal');

INSERT INTO products (product_name, category, price, stock) VALUES
('Sữa tươi Vinamilk', 'Thực phẩm', 15000, 50),
('Bánh mì gối', 'Thực phẩm', 25000, 20),
('Thịt lợn sạch', 'Thực phẩm', 120000, 10),
('Bột giặt Omo', 'Hóa mỹ phẩm', 180000, 15),
('Dầu gội Clear', 'Hóa mỹ phẩm', 145000, 0),
('Sữa tắm Lifebuoy', 'Hóa mỹ phẩm', 110000, 12),
('Chổi quét nhà', 'Gia dụng', 45000, 30),
('Nồi cơm điện', 'Gia dụng', 850000, 5),
('Chảo chống dính', 'Gia dụng', 220000, 8),
('Khăn mặt cotton', 'Gia dụng', 20000, 100),
('Coca Cola 1.5L', 'Nước giải khát', 22000, 40),
('Nước suối Aquafina', 'Nước giải khát', 10000, 60),
('Trà xanh C2', 'Nước giải khát', 12000, 25);

INSERT INTO orders (customer_id, status) VALUES
(1, 'completed'),
(2, 'completed'),
(3, 'completed'),
(4, 'cancelled'),
(5, 'completed');

INSERT INTO order_details (order_id, product_id, quantity, total_price) VALUES
(1, 1, 2, 30000), (1, 2, 1, 25000), (1, 3, 1, 120000),
(2, 1, 5, 75000), (2, 8, 1, 850000),
(3, 11, 2, 44000), (3, 12, 5, 50000),
(4, 7, 1, 45000),
(5, 9, 1, 220000), (5, 10, 5, 100000);

UPDATE products 
SET stock = stock - 5 
WHERE id = 1;

SELECT * FROM products 
WHERE category = 'Nước giải khát' 
AND price BETWEEN 10000 AND 50000 
AND stock > 0;

SELECT * FROM customers 
WHERE full_name LIKE 'Nguyễn%' 
OR address = 'Hà Nội';

SELECT o.id, o.order_date, o.status, c.full_name 
FROM orders o
JOIN customers c ON o.customer_id = c.id
ORDER BY o.order_date DESC;

SELECT c.full_name, o.order_date, p.product_name, od.quantity, od.total_price
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_details od ON o.id = od.order_id
JOIN products p ON od.product_id = p.id;

SELECT * FROM customers 
WHERE id NOT IN (SELECT DISTINCT customer_id FROM orders);
