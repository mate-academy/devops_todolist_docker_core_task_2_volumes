# Django TodoList with MySQL — Docker Instructions

## Docker Hub

- App image: https://hub.docker.com/r/ellipsis1337/todoapp
- MySQL image: https://hub.docker.com/r/ellipsis1337/mysql-local

## 1. Create a Docker Network

```bash
docker network create todo-network
```

## 2. Run MySQL Container with a Volume Attached

```bash
docker run -d \
  --name mysql-db \
  --network todo-network \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  mysql-local:1.0.0
```

The `-v mysql-data:/var/lib/mysql` flag creates a named volume `mysql-data` that persists database data across container
restarts and removals.

## 3. Run the App Container Connected to MySQL

```bash
docker run -d \
  --name todoapp \
  --network todo-network \
  -p 8080:8080 \
  todoapp:2.0.0
```

## 4. Access the Application

Open your browser and go to:

```
http://localhost:8080
```
