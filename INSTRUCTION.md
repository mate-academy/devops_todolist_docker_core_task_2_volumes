# ToDo app with MySQL in Docker

## Docker Hub repositories

- App image: https://hub.docker.com/r/juliaaqa/todoapp
- MySQL image: https://hub.docker.com/r/juliaaqa/mysql-local

## 1. Build the MySQL image

```
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

## 2. Run the MySQL container with a volume attached

```
docker run -d --name mysql-db -v mysql_data:/var/lib/mysql mysql-local:1.0.0
```

The named volume `mysql_data` stores the database files, so the data is kept even if the container is removed.

Wait about 30 seconds until the database is ready. Check the logs:

```
docker logs mysql-db
```

The logs should contain `ready for connections`.

## 3. Get the IP address of the MySQL container

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-db
```

Put this IP into `HOST` in the `DATABASES` section of `todolist/settings.py`:

```python
'HOST': '172.17.0.2',  # replace with your IP
```

## 4. Build and run the app container (connects to MySQL)

The MySQL container must be running before the build, because the migration runs during the build.

```
docker build -t todoapp:2.0.0 .
docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0
```

Check that the app started:

```
docker logs todoapp
```

## 5. Run the images from Docker Hub

```
docker pull juliaaqa/mysql-local:1.0.0
docker pull juliaaqa/todoapp:2.0.0
```

## 6. Access the application in a browser

Open:

- Landing page: http://localhost:8080/
- API: http://localhost:8080/api/

## 7. Stop and remove the containers

```
docker stop todoapp mysql-db
docker rm todoapp mysql-db
```

The volume `mysql_data` is kept, so the data remains available the next time you start MySQL.
