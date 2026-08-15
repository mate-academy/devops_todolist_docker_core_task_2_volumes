# ToDo Django Application with MySQL

This document describes how to run the **ToDo Django application** and its **MySQL database** using Docker containers.

## Prerequisites

Before running the application, make sure that Docker is installed on your system.

You can find installation instructions for your operating system in the official Docker documentation:

https://docs.docker.com/engine/install/

## MySQL Container

The application uses a separate MySQL container for database storage.

MySQL uses port `3306` inside the container. It is mapped to port `3310` on the host machine, which can be used to connect to the database with external database management tools.

The MySQL image is configured with the following environment variables:

```text
MYSQL_ROOT_PASSWORD=1234
MYSQL_DATABASE=app_db
MYSQL_USER=app_user
MYSQL_PASSWORD=1234
```

### Run the MySQL Container

Start the MySQL container first:

```bash
docker run -d \
  -p 3310:3306 \
  --name mysql-local \
  -v my-mysql-data:/var/lib/mysql \
  zhekul/mysql-local:1.0.0
```

The container uses the `my-mysql-data` Docker volume to persist database data between container restarts.

The Django application is currently configured to connect to the MySQL container using the Docker bridge network IP address `172.17.0.2`.

Make sure that the MySQL container has this IP address before starting the application.

You can check the container IP address with:

```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local
```

## ToDo Application

The application image is available on Docker Hub:

https://hub.docker.com/repository/docker/zhekul/todoapp/tags/2.0.0

The application uses port `8080`.

### Run the Application

After the MySQL container is running, start the ToDo application:

```bash
docker run -d \
  -p 8080:8080 \
  --name todoapp \
  zhekul/todoapp:2.0.0
```

During application startup, Django database migrations are executed automatically. The required database tables are created in the MySQL database before the Django development server starts.

## Access the Application

After both containers are running, open the following address in your browser:

http://localhost:8080/