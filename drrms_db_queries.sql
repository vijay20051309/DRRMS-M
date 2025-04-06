
create database drrms_db;

use drrms_db;


CREATE TABLE locations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100),
    latitude DECIMAL(10, 6),
    longitude DECIMAL(10, 6),
    weather_condition VARCHAR(50),
    weather_alert ENUM('none', 'yellow', 'orange', 'red') DEFAULT 'none',
    last_weather_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE shelters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location_id INT,
    capacity INT,
    current_occupancy INT DEFAULT 0,
    contact_number VARCHAR(15),
    FOREIGN KEY (location_id) REFERENCES locations(id)
);

CREATE TABLE resources (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type ENUM('food', 'water', 'medical', 'clothing', 'other') NOT NULL,
    quantity INT,
    unit VARCHAR(20),
    location_id INT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (location_id) REFERENCES locations(id)
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'agency', 'volunteer', 'citizen') NOT NULL,
    email VARCHAR(100),
    contact_number VARCHAR(15),
    is_requesting_help BOOLEAN DEFAULT FALSE
);

CREATE TABLE requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    resource_id INT,
    location_id INT,
    quantity_requested INT,
    status ENUM('pending', 'approved', 'denied', 'fulfilled') DEFAULT 'pending',
    request_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    remarks TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (resource_id) REFERENCES resources(id),
    FOREIGN KEY (location_id) REFERENCES locations(id)
);

CREATE TABLE audit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(255) NOT NULL,
    performed_by INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (performed_by) REFERENCES users(id)
);

INSERT INTO locations (name, region, latitude, longitude, weather_condition, weather_alert)
VALUES
  ('Chennai', 'Tamil Nadu', 13.0827, 80.2707, 'Heavy Rain', 'orange'),
  ('Cuddalore', 'Tamil Nadu', 11.7463, 79.7714, 'Cyclone Alert', 'red'),
  ('Madurai', 'Tamil Nadu', 9.9252, 78.1198, 'Cloudy', 'yellow'),
  ('Coimbatore', 'Tamil Nadu', 11.0168, 76.9558, 'Clear', 'none');




INSERT INTO shelters (name, location_id, capacity, current_occupancy, contact_number)
VALUES
  ('Relief Camp A', 1, 200, 150, '9876543210'),
  ('School Shelter Cuddalore', 2, 300, 275, '9876501234'),
  ('Community Hall Madurai', 3, 150, 90, '9876567890');
  
  INSERT INTO resources (name, type, quantity, unit, location_id)
VALUES
  ('Rice Bags', 'food', 500, 'kg', 1),
  ('Drinking Water Bottles', 'water', 1000, 'liters', 1),
  ('First Aid Kits', 'medical', 50, 'boxes', 2),
  ('Blankets', 'clothing', 300, 'units', 3),
  ('Sanitary Pads', 'other', 400, 'packs', 1);
  
  INSERT INTO users (username, password, role, email, contact_number, is_requesting_help)
VALUES
  ('admin1', 'adminpass', 'admin', 'admin@example.com', '9000000001', false),
  ('agency_tn', 'agencypass', 'agency', 'agency@example.com', '9000000002', false),
  ('volunteer_raj', 'volpass', 'volunteer', 'raj@example.com', '9000000003', false),
  ('deepa_citizen', 'deeppass', 'citizen', 'deepa@example.com', '9000000004', true),
  ('kumar_citizen', 'kumarpass', 'citizen', 'kumar@example.com', '9000000005', false);
  
  INSERT INTO requests (user_id, resource_id, location_id, quantity_requested, status, remarks)
VALUES
  (4, 1, 1, 50, 'pending', 'Need rice for 5 families'),
  (5, 2, 1, 100, 'approved', 'Water shortage in area'),
  (2, 3, 2, 20, 'fulfilled', 'Medical help for cyclone relief');
  
  INSERT INTO audit_log (action, performed_by)
VALUES
  ('Approved request ID 2', 1),
  ('Updated resource quantities in Chennai', 1),
  ('Fulfilled request ID 3', 2);


