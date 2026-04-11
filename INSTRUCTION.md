# Docker Setup Instructions

## MySQL

Build image:

docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .

Run container:

docker run -d --name mysql-container -p 3307:3306 -v mysql_data:/var/lib/mysql mysql-local:1.0.0

## App

Build image:

docker build -t todoapp:2.0.0 .

Run container:

docker run -d -p 8081:8080 todoapp:2.0.0

Run migrations:

docker exec -it 9e15060665a9 python manage.py migrate

## Access

Open browser:

http://localhost:8081

## Docker Hub

https://hub.docker.com/r/justoleh/todoapp