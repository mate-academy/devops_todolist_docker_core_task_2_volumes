# How to Run the Application

## 1. Run MySQL container with volume

```bash
docker volume create mysql_data

docker run -d \
  --name mysql-container \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  ll221/mysql-local:1.0.0
```

## 2. Get MySQL container IP

```bash
docker inspect mysql-container \
  --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
```

## 3. Configure app connection to MySQL

The Django app connects to MySQL via the IP obtained above.  
In `todolist/settings.py`, the `DATABASES['default']['HOST']` is set  
to the MySQL container IP (e.g. `172.17.0.2`).  
Update this value before building the app image.

## 4. Run App container

```bash
docker run -d \
  --name todoapp-container \
  -p 8000:8000 \
  ll221/todoapp:2.0.0
```

## 5. Access the application

Open your browser and go to: http://localhost:8000

## Docker Hub repository

https://hub.docker.com/r/ll221/todoapp