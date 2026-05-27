# Django-Todolist Setup Instructions
## Run MySQL Container with Volume
```bash
docker run -d --name mysql-db \
  -e MYSQL_ROOT_PASSWORD=1234 \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -v mysql-data:/var/lib/mysql \
  nikolayhoncharenko/mysql-local:1.0.0
```
## Run App Container

```bash
docker run -d --name django-app \
  -p 8000:8000 \
  --link mysql-db:mysql-db \
  nikolayhoncharenko/todoapp:2.0.0
```

## Access Application


Open browser: http://localhost:8000


## Docker Hub Links

[todoapp](https://hub.docker.com/repository/docker/nikolayhoncharenko/todoapp)

[mysql-local](https://hub.docker.com/repository/docker/nikolayhoncharenko/mysql-local)
