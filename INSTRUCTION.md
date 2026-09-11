# Instructions

## Docker Hub repository
App image: https://hub.docker.com/r/mavik27/todoapp

## Run MySQL container with volume
docker run -d --name mysql-container \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  mavik27/mysql-local:1.0.0

## Run App container (connects to MySQL)
docker run -d --name todoapp-container \
  -p 8080:8080 \
  mavik27/todoapp:2.0.0

Note: make sure settings.py HOST matches the MySQL container's IP
(see `docker inspect mysql-container`).

## Access the application
Open your browser at: http://localhost:8080