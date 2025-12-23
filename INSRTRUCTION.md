# Instructions

## Run MySQL Container with Volume

1. Create a volume for persistent storage:

```bash
  docker volume create mysql-data
```

2. Run MySQL container with volume attached:

```bash
  docker run -d \
    --name mysql-local \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_DATABASE=app_db \
    -e MYSQL_USER=app_user \
    -e MYSQL_PASSWORD=1234 \
    -p 3306:3306 \
    -v mysql-data:/var/lib/mysql \
    mysql-local:1.0.0
```

## Run App Container

1. Get MySQL container IP address:

```bash
  docker inspect mysql-local | grep "IPAddress"
```

2. Update todolist/settings.py with the MySQL container IP

3. Build the todoapp image:

```bash
  docker build . -f Dockerfile -t todoapp:2.0.0
```

4. Run the todoapp container:

```bash
  docker run -d \
    --name todoapp \
    -p 8080:8080 \
    todoapp:2.0.0
```

## Access Application

Open browser and navigate to: http://localhost:8080

## Docker Hub Repositories

- MySQL image: https://hub.docker.com/r/booobryyyyk/mysql-local
- App image: https://hub.docker.com/r/booobryyyyk/todoapp
