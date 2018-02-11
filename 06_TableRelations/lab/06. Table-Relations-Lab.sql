--Lab: Table Relations

--Get familiar with the camp database. You will use it in the following exercises bellow.
/*
1_Mountains and Peaks
Write a query to create two tables – mountains and peaks and link their fields properly. Tables should have:
-	Mountains:
•	id 
•	name
-	Peaks: 
•	id
•	name
•	mountain_id
*/

CREATE TABLE mountains(
id INT PRIMARY KEY,
name VARCHAR(50)
);
CREATE TABLE peaks(
id INT PRIMARY KEY,
name VARCHAR(50),
mountain_id INT, CONSTRAINT fk_peaks_mountains FOREIGN KEY(mountain_id) REFERENCES mountains(id)
);

/*
2_Posts and Authors
Write a query to create a one-to-many relationship between a table, holding information about books and other - about authors, 
so that when an author gets removed from the database all his books are deleted too. The tables should have:
-	Books
•	id
•	name  
•	author_id
•	Authors
•	id
•	name
*/

CREATE TABLE authors(
id INT PRIMARY KEY,
name VARCHAR(50)
);
CREATE TABLE books (
id INT PRIMARY KEY,
name VARCHAR(50),
author_id INT, CONSTRAINT fk_books_authors FOREIGN KEY(author_id) REFERENCES authors(id) ON DELETE CASCADE
);

/*
3_Trip Organization
Write a query to retrieve information about the SoftUni camp’s transportation organization. 
Get information about the people who drive(name and age) and their vehicle type. 
*/

SELECT v.driver_id, v.vehicle_type, CONCAT(c.first_name, ' ' , c.last_name) AS driver_name
FROM campers AS c
JOIN vehicles AS v ON c.id = v.driver_id;
  
/*
4_SoftUni Hiking
Get information about the hiking routes and their leaders – name and id. 
*/

SELECT r.starting_point, r.end_point, r.leader_id, CONCAT(c.first_name, ' ', c.last_name) AS leader_name
FROM routes AS r
JOIN campers AS c ON c.id = r.leader_id;

/*
5_Project Management DB*
Write a query to create a project management db according to the following E/R Diagram:
*/

CREATE TABLE projects(
id INT PRIMARY KEY,
client_id INT,
project_lead_id INT
);

CREATE TABLE clients(
id INT PRIMARY KEY,
client_name VARCHAR(100),
project_id INT,
CONSTRAINT fk_projects_cl FOREIGN KEY(project_id) REFERENCES projects(id)
);

CREATE TABLE employees(
id INT PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
project_id INT,
CONSTRAINT fk_projects_e FOREIGN KEY(project_id) REFERENCES projects(id)
);

ALTER TABLE projects
ADD CONSTRAINT fk_clients
FOREIGN KEY (client_id) REFERENCES clients(id),
ADD CONSTRAINT fk_employyes
FOREIGN KEY (project_lead_id) REFERENCES employees(id);


