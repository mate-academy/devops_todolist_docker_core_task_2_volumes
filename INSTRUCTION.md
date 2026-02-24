# Instructions to Run Todo App with Docker and MySQL

## Step 1: Run MySQL container with volume

```bash
docker run -d \
  --name mysql-local \
  -v mysql_data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -p 3306:3306 \
  yourusername/mysql-local:1.0.0

docker build mysql-local:1.0.0

docker build todoapp:2.0.0

docker network create

docker volume create

docker run mysql

docker run app с -e DB_HOST=mysql-container

http://localhost:8000

https://hub.docker.com/repository/docker/a1exic/oleksii/general

```
