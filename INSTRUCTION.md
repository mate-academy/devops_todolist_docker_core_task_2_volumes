## How to run MySQL with a volume

1. Build MySQL image (already provided by `Dockerfile.mysql`):
   - Image name: `mysql-local:1.0.0`

```
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

2. Create a named volume for MySQL data:

```
docker volume create mysql_data
```

3. Run MySQL container with the volume attached:

```
docker run -d --name mysql-local \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -e MYSQL_ROOT_PASSWORD=root1234 \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  mysql-local:1.0.0
```

4. Get MySQL container IP (for reference):

```
docker inspect -f {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} mysql-local
```

## How to build and run the App connected to MySQL

1. Build app image:

```
docker build -t todoapp:2.0.0 .
```

2. Run app container, passing DB connection via env and sharing default network with MySQL:

```
docker network create todo-net
docker network connect todo-net mysql-local

docker run -d --name todoapp --restart unless-stopped \
  --network todo-net \
  -e MYSQL_HOST=mysql-local \
  -e MYSQL_PORT=3306 \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -p 8080:8080 \
  todoapp:2.0.0
```

3. Initialize DB schema (run once if not migrated yet):

```
docker exec -it todoapp python manage.py migrate
```

## Accessing the application

- Open `http://localhost:8080/` for the landing page
- Open `http://localhost:8080/api/` for API

## Push images to Docker Hub

Images are available at: https://hub.docker.com/u/baranotik

```
docker tag mysql-local:1.0.0 baranotik/mysql-local:1.0.0
docker push baranotik/mysql-local:1.0.0

docker tag todoapp:2.0.0 baranotik/todoapp:2.0.0
docker push baranotik/todoapp:2.0.0
```

## Pull and run from Docker Hub

To run the application using images from Docker Hub:

```bash
# Pull MySQL image
docker pull baranotik/mysql-local:1.0.0

# Pull application image  
docker pull baranotik/todoapp:2.0.0

# Run MySQL container
docker run -d --name mysql-local --network todo-net \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -e MYSQL_ROOT_PASSWORD=root1234 \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  baranotik/mysql-local:1.0.0

# Run application container
docker run -d --name todoapp --restart unless-stopped \
  --network todo-net \
  -e MYSQL_HOST=mysql-local \
  -e MYSQL_PORT=3306 \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -p 8080:8080 \
  baranotik/todoapp:2.0.0
```

## Notes

- DB settings are read from env vars: `MYSQL_HOST`, `MYSQL_PORT`, `MYSQL_DATABASE`, `MYSQL_USER`, `MYSQL_PASSWORD`.
- Ensure Python >= 3.8.

## Docker Hub Repository

Application images are available at: https://hub.docker.com/u/baranotik
- MySQL: `baranotik/mysql-local:1.0.0`
- TodoApp: `baranotik/todoapp:2.0.0`

