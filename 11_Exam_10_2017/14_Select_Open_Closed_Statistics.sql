SELECT CONCAT(e.first_name, ' ', e.last_name) AS name, CAST(CONCAT((
SELECT COUNT(e2.id)
FROM reports AS r
INNER JOIN employees AS e2 ON e2.id = r.employee_id
WHERE r.employee_id = e.id AND YEAR(r.close_date) = '2016'
), '/',(
SELECT COUNT(e1.id)
FROM reports AS r
INNER JOIN employees AS e1 ON e1.id = r.employee_id
WHERE r.employee_id = e.id AND YEAR(r.open_date) = '2016')
) AS CHAR(10)) AS closed_open_reports
FROM employees AS e
HAVING closed_open_reports != '0/0'
ORDER BY name;