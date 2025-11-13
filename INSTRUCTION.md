# Django-Todolist + MySQL (Docker)

## Docker Hub
- MySQL: https://hub.docker.com/r/mcisb/mysql-local/tags
- App:   https://hub.docker.com/r/mcisb/todoapp/tags

## 1) Запуск MySQL с volume

```bash
docker network create todo-net || true

sudo mkdir -p /srv/mysql-data
sudo chown -R 999:999 /srv/mysql-data

docker run -d --name mysql \
  --network todo-net \
  -p 3306:3306 \
  -v /srv/mysql-data:/var/lib/mysql \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  mcisb/mysql-local:1.0.0
