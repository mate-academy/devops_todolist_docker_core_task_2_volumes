## Docker Hub

- **TodoApp**: https://hub.docker.com/repository/docker/nyxx00/todoapp/general
- **MySQL**: https://hub.docker.com/repository/docker/nyxx00/mysql-local/general

## How to run MySQL container with a volume attached

```bash
docker run --name mysql-container -d -p 3306:3306 -v my-sql-data:/var/lib/mysql mysql-local:1.0.0
```

## How to run an App container which will connect to a MySQL db container

1. Get MySQL container IP

```bash
  docker inspect mysql-container | grep "IPAddress"
```

2. Update Django settings with the MySQL container IP

3. Run the todoapp container:
```bash
docker run -d --name app -p 8080:8080 todoapp:2.0.0
```

## How to access the application via browser

- **Main Application**: http://localhost:8080
- **API Endpoints**: http://localhost:8080/api/