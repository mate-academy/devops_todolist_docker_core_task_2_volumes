# Application + MySQL Docker Setup

This guide explains how to:
- Run a MySQL container with a persistent volume
- Run an application container connected to the MySQL database
- Access the application in a browser
- Submit a Pull Request for validation

---
## 1. Prerequisites

Make sure the following are installed:

- Docker
- Docker Compose (optional but recommended)
- Python >= 3.8

---
## 2. Run MySQL

Docker image https://hub.docker.com/layers/wallian169/mysql-local/1.0.0

```bash
docker pull wallian169/mysql-local:1.0.0
```
```bash
docker volume create mysql_data
```

```bash
docker network create app-network
```

```bash
docker run -d \
  --name mysql-db \
  --network app-network \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  wallian169/mysql-local:1.0.0
```
---
## 3. Run Todo app

Docker image https://hub.docker.com/layers/wallian169/todoapp/2.0.0
```bash
docker pull wallian169/todoapp:2.0.0
```
```bash
docker run -d \
  --name django-app \
  --network app-network \
  -p 8080:8080 \
  wallian169/todoapp:2.0.0
```
---
## 4. Access the Application
Open your browser:
http://localhost:8080