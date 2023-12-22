-- create_database.sql
DROP DATABASE IF EXISTS `flight_management_system`;
CREATE DATABASE IF NOT EXISTS `flight_management_system`;
USE `flight_management_system`;

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    e_name VARCHAR(255),
    roles VARCHAR(255),
    languages_spoken VARCHAR(255),
    designation VARCHAR(255),
    age INT,
    date_of_birth DATE,
    phone_number VARCHAR(255)
);

CREATE TABLE Airplane (
    airplane_number INT PRIMARY KEY,
    airplane_model VARCHAR(255),
    fuel_capacity INT,
    passenger_capacity INT
);

CREATE TABLE Maintenance_History (
    id INT PRIMARY KEY,
    airplane_number INT,
    type VARCHAR(255),
    cost DECIMAL(10, 2),
    date DATE,
    employee_involved INT,
    employee_id INT,
    FOREIGN KEY (airplane_number) REFERENCES Airplane(airplane_number),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Location (
    airport_id VARCHAR(255) PRIMARY KEY,
    timezone VARCHAR(255),
    coordinates VARCHAR(255),
    arrival_time VARCHAR(255),
    flight_duration VARCHAR(255)
);

CREATE TABLE Flight (
    id INT PRIMARY KEY,
    airplane_number INT,
    from_location VARCHAR(255),
    to_location VARCHAR(255),
    arrival_time TIMESTAMP,
    flight_duration DECIMAL(10, 2),
    number_of_layovers INT,
    FOREIGN KEY (airplane_number) REFERENCES Airplane(airplane_number),
    FOREIGN KEY (from_location) REFERENCES Location(airport_id),
    FOREIGN KEY (to_location) REFERENCES Location(airport_id)
);

CREATE TABLE Passenger (
    passenger_id INT PRIMARY KEY,
    phone_number VARCHAR(255),
    age INT,
    date_of_birth DATE,
    name VARCHAR(255)
);

CREATE TABLE Reservation (
    id INT PRIMARY KEY,
    flight_id INT,
    date DATE,
    meal BOOLEAN,
    passenger_id INT,
    flight_number INT,
    FOREIGN KEY (flight_id) REFERENCES Flight(id),
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (flight_number) REFERENCES Flight(id)
);



CREATE TABLE Baggage (
    tag_index VARCHAR(255) PRIMARY KEY,
    weight_in_kg DECIMAL(10, 2),
    passenger_id INT,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id)
);

CREATE TABLE Feedback (
    id INT PRIMARY KEY,
    flight_id INT,
    passenger_id INT,
    positive_negative BOOLEAN,
    number_of_words INT,
    FOREIGN KEY (flight_id) REFERENCES Flight(id),
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id)
);

CREATE TABLE Log (
    id INT PRIMARY KEY,
    airplane_number INT,
    parametric_reading VARCHAR(255),
    timestamp TIMESTAMP,
    FOREIGN KEY (airplane_number) REFERENCES Airplane(airplane_number)
);


-- Populate Airplane Table
INSERT INTO Airplane (airplane_number, airplane_model, fuel_capacity, passenger_capacity)
VALUES
  (100, 'Boeing 747', 50000, 416),
  (134, 'Airbus A320', 30000, 150),
  (271, 'Boeing 777', 60000, 550),
  (297, 'Airbus A380', 80000, 853),
  (312, 'Boeing 737', 40000, 215),
  (150, 'Airbus A350', 45000, 300),
  (188, 'Boeing 767', 35000, 250),
  (221, 'Embraer E190', 20000, 100),
  (255, 'Airbus A330', 55000, 400),
  (333, 'Boeing 757', 38000, 220);


-- Populate Employee Table 
  INSERT INTO Employee (employee_id, e_name, roles, languages_spoken, designation, age, date_of_birth, phone_number)
