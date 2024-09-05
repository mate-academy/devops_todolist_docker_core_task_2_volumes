# TODOApp Setup Guide

## Docker Hub Images

- **TODOApp Image:** [efirshey/todoapp](https://hub.docker.com/repository/docker/efirshey/todoapp/general)
- **MySQL Image:** [efirshey/mysql-local](https://hub.docker.com/repository/docker/efirshey/mysql-local/general)

## Start Containers

To start the containers, run the following commands:

```bash
docker run -d -p 3306:3306 --name mysql -v mysql-data:/var/lib/mysql mysql-local:1.0.0
docker run -d -p 8080:8080 --name todo-app todoapp:2.0.0
```

## FIND APPLICATION IN BROWSER

http://127.0.0.1:8080
 