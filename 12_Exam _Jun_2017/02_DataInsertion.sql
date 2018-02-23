INSERT INTO submissions (passed_tests, problem_id, user_id)
SELECT
	CEIL(SQRT(POW(CHAR_LENGTH(p.name), 3)) - CHAR_LENGTH(p.name)) AS passed_tests,
	p.id as problem_id,
	p.id * 3 / 2 as user_id
FROM problems AS p
WHERE p.id BETWEEN 1 AND 10;
