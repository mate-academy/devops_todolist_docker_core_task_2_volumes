Инструкция по запуску проекта Django-Todolist

Запуск MySQL контейнера

---bash
docker run -d \
  --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  your_dockerhub_username/mysql-local:1.0.0
