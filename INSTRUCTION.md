# Django Todolist – Docker Instructions

This document explains how to run the **MySQL database container** and the **Django Todolist application container**, and how to access the application in your browser.

---

## 1. Prerequisites

- Docker installed and running  
- Access to Docker Hub  

You can either **build the images locally** or **pull them directly from Docker Hub**.

### Pull images from Docker Hub (optional)

```bash
docker pull zoryana/mysql-local:1.0.0
docker pull zoryana/todoapp:2.0.0

docker volume create mysql_data
docker run -d \
  --name mysql-local \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  zoryana/mysql-local:1.0.0

docker inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}" mysql-local

docker run -d \
  --name todoapp \
  -p 8000:8000 \
  -e DB_HOST=<MYSQL_CONTAINER_IP> \
  zoryana/todoapp:2.0.0

https://hub.docker.com/r/zoryana/mysql-local
https://hub.docker.com/r/zoryana/todoapp
http://localhost:8000



