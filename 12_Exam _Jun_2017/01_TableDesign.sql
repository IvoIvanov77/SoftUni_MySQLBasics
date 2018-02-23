DROP DATABASE closed_judge_system;
CREATE DATABASE closed_judge_system;
USE closed_judge_system;

#judge:

CREATE  TABLE users
(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
	username VARCHARACTER(30) NOT NULL UNIQUE,
	`password` VARCHARACTER(30) NOT NULL,	
	email VARCHARACTER(50) NOT NULL
	
);

CREATE  TABLE categories
(
	id INT(11)  PRIMARY KEY AUTO_INCREMENT,
	name VARCHARACTER(50) NOT NULL,
	parent_id INT(11),
	CONSTRAINT fk_categories_categories FOREIGN KEY (parent_id) 
	REFERENCES categories(id)
);

CREATE  TABLE contests
(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
	name VARCHARACTER(50) NOT NULL,
	category_id INT(11),
	CONSTRAINT fk_contests_categories FOREIGN KEY (category_id) 
	REFERENCES categories(id)
);

CREATE  TABLE problems
(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
	name VARCHARACTER(100) NOT NULL,	
	points INT(11) NOT NULL,
	tests INT(11) DEFAULT 0,
	contest_id INT(11),
	CONSTRAINT fk_problems_contest FOREIGN KEY (contest_id) 
	REFERENCES contests(id)
);

CREATE  TABLE submissions
(
	id INT(11)  PRIMARY KEY AUTO_INCREMENT,
	passed_tests INT(11) NOT NULL,
	problem_id INT(11),
	user_id INT(11),
	CONSTRAINT fk_submissions_problems FOREIGN KEY (problem_id) 
	REFERENCES problems(id),
	CONSTRAINT fk_submissions_users FOREIGN KEY (user_id) 
	REFERENCES users(id)
	
);

CREATE  TABLE users_contests
(		
	user_id INT(11),
	contest_id INT(11),	
	PRIMARY KEY(user_id, contest_id),
	CONSTRAINT fk_users_contests_users FOREIGN KEY (user_id) 
	REFERENCES users(id),
	CONSTRAINT fk_contest_id_contests FOREIGN KEY (contest_id) 
	REFERENCES contests(id)
	
);
