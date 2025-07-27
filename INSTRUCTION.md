## How to run the project

### Run MySQL with volume:

```bash
docker run -d \
  --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  your_dockerhub_username/mysql-local:1.0.0
```

### Run Django App (after updating DB host in settings.py)

```bash
docker run -d \
  -p 8000:8000 \
  --name todo-app \
  your_dockerhub_username/todoapp:2.0.0
```

### Open in browser:

http://localhost:8000/

### HUB 

https://hub.docker.com/repository/docker/stacyvariuchuk/mysql-local/general
https://hub.docker.com/repository/docker/stacyvariuchuk/todoapp/general
