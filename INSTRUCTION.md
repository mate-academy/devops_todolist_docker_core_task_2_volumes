### Run MySQL Container with Volume Attached

```
docker run -d --name mysql_container \
-e MYSQL_ROOT_PASSWORD=root \
-e MYSQL_DATABASE=app_db \
-e MYSQL_USER=app_user \
-e MYSQL_PASSWORD=1234 \
-v mysql_data:/var/lib/mysql \
-p 3306:3306 \
olhaho/mysql-local:1.0.0
```

### Get IP Address Of MySql

```
MYSQL_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql_container)
```

### Run the App Container Connecting to MySQL

```
docker run -d --name todoapp_container \
-e DATABASE_HOST=$MYSQL_IP \
-p 8080:8080 \
olhaho/todoapp:2.0.0
```

### Docker Hub Repository Link

MySql Image: https://hub.docker.com/r/olhaho/mysql-local/tags
App Image: https://hub.docker.com/r/olhaho/todoapp/tags

### Access the Application

Link for app: http://localhost:8080
