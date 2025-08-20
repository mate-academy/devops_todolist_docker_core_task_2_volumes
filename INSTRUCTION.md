## To run mysql container with attached volume use command:
```shell
    docker run -d -p 3306:3306 --name mysql-local -v mysql-local-data:/var/lib/mysql mysql-local:1.0.0
```

## To run app connected to DB, make sure that mysql container is running and use command:
```shell
    docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0
```

## In the browser open [localhost](http://localhost:8080/)

### [App image](https://hub.docker.com/repository/docker/vsupruniuk/todoapp/general)
### [DB image](https://hub.docker.com/repository/docker/vsupruniuk/mysql-local/general)
