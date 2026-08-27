# Docker Instructions

Docker Hub repository: https://hub.docker.com/r/bodya4243/todoapp

App image: `bodya4243/todoapp:2.0.0`

## MySQL Container With Volume

Create a persistent volume for MySQL data:

```bash
docker volume create mysql_data
```

Run the MySQL container with the volume attached:

```bash
docker run -d \
  --name mysql_bd \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  mysql-local:1.0.0
```

## Build the App Image

From the project root, build the app image:

```bash
docker build -t todoapp:2.0.0 .
```

If you want to override the Python base image version:

```bash
docker build --build-arg PYTHON_VERSION=3.11-slim -t todoapp:2.0.0 .
```

## Run the App Container

The app container must connect to the running MySQL container. Use the MySQL container IP in `todolist/settings.py`:

```bash
172.17.0.2
```

Run the app container and publish port 8080:

```bash
docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0
```

If a container named `todoapp` already exists:

```bash
docker rm -f todoapp
docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0
```

## Pull From Docker Hub

Pull the published image:

```bash
docker pull bodya4243/todoapp:2.0.0
```

Run the published image:

```bash
docker run -d --name todoapp -p 8080:8080 bodya4243/todoapp:2.0.0
```

## Access in a Browser

Open the app:

```text
http://localhost:8080/
```

Open the API:

```text
http://localhost:8080/api/
```
