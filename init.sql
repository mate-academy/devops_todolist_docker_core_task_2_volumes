GRANT SELECT, INSERT, UPDATE, DELETE ON app_db.* TO 'app_user'@'%';
FLUSH PRIVILEGES;

-- Use the 'app' database
USE app_db;

-- Create a table to store counter data
CREATE TABLE counter (
   id INT AUTO_INCREMENT PRIMARY KEY,
   value INT NOT NULL DEFAULT 0
);