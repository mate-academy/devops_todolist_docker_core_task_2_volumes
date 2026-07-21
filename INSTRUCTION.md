# ToDo List Application Setup

## 1. Run MySQL Container with Volume
```
docker run -d --name mysql-server -p 3306:3306 -v mysql_data:/var/lib/mysql diashockh/mysql-local:1.0.0
```

## 2. Run App Container
```
docker run -d --name todo-app -p 8000:8000 diashockh/todoapp:2.0.0
```

## 3. Docker Hub Repository
https://hub.docker.com/r//todoapp

## 4. Accessing the Application
http://localhost:8000

