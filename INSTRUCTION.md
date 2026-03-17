# INSTRUCTION

## Docker Hub links

- MySQL image: `https://hub.docker.com/r/nazarkulyk6/mysql-local`
- App image: `https://hub.docker.com/r/nazarkulyk6/todoapp`

## Build MySQL image

From the project root:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

## Run MySQL container with a volume

### Option A: named volume (recommended)

```bash
docker volume create mysql_data
docker run -d --name mysql-local \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  mysql-local:1.0.0
```

### Option B: bind mount (store DB files in a folder)

```bash
docker run -d --name mysql-local \
  -p 3306:3306 \
  -v "$(pwd)/mysql_data":/var/lib/mysql \
  mysql-local:1.0.0
```

## Get MySQL container IP

```bash
docker inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}" mysql-local
```

Export it for the app build:

```bash
export MYSQL_HOST=<mysql_container_ip>
```

## Build and run the Django app container (connects to MySQL)

Build image (tag required by task):

```bash
docker build --build-arg MYSQL_HOST=$MYSQL_HOST -t todoapp:2.0.0 .
```

Run container:

```bash
docker run --rm -p 8080:8080 -e MYSQL_HOST=$MYSQL_HOST todoapp:2.0.0
```

## Open in browser

- UI: `http://localhost:8080/`
- API: `http://localhost:8080/api/`

## Tag & push images to Docker Hub

```bash
docker tag mysql-local:1.0.0 nazarkulyk6/mysql-local:1.0.0
docker push nazarkulyk6/mysql-local:1.0.0

docker tag todoapp:2.0.0 nazarkulyk6/todoapp:2.0.0
docker push nazarkulyk6/todoapp:2.0.0
```