VALUES
  (1,'Hema Singh', 'Pilot', 'English', 'Captain', 35, '1988-05-15', '123-456-7890'),
  (2,'Aarav Kapoor', 'Mechanic', 'Spanish', 'Senior Engineer', 42, '1981-10-22', '987-654-3210'),
  (4,'Rohan Kumar', 'Pilot', 'German', 'First Officer', 40, '1983-08-18', '111-222-3333'),
  (3,'Diya Verma', 'Crew', 'French', 'Attendant', 28, '1994-02-08', '555-666-7777'),
  (5,'Harshita Sharma', 'Mechanic', 'Italian', 'Engineer', 37, '1986-11-30', '999-888-7777'),
  (6, 'Neha Kapoor', 'Crew', 'English', 'Flight Attendant', 25, '1998-12-10', '777-888-9999'),
  (7, 'Arjun Sharma', 'Pilot', 'Hindi', 'Captain', 38, '1985-07-18', '333-444-5555'),
  (8, 'Riya Verma', 'Mechanic', 'French', 'Engineer', 32, '1990-04-05', '666-777-8888'),
  (9, 'Kabir Singh', 'Crew', 'Spanish', 'Attendant', 29, '1993-09-22', '111-222-3333'),
  (10, 'Ananya Patel', 'Pilot', 'German', 'First Officer', 34, '1988-02-28', '444-555-6666');



-- Populate Location Table with Indian Airport Codes
INSERT INTO Location (airport_id, timezone, coordinates, arrival_time, flight_duration)
VALUES
  ('DEL', 'UTC+5:30', '28.6139° N, 77.2090° E', '08:00 AM - 08:00 PM', '5 hours'),
  ('BOM', 'UTC+5:30', '19.0760° N, 72.8777° E', '09:00 AM - 09:00 PM', '4.5 hours'),
  ('CCU', 'UTC+5:30', '22.5726° N, 88.3639° E', '10:00 AM - 10:00 PM', '3.5 hours'),
  ('BLR', 'UTC+5:30', '12.9716° N, 77.5946° E', '11:00 AM - 11:00 PM', '6 hours'),
  ('MAA', 'UTC+5:30', '13.0827° N, 80.2707° E', '12:00 PM - 12:00 AM', '7 hours'),
  ('HYD', 'UTC+5:30', '17.3850° N, 78.4867° E', '01:00 PM - 01:00 AM', '4 hours'),
  ('IXC', 'UTC+5:30', '18.5204° N, 73.8567° E', '02:00 PM - 02:00 AM', '3.5 hours'),
  ('AMD', 'UTC+5:30', '23.0225° N, 72.5714° E', '03:00 PM - 03:00 AM', '5 hours'),
  ('JAI', 'UTC+5:30', '26.9124° N, 75.7873° E', '04:00 PM - 04:00 AM', '2.5 hours'),
  ('DED', 'UTC+5:30', '26.8467° N, 80.9462° E', '05:00 PM - 05:00 AM', '6 hours');;

-- Populate Passenger Table with Indian Names
INSERT INTO Passenger (passenger_id, phone_number, age, date_of_birth, name)
VALUES
  (201, '123-456-7890', 28, '1995-03-15', 'Amit Patel'),
  (202, '987-654-3210', 35, '1988-08-20', 'Kunal Kapoor'),
  (203, '111-222-3333', 42, '1981-11-25', 'Rahul Kumar'),
  (204, '555-666-7777', 50, '1973-04-30', 'Priya Sharma'),
  (205, '999-888-7777', 22, '2001-07-05', 'Aditya Singh'),
  (206, '777-888-9999', 30, '1992-06-12', 'Nisha Sharma'),
  (207, '333-444-5555', 45, '1978-03-25', 'Vikram Kapoor'),
  (208, '666-777-8888', 28, '1994-08-15', 'Aarohi Verma'),
  (209, '111-222-3333', 40, '1982-11-28', 'Rajat Singh'),
  (210, '444-555-6666', 22, '2000-04-02', 'Ishita Patel');


  -- Populate Flight Table
INSERT INTO Flight (id, airplane_number, from_location, to_location, arrival_time, flight_duration, number_of_layovers)
VALUES
  (1, 100, 'DEL', 'BOM', '2023-11-30 08:00:00', 2.5, 0),
  (2, 134, 'BOM', 'CCU', '2023-06-02 09:00:00', 2.0, 1),
  (3, 271, 'CCU', 'BLR', '2023-06-03 10:00:00', 1.5, 0),
  (4, 297, 'BLR', 'MAA', '2023-06-04 11:00:00', 3.0, 1),
  (5, 312, 'MAA', 'DEL', '2023-06-05 12:00:00', 2.5, 1),
  (6, 150, 'HYD', 'IXC', '2023-06-06 01:00:00', 1.5, 0),
  (7, 188, 'IXC', 'AMD', '2023-06-06 02:00:00', 2.0, 1),
  (8, 221, 'AMD', 'JAI', '2023-06-04 03:00:00', 1.0, 0),
  (9, 255, 'JAI', 'DED', '2023-06-06 04:00:00', 2.5, 1),
  (10, 333, 'DED', 'DEL', '2023-06-04 05:00:00', 1.5, 0);


