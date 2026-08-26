# Todo App - Run Instructions

## 1. Run MySQL Container with Volume

Run the MySQL container with a named volume to persist database data:

docker run -v mysql-data:/var/lib/mysql -d -p 3306:3306 daniilshpak/mysql-local:1.0.0

The mysql-data volume stores MySQL data in /var/lib/mysql and keeps the data persistent.

## 2. Run Todo Application

Make sure the MySQL container is running before starting the application.

Run the Todo application container:

docker run -d -p 8081:8080 daniilshpak/todoapp:2.0.0

The application connects to the MySQL container and is available on host port 8081.

## 3. Docker Hub Image

Todo application Docker Image:

https://hub.docker.com/r/daniilshpak/todoapp

## 4. Access the Application

Open the application in your browser:

http://localhost:8081
