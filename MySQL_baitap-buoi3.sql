--Kiểm tra version
SELECT VERSION();

--AUTO_INCREMENT: tự động tăng, đảm bảo cột khóa chính luôn luôn là duy nhất và không trùng nhau

CREATE TABLE users (
	users_id INT PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(255),
	email VARCHAR(255),
	pass_word VARCHAR(255)
)


-- Thêm dữ liệu
INSERT INTO users(users_id, full_name, email, pass_word) VALUES
(1, "Nguyen Van A", "A@gmail.com","1234"),
(2, "Nguyen Van B", "B@gmail.com","1234"),
(3, "Nguyen Van C", "C@gmail.com","1234"),
(4, "Nguyen Van D", "D@gmail.com","1234"),
(5, "Nguyen Van E", "E@gmail.com","1234");

--Truy vấn
-- 1 - FROM: Sẽ chạy trước
-- 2 - SELECT: Chỉ định kết quả đổ ra
SELECT * 
FROM users

SELECT full_name AS "Họ và tên", email AS "đây là email"
FROM users 

--LIMIT
SELECT *
FROM users 
LIMIT 2 

--WHERE: lọc dữ liệu
SELECT *
FROM users 
WHERE users_id = 2

-- BÀI TẬP NHỎ
-- Tạo table có tên là foods
-- field: foods_id là kiểu số, khóa chính, tự động tăng
-- field: foods_name là kiểu chữ
-- field: description là kiểu chữ

CREATE TABLE foods (
	foods_id INT PRIMARY KEY AUTO_INCREMENT,
	foods_name VARCHAR(255),
	description VARCHAR(255)
)


INSERT INTO foods (foods_name, description)
VALUES 
('Pizza', 'Italian dish with cheese and tomato'),
('Sushi', 'Japanese dish with rice and fish'),
('Burger', 'American fast food with meat and bread'),
('Pasta', 'Italian noodle dish with various sauces'),
('Tacos', 'Mexican dish with tortilla and fillings')


CREATE TABLE orders(
	orders_id INT PRIMARY KEY AUTO_INCREMENT,
	
	users_id INT,
	foods_id INT,
	
	FOREIGN KEY (users_id) REFERENCES users (users_id),
	FOREIGN KEY (foods_id) REFERENCES foods (foods_id)
)

INSERT INTO orders (orders_id, users_id, foods_id)
VALUES
(1, 1, 2),
(2, 3, 1),
(3, 4, 5),
(4, 2, 3),
(5, 5, 4)

-- 1 - 1( ONE - to - ONE)
-- Mô tả: Mỗi bản ghi trong bảng A sẽ chỉ liên kết tới một bảng ghi trong bảng B


-- 1 - N( ONE - to - MANY) 
-- Mô tả: Một bản ghi trong bảng A có thể có nhiều bản ghi tương ứng trong bảnG B

-- N - N( MANY - to - MANY)
-- Mô tả: Một bản ghi trong bảng A có thể liên kết nhiều với bản ghi trong bảng B và ngược lại

--INNER JOIN
SELECT * 
FROM orders 
INNER JOIN users ON users.users_id = orders.users_id
INNER JOIN foods ON orders.foods_id = foods.foods_id

-- trường hợp 2 bảng bằng nhau
-- Sẽ lấy bảng ở FROM làm chuẩn để đi so sánh

-- Trương hợp lấy 2 bảng có số lượng khác nhau
-- sẽ lấy bảng nào ít hàng hơn làm chuẩn để đi so sánh

-- LEFT JOIN: sẽ lấy tất cả các bản ghi bên trái, ngay cả khi không có bản ghi khớp với bản ghi bên phải
SELECT * 
FROM users 
LEFT JOIN orders ON orders.users_id = users.users_id

-- RIGHT JOIN: sẽ lấy tất cả các bản ghi bên PHẢI, ngay cả khi không có bản ghi khớp với bản ghi bên TRÁI
SELECT * 
FROM users 
RIGHT JOIN orders ON orders.users_id = users.users_id

-- CROSS JOIN
SELECT * 
FROM orders 
CROSS JOIN users 

