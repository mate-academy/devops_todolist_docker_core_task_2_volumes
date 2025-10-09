-- Grant privileges to the app_user (created by MYSQL_USER env var)
GRANT ALL PRIVILEGES ON app_db.* TO 'app_user'@'%';
FLUSH PRIVILEGES;

-- Use the 'app_db' database
USE app_db;

-- Create a table to store counter data
CREATE TABLE IF NOT EXISTS counter (
   id INT AUTO_INCREMENT PRIMARY KEY,
   value INT DEFAULT 0
);
