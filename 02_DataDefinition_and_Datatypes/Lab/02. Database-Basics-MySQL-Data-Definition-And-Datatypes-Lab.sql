/*
01_Create New Database
*/
 
/*
 02_Create Tables	
When we create tables, we specify the database we want to add them to. This is done by using the “USE” clause.
Submit your solutions without the “USE {database name}” row.
Table “employees”:
•	id – INT, primary key, AUTO_INCREMENT;
•	first_name – VARCHAR, NOT NULL; 
•	last_name – VARCHAR, NOT NULL;  
Create the “categories” and “products” tables analogically:
Table “categories”:
•	id – INT, primary key, AUTO_INCREMENT;
•	name – VARCHAR, NOT NULL; 
Table “products”:
•	id –  INT, primary key, AUTO_INCREMENT;
•	name – VARCHAR, NOT NULL; 
•	category_id – INT, NOT NULL;
*/

CREATE TABLE employees
(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL
);
CREATE TABLE categories
(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);
CREATE TABLE products
(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
category_id INT NOT NULL
);

/*
03_Insert Data in Tables
Inserting data can be done with a query too. To do that we use the “INSERT” clause. Populate the “employees” table with 3 test values.
*/

INSERT INTO employees (id,first_name, last_name) VALUES(1, "Ivaylo", "Ivanov");
INSERT INTO employees (id,first_name, last_name) VALUES(2, "Ivaylo", "Ivanov");
INSERT INTO employees (id,first_name, last_name) VALUES(3, "Ivaylo", "Ivanov");

/*
04_Altering Tables
Altering the tables is done via the “ALTER TABLE” clause. Add a new column – “middle_name” to the “employees” table. 
*/

ALTER TABLE employees ADD middle_name VARCHAR(50) NOT NULL;

/*
05_Adding Constraints
Create the connection via foreign key between the “products” and “categories” tables that you’ve created earlier. 
Make “category_id” foreign key linked to “id” in the “categories” table. 
*/

ALTER TABLE products ADD FOREIGN KEY (category_id)
REFERENCES categories(id);

/*
06_Modifying Columns
Change the property “VARCHAR(50)” to “VARCHAR(100)” to the “middle_name” column in “employees” table.
*/

ALTER TABLE employees
MODIFY COLUMN middle_name VARCHAR(100); 

