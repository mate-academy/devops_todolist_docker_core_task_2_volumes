## Creation docker network
```
docker network create todo-net
```
## Creation of build of image for mysql

```
docker build . -t mysql-local:1.0.0 -f Dockerfile.mysql
```

## Starting container with mysql and volume

```
docker run -d --name my-sql-container --network todo-net -p 3306:3306 -v my-sql-volume-1:/var/lib/mysql mysql-local:1.0.0
```

## Build app image

```
docker build -t todoapp:2.0.0 .
```

## Start app container

```
docker run -d --name todo-app-container --network todo-net -p 8080:8080 todoapp:2.0.0

```

## Link to app image on docker hub

https://hub.docker.com/repository/docker/apihunter/todolist/general

## Link for opening app

http://0.0.0.0:8080