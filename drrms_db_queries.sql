create database drrms_db;

use drrms_db;


CREATE TABLE locations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,                   -- Area/City name
  region VARCHAR(100),                          -- Broader region like district or state
  latitude DECIMAL(10, 6),
  longitude DECIMAL(10, 6),
  weather_condition VARCHAR(50),                -- e.g., 'Rain', 'Cyclone', 'Clear'
  weather_alert ENUM('none', 'yellow', 'orange', 'red') DEFAULT 'none',
  last_weather_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO locations (name, region, latitude, longitude, weather_condition, weather_alert)
VALUES 
('Chennai', 'Tamil Nadu', 13.0827, 80.2707, 'Heavy Rain', 'orange'),
('Cuddalore', 'Tamil Nadu', 11.7463, 79.7714, 'Cyclone Warning', 'red'),
('Madurai', 'Tamil Nadu', 9.9252, 78.1198, 'Cloudy', 'yellow'),
('Coimbatore', 'Tamil Nadu', 11.0168, 76.9558, 'Clear', 'none'),
('Tirunelveli', 'Tamil Nadu', 8.7139, 77.7567, 'Moderate Rain', 'yellow'),
('Kanchipuram', 'Tamil Nadu', 12.8352, 79.7036, 'Drizzle', 'none');

select * from locations;



