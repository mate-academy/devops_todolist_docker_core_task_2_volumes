# INSTRUCTION

## Run MySQL container with a volume attached
```
docker run --name mysql-volume -p 3306:3306 -d -v mysql-data:/var/lib/mysql rmarianna/mysql-local:1.0.0
```

## Run an App container which will connect to a MySQL db container
1. Create a network for containers
```
docker network create mysql-data
```
2. Run a MySQL container on this network
```
docker run --name mysql-db --network mysql-data -e MYSQL_DATABASE=app_db -e MYSQL_USER=app_user -e MYSQL_PASSWORD=1234 -e MYSQL_ROOT_PASSWORD=root -v mysql_data:/var/lib/mysql -d mysql-local:1.0.0
```
3. Update *settings.py* file in *HOST*, specify mysql-db instead of localhost
4. Run the App container on the same network
```
docker run --name todo-app --network todo-net -p 8000:8000 -d todoapp:2.0.0
```

## The link to my personal docker hub repository with an app image
[todoapp](https://hub.docker.com/repository/docker/rmarianna/todoapp/tags/2.0.0/sha256-5a194f784e4120a4c8ec8169d9e7cd63e5d8343e9083d2a87672adbc81cffb0d)


##  How to access the application via a browser
http://localhost:8080/
