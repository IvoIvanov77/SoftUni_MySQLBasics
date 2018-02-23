DROP DATABASE report_service;
CREATE DATABASE report_service;
USE report_service;

#judge:

CREATE  TABLE users
(
	id INT(11) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	username VARCHARACTER(30) NOT NULL UNIQUE,
	`password` VARCHARACTER(50) NOT NULL,
	name VARCHARACTER(50),
	gender VARCHARACTER(1),
	birthdate DATETIME,
	age  INT(11) UNSIGNED,
	email VARCHARACTER(50) NOT NULL
	
);

CREATE  TABLE departments
(
	id INT(11) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHARACTER(50) NOT NULL
	
);

CREATE  TABLE `status`
(
	id INT(11) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	label VARCHARACTER(30) NOT NULL

);

CREATE  TABLE categories
(
	id INT(11) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHARACTER(50) NOT NULL,	
	department_id INT(11) UNSIGNED,
	CONSTRAINT fk_categoryes_departments FOREIGN KEY (department_id) 
	REFERENCES departments(id)
);

CREATE  TABLE employees
(
	id INT(11) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHARACTER(25),
	last_name VARCHARACTER(25),
	gender VARCHARACTER(1),
	birthdate DATETIME,
	age INT(11) UNSIGNED,
	department_id INT(11) UNSIGNED,
	CONSTRAINT fk_employees_departments FOREIGN KEY (department_id) 
	REFERENCES departments(id)
	
);


CREATE  TABLE reports
(	
	id INT(11) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	category_id INT(11) UNSIGNED,
	status_id INT(11) UNSIGNED,
	open_date DATETIME NOT NULL,
	close_date DATETIME,
	description VARCHARACTER(200),
	user_id INT(11) UNSIGNED,
	employee_id INT(11) UNSIGNED,	
	CONSTRAINT fk_reports_status FOREIGN KEY (category_id) 
	REFERENCES categories(id),
	CONSTRAINT fk_reports_categories FOREIGN KEY (status_id) 
	REFERENCES `status`(id),
	CONSTRAINT fk_reports_users FOREIGN KEY (user_id) 
	REFERENCES users(id),
	CONSTRAINT fk_reports_employees FOREIGN KEY (employee_id) 
	REFERENCES employees(id)
	
);
