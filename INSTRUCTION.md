# Django TodoList with MySQL - Docker Instructions

## Docker Hub Repositories

- **TodoApp**: https://hub.docker.com/r/vasyl568/todoapp
- **MySQL Database**: https://hub.docker.com/r/vasyl568/mysql-local

## How to run MySQL container with a volume attached

1. Create a named volume for persistent data:
   ```bash
   docker volume create mysql-data
   ```

2. Run MySQL container with volume attached:
   ```bash
   docker run -d \
     --name mysql-container \
     -e MYSQL_ROOT_PASSWORD=root \
     -e MYSQL_DATABASE=app_db \
     -e MYSQL_USER=app_user \
     -e MYSQL_PASSWORD=1234 \
     -p 3306:3306 \
     -v mysql-data:/var/lib/mysql \
     mysql-local:1.0.0
   ```

## How to run App container which will connect to MySQL database

1. Get MySQL container IP address:
   ```bash
   docker inspect mysql-container | grep "IPAddress"
   ```

2. Update Django settings with the MySQL container IP (typically 172.17.0.2)

3. Run the todoapp container:
   ```bash
   docker run -d \
     --name todoapp-container \
     -p 8000:8080 \
     todoapp:2.0.0
   ```

## How to access the application via browser

Once both containers are running, access the application at:
- **Main Application**: http://localhost:8000
- **API Endpoints**: http://localhost:8000/api/
