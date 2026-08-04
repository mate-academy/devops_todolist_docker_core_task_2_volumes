# Running the ToDo App with a MySQL Database (Docker + Volumes)

This guide explains how to run the MySQL database container (with a persistent volume)
and the ToDo application container that connects to it.

## Docker Hub repositories

- App image: https://hub.docker.com/r/netlyuk/todoapp
- MySQL image: https://hub.docker.com/r/netlyuk/mysql-local

## 1. Run the MySQL container with a volume attached

Pull the image and create a named volume so database data survives container restarts/removal:

```bash
docker pull netlyuk/mysql-local:1.0.0

docker volume create mysql_local_data

docker run -d \
  --name mysql-local-container \
  -v mysql_local_data:/var/lib/mysql \
  -p 3306:3306 \
  netlyuk/mysql-local:1.0.0
```

The image is pre-configured (via `ENV` variables in `Dockerfile.mysql`) to initialize:

- Database: `app_db`
- User: `app_user`
- Password: `1234`

Wait a few seconds for MySQL to finish initializing, then verify it's ready:

```bash
docker exec mysql-local-container mysqladmin ping -h localhost -uapp_user -p1234
```

To confirm the volume works, remove the container and start a new one attached to the
same volume — your data (and the `app_db`/`app_user` setup) will persist:

```bash
docker rm -f mysql-local-container
docker run -d --name mysql-local-container -v mysql_local_data:/var/lib/mysql -p 3306:3306 netlyuk/mysql-local:1.0.0
```

## 2. Get the MySQL container's IP address

The app container needs the MySQL container's IP to connect to it:

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local-container
```

Update `HOST` in `todolist/settings.py` (`DATABASES` section) with this IP before
building the app image — the app image runs migrations at build time, so MySQL must
already be running and reachable at this IP.

## 3. Build and run the App container

```bash
docker build -t todoapp:2.0.0 .
docker run -d --name todoapp-container -p 8080:8080 todoapp:2.0.0
```

Or pull the already published image instead of building locally:

```bash
docker pull netlyuk/todoapp:2.0.0
docker run -d --name todoapp-container -p 8080:8080 netlyuk/todoapp:2.0.0
```

Check the logs to confirm a successful startup:

```bash
docker logs todoapp-container
```

You should see:

```
Starting development server at http://0.0.0.0:8080/
```

## 4. Access the application in a browser

Open your browser and navigate to:

```
http://localhost:8080/
```

You should see the ToDo application's home page.
