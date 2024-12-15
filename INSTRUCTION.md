Інструкція для розгортання

1. Запуск MySQL-контейнера

docker run -d \
    --name mysql-local-container \
    -v mysql_data:/var/lib/mysql \
    -e MYSQL_DATABASE=app_db \
    -e MYSQL_USER=app_user \
    -e MYSQL_PASSWORD=1234 \
    -e MYSQL_ROOT_PASSWORD=rootpassword \
    -p 3306:3306 \
    zaebalsya13/mysql-local:1.0.0

2. Запуск додатку

docker run -d \
    --name todoapp-container \
    -p 8080:8080 \
    --link mysql-local-container:mysql \
    zaebalsya13/todoapp:2.0.0

3. Доступ до додатку

Відкрий у браузері: http://localhost:8080.


Docker Hub посилання

•	MySQL: https://hub.docker.com/r/zaebalsya13/mysql-local
	
•	Додаток: https://hub.docker.com/r/zaebalsya13/todoapp