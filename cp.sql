create database cg_shop;

use cg_shop;

-- drop database cg_shop;

create table products (
	id			int primary key,
    name		varchar(100),
    description text,
    price		decimal,
    quantity	int
);

select * from products;

-- drop table products;

insert into products (id, name, description, price, quantity) values
(1, 'Quần đùi', 'Quần đùi rách gối', 300.00, 25),
(2, 'Áo sơmi', 'Áo sơ mi Hàn Quốc', 250.00, 25),
(3, 'Áo khoác', 'Áo khoác da trơn, đen', 450.00, 25)
;

select * from products;

update products
set price = 350.00
where id = 1;

-- delete from products where id = 1;

alter table products add column is_active bit default 1;
alter table products change column quantity qty int;
alter table products drop column is_active;

select * from products;

-- Learn constraints: not null, unique, check, default
alter table products modify column id int not null;
alter table products modify column name varchar(100) not null;
alter table products modify column description text not null;
alter table products modify column price decimal not null;
alter table products modify column qty int not null;

insert into products (id, name, description, price, qty) values
(6, 'Quần jean2', 'Quần jean xanh đen2', 450, null)
;

alter table products add column link varchar(255) unique;

update products set link = '/quan-dui' where id = 1;
update products set link = '/ao-somi' where id = 2;
update products set link = '/ao-khoac' where id = 3;
update products set link = '/quan-kaki' where id = 4;
update products set link = '/quan-jean' where id = 5;

alter table products
add constraint ck_products_qty check (qty > 0);

update products set qty = -25 where id = 1;

alter table products add column is_active bit default 1;

select * from products;

-- primary key, foreign key, composite key
-- users-roles (n-n) => tách 1 mối quan hệ n-n thành 
-- 2 mối quan hệ 1-n thông qua 1 bảng trung gian
create table roles (
	id int auto_increment primary key,
    name varchar(45) not null,
    description varchar(255)
);

create table users (
	id int auto_increment primary key,
    username varchar(45) not null,
    password varchar(255) not null,
    full_name varchar(255) not null,
    phone varchar(100) not null unique,
    email varchar(255) not null unique
);

create table users_roles (
	user_id int not null,
    role_id int not null,
    primary key (user_id, role_id), -- composite key
    foreign key (user_id) references users(id),
    foreign key (role_id) references roles(id)
);

insert into roles (name, description) values
('ROLE_ADMIN', 'Người dùng'),
('ROLE_USER', 'Quản trị viên')
;

insert into users (username, password, full_name, phone, email) values
('admin123', 'Admin@123', 'CG Admin', '0901234567', 'admin@gmail.com'),
('user123', 'User@123', 'CG User 123', '0901234123', 'user123@gmail.com'),
('user456', 'User@456', 'CG User 456', '0901234456', 'user456@gmail.com')
;

insert into users_roles (user_id, role_id) values
(1, 1),
(2, 2),
(3, 2)
;

select * from products;

delete from products where id = 5;

-- Operators: <>, between, like, in
select * from products where link <> '/ao-khoac';
select * from products where price between 300 and 450;
select * from products where name like 'Áo%';
select * from products where name like '%kaki';

select * from users;
select * from users where full_name like '%User%';

select * from users where full_name like '%User%' or full_name like '%Admin';

select * from products where id in (2,3,4);

update products set is_active = 0 where id =3;

insert into products (id,name ,description,price,qty,link,is_active)values
('6' ,'QUan jean', 'Quan jean xanh den',250,15,'/quan-jean-xanh-den',false);

insert into products

select * from  products;

-- AND,OR,NOT

select * from	products where price >= 300 and is_active = 1;
select * from	products where price >= 300 or is_active = 1;
select * from	products where not is_active = 0;