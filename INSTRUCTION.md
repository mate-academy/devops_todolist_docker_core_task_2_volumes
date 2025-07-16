# Інструкція для запуску Dockerized Django ToDoList з MySQL

## Репозиторії образів на Docker Hub

- MySQL образ: https://hub.docker.com/r/langrafka/mysql-local
- Django ToDoList образ: https://hub.docker.com/r/langrafka/todoapp

---

## Крок 1. Запуск контейнера MySQL з томом для збереження даних

```bash
docker volume create mysql_data

docker run -d \
  --name mysql-db \
  -v mysql_data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -p 3307:3306 \
  langrafka/mysql-local:1.0.0
