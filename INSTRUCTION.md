# Django ToDo App with MySQL

## Docker Hub Repositories

- Django App: https://hub.docker.com/r/dmytrotverdun/todoapp
- MySQL Database: https://hub.docker.com/r/dmytrotverdun/mysql-local

## Create Docker Network

```bash
docker network create todo-network
```

## Create Docker Volume

```bash
docker volume create todo-mysql-data
```

## Run MySQL Container

```bash
docker run -d --name todo-mysql --network todo-network -v todo-mysql-data:/var/lib/mysql dmytrotverdun/mysql-local:1.0.0
```

## Build Django Image

```bash
docker build -t todoapp:2.0.0 .
```

## Run Django Container

```bash
docker run -d --name todo-app --network todo-network -p 8080:8080 dmytrotverdun/todoapp:2.0.0
```

## Access the Application

Open the application in your browser:

http://localhost:8080

To access the ToDo list:

http://localhost:8080/todolist

## Application Startup Screenshot

![Successful Django startup](screenshots/django-startup.png)