# Instructions

## Docker Hub repository
- MySQL image: https://hub.docker.com/r/mavik27/mysql-local
- App image: https://hub.docker.com/r/mavik27/todoapp

## 1. Run MySQL container with a volume

docker volume create mysql_data

docker run -d \
  --name mysql-container \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mavik27/mysql-local:1.0.0

## 2. Get MySQL container IP and update settings.py (if needed)

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-container

## 3. Run the App container

docker run -d \
  --name todoapp-container \
  -p 8000:8000 \
  mavik27/todoapp:2.0.0

## 4. Access the application

Open your browser and go to:
http://localhost:8000/

API is available at:
http://localhost:8000/api/