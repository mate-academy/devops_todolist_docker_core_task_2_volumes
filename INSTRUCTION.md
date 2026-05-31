# Docker Instructions

## MySQL контейнер

Запусти:
```bash
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
docker run --name mysql-container -d -p 3306:3306 -v /твоя/папка:/var/lib/mysql mysql-local:1.0.0
```

## Django контейнер

Запусти:
```bash
docker build -t todoapp:2.0.0 .
docker run --name todoapp-container -d -p 8080:8080 --link mysql-container todoapp:2.0.0
docker exec todoapp-container python manage.py migrate
```

## Доступ

http://localhost:8080

## Docker Hub

- MySQL: https://hub.docker.com/r/nikolayhoncharenko/mysql-local
- App: https://hub.docker.com/r/nikolayhoncharenko/todoapp