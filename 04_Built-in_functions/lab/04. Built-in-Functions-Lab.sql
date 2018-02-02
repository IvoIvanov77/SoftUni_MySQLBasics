/*
Download from the course instance and get familiar with the book_library database. 
You will use it in the following exercises.
*/

/*
01_Find Book Titles
Write a SQL query to find books which titles start with “The”. Order the result by id. 
*/


SELECT title
FROM books
WHERE title LIKE 'The%'
ORDER BY id;

SELECT title
FROM books
WHERE SUBSTRING(title, 1, 3) = "The";

/*
02_Replace Titles
Write a SQL query to find books which titles start with “The” and replace the substring with 3 asterisks. 
Retrieve data about the updated titles. Order the result by id. 
*/

SELECT
REPLACE(title, 'The', '***')
FROM books
WHERE SUBSTRING(title, 1, 3) = 'The'
ORDER BY id;

UPDATE books
SET title = REPLACE(title,"The","***")
WHERE SUBSTRING(title, 1, 3) = "The";
SELECT title from books 
WHERE SUBSTRING(title, 1, 3) = "***";

/*
03_Sum Cost of All Books
Write a SQL query to sum prices of all books. Format the output to 2 digits after decimal point. 
*/

SELECT ROUND(SUM(cost), 2) AS total_cost
FROM books;

/*
4.	Days Lived
Write a SQL query to calculate the days that the authors have lived. 
NULL values mean that the author is still alive. 
*/

SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', 
TIMESTAMPDIFF(DAY, born, died) AS 'Days Lived'
FROM authors;

/*
05_Harry Potter Books
Write a SQL query to retrieve titles of all the Harry Potter books. Order the information by id. 
*/

SELECT title
FROM books
WHERE title LIKE '%Harry Potter%';

