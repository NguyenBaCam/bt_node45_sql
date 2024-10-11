
-- Tạo bảng food_type trước
CREATE TABLE food_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(255)
);

-- Nhập dữ liệu vào bảng food_type
INSERT INTO food_type (type_id, type_name) 
VALUES 
(1," Khai vị") ,
(2," Món chính"),
(3," Tráng miệng"),
(4," Đồ uống");

-- Tạo bảng user
CREATE TABLE users (
    users_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

-- Nhâp dữ liệu vào bảng users
INSERT INTO users(users_id, full_name, email, password) VALUES
(1, "Nguyen Van A", "A@gmail.com","1234"),
(2, "Nguyen Van B", "B@gmail.com","1234"),
(3, "Nguyen Van C", "C@gmail.com","1234"),
(4, "Nguyen Van D", "D@gmail.com","1234"),
(5, "Nguyen Van E", "E@gmail.com","1234"),
(6, "Nguyen Van F", "F@gmail.com","1234");

-- Tạo bảng restaurant
CREATE TABLE restaurant (
    res_id INT AUTO_INCREMENT PRIMARY KEY,
    res_name VARCHAR(255),
    image VARCHAR(255),
    `desc` TEXT
);

-- Nhập dữ liệu vào bảng restaurant
INSERT INTO restaurant (res_id, res_name, image, `desc`) 
VALUES
(1, "Phở Thìn", "phothin.jpg", "Nhà hàng nổi tiếng với món Phở"),
(2, "Highlands Coffee", "highlands.jpg", "Chuỗi cà phê nổi tiếng ở Việt Nam"),
(3, "Trung Nguyên Legend", "trungnguyenlg.jpg", "Chuỗi nhà hàng nổi tiếng thuộc sở hữu của Đặng Lê Nguyên Vũ"),
(4, "Ẩm thực Trần", "amthuctran.jpg", "Là nhà hàng ở đà nẵng, nổi tiếng với những món ăn đặc sản đến từ Quảng Nam, Đà Nẵng"),
(5, "Bánh xèo Bà Dưỡng", "banhxeo.jpg", "Nổi tiếng với món bánh xèo, to, tròn, nhiều topping. Đổi lại với cái giá chát đối với sinh viên và người đi làm việc tay chân"),
(6, "Kichi Kichi", "kichi.jpg", "Lẩu băng chuyền");

-- Tạo bảng food
CREATE TABLE foods (
    foods_id INT AUTO_INCREMENT PRIMARY KEY,
    foods_name VARCHAR(255),
    image VARCHAR(255),
    price FLOAT,
    `desc` TEXT,
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES food_type(type_id)
);

-- Nhập dữ liệu vào bảng foods
INSERT INTO foods( foods_name, image, price, `desc`, type_id)
VALUES
( "Phở Bò", "pho.jpg", 50.000, "Phở bò truyền thống đặc biệt",2),
( "Coffee sữa", "coffee.jpg", 35.000, "Coffee phổ biến từ Bắc vào Nam", 4),
( "Bánh xèo", "banhxeo.jpg", 75.000, "Món bánh xèo đặc sản của Đà Nẵng", 2),
( "Bánh tráng cuốn thịt heo", "banhtrangthitheo.jpg", 135.000, "Món ăn đặc sản đà nẵng, bánh tráng cuốn thịt heo 2 đầu da", 2),
( "Trà đào", "tradao.jpg", 25.000, "Nước uống ngon", 4),
( "Kem dừa", "kemdua.jpg", 35.000, "Kem dừa mã lai, thái lan ở đường Phan Tứ, Lê Đình Lý tại Đà Nẵng tạm ổn", 3),
( "Gỏi tôm chả", "goi.jpg", 55.000, "Là món khai vị phổ biens ở vùng quê Việt Nam, tập hợp rau củ quả và tôm thịt mix với nước mắm chua ngọt", 1);


-- Tạo bảng orders
CREATE TABLE orders (
    users_id INT,
    foods_id INT,
    amount INT,
    code VARCHAR(50),
    arr_sub_id VARCHAR(255),
    FOREIGN KEY (users_id) REFERENCES users(users_id),
    FOREIGN KEY (foods_id) REFERENCES foods(foods_id)
);

-- Nhập dữ liệu vào bảng orders
INSERT INTO orders (users_id, foods_id, amount, code, arr_sub_id)
VALUES
( 1, 1, 2, "ORDER001", "1,5"),
( 2, 3, 1, "ORDER002", "6"),
( 3, 2, 3, "ORDER003", "7"),
( 4, 4, 2, "ORDER004", "2"),
( 5, 5, 3, "ORDER005", "4"),
( 1, 3, 2, "ORDER006", "6"),
( 1, 5, 6, "ORDER007", "4");

-- Tạo bảng rate_res
CREATE TABLE rate_res (
    users_id INT,
    res_id INT,
    amount INT NOT NULL,
    date_rate DATETIME,
    FOREIGN KEY (users_id) REFERENCES users(users_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

-- Nhập dữ liệu vào bảng rate_res
INSERT INTO rate_res (users_id, res_id, amount, date_rate)
VALUES 
(1, 1, 5, '2024-10-10'),
(2, 2, 4, '2024-10-10'),
(3, 3, 5, '2024-10-10'),
(4, 2, 3, '2024-10-10'),
(5, 1, 4, '2024-10-11'),
(3, 1, 5, '2024-10-11'),
(1, 4, 5, '2024-10-11'),
(2, 5, 4, '2024-10-11');

-- Tạo bảng like_res
CREATE TABLE like_res (
    users_id INT,
    res_id INT,
    date_like DATETIME,
    FOREIGN KEY (users_id) REFERENCES users(users_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

-- Nhập dữ liệu vào bảng like_res
INSERT INTO like_res (users_id, res_id, date_like)
VALUES
(1, 1, '2024-10-10'),
(2, 1, '2024-10-10'),
(3, 2, '2024-10-10'),
(4, 3, '2024-10-11'),
(5, 1, '2024-10-11'),
(1, 2, '2024-10-11'),
(2, 3, '2024-10-11'),
(3, 4, '2024-10-11'),
(4, 2, '2024-10-11');

-- Tạo bảng sub_food
CREATE TABLE sub_food (
    sub_id INT AUTO_INCREMENT PRIMARY KEY,
    sub_name VARCHAR(255),
    sub_price FLOAT,
    foods_id INT,
    FOREIGN KEY (foods_id) REFERENCES foods(foods_id)
);

-- Nhập bảng dữ liệu vào sub_food
INSERT INTO sub_food ( sub_id, sub_name, sub_price, foods_id)
VALUES
(1, "Thêm phở", 10.000, 1),
(2, "Thêm thịt lợn", 15.000, 4),
(3, "Kem topping", 15.000, 6),
(4, "Topping thạch", 5.000, 5),
(5, "Thịt bò tái, nạm, gân", 15.000, 1),
(6, "Sốt chấm", 0, 3),
(7, "Sữa thêm", 0, 2);


------------------------------------------
-- Tìm 5 người đã like nhà hàng nhiều nhất
SELECT COUNT(like_res.users_id) AS "Số lượng like" , users.full_name, users.email
FROM like_res
INNER JOIN users on like_res.users_id = users.users_id
GROUP BY like_res.users_id
ORDER BY COUNT(like_res.users_id) DESC
LIMIT 5

-- Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT COUNT(like_res.res_id) AS "Số lượng like" , restaurant.res_name, restaurant.image
FROM like_res
INNER JOIN restaurant on like_res.res_id = restaurant.res_id
GROUP BY like_res.res_id
ORDER BY COUNT(like_res.res_id) DESC
LIMIT 2

-- Tìm người đã đặt hàng nhiều nhất
SELECT COUNT(orders.users_id) AS "Số lượng like" , users.full_name, users.email
FROM orders
INNER JOIN users on orders.users_id = users.users_id
GROUP BY orders.users_id
ORDER BY COUNT(orders.users_id) DESC
LIMIT 1

-- Tìm người dùng không hoạt động trong hệ thống( Không đặt hàng, không like, không đánh giá nhà hàng)
SELECT *
FROM users
LEFT JOIN orders on orders.users_id = users.users_id
LEFT JOIN like_res on like_res.users_id = users.users_id
LEFT JOIN rate_res on rate_res.users_id = users.users_id
WHERE 
orders.users_id is NULL AND 
like_res.users_id is NULL AND
rate_res.users_id is NULL
