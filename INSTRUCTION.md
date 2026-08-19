# Instructions

## 1. Build MySQL image

```
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
```

## 2. Create a Docker volume for MySQL data

```
docker volume create mysql-data
```

## 3. Run the MySQL container with the volume 

```
docker run -d --name mysql-local -p 3306:3306 -v mysql-data:/var/lib/mysql mysql-local:1.0.0
```

## 4. Check MySQL container logs
```
docker logs mysql-local
```

## 5. Connect to the MySQL database inside the container

```
docker exec -it mysql-local mysql -uapp_user -p1234 app_db
```

## 6.  Run the application container 
```
docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0 
```

## Docker Hub repository

[Link](https://hub.docker.com/repository/docker/tetianamohorian/todoapp-2)

## Access application in the browser

[http://localhost:8080](http://localhost:8080)
