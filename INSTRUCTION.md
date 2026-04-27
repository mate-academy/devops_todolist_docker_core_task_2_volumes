# Django Todolist - Docker Deployment Instructions

This project is a Dockerized Django Todo List application connected to a MySQL database. Follow the steps below to run the environment locally.

## Prerequisites

- Docker installed on your machine.
- An active internet connection to pull images from Docker Hub.

---

## 1. Run MySQL Database Container

To start the MySQL database with a persistent volume (to ensure your data is not lost when the container stops), run the following command:

```bash
docker run -d \
  --name mysql \
  -p 3306:3306 \
  -v my-mysql-data:/var/lib/mysql \
  clem97121/mysql-local:1.0.0
```
Note: This container uses the my-mysql-data volume for data persistence and initializes the app_db database for the application.

2. Run the Django Application Container
Once the MySQL container is running, start the Todo application. The app is configured to connect to the MySQL container using its internal Docker IP.

Bash
docker run -d \
  --name todo-app \
  -p 8000:8000 \
  clem97121/todoapp:2.0.0
Initial Database Setup
If you are running this for the first time, you need to apply the database migrations. Execute the following command:

Bash
docker exec todo-app python manage.py migrate
3. Docker Hub Repository
You can find the official image for this application on my personal Docker Hub:

App Image Repository: https://hub.docker.com/r/clem97121/todoapp

4. Accessing the Application
Once both containers are running successfully, you can access the Todo List application through your web browser.

URL: http://localhost:8000

From here, you can:

Create accounts/login.

Add and manage your todo items.

Interact with the UI and API.

Technical Configuration Summary
MySQL Image: clem97121/mysql-local:1.0.0

App Image: clem97121/todoapp:2.0.0

Environment:

DB_NAME: app_db

DB_USER: app_user

DB_PASS: 1234