# Running MySQL and App containers (local)

This document shows how to build the MySQL image, run it with a volume, find its IP address, then build the Django app image with the DB host baked in so migrations run during build.

## Build MySQL image

```bash
# From repository root
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

## Run MySQL container (detached, with volume)

```bash
docker run -d \
  --name mysql-local \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```

Verify the database exists:

```bash
docker logs mysql-local
# or
docker exec -it mysql-local mysql -uapp_user -p1234 -e "SHOW DATABASES;"
```

## Get the MySQL container IP (needed to build the app image)

```bash
# Inspect container and extract IP address
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local
```

Copy that IP (e.g. `172.17.0.2`) to use in the next step.

## Build the Django app image (provide DB IP as build-arg)

```bash
# Replace <MYSQL_IP> with the value from the previous step
docker build --build-arg DB_HOST=<MYSQL_IP> -t todoapp:2.0.0 .
```

Note: the app `Dockerfile` runs `python manage.py migrate` during build time. Make sure the MySQL container is reachable from the build environment (or use an alternative approach such as running migrations at container startup).

## Docker Hub link for the app image

Add the direct link to your pushed `todoapp:2.0.0` image below (replace `<YOUR_DOCKERHUB_USERNAME>` with your username):

```
https://hub.docker.com/r/<YOUR_DOCKERHUB_USERNAME>/todoapp
```

Place the above link in this file when you have pushed the image to Docker Hub.

## Run App container

```bash
docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0
```

Open the app at: http://localhost:8080/ (default Django runserver configured to `0.0.0.0:8080` in image)

## Push images to Docker Hub (optional)

```bash
# Tag and push mysql-local
docker tag mysql-local:1.0.0 dmn1024/mysql-local:1.0.0
docker push dmn1024/mysql-local:1.0.0

# Tag and push app
docker tag todoapp:2.0.0 dmn1024/todoapp:2.0.0
docker push dmn1024/todoapp:2.0.0
```

## Tips and caveats

- MySQL initialization (creating DB and user) runs only when the container's data directory is empty.
- If `mysql_data` volume already contains data, the `MYSQL_*` env vars are ignored on container start.
- If you prefer to use `docker-compose`, create a `docker-compose.yml` that starts both services and ensures the app waits on the DB before running migrations.
