GRANT ALL PRIVILEGES ON app_db.* TO 'app_user'@'%';

-- Use the 'app' database
USE app_db;

-- Create a table to store counter data
CREATE TABLE counter (
   id INT AUTO_INCREMENT PRIMARY KEY,
   value INT
);
