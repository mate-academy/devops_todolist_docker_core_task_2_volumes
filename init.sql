GRANT ALL PRIVILEGES ON app_db.* TO 'app_user'@'%';

USE app_db;

CREATE TABLE counter (
   id INT AUTO_INCREMENT PRIMARY KEY,
   value INT
);
