# Інструкція з запуску

## Запуск MySQL контейнера з Volume
docker run -d \
  --name mysql-container \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  klemjl/mysql-local:1.0.0

## Запуск App контейнера
docker run -d -p 8000:8000 --name todoapp-container klemjl/todoapp:2.0.0

## Посилання на Docker Hub
https://hub.docker.com/r/klemjl/todoapp

## Доступ до застосунку через браузер
Відкрий: http://localhost:8000