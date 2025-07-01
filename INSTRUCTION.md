# Django Todolist Docker Instructions

## How to run MySQL container with volume attached

```bash
# Create a named volume for MySQL data persistence
docker volume create mysql_data

# Run MySQL container with persistent volume
docker run -d \
  --name mysql-local \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```

## How to run App container which will connect to MySQL db container

```bash
# Run the Django application container
docker run -d \
  --name todoapp \
  -p 8000:8000 \
  todoapp:2.0.0
```

## Docker Hub Repository

**Repository**: sergiinosachenko/todoapp  
**Image**: todoapp:2.0.0

To pull the image:
```bash
docker pull sergiinosachenko/todoapp:2.0.0
```

## How to access the application via browser

Once both containers are running, access the application at:

- **Main Application**: http://localhost:8000/
- **Admin Interface**: http://localhost:8000/admin/
- **API Endpoints**: http://localhost:8000/api/
