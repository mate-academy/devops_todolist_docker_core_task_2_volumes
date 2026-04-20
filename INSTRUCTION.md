# How to run the project

## Docker Hub repositories

MySQL image: https://hub.docker.com/r/vikkinech/mysql-local
App image: https://hub.docker.com/r/vikkinech/todoapp

## Build Docker images

### Build MySQL image

```bash
docker build -f Dockerfile.mysql -t vikkinech/mysql-local:1.0.0 .
```

### Push MySQL image

```bash
docker push vikkinech/mysql-local:1.0.0
```

### Build app image

```bash
docker build -t vikkinech/todoapp:2.0.0 .
```

### Push app image

```bash
docker push vikkinech/todoapp:2.0.0
```

## Project dependencies

The application dependencies are listed in `requirements.txt`.

Make sure it contains:

```txt
mysql-connector-python==8.2.0
```

Install dependencies locally if needed:

```bash
pip install -r requirements.txt
```

## Database configuration

The application uses the `DB_HOST` environment variable at runtime.

* If `DB_HOST` is not provided → defaults to `localhost` (for local development)
* In Docker → use:

```bash
-e DB_HOST=mysql-container
```

## Create Docker network

```bash
docker network create app-net
```

## Run MySQL container

```bash
docker run -d \
  --name mysql-container \
  --network app-net \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -v mysql-data:/var/lib/mysql \
  vikkinech/mysql-local:1.0.0
```


## Wait for MySQL to be ready

Check logs until you see "ready for connections":

```bash
docker logs mysql-container
```

## Run application container

```bash
docker run -d \
  --name todoapp-container \
  --network app-net \
  -e DB_HOST=mysql-container \
  -p 8000:8000 \
  vikkinech/todoapp:2.0.0
```

## Run database migrations

Run migrations after starting the containers:

```bash
docker exec -it todoapp-container python manage.py migrate
```

## Start Django server

The Django server starts automatically when the container runs.

If needed, you can start it manually:

```bash
docker exec -it todoapp-container python manage.py runserver 0.0.0.0:8000
```

## Open application in browser

http://localhost:8000
