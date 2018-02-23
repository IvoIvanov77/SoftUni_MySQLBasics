SELECT u.nickname, cr.email, cr.password
FROM users AS u
INNER JOIN credentials AS cr ON cr.id = u.credential_id
WHERE
RIGHT(cr.email, 5) = 'co.uk'
ORDER BY cr.email;