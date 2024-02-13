# Django-Todolist

## How to run MySQL container with a volume attached

```bash
    docker build -f Dockerfile.mysql -t mysql-local:1.0.0
```

```bash
    docker run -d -p 3306:3306 --name mysql-container -e MYSQL_ROOT_PASSWORD=root_password -v mysql_data:/var/lib/mysql mysql-local:1.0.0
```

## How to run an App container which will connect to a MySQL db container

```bash
    docker build -f Dockerfile -t todoapp:2.0.0
```

```bash
    docker run -d -p 8000:8000 --name todoapp-container --link mysql-container todoapp:2.0.0
```

[docker hub repository mysql](https://hub.docker.com/repository/docker/khyelyseieva/mysql-local/general)
[docker hub repository todoapp](https://hub.docker.com/repository/docker/khyelyseieva/todoapp/general)

[http://0.0.0.0:8080](http://0.0.0.0:8080/)
