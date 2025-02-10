# Інструкція з запуску додатку

## Запуск MySQL-контейнера
```sh
docker run -d --name mysql_container -e MYSQL_ROOT_PASSWORD=root_password \
  -e MYSQL_DATABASE=app_db -e MYSQL_USER=app_user -e MYSQL_PASSWORD=1234 \
  -v mysql_data:/var/lib/mysql -p 3306:3306 maxisky2595/mysql-local:1.0.0