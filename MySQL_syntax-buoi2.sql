-- MySQL

-- Không phân biệt chữ hoa chữ thường "select" & "SELECT"
-- => Sử dụng chữ HOA
-- Dùng dấu ";" để kết thúc dòng

-- Tạo csdl / db / database
CREATE DATABASE demo_database;
CREATE DATABASE IF NOT demo_database;

-- Xóa csdl / db / database
DROP DATABASE demo_database_test;
DROP DATABASE IF EXISTS demo_database_test;

-- Chọn database để thao tác
USE demo_database;

--TABLE

-- Tạo table
CREATE TABLE users(
	user_id INT,
	full_name VARCHAR(255),
	email VARCHAR(255),
	age INT,
	avatar VARCHAR(255),
	birth_day DATE,
	is_active BOOLEAN
	
);

-- Đổi tên table
RENAME TABLE	users	TO	user_new;

-- Xóa Table
DROP TABLE users;
DROP TABLE IF EXISTS users_new;

-- Xóa dữ liệu bên trong Table
TRUNCATE TABLE users;

-- ALTER TABLE
-- Thêm một cột vào Table
ALTER TABLE users
ADD pass_word VARCHAR(255);

-- Xóa một cột
ALTER TABLE users
DROP COLUMN avatar;

-- Đổi tên cột trong Table
-- RENAME sẽ chỉ hổ trợ từ phiên bản sql 8.0 trở lên
ALTER TABLE users
RENAME COLUMN full_name TO fullName;

-- Đổi tên cột cách 2: DÙNG CHO PHIÊN BẢN CŨ HƠN
ALTER TABLE users
CHANGE ten_cot_cu ten_cot_moi VARCHAR(255);

--Sửa đổi kiểu dữ liệu của cột trong table
ALTER TABLE users
MODIFY COLUMN email INT;



-- RÀNG BUỘC
-- NOT NULL: Cột không được NULL, phải có dữ liệu
-- UNIQUE: giá trị trong cột phải khác nhau, duy nhất(id, email, user_name,...)
-- PRIMARY KEY: sự kết hợp của NOT NULL & UNIQUE, thông thường gắn => id, 1 table phải có PRIMARY KEY
-- FOREIGN KEY: Tạo liên kết giữa Table với nhau
-- DEFAULT: đặt giá trị mặc định cho một cột
-- CREATE INDEX: Đánh chỉ mục, láy dữ liệu nhanh hơn(email, ...)

--NOT NULL với CREATE TABLE
CREATE TABLE not_null (
	id INT NOT NULL,
	age INT
);
-- NOT NULL với ALTER TABLE
ALTER TABLE not_null
MODIFY age INT NOT NULL;

-- UNIQUE với CREATE TABLE
CREATE TABLE `unique` (
	unique_id INT NOT NULL UNIQUE,
	
	email VARCHAR(255),
	facebook_id VARCHAR(255),
	
	UNIQUE (email),
	
	CONSTRAINT UC_unique UNIQUE (facebook_id)
);

-- UNIQUE với ALTER TABLE
ALTER TABLE `unique`
ADD UNIQUE (facebook_id);

ALTER TABLE `unique`
ADD CONSTRAINT UC_unique_2 UNIQUE (zalo_id);

--Xóa UNIQUE 
ALTER TABLE `unique`
DROP INDEX UC_unique_2;

-- PRIMARY với CREATE TABLE 
CREATE TABLE primary_key (
	-- cách một
	-- primary_key_id int PRIMARY KEY,
	facebook_id VARCHAR(255),
	google_id VARCHAR(255),
	zalo_id VARCHAR(255),
	github_id VARCHAR(255),
	discord_id VARCHAR(255)
	
	-- cách 2
	-- PRIMARY KEY (facebook_id),
	
	-- cách 3
	-- CONSTRAINT PK_primary_key PRIMARY KEY (google_id, zalo_id)
	
);

-- PRIMARY KEY  với ALTER TABLE 
ALTER TABLE primary_key
ADD PRIMARY KEY (github_id);


ALTER TABLE primary_key
ADD CONSTRAINT PK_primary_key PRIMARY KEY (google_id, zalo_id);


