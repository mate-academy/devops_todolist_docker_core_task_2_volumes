# Instructions

## Docker Hub repositories

- MySQL image: https://hub.docker.com/r/eugene9451/mysql-local
- App image: https://hub.docker.com/r/eugene9451/todoapp

## 1. Run the MySQL container with a volume attached

Build the MySQL image (based on the official `mysql` image) from `Dockerfile.mysql`:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

Create a named volume to persist MySQL data:

```bash
docker volume create mysql_data
```

Run the MySQL container with the volume attached:

```bash
docker run -d --name mysql-db -v mysql_data:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0
```

Check that the container is up and the database is ready:

```bash
docker ps
docker logs mysql-db
```

Wait for the line `ready for connections` in the logs before continuing.

## 2. Connect the app to the MySQL container

Get the MySQL container's IP address:

```bash
docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" mysql-db
```

Put this IP into `todolist/settings.py` in the `DATABASES['default']['HOST']` field:

```python
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': '172.17.0.2',  # IP of the running mysql-db container
        'PORT': '',
    }
}
```

> The MySQL container must be running before building the app image — the app's `Dockerfile` runs `python manage.py migrate` during the build, which requires a live connection to the database.

## 3. Build and run the app container

Build the app image:

```bash
docker build -t todoapp:2.0.0 .
```

Run the app container:

```bash
docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0
```

Check the logs to confirm the server started successfully:

```bash
docker logs todoapp
```

## 4. Access the application in the browser

Open:

```
http://localhost:8080
```

The Django Todolist application should load, now backed by the MySQL database running in the `mysql-db` container.

## 5. Pushed images

```bash
docker tag mysql-local:1.0.0 eugene9451/mysql-local:1.0.0
docker tag todoapp:2.0.0 eugene9451/todoapp:2.0.0

docker push eugene9451/mysql-local:1.0.0
docker push eugene9451/todoapp:2.0.0
```
