# Django-Todolist

## Instructions 

https://hub.docker.com/repository/docker/obieliaiev782/mysql-local/general
https://hub.docker.com/repository/docker/obieliaiev782/todoapp/general

### How to run MySQL container with a volume attached

Build:
```
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
```
Run:
```
docker run -d --name mysql-container -p 3306:3306 -v mysql-volume:/var/lib/mysql mysql-local:1.0.0
```

### How to run an App container which will connect to a MySQL db container

Build:
```
docker build . -t todoapp:2.0.0
```
Run:
```
docker run -d -p 8081:8080 --name todoapp-server todoapp:2.0.0
```

### Access the application via a browser

[Landing Page](http://localhost:8081)