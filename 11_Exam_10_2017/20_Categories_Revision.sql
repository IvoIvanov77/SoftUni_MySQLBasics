/*Select all categories which have reports with status “waiting” or “in progress” and show their total number 
in the column “Reports Number”. In the third column fill the main status type of  reports for the category 
(e.g. 2 reports with status “waiting” and 3 reports with status “in progress” result in value “in progress”). 
If they are equal just fill in “equal”.*/
SELECT c.name AS category_name, COUNT(r.id) AS reports_number
FROM reports AS r
INNER JOIN categories AS c ON c.id = r.category_id
INNER JOIN `status` AS s ON s.id = r.status_id
WHERE s.label IN('waiting', 'in progress')
GROUP BY c.name;
