## Creation of build of image for mysql

```
docker build . -t mysql-local:1.0.0 -f Dockerfile.mysql
```

## network creation

```
docker network create todo-net
```

## creation volume

```
docker volume create my-sql-volume-1
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
docker run -d --name todo-app-container-2 --network todo-net -p 8080:8080 -e DB_HOST=my-sql-container todoapp:2.0.0
```

## Link to app image on docker hub

https://hub.docker.com/r/petrokurinnyi/todoapp

## Link to mysql-local

https://hub.docker.com/r/petrokurinnyi/mysql-local

## Link to the screenshot of working app

https://drive.google.com/file/d/1uPZRIkb6V7YFfXO2RvgU0hcZh5m7DonO/view?usp=sharing

## Link for opening app

http://localhost:8080/
