# Django TodoList — Docker Instructions

## 1. Run MySQL container

Create a Docker volume for MySQL data:

```bash
docker volume create mysql-data
```

Run the MySQL container with the volume attached:

```bash
docker run -d \
  --name mysql-local \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  boz1k/mysql-local:1.0.0
```

Check that the MySQL container is running:

```bash
docker ps
```

MySQL uses the following configuration:

* Database: `app_db`
* User: `app_user`
* Password: `1234`
* Port: `3306`

## 2. Run the application container

The Django application connects to the running MySQL container using its IP address.

Check the MySQL container IP:

```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local
```

The IP address must match the `HOST` value in `todolist/settings.py`.

Build the application image:

```bash
docker build -t todoapp:2.0.0 .
```

Run the application:

```bash
docker run -d \
  --name todoapp \
  -p 8080:8080 \
  todoapp:2.0.0
```

Check running containers:

```bash
docker ps
```

Check application logs:

```bash
docker logs todoapp
```

The application should start on port `8080`.

## 3. Docker Hub

The application image is available on Docker Hub:

[Docker Hub — boz1k/todoapp](https://hub.docker.com/r/boz1k/todoapp)

Image:

```text
boz1k/todoapp:2.0.0
```

The MySQL image is also available on Docker Hub:

```text
boz1k/mysql-local:1.0.0
```

## 4. Access the application

After both containers are running, open the application in a web browser:

```text
http://localhost:8080
```
