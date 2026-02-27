## To build and run mysql container with attached volume use commands:

```shell
    docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
    docker run -d -p 3306:3306 --name mysql-local -v mysql-local-data:/var/lib/mysql mysql-local:1.0.0
```


## To run app connected to DB, make sure that mysql container is running and use command:

```shell
    docker network inspect bridge
```



## Grab the container `IPv4Address` and replace in `todolist/settings.py` in `DATABASES`(line 70) property



## Use commands to build and run the app

```shell
    docker build . -f Dockerfile -t todoapp:2.0.0
    docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0
```



## In the browser open [localhost](http://localhost:8080/)



## To push any of the images use commands:

```shell
    docker tag [source-image] [repository-name]/[source-image]
    docker push [repository-name]/[source-image]
```



## Docker Hub links:
App image: [aisengrim/todoapp2](https://hub.docker.com/repository/docker/aisengrim/todoapp2/general)
MySQL image: [aisengrim/mysql-local](https://hub.docker.com/repository/docker/aisengrim/mysql-local/general)
