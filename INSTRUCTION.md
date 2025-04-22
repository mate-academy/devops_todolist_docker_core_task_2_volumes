# Django-Todolist Application Instructions

## Prerequisites

- Docker installed on your system
- Docker Hub account

## Running MySQL Container with Volume

1. Build the MySQL image:

```bash
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
```

2. Run the MySQL container with a volume attached:

```bash
docker run -d \
  --name mysql-todolist \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```

3. Push the image to Docker Hub:

```bash
docker tag mysql-local:1.0.0 verbatym733/mysql-local:1.0.0
docker push verbatym733/mysql-local:1.0.0
```

## Running the Application Container

1. Update the database configuration in `todolist/settings.py` with the MySQL container's IP address:

   - Replace `'HOST': 'localhost'` with `'HOST': 'mysql-todolist'`

2. Build the application image:

```bash
docker build -t todoapp:2.0.0 .
```

3. Run the application container:

```bash
docker run -d \
  --name todolist-app \
  --link mysql-todolist \
  -p 8000:8080 \
  todoapp:2.0.0
```

4. Push the application image to Docker Hub:

```bash
docker tag todoapp:2.0.0 verbatym733/todoapp:2.0.0
docker push verbatym733/todoapp:2.0.0
```

## Accessing the Application

1. Open your web browser and navigate to:

```
http://localhost:8000
```

2. You should see the Django-Todolist application interface.

## Docker Hub Repository

The application image is available at:

```
https://hub.docker.com/r/verbatym733/todoapp
```

## Notes

- Make sure to replace verbatym733 with your actual Docker Hub username if you're forking this project
- The MySQL container must be running before starting the application container
- The application uses port 8000 on the host machine
- Data persistence is ensured through Docker volumes
