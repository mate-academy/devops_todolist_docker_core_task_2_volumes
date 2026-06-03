(# Инструкции по запуску с Docker)

Ниже приведены команды для запуска контейнера MySQL с подключённым томом и запуска контейнера приложения, подключающегося к базе данных.

## 1) Создать сеть Docker (рекомендуется)

```bash
docker network create todonet
```

## 2) Запуск контейнера MySQL с томом

В этом репозитории есть Dockerfile для MySQL. Если вы уже собрали образ как `mysql-local:1.0.0` (например, `docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .`), запустите:

```bash
docker run -d \
	--name mysql-local \
	--network todonet \
	-e MYSQL_ROOT_PASSWORD=rootpassword \
	-e MYSQL_DATABASE=app_db \
	-e MYSQL_USER=app_user \
	-e MYSQL_PASSWORD=1234 \
	-v mysql-data:/var/lib/mysql \
	-p 3306:3306 \
	mysql-local:1.0.0
```

Примечания:
- `-v mysql-data:/var/lib/mysql` — создаёт именованный том `mysql-data` и подключает его к каталогу данных MySQL.
- Порт `3306` проброшен наружу для локального доступа (по желанию можно убрать `-p 3306:3306`).

## 3) Запуск контейнера приложения и подключение к MySQL

Замените `YOUR_DOCKERHUB_USERNAME/todolist:latest` на ссылку на ваш образ в Docker Hub либо на локально собранный образ.

Пример запуска образа с Docker Hub (замените имя образа на своё):

```bash
docker run -d \
	--name todolist-app \
	--network todonet \
	-e DATABASE_HOST=mysql-local \
	-e DATABASE_PORT=3306 \
	-e DATABASE_NAME=app_db \
	-e DATABASE_USER=app_user \
	-e DATABASE_PASSWORD=1234 \
	-p 8000:8000 \
	YOUR_DOCKERHUB_USERNAME/todolist:latest
```

Если вы хотите использовать локально собранный образ (из этого репозитория), соберите и запустите его так:

```bash
# собрать локально (если есть Dockerfile для приложения в корне)
docker build -t local/todolist:latest .

docker run -d \
	--name todolist-app \
	--network todonet \
	-e DATABASE_HOST=mysql-local \
	-e DATABASE_PORT=3306 \
	-e DATABASE_NAME=app_db \
	-e DATABASE_USER=app_user \
	-e DATABASE_PASSWORD=1234 \
	-p 8000:8000 \
	local/todolist:latest
```

## 4) Доступ к приложению через браузер

После старта контейнера приложения (в примерах выше порт `8000` проброшен наружу) откройте в браузере:

- http://localhost:8000/

Если вы пробросили другой порт, замените `8000` на ваш проброшенный порт.

## 5) Ссылка на Docker Hub

Ссылка на репозиторий Docker Hub с образом приложения (замените на свой репозиторий):

- https://hub.docker.com/r/YOUR_DOCKERHUB_USERNAME/todolist

---
Если нужно, могу добавить пример `docker-compose.yml` для удобного старта обоих контейнеров.

