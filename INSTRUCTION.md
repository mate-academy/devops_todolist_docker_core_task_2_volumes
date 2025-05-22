# 📦 Running TodoApp with MySQL using Docker

## 🐬 Step 1: Run MySQL container with volume

Create a named volume to persist MySQL data:
```bash
docker volume create mysql_data
```
```bash
docker run -d \
  --name mysql_container \
  -e MYSQL_ROOT_PASSWORD=devpassword123 \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=devpassword123 \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql:latest

```

## Step 2: Run the App container (connects to MySQL)

```bash
docker run -d \
  --name todo_app \
  --link mysql_container \
  -e DB_HOST=mysql_container \
  -e DB_PORT=3306 \
  -e DB_NAME=app_db \
  -e DB_USER=app_user \
  -e DB_PASSWORD=devpassword123 \
  -p 8080:8000 \
  alex13thx/todoapp-python:2.0.0

```

## 3: Access the application
http://localhost:8080/


## Docker Hub App Image
https://hub.docker.com/repository/docker/alex13thx/todoapp-python/general