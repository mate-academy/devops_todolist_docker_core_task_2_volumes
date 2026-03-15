# Django TodoList with MySQL — Docker Instructions

## Docker Hub

- App image: https://hub.docker.com/r/ellipsis1337/todoapp
- MySQL image: https://hub.docker.com/r/ellipsis1337/mysql-local

## 1. Run MySQL Container with a Volume Attached

```bash
docker run -d \
  --name mysql-db \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  mysql-local:1.0.0
```

The `-v mysql-data:/var/lib/mysql` flag creates a named volume `mysql-data` that persists database data across container restarts and removals.

## 2. Run the App Container Connected to MySQL

First, find NAME and DRIVER with values 'bridge' using:

```bash
docker network list
```

than find IPv4Address of mysql-db container

```bash
docker network inspect <network_id>
```

Than paste this IP into  `todolist/settings.py`,  `DATABASES['default']['HOST']`, then build and run:

```bash
docker run -d \
  --name todoapp \
  -p 8080:8080 \
  todoapp:2.0.0
```

## 3. Access the Application

Open your browser and go to:

```
http://localhost:8080
```
