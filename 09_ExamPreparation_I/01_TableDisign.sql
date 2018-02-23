DROP DATABASE airport_management_system;
CREATE DATABASE airport_management_system;
USE airport_management_system;

#judge:

CREATE  TABLE towns
(
	town_id INT PRIMARY KEY,
	town_name VARCHARACTER(30) NOT NULL
	
);

CREATE  TABLE airports
(
	airport_id INT PRIMARY KEY,
	airport_name VARCHARACTER(50) NOT NULL,
	town_id INT,
	CONSTRAINT fk_aiports_towns FOREIGN KEY (town_id) 
	REFERENCES towns(town_id)

);

CREATE  TABLE airlines
(
	airline_id INT PRIMARY KEY,
	airline_name VARCHARACTER(30) NOT NULL,
	nationality VARCHARACTER(30) NOT NULL,
	rating INT DEFAULT 0
);
CREATE  TABLE customers
(
	customer_id INT PRIMARY KEY,
	first_name VARCHARACTER(20) NOT NULL,
	last_name VARCHARACTER(20) NOT NULL,
	date_of_birth DATE NOT NULL,	
	gender VARCHARACTER(1),
	home_town_id INT,
	CONSTRAINT fk_customers_towns FOREIGN KEY (home_town_id) 
	REFERENCES towns(town_id)
);

CREATE  TABLE flights
(
	flight_id INT PRIMARY KEY AUTO_INCREMENT,
	departure_time DATETIME NOT NULL,
	arrival_time DATETIME NOT NULL,
	`status` VARCHARACTER(9) NOT NULL,
	origin_airport_id INT,
	destination_airport_id INT,
	airline_id INT,
	CONSTRAINT fk_flight_origin_airports 
	FOREIGN KEY (origin_airport_id) 
	REFERENCES airports(airport_id),
	CONSTRAINT fk_flight_destination_airports 
	FOREIGN KEY (destination_airport_id) 
	REFERENCES airports(airport_id),
	CONSTRAINT fk_flight_airlines 
	FOREIGN KEY (airline_id) 
	REFERENCES airlines(airline_id)
	
);

CREATE  TABLE tickets
(
	ticket_id INT PRIMARY KEY AUTO_INCREMENT,
	price DECIMAL(8,2) NOT NULL,	
	class VARCHARACTER(6) NOT NULL,
	seat VARCHARACTER(5) NOT NULL,
	customer_id INT,
	flight_id INT,
	CONSTRAINT fk_ticketss_customers FOREIGN KEY (customer_id) 
	REFERENCES customers(customer_id),
	CONSTRAINT fk_ticketss_flights FOREIGN KEY (flight_id) 
	REFERENCES flights(flight_id)
);






