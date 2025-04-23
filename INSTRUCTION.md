# MySQL and TodoApp Docker Setup Guide

## 1. Running MySQL Container


# https://hub.docker.com/repository/docker/savik1992/mysql-local/general

First, start the MySQL container:

# Pull MySQL image
```bash
docker pull savik1992/mysql-local:1.0.0
```

# Run MySQL container
```bash
docker run -d \
  --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=root_password \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  savik1992/mysql-local:1.0.0
```

# Verify container is running
```bash
docker ps
```

## 2. Running TodoApp Container

# https://hub.docker.com/repository/docker/savik1992/todoapp/general

First, start the MySQL container:


# Pull MySQL image
```bash
docker pull savik1992/todoapp:2.0.0
```

# Run application container

```bash
docker run -d \
  --name app-container \
  -p 8080:8080 \
  --link mysql-container:mysql \
  savik1992/todoapp:2.0.0
```

# Verify container is running

```bash
docker ps
```
## 3. Accessing the Application

```bash
http://localhost:8080
```