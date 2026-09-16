# Django-Todolist Deployment Instructions

Docker Hub repository with the application image:
https://hub.docker.com/r/rtemiis/todoapp

---

## 1. Run MySQL Container with Volume Attached

To run the MySQL database container with persistent volume storage, execute:

```bash
docker run -d --name mysql-server -v mysql_data:/var/lib/mysql -p 3306:3306 rtemiis/mysql-local:1.0.0
```

> **Note:** The volume `mysql_data` mounts to `/var/lib/mysql` to preserve database data across container restarts.

---

## 2. Build and Run the App Container

Before building and running the application container, ensure that the MySQL container is running and retrieve its IP address:

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-server
```

Update `HOST` in `todolist/settings.py` with this IP address if you are building the container locally.

### Build the application image:
```bash
docker build -t todoapp:2.0.0 .
```

### Run the application container:
Run the container and expose port 8000:
```bash
docker run -d --name todo-app -p 8000:8000 rtemiis/todoapp:2.0.0
```

---

## 3. Access the Application via Browser

Once both containers are running, open your web browser and navigate to:

http://localhost:8000