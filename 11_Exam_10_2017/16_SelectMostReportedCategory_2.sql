/*Select all departments with their categories where users have submitted a report. 
Show the distribution of reports among the categories of each department in percentages without decimal part.
Order them by department name, then by category name and then by percentage (all in ascending order).*/
SELECT d.name AS department_name, c.name AS category_name, ROUND((
SELECT COUNT(*)
FROM reports AS r1
WHERE r1.category_id = c.id) / 
(
SELECT COUNT(*)
FROM reports AS r2
INNER JOIN categories AS c1 ON c1.id = r2.category_id
INNER JOIN departments AS d1 ON d1.id = c1.department_id
WHERE d1.id = d.id) * 100
) AS percentage
FROM departments AS d
INNER JOIN categories AS c ON c.department_id = d.id
HAVING percentage > 0
ORDER BY department_name, category_name, percentage;
