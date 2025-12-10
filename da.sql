use demo;

create table Class(
id int Primary Key auto_increment,
name varchar(255) not null
);

create table Teacher(
id int Primary Key auto_increment,
name varchar(255) not null,
age int,
country varchar(50)
);