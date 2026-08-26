## 1. Run MySQL container with a volume

docker run -d --name mysql-local -p 3306:3306 -v mysql-local-data:/var/lib/mysql mysql-local:1.0.0

## 2. Run the App container and connect it to MySQL

docker inspect mysql-local

#Find the IPAddress and use it in the Django database configuration

docker build -t todoapp:2.0.0 .

docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0

## 3. Docker Hub repository

nicotqq/todoapp:2.0.0

docker run -d --name todoapp -p 8080:8080 nicotqq/todoapp:2.0.0

## 4. Access the application via a browser

http://localhost:8080