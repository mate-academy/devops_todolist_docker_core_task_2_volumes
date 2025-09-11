# INSTRUCTION

## Build and push MySQL image
```
docker build -f Dockerfile.mysql -t rmarianna/mysql-local:1.0.0 .
docker push rmarianna/mysql-local:1.0.0
```

## Build and push App image
```
docker build -t rmarianna/todoapp:2.0.0 .
docker push rmarianna/todoapp:2.0.0

```

## Run MySQL container with a volume attached
```
docker volume create mysql_data
docker run --name mysql-db --network todo-net -p 3306:3306 -d -v mysql_data:/var/lib/mysql rmarianna/mysql-local:1.0.0
```

## Run an App container which will connect to a MySQL db container
1. Create a network for containers
```
docker network create todo-net
```
2. Run a MySQL container on this network (the MySQL container must be running at this point)
```
docker run --name mysql-db --network todo-net -v mysql_data:/var/lib/mysql -d rmarianna/mysql-local:1.0.0
```
3. Update *settings.py* file in *HOST*, specify mysql-db instead of localhost
4. Run the App container on the same network
```
docker run --name todo-app --network todo-net -p 8080:8080 -d rmarianna/todoapp:2.0.0
```

## The link to my personal docker hub repository with an app image
[todoapp](https://hub.docker.com/repository/docker/rmarianna/todoapp:2.0.0)


##  How to access the application via a browser
http://localhost:8080/
