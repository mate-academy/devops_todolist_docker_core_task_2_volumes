# Application Deployment Instructions

## 1. Create Docker Network
bash
docker network create todo-net

## 2. Run MySQL Container with Volume Attached
bash
docker volume create mysql_data
MYSQL_DATABASE=app_db -e MYSQL_USER=app_user -e MYSQL_PASSWORD=1234 -e
MYSQL_ROOT_PASSWORD=root -p 3306:3306 dmytro0908/mysql-local:1.0.0

## 3. Run Application Container Connected to MySQL
bash
docker run -d --name todoapp-container --network todo-net -p 8000:8000 -e
DB_HOST=mysql-db -e DB_NAME=app_db -e DB_USER=app_user -e DB_PASSWORD=1234
dmytro0908/todoapp:2.0.0

## 4. Docker Hub Repository
- Application Repository: https://hub.docker.com/r/dmytro0908/todoapp

## 5. Access the Application via Browser
Open your browser and navigate to:
- Main Web Interface: http://localhost:8000
- REST API: http://localhost:8000/api/