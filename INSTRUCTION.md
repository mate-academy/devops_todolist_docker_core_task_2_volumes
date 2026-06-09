# Django Todolist with MySQL in Docker

This project runs a Django TODO app connected to a MySQL database in Docker.

## 1. Build the MySQL image

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

## 2. Run MySQL with a volume attached

Create a Docker volume:

```bash
docker volume create mysql_data
```

Start the MySQL container:

```bash
docker run -d \
  --name mysql-local \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  mysql-local:1.0.0
```

Check that the container is running:

```bash
docker ps
docker logs -f mysql-local
```

> Note: this task expects the Django app to use `HOST = localhost` in `todolist/settings.py`.
> If your Docker setup does not allow container-to-container access via `localhost`, you may need to
> adjust your Docker networking so the app container can reach the MySQL container in the same
> network namespace.

## 3. Build the Django app image

```bash
docker build -t todoapp:2.0.0 .
```

## 4. Run the app container

```bash
docker run -d \
  --name todoapp \
  -p 8000:8000 \
  todoapp:2.0.0
```

## 5. Run migrations inside the app container

```bash
docker exec -it todoapp python manage.py migrate
```

## 6. Open the application in a browser

After the app container starts, open:

```text
http://localhost:8000
```

## 7. Docker Hub images

My MySQL image repository:

```text
https://hub.docker.com/r/bobgor/mysql-local
```

My app image repository:

```text
https://hub.docker.com/r/bobgor/todoapp
```

## 8. Push images to Docker Hub

```bash
docker tag mysql-local:1.0.0 bobgor/mysql-local:1.0.0
docker push bobgor/mysql-local:1.0.0

docker tag todoapp:2.0.0 bobgor/todoapp:2.0.0
docker push bobgor/todoapp:2.0.0
```

## 9. Notes

- The MySQL container stores data in the `mysql_data` volume.
- The Django app must point to the running MySQL container in `todolist/settings.py`.
- The required database host value for this task is `localhost`.
