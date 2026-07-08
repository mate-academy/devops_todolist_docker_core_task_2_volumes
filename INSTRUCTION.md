# Django-Todolist — Docker Instructions (MySQL Setup)

## Docker Hub Repositories

- App image: https://hub.docker.com/r/olehkovalievskyi/todoapp
- MySQL image: https://hub.docker.com/r/olehkovalievskyi/mysql-local

## Prerequisites

- Docker installed on your machine
- (Optional) Docker Hub account, if you want to pull the pre-built images

## 1. Build the MySQL image

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

## 2. Run the MySQL container with a volume attached

```bash
docker run -d \
  --name mysql-container \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```

This creates a named volume `mysql-data` that persists the database data
even if the container is removed.

Alternatively, pull the pre-built image from Docker Hub:

```bash
docker pull olehkovalievskyi/mysql-local:1.0.0
docker run -d \
  --name mysql-container \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  olehkovalievskyi/mysql-local:1.0.0
```

## 3. Get the MySQL container's IP address

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-container
```

Update the `HOST` value in `todolist/settings.py` (`DATABASES` section)
with the IP address returned above.

## 4. Build the app image

```bash
docker build -t todoapp:2.0.0 .
```

## 5. Run the app container

Make sure the MySQL container is already running and reachable
(see step 3), then start the app:

```bash
docker run -d \
  -p 8080:8080 \
  --name todoapp-container \
  todoapp:2.0.0
```

Alternatively, pull the pre-built image from Docker Hub:

```bash
docker pull olehkovalievskyi/todoapp:2.0.0
docker run -d \
  -p 8080:8080 \
  --name todoapp-container \
  olehkovalievskyi/todoapp:2.0.0
```

## Stopping the containers

```bash
docker stop todoapp-container mysql-container
```

## Access the application

Once both containers are running, open your browser and navigate to:

http://localhost:8080

## Notes

- The MySQL database (`app_db`) and user (`app_user` / password `1234`)
  are initialized automatically via environment variables in
  `Dockerfile.mysql`.
- The `mysql-data` volume ensures database data survives container
  restarts and removal.

## Screenshot

![Application successfully started](https://snipboard.io/P4k5SQ.jpg)