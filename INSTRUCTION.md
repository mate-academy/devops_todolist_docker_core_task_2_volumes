# Instructions

## 1. Run MySQL container with a volume attached

```bash
docker volume create mysql-data

docker run -d \
  --name mysql-container \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  <твій_логін>/mysql-local:1.0.0
```

## 2. Run the App container connected to MySQL

```bash
docker run -d \
  --name todoapp-container \
  --network host \
  <твій_логін>/todoapp:2.0.0
```

> The app connects to MySQL via `localhost:3306`, which works because both containers share the host's network stack (`--network host`).

## 3. Docker Hub repository

App image: https://hub.docker.com/r/<твій_логін>/todoapp

## 4. Access the application

Open your browser and go to:

```
http://localhost:8080
```