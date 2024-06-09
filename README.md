## Links to DockerHub

https://hub.docker.com/repository/docker/stasblashchuk97/mysql-local
https://hub.docker.com/repository/docker/stasblashchuk97/todoapp

## Images to download

Download the mysql-local:1.0.0 image from the mysql-local repository
Download the todoapp:2.0.0 image from the todoapp repository

## How to build and run the MySQL container with a volume attached

1. Run the mysql container by executing following command
```
 docker run -d -p 3307:3306 -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
 ```

1. Run the todoapp container by executing following command
```
 docker run -d -p 8080:8080 -v my-mysql-data:/var/lib/mysql todoapp:2.0.0
 ```

## How to access the application via browser

Open browser and proceed by following url http://0.0.0.0:8080/