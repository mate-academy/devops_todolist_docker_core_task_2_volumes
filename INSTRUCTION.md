# INSTRUCTION.md

## Publishing Images to Docker Hub

```bash
# 1. Login to Docker Hub
docker login

# 2. Build MySQL image
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .

# 3. Tag and push MySQL image
docker tag mysql-local:1.0.0 voleger/mysql-local:1.0.0
docker push voleger/mysql-local:1.0.0

# 4. Build app image
docker build -t todoapp:2.0.0 .

# 5. Tag and push app image
docker tag todoapp:2.0.0 voleger/todoapp:2.0.0
docker push voleger/todoapp:2.0.0
```

## Running the MySQL Container with a Volume Attached

```bash
docker network create todolist-net

docker run -d \
  --name mysql-db \
  --network todolist-net \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -e MYSQL_ROOT_PASSWORD=1234 \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  voleger/mysql-local:1.0.0
```

The `-v mysql-data:/var/lib/mysql` flag attaches a named Docker volume to persist
MySQL data across container restarts and recreations.

## Running the App Container Connected to MySQL

```bash
docker run -d \
  --name todo-app \
  --network todolist-net \
  -p 8080:8080 \
  voleger/todoapp:2.0.0
```

The app connects to MySQL via `HOST: 'mysql-db'` in `settings.py`. On the shared
`todolist-net` network, the hostname `mysql-db` resolves to the container by its
`--name mysql-db` label.

The app uses port **8080** (configured in the Dockerfile entrypoint).

## Accessing the Application

Open a browser and navigate to:

- **Landing page:** http://localhost:8080/
- **API:** http://localhost:8080/api/
- **Admin:** http://localhost:8080/admin/

## Docker Hub Repository

- MySQL image: https://hub.docker.com/r/voleger/mysql-local
- App image: https://hub.docker.com/r/voleger/todoapp