-- GROUP BY: sẽ nhóm những dữ liệu giống nhau và thường được sử dụng với COUNT(), MAX(), MIN(), SUM(), AVG()
-- Query 1 ERROR at Line 125: : Column 'users_id' in group statement is ambiguous
-- vì đang chỉ định cho GROUP BY là nhóm theo cột users_id mà lại có 2 cột users_id, cho nên GROUP BY không biết chọn cộn nào => GROUP BY users.users_id
SELECT *
FROM users 
INNER JOIN orders on orders.users_id = users.users_id
GROUP BY users_id

-- Query 1 ERROR at Line 132: : Expression #5 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'db_app_food.orders.orders_id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
-- Khi dùng GROUP BY thì phải đảm bảo dữ liệu trong hàng phải giống nhau
-- => chỉ định các cột có dữ liệu giống nhau ở SELECT

SELECT *
FROM users 
INNER JOIN orders on orders.users_id = users.users_id
GROUP BY users_id

-- COUNT: đếm số lượng trùng trong lúc nhóm (GROUP BY)

SELECT users.users_id, users.full_name, users.pass_word, orders.users_id, COUNT(users.users_id) AS "Số lượng"
FROM users
INNER JOIN orders on orders.users_id = users.users_id
GROUP BY users.users_id

-- ORDER BY
-- ASC: Sắp xếp tăng dần
-- DESC: Sắp xếp giảm dần
SELECT users.users_id, users.full_name, users.pass_word, orders.users_id, COUNT(users.users_id) AS "Số lượng"
FROM users
INNER JOIN orders on orders.users_id = users.users_id
GROUP BY users.users_id
ORDER BY users.users_id DESC  

-- Tìm 5 người đã orders nhiều nhất.
-- LIMIT 5: giới hạn kết quả chỉ trả ra 5
-- Khi một người mua hàng thì sẽ xuất hiện bên trong orders
-- Thì mình sẽ tìm người dùng xuất hiện nhiều nhất bên trong bảng orders
-- Sắp xếp giảm dần để cho số COUNT lên trên đầu (người dùng mua nhiều nhất)


SELECT COUNT(orders.users_id), users.full_name, users.email
FROM orders
INNER JOIN users on orders.users_id = users.users_id
GROUP BY orders.users_id
ORDER BY `COUNT(orders.users_id)` DESC
LIMIT 5

-- Tìm 2 thức án có lượt mua nhiều nhất.
SELECT COUNT(orders.foods_id), orders.foods_id, foods.foods_id, foods.foods_name, foods.description
FROM orders
INNER JOIN foods on orders.foods_id = foods.foods_id
GROUP BY orders.foods_id
ORDER BY `COUNT(orders.foods_id)` DESC

-- Tìm người đã đặt hàng nhiều nhất.
SELECT COUNT(orders.users_id) AS "Số lần mua", users.full_name, users.email
FROM orders
INNER JOIN users on orders.users_id = users.users_id
GROUP BY orders.users_id
ORDER BY `Số lần mua` DESC
LIMIT 1

-- Tìm người dùng không hoạt động trong hệ thống
-- (không đặt hàng, không like, không đánh giá nhà
-- hàng).

-- Bước 1: lấy tất cả dữ liệu bên trong orders
SELECT *
FROM orders

-- Bước 2: lấy thêm thông tin của bảng users
SELECT *
FROM orders
INNER JOIN users on orders.users_id = users.users_id

-- Bước 3: lấy thêm những người dùng không tồn tại bên trong bảng orders
SELECT *
FROM orders
RIGHT JOIN users on orders.users_id = users.users_id

-- Bước 4: lọc kết quả bên bảng orders tìm xem user_id là NULL thì lấy ra 
-- => WHERE orders.users_id is NULL
SELECT *
FROM orders
RIGHT JOIN users on orders.users_id = users.users_id
WHERE orders.users_id is NULL

-- Bước 5: đổi lại sắp xếp của các bảng
SELECT *
FROM users
LEFT JOIN orders on orders.users_id = users.users_id
LEFT JOIN like_res on like_res.users_id = users.users_id
LEFT JOIN rate_res on rate_res.users_id = users.users_id
WHERE 
orders.users_id is NULL AND 
like_res.user_id is NULL AND
rate_res.user_id is NULL





