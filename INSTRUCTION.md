# Django-Todolist Deployment Instructions

Docker Hub repository with the application image:
https://hub.docker.com/r/rtemiis/todoapp

---

## 1. Create a Docker Network

Create a custom bridge network so that both containers can communicate with each other:

```bash
docker network create todo-network
```

---

## 2. Run MySQL Container with Volume Attached

Run the MySQL container attached to the created network with persistent volume storage:

```bash
docker run -d --name mysql-server --network todo-network -v mysql_data:/var/lib/mysql -p 3306:3306 rtemiis/mysql-local:1.0.0
```

> **Note:** The volume `mysql_data` mounts to `/var/lib/mysql` to preserve database data across container restarts.

---

## 3. Build and Run the App Container

### Build the application image:
```bash
docker build -t todoapp:2.0.0 .
```

### Run the application container:
Run the container connected to the same Docker network:

```bash
docker run -d --name todo-app --network todo-network -p 8000:8000 rtemiis/todoapp:2.0.0
```

---

## 4. Access the Application via Browser

Once both containers are running, open your web browser and navigate to:

http://localhost:8000