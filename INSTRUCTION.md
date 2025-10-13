# INSTRUCTION.md - коротка версія

## Створити мережу
docker network create todonet

docker run -d --name mysql_local -v ./mysql_data:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0

docker run -d --name todoapp_container --network todonet -p 8000:8000 todoapp:2.0.0

docker exec -it todoapp_container python manage.py migrate

docker logs -f todoapp_container

Головна сторінка: http://localhost:8000
API: http:localhost:8000/api/

MySQL:  docker pull illa140/mysql-local:1.0.0
Django: docker pull illa140/todoapp:2.0.0