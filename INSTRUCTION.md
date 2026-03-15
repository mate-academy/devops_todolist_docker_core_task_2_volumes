# Todo Django App

## Run MySQL container

Create volume:

```
docker volume create mysql-data
```
## Create Docker Network
```
docker network create todo-network
```

## Run MySQL container
```
docker run -d \
--name mysql-container \
--network todo-network \
-v mysql-data:/var/lib/mysql \
-p 3306:3306 \
aleksandra2402/mysql-local:1.0.0
```

## Run App container
```
docker run -p 8000:8000 \
--network todo-network \
aleksandra2402/todoapp:2.0.0
```

## Open Application
Open browser:
http://localhost:8000
