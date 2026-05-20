# Django-Todolist (Docker Core Task 2: Volumes)

This document provides complete instructions on how to run the containerized Django-Todolist web application along with a MySQL database using Docker and attached Volumes.

## Docker Hub Repositories
- **Application Image:** [tigerob/todoapp:2.0.0](https://hub.docker.com/r/tigerob/todoapp)
- **Database Image:** [tigerob/mysql-local:1.0.0](https://hub.docker.com/r/tigerob/mysql-local)

---

## Deployment Instructions

To ensure proper connectivity, the MySQL database container must be started first, followed by the web application container.

### 1. Run the MySQL Container with Volume Attached
Run the following command to start the MySQL database container. This initializes the required application database, sets up the user, and attaches a named volume (`mysql_data`) to ensure data persistence:

```bash
docker run -d \
  --name mysql-container \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  tigerob/mysql-local:1.0.0

```

### 2. Run the Web Application Container (Django)

Once the database container is fully up and running, start the Django application container. It will automatically apply the required database migrations upon startup:

```bash
docker run -d \
  --name django-todo-app \
  -p 8000:8000 \
  tigerob/todoapp:2.0.0

```

---

## Accessing the Application

After successfully starting both containers, the application can be accessed via your web browser at the following URLs:

* **Landing Page (UI):** [http://localhost:8000/](https://www.google.com/search?q=http://localhost:8000/)
* **Application API:** [http://localhost:8000/api/](https://www.google.com/search?q=http://localhost:8000/api/)
