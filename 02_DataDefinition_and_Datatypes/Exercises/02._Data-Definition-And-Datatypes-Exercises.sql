
/*1.	Create Database
You now know how to create database using the GUI of the HeidiSQL. Now it’s time to create it using SQL queries. 
In that task (and the several following it) you will be required to create the database from the previous exercise using only SQL queries. 
Firstly, just create new database named minions.*/

/*
2.	Create Tables
In the newly created database Minions add table minions (id, name, age). Then add new table towns (id, name). 
Set id columns of both tables to be primary key as constraint.
 */

CREATE  TABLE minions
(
	id INT PRIMARY KEY,
	name VARCHARACTER(50),
	age INT
);
CREATE  TABLE towns
(
	id INT PRIMARY KEY,
	name VARCHARACTER(50)
)
 
/*
3_Alter Minions Table
Change the structure of the Minions table to have new column town_id that would be of the same type as the id column of towns table. 
Add new constraint that makes town_id foreign key and references to id column of towns table. 
*/

ALTER TABLE minions
ADD town_id INT,
ADD CONSTRAINT FOREIGN KEY (town_id) REFERENCES towns(id);

/*
04_Insert Records in Both Tables
Populate both tables with sample records given in the table below.
minions		towns
id	name	age	town_id		id	name
1	Kevin	22	   1		1	Sofia
2	Bob	     15	   3		2	Plovdiv
3	Steward	NULL	2		3	Varna
Use only insert SQL queries. Submit your INSERT statements in Judge as Run skeleton, run queries & check DB.
*/

INSERT INTO towns
VALUES(1, 'Sofia');

INSERT INTO towns
VALUES(2, 'Plovdiv');

INSERT INTO towns
VALUES(3, 'Varna');

INSERT INTO minions
VALUES(1, 'Kevin', 22, 1);

INSERT INTO minions
VALUES(2, 'Bob', 15, 3);

INSERT INTO minions
VALUES(3, 'Steward', NULL, 2);

/*
05_Truncate Table Minions
Delete all the data from the minions table using SQL query. Submit your query in Judge as Run skeleton, run queries & check DB.
*/

TRUNCATE TABLE minions;

/*
06_Drop All Tables
Delete all tables from the minions database using SQL query.
*/

DROP TABLE minions, towns;

/*
07_Create Table People
Using SQL query create table “people” with columns:
•	id – unique number for every person there will be no more than 231-1people. (Auto incremented)
•	name – full name of the person will be no more than 200 Unicode characters. (Not null)
•	picture – image with size up to 2 MB. (Allow nulls)
•	height –  In meters. Real number precise up to 2 digits after floating point. (Allow nulls)
•	weight –  In kilograms. Real number precise up to 2 digits after floating point. (Allow nulls)
•	gender – Possible states are m or f. (Not null)
•	birthdate – (Not null)
•	biography – detailed biography of the person it can contain max allowed Unicode characters. (Allow nulls)
Make id primary key. Populate the table with 5 records.  Submit your CREATE and INSERT statements in Judge as Run queries & check DB.
*/

CREATE TABLE people
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(200) NOT NULL,
	picture BLOB,
	height  FLOAT,
	weight FLOAT,
	gender CHAR NOT NULL,
	birthdate DATE NOT NULL,
	biography TEXT
);
INSERT INTO people(name, gender, birthdate) VALUES('ivaylo','M', '1977.05.07');
INSERT INTO people(name, gender, birthdate) VALUES('ivaylo','M', '1977.05.07');
INSERT INTO people(name, gender, birthdate) VALUES('ivaylo','M', '1977.05.07');
INSERT INTO people(name, gender, birthdate) VALUES('ivaylo','M', '1977.05.07');
INSERT INTO people(name, gender, birthdate) VALUES('ivaylo','M', '1977.05.07');


/*
08_Create Table Users
Using SQL query create table users with columns:
•	id – unique number for every user. There will be no more than 263-1 users. (Auto incremented)
•	username – unique identifier of the user will be no more than 30 characters (non Unicode). (Required)
•	password – password will be no longer than 26 characters (non Unicode). (Required)
•	profile_picture – image with size up to 900 KB. 
•	last_login_time
•	is_deleted – shows if the user deleted his/her profile. Possible states are true or false.
Make id primary key. Populate the table with 5 records. Submit your CREATE and INSERT statements. 
*/

