UPDATE problems AS p
INNER JOIN contests AS c ON c.id = p.contest_id
INNER JOIN categories AS cat ON cat.id = c.category_id 
SET p.tests = (CASE 
	WHEN p.id % 3 = 0 THEN CHARACTER_LENGTH(cat.name) 
	WHEN p.id % 3 = 1 THEN (
		SELECT SUM(s.id)
		FROM submissions AS s
		WHERE s.problem_id = p.id)
	WHEN p.id % 3 = 2 THEN CHARACTER_LENGTH(c.name) 
END)
WHERE p.tests = 0;