-- Populate Feedback Table with Indian Passengers
INSERT INTO Feedback (id, flight_id, passenger_id, positive_negative, number_of_words)
VALUES
  (1, 1, 201, 1, 10),
  (2, 2, 202, 0, 8),
  (3, 3, 203, 1, 12),
  (4, 4, 204, 0, 9),
  (5, 5, 205, 1, 11),
  (6, 6, 206, 1, 9),
  (7, 7, 207, 0, 7),
  (8, 8, 208, 1, 10),
  (9, 9, 209, 0, 8),
  (10, 10, 210, 1, 12);

-- Populate Log Table with Indian Parametric Readings
INSERT INTO Log (id, airplane_number, parametric_reading, timestamp)
VALUES
  (1, 100, 'reading1', CURRENT_TIMESTAMP),
  (2, 134, 'reading2', CURRENT_TIMESTAMP),
  (3, 271, 'reading3', CURRENT_TIMESTAMP),
  (4, 297, 'reading4', CURRENT_TIMESTAMP),
  (5, 312, 'reading5', CURRENT_TIMESTAMP),
  (6, 150, 'reading6', CURRENT_TIMESTAMP),
  (7, 188, 'reading7', CURRENT_TIMESTAMP),
  (8, 221, 'reading8', CURRENT_TIMESTAMP),
  (9, 255, 'reading9', CURRENT_TIMESTAMP),
  (10, 333, 'reading10', CURRENT_TIMESTAMP);




-- Populate Maintenance_History Table
INSERT INTO Maintenance_History (id, airplane_number, type, cost, date, employee_involved, employee_id)
VALUES
  (1, 100, 'Regular Check', 5000.00, '2023-01-10', 2, 2),
  (2, 134, 'Engine Overhaul', 12000.00, '2023-02-15', 4, 4),
  (3, 271, 'Avionics Upgrade', 8000.00, '2023-03-20', 5, 5),
  (4, 297, 'Structural Inspection', 10000.00, '2023-04-25', 2, 2),
  (5, 312, 'Fuel System Maintenance', 6000.00, '2023-05-30', 5, 5),
  (6, 150, 'Routine Check', 4000.00, '2023-07-15', 7, 7),
  (7, 188, 'Interior Refurbishment', 15000.00, '2023-08-20', 8, 8),
  (8, 221, 'Electrical System Upgrade', 10000.00, '2023-09-25', 9, 9),
  (9, 255, 'Aircraft Painting', 8000.00, '2023-10-30', 10, 10),
  (10, 333, 'Fuel Tank Inspection', 5000.00, '2023-11-30', 6, 6);



-- Populate Reservation Table
INSERT INTO Reservation (id, flight_id, date, meal, passenger_id, flight_number)
VALUES
  (1, 1, '2023-05-20', true, 201, 1),
  (2, 2, '2023-05-21', false, 202, 2),
  (3, 3, '2023-05-22', true, 203, 3),
  (4, 4, '2023-05-23', false, 204, 4),
  (5, 5, '2023-05-24', true, 205, 5),
  (6, 6, '2023-06-15', true, 201, 6),
  (7, 7, '2023-06-16', false, 207, 7),
  (8, 8, '2023-06-17', true, 204, 8),
  (9, 9, '2023-06-18', false, 203, 9),
  (10, 10, '2023-06-19', true, 203, 10);

-- Populate Baggage Table
INSERT INTO Baggage (tag_index, weight_in_kg, passenger_id)
VALUES
  ('ABC123', 20.5, 201),
  ('DEF456', 15.0, 202),
  ('GHI789', 25.3, 203),
  ('JKL012', 18.7, 204),
  ('MNO345', 22.0, 205),
  ('PQR123', 18.0, 206),
  ('XYZ456', 23.5, 207),
  ('LMN789', 17.8, 208),
  ('UVW012', 21.2, 209),
  ('STU345', 19.5, 210);

