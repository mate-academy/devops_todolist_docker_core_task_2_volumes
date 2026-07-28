Markdown
# Instructions for Running Django-Todolist with MySQL in Docker

This document provides step-by-step instructions on how to run the MySQL database container with attached volumes and the Django application container.

---

## 1. Run the MySQL Container with Volume Attached

To ensure data persistence, run your built local MySQL image (`mysql-local:1.0.0`) with a Docker volume attached:

```bash
docker run -d \
  --name mysql_container \
  -v mysql_data:/var/lib/mysql \
  mysql-local:1.0.0
-d: Runs the container in detached mode (background).

--name mysql_container: Assigns a custom name to the container.

-v mysql_data:/var/lib/mysql: Attaches a named volume mysql_data to persist database records on the host machine.

2. Run the Django App Container
Ensure your application's database configuration (todolist/settings.py) points to the MySQL container's IP address or network host.

Run the application container (todoapp:2.0.0) by mapping port 8000:

Bash
docker run -d \
  --name todo_app_container \
  -p 8000:8000 \
  mulykovdockerdevops/todoapp:2.0.0
(Optional) Run database migrations inside the running container if they were not executed during build:

Bash
docker exec -it todo_app_container python manage.py migrate
3. Docker Hub Repository
The official built image for the application is publicly available on Docker Hub:

Docker Hub Repository: mulykovdockerdevops/todoapp (Tag: 2.0.0)

4. How to Access the Application
Once the application container is up and running, open your web browser and navigate to:

Landing Page: http://localhost:8000/

API Endpoint: http://localhost:8000/api/