Проєкт складається з Docker-образу бази даних MySQL та Python-застосунку. Образ MySQL 
доступний за посиланням https://hub.docker.com/r/goldbernik/mysql-local
, образ застосунку — https://hub.docker.com/r/goldbernik/todoapp_1
. Для запуску необхідно мати встановлений Docker. 
Спочатку потрібно запустити контейнер MySQL з підключеним томом командою 
docker run -d --name mysql-local -p 3306:3306 -v mysql_data:/var/lib/mysql goldbernik/mysql-local:1.0.0. 
Далі необхідно отримати IP-адресу контейнера MySQL та вказати
її в конфігурації Python-застосунку. Після цього запускається контейнер 
застосунку командою docker run -d --name todoapp -p 8080:8080 goldbernik/todoapp_1:2.0.0. 
Застосунок буде доступний у браузері за адресою http://localhost:8080
, або за IP-адресою сервера, якщо запуск виконується віддалено.
Дані MySQL зберігаються у Docker-томі та не втрачаються після перезапуску контейнерів.