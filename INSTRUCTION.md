## how to create a Docker network

```
docker network create todoapp-network
```

## how to run MySQL container with a volume attached

```
docker run -d -p 3306:3306 --name mysql-local --network todoapp-network -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
```

## how to run an App container which will connect to a MySQL db container

```
docker run -d -p 8085:8080 --name todoapp --network todoapp-network -e MYSQL_HOST=mysql-local todoapp:2.0.0
```

## link to docker hub repository with an app image - mysql

```
https://hub.docker.com/repository/docker/andriyshafran/mysql-local/
```

## link to docker hub repository with an app image - todoapp

```
https://hub.docker.com/repository/docker/andriyshafran/todoapp/
```

## how to access the application via a browser

```
http://127.0.0.1:8085
```
