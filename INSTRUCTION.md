# Deployment Guide: Todo Application (v2.0.0) with MySQL in Docker

This guide provides step-by-step instructions for deploying the Django web application and MySQL database in isolated Docker containers with persistent data storage.

## Environment Architecture
* **Database:** `mysql-server` container (Image: `mysql:8.0`)
* **Web Application:** `todo-app-v2` container (Custom Image: `todoapp:2.0.0` / `iondan587/todoapp:2.0.0`)

---

## Local Deployment Steps

### Step 1: Spin up the MySQL Database
Before starting the web application, ensure the database container is active. Run the MySQL container with a Docker volume attached for data persistence:
```bash
docker run -d --name mysql-server -e MYSQL_DATABASE=app_db -e MYSQL_USER=app_user -e MYSQL_PASSWORD=1234 -e MYSQL_ROOT_PASSWORD=root_pass -v mysql_data:/var/lib/mysql mysql-local:1.0.0.