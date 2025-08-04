# How to run the app with MySQL

## Run MySQL container with volume
```bash
docker volume create mysql-data

docker run -d \
  --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=1234 \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  gosxa/mysql-local:1.0.0
```

## Run the App container
```bash
docker run -d --name todoapp-container -p 8080:8080 gosxa/todoapp:2.0.0
```
Access app in browser:
http://localhost:8080/

DockerHub app image:
https://hub.docker.com/r/gosxa/todoapp