# Docker Run Instructions

Docker Hub images:

https://hub.docker.com/r/oleksijlyashenko/mysql-local
https://hub.docker.com/r/oleksijlyashenko/todoapp

## Build the MySQL image

From the project root, build the custom MySQL image:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

## Run MySQL with a volume

Create a Docker volume for MySQL data:

```bash
docker volume create mysql_data
```

Run the MySQL container with the volume attached:

```bash
docker run -d \
  --name mysql-db \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  mysql-local:1.0.0
```

The MySQL image initializes the database with these values:

```text
Database: app_db
User: app_user
Password: 1234
Port: 3306
```

Check that the MySQL container is running:

```bash
docker ps
```

Get the MySQL container IP address:

```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-db
```

Use this IP address in `todolist/settings.py` as the database host before building the app image:

```python
'HOST': '<MYSQL_CONTAINER_IP>',
'PORT': '3306',
```

## Build the app image

Build the Django application image:

```bash
docker build -t todoapp:2.0.0 .
```

## Run the app container

Run the app container and expose it on port `8080`:

```bash
docker run -d \
  --name todoapp \
  -p 8080:8080 \
  todoapp:2.0.0
```

Check that the app container is running:

```bash
docker ps
```

View app logs:

```bash
docker logs todoapp
```

## Access the application

Open this URL in a browser:

```text
http://localhost:8080
```

## Push images to Docker Hub

Log in to Docker Hub:

```bash
docker login
```

Check that both images exist locally:

```bash
docker images
```

The local images should include:

```text
mysql-local   1.0.0
todoapp       2.0.0
```

Tag the MySQL image for the personal Docker Hub repository:

```bash
docker tag mysql-local:1.0.0 oleksijlyashenko/mysql-local:1.0.0
```

Push the MySQL image:

```bash
docker push oleksijlyashenko/mysql-local:1.0.0
```

Tag the app image for the personal Docker Hub repository:

```bash
docker tag todoapp:2.0.0 oleksijlyashenko/todoapp:2.0.0
```

Push the app image:

```bash
docker push oleksijlyashenko/todoapp:2.0.0
```

After pushing, the images are available at:

```text
https://hub.docker.com/r/oleksijlyashenko/mysql-local
https://hub.docker.com/r/oleksijlyashenko/todoapp
```
