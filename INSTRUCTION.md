# Run MySQL Container

docker volume create mysql_data

docker run -d --name mysql-container -p 3306:3306 -v mysql_data:/var/lib/mysql shvdw/mysql-local:1.0.0

# Run Todo Application

docker run -d --name todoapp-container -p 8000:8000 shvdw/todoapp:2.0.0

# Open application

http://localhost:8000

# Docker Hub repositories

https://hub.docker.com/r/shvdw/todoapp

https://hub.docker.com/r/shvdw/mysql-local