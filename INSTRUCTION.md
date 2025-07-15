## Docker Instructions for Django-Todolist

## Run MySQL Container with Volume

```bash
docker network create app-network

docker run -d \
  --name mysql-local-container \
  --network app-network \
  -v mysql_data:/var/lib/mysql \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -e MYSQL_ROOT_PASSWORD=root \
  vitaliich/mysql-local:1.0.0
```

docker run -d \
 --name todoapp-container \
 --network app-network \
 -e DB_HOST=mysql-local-container \
 -e DB_USER=app_user \
 -e DB_PASSWORD=1234 \
 -e DB_NAME=app_db \
 -p 8080:8080 \
 vitaliich/todoapp:2.0.0

Open in your browser:

http://localhost:8080

🔗 Docker Hub Links
MySQL Image: https://hub.docker.com/r/vitaliich/mysql-local

App Image: https://hub.docker.com/r/vitaliich/todoapp
