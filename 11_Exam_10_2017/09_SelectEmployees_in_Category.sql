-- 3/3 judge

SELECT c.name, COUNT(e.Id) AS `employees_number`
FROM categories AS c
INNER JOIN departments AS d ON d.Id = c.Department_id
INNER JOIN employees AS e ON d.Id = e.Department_Id
GROUP BY c.name
ORDER BY c.name;


SELECT c.name AS category_name, COUNT(r.employee_id) AS employees_number
FROM categories AS c
INNER JOIN reports AS r ON r.category_id = c.id
GROUP BY r.category_id
ORDER BY c.name;