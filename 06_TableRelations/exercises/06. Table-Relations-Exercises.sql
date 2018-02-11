 
/*
1_One-To-One Relationship
Create two tables as follows. Use appropriate data types.
*/

CREATE TABLE passports(
passport_id INT PRIMARY KEY AUTO_INCREMENT,
passport_number VARCHAR(50) UNIQUE
);

ALTER TABLE passports AUTO_INCREMENT = 101;

CREATE TABLE persons(
person_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50),
salary DECIMAL(10, 2),
passport_id INT UNIQUE, 
CONSTRAINT fk_passprts FOREIGN KEY (passport_id) REFERENCES passports(passport_id)
);

INSERT INTO passports(passport_number) VALUES
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2');

INSERT INTO persons(first_name, salary, passport_id) VALUES
('Roberto', 43300.00, 102),
('Tom',	56100.00, 103),
('Yana', 60200.00, 101);

/*
2_One-To-Many Relationship
Create two tables as follows. Use appropriate data types.
*/

CREATE TABLE manufacturers(
manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
established_on DATE
);

CREATE TABLE models(
model_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
manufacturer_id INT ,
CONSTRAINT fk_manufacturer
FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(manufacturer_id)
);
ALTER TABLE models AUTO_INCREMENT = 101;

INSERT INTO manufacturers(name, established_on) VALUES
('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

INSERT INTO models(name, manufacturer_id) VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);


/*
3_Many-To-Many Relationship
Create three tables as follows. Use appropriate data types.
*/

CREATE TABLE students(
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50)
);

CREATE TABLE exams(
exam_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50)
);

ALTER TABLE exams AUTO_INCREMENT = 101;

CREATE TABLE students_exams(
student_id INT,
exam_id INT, 
CONSTRAINT fk_students FOREIGN KEY (student_id) REFERENCES students(student_id),
CONSTRAINT fk_exams FOREIGN KEY (exam_id) REFERENCES exams(exam_id),
PRIMARY KEY(student_id, exam_id)
);

INSERT INTO students(name) VALUES
('Mila'),
('Toni'),
('Ron');
INSERT INTO exams(name) VALUES
('Spring MVC'),
('Neo4j'),
('Oracle 11g');
INSERT INTO students_exams(student_id, exam_id) VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);


/*
4_Self-Referencing
Create a single table as follows. Use appropriate data types.
*/

CREATE TABLE teachers(
teacher_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
manager_id INT, CONSTRAINT fk_teachers
FOREIGN KEY(manager_id)
REFERENCES teachers(teacher_id)
);

INSERT INTO teachers VALUES
(101, 'John', NULL),
(106, 'Greta', 101),
(102, 'Maya', 106),
(103, 'Silvia', 106),
(105, 'Mark', 101),
(104, 'Ted', 105);



/*
5_Online Store Database
Create a new database and design the following structure:
*/

CREATE TABLE item_types(
item_type_id INT PRIMARY KEY,
name VARCHAR(50));

CREATE TABLE cities(
city_id INT PRIMARY KEY,
name VARCHAR(50));

CREATE TABLE items(
item_id INT PRIMARY KEY,
name VARCHAR(50),
item_type_id INT, CONSTRAINT fk_item_types 
FOREIGN KEY(item_type_id) REFERENCES item_types(item_type_id)
);

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name VARCHAR(50),
birthday DATE,
city_id INT, CONSTRAINT fk_cities 
FOREIGN KEY(city_id) REFERENCES cities(city_id)
);

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT, CONSTRAINT fk_customers 
FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items(
order_id INT,
item_id INT, CONSTRAINT pk_order_items PRIMARY KEY(order_id, item_id),
CONSTRAINT fk_order_items_order_id FOREIGN KEY(order_id) REFERENCES orders(order_id),
CONSTRAINT fk_order_items_item_id FOREIGN KEY(item_id) REFERENCES items(item_id)
);


/*
6_University Database
Create a new database and design the following structure:
*/ 

CREATE TABLE majors(
major_id INT PRIMARY KEY,
name VARCHAR(50));

CREATE TABLE subjects(
subject_id INT PRIMARY KEY,
subject_name VARCHAR(50));

CREATE TABLE students(
student_id INT PRIMARY KEY,
student_number VARCHAR(12),
student_name VARCHAR(50),
major_id INT,
CONSTRAINT fk_students_majors
FOREIGN KEY(major_id) REFERENCES majors(major_id)
);
CREATE TABLE payments(
payment_id INT PRIMARY KEY,
payment_date DATE,
payment_amount DECIMAL(8,2),
student_id INT,
CONSTRAINT fk_payments_students
FOREIGN KEY(student_id) REFERENCES students(student_id)
);

CREATE TABLE agenda(
student_id INT,
subject_id INT,
CONSTRAINT pk_agenda PRIMARY KEY(student_id, subject_id),
CONSTRAINT fk_agenda_students
FOREIGN KEY(student_id) REFERENCES students(student_id),
CONSTRAINT fk_agenda_subjects
FOREIGN KEY(subject_id) REFERENCES subjects(subject_id)
);

/*
7_SoftUni Design
Create an E/R Diagram of the SoftUni Database.
*/
/*
8_Geography Design
Create an E/R Diagram of the Geography Database.
*/
/*
9_Peaks in Rila
Display all peaks for "Rila" mountain_range. Include:
•	mountain_range
•	peak_name
•	peak_elevation
Peaks should be sorted by peak_elevation descending.
*/

SELECT m.mountain_range, p.peak_name, p.elevation
FROM peaks AS p
JOIN mountains AS m ON m.id = p.mountain_id
WHERE m.mountain_range = 'Rila'
ORDER BY p.elevation DESC;


