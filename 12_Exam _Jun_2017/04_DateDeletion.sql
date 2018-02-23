DELETE u
FROM users AS u
LEFT JOIN users_contests AS uc ON uc.user_id = u.id
WHERE uc.user_id IS NULL;