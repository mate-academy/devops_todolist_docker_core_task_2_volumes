# INSTRUCTION

## 1. Запуск MySQL контейнера

Створюємо том та мережу:
```bash
docker volume create mysql_data
docker network create appnet

docker run -d --name mysql-local \
  --network appnet \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  denysanakonda/mysql-local:1.0.0

## 1.2. Дізнаємося IP контейнера:

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local

## 2. Запуск Django застосунку.

## 2.1. Варіант А (локальний образ):

docker run -d --name todoapp \
  --network appnet \
  -p 8000:8000 \
  todoapp:2.0.0

## 2.2. Варіант B (з Docker Hub):

docker run -d --name todoapp \
  --network appnet \
  -p 8000:8000 \
  denysanakonda/todoapp:2.0.0

## 3. Доступ до застосунку

http://localhost:8000

## 4. Образи в Docker Hub

MySQL: https://hub.docker.com/r/denysanakonda/mysql-local

Django App: https://hub.docker.com/r/denysanakonda/todoapp