CREATE TABLE users
(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	username CHAR(30) UNIQUE NOT NULL,
	`password` CHAR(26) NOT NULL,
	profile_picture MEDIUMBLOB,
	last_login_time TIMESTAMP,
	is_deleted TINYINT(1)
);

INSERT INTO users(username, `password`, is_deleted)
VALUES('ivaylo I','pass', 0);

INSERT INTO users(username, `password`, is_deleted)
VALUES('ivaylo II','pass', 0);

INSERT INTO users(username, `password`, is_deleted)
VALUES('ivaylo III','pass', 0);

INSERT INTO users(username, `password`, is_deleted)
VALUES('ivaylo IV','pass', 0);

INSERT INTO users(username, `password`, is_deleted)
VALUES('ivaylo V','pass', 0);



/*
09_Change Primary Key
Using SQL queries modify table users from the previous task. First remove current primary key then create new primary key 
that would be combination of fields id and username. The initial primary key name on id is pk_users. 
*/

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users` PRIMARY KEY (`id`, `username`);

/*
10_Set Default Value of a Field
Using SQL queries modify table users. Make the default value of last_login_time field to be the current time. 
*/

ALTER TABLE `users`
CHANGE last_login_time last_login_time TIMESTAMP;

/*
11_Set Unique Field
Using SQL queries modify table users. Remove username field from the primary key so only the field id would be primary key.
Now add unique constraint to the username field. The initial primary key name on (id, username) is pk_users.
*/

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT PRIMARY KEY (`id`),
ADD CONSTRAINT UNIQUE (`username`);

/*
12_Movies Database
Using SQL queries create Movies database with the following entities:
•	directors (id, director_name, notes) 
•	genres (id, genre_name, notes) 
•	categories (id, category_name, notes)  
•	movies (id, title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
Set most appropriate data types for each column. Set primary key to each table. Populate each table with 5 records. Make sure the columns that are present 
in 2 tables would be of the same data type. Consider which fields are always required and which are optional. Submit your CREATE TABLE and INSERT statements
as Run queries & check DB.
*/


CREATE DATABASE movies;

CREATE TABLE directors
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	director_name VARCHAR(200) NOT NULL,
	notes TEXT
);

CREATE TABLE genres
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	genre_name VARCHAR(200) NOT NULL,
	notes TEXT
);

CREATE TABLE categories
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	category_name VARCHAR(200) NOT NULL,
	notes TEXT
);

CREATE TABLE movies
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(200) NOT NULL,
	director_id INT,
	INDEX dir_ind (director_id),
	FOREIGN KEY(director_id) REFERENCES directors(id),
	copyright_year DATE,
	`length` DECIMAL,
	genre_id INT,
	INDEX genre_ind (genre_id),
	FOREIGN KEY(genre_id) REFERENCES genres(id),
	category_id INT,
	INDEX category_ind (category_id),
	FOREIGN KEY(category_id) REFERENCES categories(id),
	rating DECIMAL,
	notes TEXT
);

INSERT INTO categories(category_name)
VALUES('name1'),('name2'),('name3'),('name4'),('name5');
INSERT INTO directors(director_name)
VALUES('name1'),('name2'),('name3'),('name4'),('name5');
INSERT INTO genres(genre_name)
VALUES('name1'),('name2'),('name3'),('name4'),('name5');
INSERT INTO movies(title,director_id,genre_id,category_id)
VALUES
('name1',1,1,1),
('name2',2,2,2),
('name3',3,3,3),
('name4',4,4,4),
('name5',5,5,5);

--100/100 judge
CREATE TABLE directors
(
	id INT(11) NOT NULL PRIMARY KEY,
	director_name VARCHAR(50) NOT NULL,
	notes TEXT
);
CREATE TABLE genres
(
	id INT(11) NOT NULL PRIMARY KEY,
	genre_name VARCHAR(50) NOT NULL,
	notes TEXT
);
CREATE TABLE categories 
(
	id INT(11) NOT NULL PRIMARY KEY,
	category_name VARCHAR(50) NOT NULL,
	notes TEXT
);
CREATE TABLE movies 
(
	id INT(11) NOT NULL PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	director_id VARCHAR(50),
	copyright_year DATE, LENGTH TIME,
	genre_id INT(11), 
	category_id INT(11), 
	rating DOUBLE(2,1),
	notes TEXT
);
INSERT INTO categories(id, category_name) VALUES(1, 'first'),(2, 'first1'),(3, 'first2'),(4, 'first3'),(5, 'first4');
INSERT INTO directors(id, director_name) VALUES(1, 'first'),(3, 'first1'),(4, 'first2'),(5, 'first3'),(6, 'first4');
INSERT INTO genres(id, genre_name) VALUES(1, 'first'),(2, 'first1'),(3, 'first2'),(4, 'first3'),(5, 'first4');
INSERT INTO movies(id, title,	director_id,genre_id,category_id) 
VALUES(1, 'Titanic',1,1,1),(2, 'Avatar',2,2,2),(3, 'It',3,3,3),(4, 'The Godfather',4,4,4),(5, 'Scarface',4,4,5);

/*
13_Car Rental Database
Using SQL queries create car_rental database with the following entities:
•	categories (id, category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
•	cars (id, plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
•	employees (id, first_name, last_name, title, notes)
•	customers (id, driver_licence_number, full_name, address, city, zip_code, notes)
•	rental_orders (id, employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, 
total_days, rate_applied, tax_rate, order_status, notes)
Set most appropriate data types for each column. Set primary key to each table. Populate each table with 3 records. 
Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always required and which are optional. 
Submit your CREATE TABLE and INSERT statements as Run queries & check DB.
*/

CREATE TABLE categories
(
	id INT(11) PRIMARY KEY,
	category VARCHAR(50) NOT NULL,
	daily_rate INT(3),
	weekly_rate INT(3),
	monthly_rate INT(3),
	weekend_rate INT(3)
);
CREATE TABLE cars
(
	id INT PRIMARY KEY,
	plate_number VARCHAR(50) NOT NULL,
	make VARCHAR(50),
 model VARCHAR(50),
	car_year INT(4),
	category_id INT(11),
	doors INT(2),
	picture BLOB,
	car_condition VARCHAR(50),
	available BOOL
);
CREATE TABLE employees
(
	id INT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	title VARCHAR(50),
	notes TEXT
);
CREATE TABLE customers
(
	id INT PRIMARY KEY,
	driver_licence_number INT(11) NOT NULL,
	full_name VARCHAR(50),
	address VARCHAR(50),
	city VARCHAR(50),
	zip_code INT(5),
	notes TEXT
);
CREATE TABLE rental_orders 
(
	id INT PRIMARY KEY,
	employee_id INT(11) NOT NULL,
	customer_id INT(11) NOT NULL,
	car_id INT(11) NOT NULL,
	car_condition VARCHAR(50),
	tank_level INT(11),
	kilometrage_start INT(11),
	kilometrage_end INT(11),
	total_kilometrage INT(11),
	start_date DATE,
	end_date DATE,
	total_days INT(11),
	rate_applied INT(3),
	tax_rate INT(11),
	order_status VARCHAR(50),
	notes TEXT
);
INSERT INTO cars(id, plate_number) VALUES (1, '123'),(2, '1234'),(3, '12345');
INSERT INTO categories(id, category) VALUES (1, 'Classic'),(2, 'Limuzine'),(3, 'Sport');
INSERT INTO customers(id, driver_licence_number) VALUES (1, '2232'),(2, '232323'),(3, '111');
INSERT INTO employees(id, first_name,last_name) VALUES (1, 'Ivan', 'Ivanov'),(2, 'Ivan1', 'Ivanov1'), (3, 'Ivan2', 'Ivanov2');
INSERT INTO rental_orders(id, employee_id,customer_id, car_id) VALUES (1,1,1, 1),(2,2, 1, 2), (3,3,2, 3);

/*
14.	Hotel Database
Using SQL queries create Hotel database with the following entities:
•	employees (id, first_name, last_name, title, notes)
•	customers (account_number, first_name, last_name, phone_number, emergency_name, emergency_number, notes)
•	room_status (room_status, notes)
•	room_types (room_type, notes)
•	bed_types (bed_type, notes)
•	rooms (room_number, room_type, bed_type, rate, room_status, notes)
•	payments (id, employee_id, payment_date, account_number, first_date_occupied, last_date_occupied, total_days, amount_charged, tax_rate, tax_amount, payment_total, notes)
•	occupancies (id, employee_id, date_occupied, account_number, room_number, rate_applied, phone_charge, notes)
Set most appropriate data types for each column. Set primary key to each table. Populate each table with 3 records. 
Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always required and which are optional. Submit your 
CREATE TABLE and INSERT statements as Run queries & check DB.*/

CREATE DATABASE hotel;
USE hotel;
CREATE TABLE employees
(
	id INT(11) AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	title VARCHAR(50),
	notes TEXT
);
CREATE TABLE customers
(
	account_number VARCHAR(50) NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	phone_number VARCHAR(50),
	emergency_name VARCHAR(50),
	emergency_number VARCHAR(50),
	notes TEXT
);
CREATE TABLE room_status
(
	room_status VARCHAR(50) NOT NULL PRIMARY KEY,
	notes TEXT
);
CREATE TABLE room_types
(
	room_type VARCHAR(50) NOT NULL PRIMARY KEY,
	notes TEXT
);
CREATE TABLE bed_types
(
	bed_type VARCHAR(50) NOT NULL PRIMARY KEY,
	notes TEXT
);
CREATE TABLE rooms
(
	room_number INT(5) NOT NULL PRIMARY KEY,
	room_type VARCHAR(50),
	bed_type VARCHAR(50),
	rate DOUBLE(2,1),
	room_status VARCHAR(50),
	notes TEXT
);
CREATE TABLE payments
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	employee_id INT(11) NOT NULL,
	payment_date DATE,
	account_number VARCHAR(50),
	first_date_occupied DATE,
	last_date_occupied DATE,
	total_days INT(11),
	amount_charged INT(11),
	tax_rate INT(11),
	tax_amount INT(11),
	payment_total INT(11),
	notes TEXT
);
CREATE TABLE occupancies
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	employee_id INT(11) NOT NULL,
	date_occupied DATE,
	account_number VARCHAR(50),
	room_number INT(5),
	rate_applied DOUBLE(2,1),
	phone_charge INT(11),
	notes TEXT
);
INSERT INTO employees(first_name, last_name) VALUES ('Ivan1','Ivanov1'),('Ivan2','Ivanov2'),('Ivan3','Ivanov3');
INSERT INTO customers(account_number, first_name, last_name) 
VALUES ('22', 'Ivan1','Ivanov1'),('221','Ivan2','Ivanov2'),('122','Ivan3','Ivanov3');
INSERT INTO room_status(room_status) VALUES ('free'),('freee'),('taken');
INSERT INTO room_types(room_type) VALUES ('family'),('two room'),('apartment');
INSERT INTO bed_types(bed_type) VALUES ('big'),('small'),('medium');
INSERT INTO rooms(room_number) VALUES (22),(212),(311);
INSERT INTO payments(employee_id) VALUES (22),(212),(311);
INSERT INTO occupancies(employee_id) VALUES (22),(212),(311);

/*
15_Create SoftUni Database
Now create bigger database called soft_uni. You will use database in the future tasks. It should hold information about
•	towns (id, name)
•	addresses (id, address_text, town_id)
•	departments (id, name)
•	employees (id, first_name, middle_name, last_name, job_title, department_id, hire_date, salary, address_id)
Id columns are auto incremented starting from 1 and increased by 1 (1, 2, 3, 4…). Make sure you use appropriate data types for each column. 
Add primary and foreign keys as constraints for each table. Use only SQL queries. Consider which fields are always required and which are optional. 
Submit your CREATE TABLE  statements as Run queries & check DB.
*/

CREATE DATABASE soft_uni;

USE soft_uni;

CREATE TABLE towns
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(200) NOT NULL
);

CREATE TABLE addresses
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	address_text TEXT NOT NULL,
	town_id INT,
	INDEX town_ind (town_id),
	FOREIGN KEY(town_id) REFERENCES towns(id)
);

CREATE TABLE departments
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(200) NOT NULL
);

CREATE TABLE employees
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	middle_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	job_title VARCHAR(50) NOT NULL,
	department_id INT,
	INDEX dep_ind (department_id),
	FOREIGN KEY(department_id) REFERENCES departments(id),
	hire_date DATE,
	salary DECIMAL,
	address_id INT,
	INDEX address_ind (address_id),
	FOREIGN KEY(address_id) REFERENCES addresses(id)
);

/*
16_Backup Database
By using mysqldump command from MySql command line make a backup of the database soft_uni, from the previous tasks, into a file named “softuni-backup.sql”. 
Drop your database from Heidi or MySQL Workbench. Then restore the database from the created backup file by using mysql  command line.
*/

C:\xampp\mysql\bin>mysqldump -u root  soft_uni > softuni-backup.sql

CREATE DATABASE soft_uni;
C:\xampp\mysql\bin>mysql -u root soft_uni < softuni-backup.sql

/*
17_Basic Insert
Use the SoftUni database and insert some data using SQL queries.
name	              job_title	        department	        hire_date	salary
Ivan Ivanov Ivanov	.NET Developer	Software Development	01/02/2013	3500.00
Petar Petrov Petrov	Senior Engineer	 Engineering	        02/03/2004	4000.00
Maria Petrova Ivanova	Intern	   Quality Assurance	    28/08/2016	525.25
Georgi Terziev Ivanov	CEO	           Sales	            09/12/2007	3000.00
Peter Pan Pan	       Intern	      Marketing	            28/08/2016	599.88
•	towns: Sofia, Plovdiv, Varna, Burgas
•	departments: Engineering, Sales, Marketing, Software Development, Quality Assurance
•	employees:
Submit your INSERT queries in Judge as Run skeleton, run queries & check DB.
*/

INSERT INTO towns(name) Values('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');
INSERT INTO departments  (name) Values('Engineering'), ('Sales'), ('Marketing'), ('Software Development'),('Quality Assurance');
INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
Values('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);


/*1
18_Basic Select All Fields
Use the soft_uni database and first select all records from the towns, then from departments and finally from employees table. 
Use SQL queries and submit them to Judge at once. Submit your query statements as Prepare DB & Run queries.
*/

SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM employees;

/*
19_Basic Select All Fields and Order Them
Modify queries from previous problem by sorting:
•	towns - alphabetically by name
•	departments - alphabetically by name
•	employees - descending by salary
Submit your query statements as Prepare DB & Run queries.
*/

SELECT * FROM towns ORDER BY name;
SELECT * FROM departments ORDER BY name;
SELECT * FROM employees ORDER BY salary DESC;

/*
20_Basic Select Some Fields
Modify queries from previous problem to show only some of the columns. For table:
•	towns – name
•	departments – name
•	employees – first_name, last_name, job_title, salary
Keep the ordering from the previous problem. 
*/

SELECT name FROM towns ORDER BY name;
SELECT name FROM departments ORDER BY name;
SELECT first_name, last_name, job_title, salary FROM employees ORDER BY salary DESC;

/*
21_Increase Employees Salary
Use softuni database and increase the salary of all employees by 10%. Select only salary column from the employees table. 
Submit your query statements as Prepare DB & Run queries.
*/

UPDATE employees SET salary = salary * 1.1;
SELECT salary FROM employees;

/*
22_Decrease Tax Rate
Use hotel database and decrease tax rate by 3% to all payments. Select only tax_rate column from the payments table. 
Submit your query statements as Prepare DB & Run queries.
*/

UPDATE payments SET tax_rate = tax_rate * 0.97 WHERE id = id;
SELECT tax_rate FROM payments;

/*
23_Delete All Records
Use Hotel database and delete all records from the occupancies table. Use SQL query. 
Submit your query statements as Run skeleton, run queries & check DB.
*/

TRUNCATE occupancies;

