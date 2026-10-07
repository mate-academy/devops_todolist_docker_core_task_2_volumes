# Docker Run Instructions

## 1) Build and run the MySQL container with a volume attached

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
docker volume create mysql-data
docker run -d --name mysql-db -p 3306:3306 -v mysql-data:/var/lib/mysql \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  mysql-local:1.0.0
```

Check the container is healthy:

```bash
docker ps
docker logs mysql-db
```

## 2) Build the application image

```bash
docker build -t todoapp:2.0.0 .
```

## 3) Run the application container and connect it to MySQL

```bash
docker run -d --name todoapp -p 8080:8080 --link mysql-db:mysql-db \
  -e DB_HOST=mysql-db \
  -e DB_NAME=app_db \
  -e DB_USER=app_user \
  -e DB_PASSWORD=1234 \
  -e DB_PORT=3306 \
  todoapp:2.0.0
```

If your MySQL container is on a custom Docker network or a different host, replace `DB_HOST` with the actual MySQL IP address:

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-db
```

## 4) Push images to Docker Hub

```bash
docker login
docker tag mysql-local:1.0.0 rimbozero/mysql-local:1.0.0
docker push rimbozero/mysql-local:1.0.0
docker tag todoapp:2.0.0 rimbozero/todoapp:2.0.0
docker push rimbozero/todoapp:2.0.0
```

Docker Hub repositories:

- MySQL image: https://hub.docker.com/r/rimbozero/mysql-local
- App image: https://hub.docker.com/r/rimbozero/todoapp

## 5) Access the application in a browser

Open:

```text
http://localhost:8080
```

The application should start successfully after the database is reachable and the Django migrations complete.
