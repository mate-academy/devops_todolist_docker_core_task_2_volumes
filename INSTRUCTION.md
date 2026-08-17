# INSTRUCTION.md

## 1. Run MySQL container with a volume

Create a Docker volume:

```bash
docker volume create mysql-data
```

Run the MySQL container:

```bash
docker run -d \
  --name mysql-local \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  mysql-local:1.0.0
```

Check that the container is running:

```bash
docker ps
```

Get the MySQL container IP:

```bash
docker inspect mysql-local
```

Use this IP as the `HOST` value in `todolist/settings.py`.

## 2. Run App container connected to MySQL

Run the application container:

```bash
docker run -d \
  --name todoapp \
  -p 8080:8080 \
  todoapp:2.0.0
```

The application connects to the MySQL container using its IP address configured in `todolist/settings.py`.

## 3. Docker Hub

Application images:

https://hub.docker.com/repository/docker/qwertyasd0933/todoapp/general

https://hub.docker.com/repository/docker/qwertyasd0933/mysql-local/general

## 4. Access the application

Open the following address in a web browser:

http://localhost:8000
