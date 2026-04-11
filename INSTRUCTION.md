# Instructions

## Run MySQL container with volume

```bash
docker run -d \
  --name mysql-container \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  YOUR_DOCKERHUB_USER/mysql-local:1.0.0
```

## Run App container (connects to MySQL)

```bash
docker run -d \
  --name todoapp-container \
  -p 8000:8000 \
  YOUR_DOCKERHUB_USER/todoapp:2.0.0
```

## Access the application

Open in browser: http://localhost:8000

## Docker Hub

App image: https://hub.docker.com/r/YOUR_DOCKERHUB_USER/todoapp