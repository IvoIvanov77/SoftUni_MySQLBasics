DROP DATABASE the_nerd_herd;
CREATE DATABASE the_nerd_herd;
USE the_nerd_herd;

#judge:

CREATE  TABLE credentials
(
	id INT PRIMARY KEY,
	email VARCHARACTER(30),
	password VARCHARACTER(20)
	
);

CREATE  TABLE locations
(
	id INT PRIMARY KEY,
	latitude FLOAT,
	longitude FLOAT
	
);

CREATE  TABLE users
(
	id INT PRIMARY KEY,
	nickname VARCHARACTER(25),
	gender CHARACTER(1),
	age INT,
	location_id INT,
	credential_id INT UNIQUE,
	CONSTRAINT fk_users_locationss FOREIGN KEY (location_id) 
	REFERENCES locations(id),
	CONSTRAINT fk_users_credentials FOREIGN KEY (credential_id) 
	REFERENCES credentials(id)

);

CREATE  TABLE chats
(
	id INT PRIMARY KEY,
	title VARCHARACTER(32),
	start_date DATE,
	is_active BIT(1)
);

CREATE  TABLE messages
(
	id INT PRIMARY KEY,
	content VARCHARACTER(200),
	sent_on DATE,
	chat_id INT,
	user_id INT,
	CONSTRAINT fk_messages_chats FOREIGN KEY (chat_id) 
	REFERENCES chats(id),
	CONSTRAINT fk_messages_users FOREIGN KEY (user_id) 
	REFERENCES users(id)
);


CREATE  TABLE users_chats
(	
	user_id INT,
	chat_id INT,
	PRIMARY KEY(user_id, chat_id),
	CONSTRAINT fk_user_chats_users FOREIGN KEY (user_id) 
	REFERENCES users(id),
	CONSTRAINT fk_user_chats_chats FOREIGN KEY (chat_id) 
	REFERENCES chats(id)
);









