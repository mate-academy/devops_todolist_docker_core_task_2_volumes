# Django ToDo List — Docker Instructions

## Description

Django ToDo List is a web application that provides task management functionality, user authentication, and a REST API.

The application runs inside Docker containers using:

- Python 3.11
- Django 4.1.10
- MySQL 8.0
- MySQL Connector/Python 8.2.0
- Docker Volumes
- Docker Networks

The application uses MySQL as its database. Database data is stored in a persistent Docker Volume.

## Docker Hub Repositories

The Docker images are available on Docker Hub.

### Django Application

Repository:

https://hub.docker.com/r/romanartem/todoapp

Image:

`romanartem/todoapp:2.0.0`

### MySQL Database

Repository:

https://hub.docker.com/r/romanartem/mysql-local

Image:

`romanartem/mysql-local:1.0.0`

### Previous Application Version

The previous application image is also available:

`romanartem/todoapp:1.0.0`

Version 1.0.0 uses SQLite, while version 2.0.0 uses MySQL with persistent storage.

## Requirements

Before running the application, install:

- Docker Desktop
- Git

Make sure Docker Desktop is running.

## 1. Clone the Repository

Clone the GitHub repository:

```bash
git clone https://github.com/KoLpI76/devops_todolist_docker_core_task_2_volumes.git
cd devops_todolist
```

Switch to the solution branch:

```bash
git switch task_solution
```

## 2. Create a Docker Network

Create a Docker network to allow communication between the Django and MySQL containers:

```bash
docker network create todo-network
```

Verify the network:

```bash
docker network ls
```

Both containers will use the `todo-network` network.

## 3. Create a Docker Volume

Create a persistent Docker Volume for MySQL:

```bash
docker volume create mysql-data
```

Verify that the volume exists:

```bash
docker volume ls
```

The volume stores MySQL database files and preserves them when the database container is removed.

## 4. Build the MySQL Docker Image

Build the MySQL image using `Dockerfile.mysql`:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

The Dockerfile is based on the official MySQL 8.0 image.

It initializes the following database configuration:

| Parameter | Value |
|---|---|
| Database | app_db |
| Username | app_user |
| Password | 1234 |
| MySQL port | 3306 |
| Root password | root1234 |

These credentials are used for educational purposes only.

## 5. Run MySQL with a Persistent Volume

Start the MySQL container:

```bash
docker run -d \
  --name mysql-container \
  --network todo-network \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```

The command:

- Starts the MySQL container in detached mode.
- Connects it to the Docker network.
- Attaches the persistent Docker Volume.
- Exposes MySQL on port 3306.

Verify the container:

```bash
docker ps
```

Check MySQL logs:

```bash
docker logs mysql-container
```

Wait until the logs contain:

```text
ready for connections
```

## 6. Verify the MySQL Database

Connect to MySQL using the application user:

```bash
docker exec mysql-container mysql -u app_user -p -D app_db -e "SHOW DATABASES;"
```

Enter the password `1234` when prompted.

Expected databases include:

```text
app_db
information_schema
performance_schema
```

This confirms that the application user can connect to MySQL.

## 7. Verify the Docker Volume

Check the volume attached to the MySQL container:

```bash
docker inspect mysql-container --format '{{range .Mounts}}{{.Name}} -> {{.Destination}}{{println}}{{end}}'
```

Expected output:

```text
mysql-data -> /var/lib/mysql
```

This confirms that MySQL stores
