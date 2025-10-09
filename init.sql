-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS app_db;


-- Use the 'app_db' database
USE app_db;

-- Create a table to store counter data
CREATE TABLE IF NOT EXISTS counter (
   id INT AUTO_INCREMENT PRIMARY KEY,
   value INT DEFAULT 0
);
