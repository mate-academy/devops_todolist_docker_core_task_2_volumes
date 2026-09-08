# Django ToDo App Containerization

This repository contains a containerized Django ToDo application with a MySQL database back-end.

## Docker Hub Repository
You can find the public Docker images here:
* **App Image Link:** [https://hub.docker.com/repository/docker/poikka001/todoapp](https://hub.docker.com/repository/docker/poikka001/todoapp)
* **MySQL Image Link:** [https://hub.docker.com/repository/docker/poikka001/mysql-local/general](https://hub.docker.com/repository/docker/poikka001/mysql-local/general)

---

## Instructions for Running the Application

Follow these steps sequentially to run the entire application infrastructure on your local machine:

### Step 1: Run the MySQL Database Container
First, start the MySQL database container with an attached named volume (`mysql-data`) to persist your data:
```bash
docker run -d -p 3306:3306 --name my-mysql -v mysql-data:/var/lib/mysql poikka001/mysql-local:1.0.0
```

### Step 2: Run the Django Application Container
Next, start the Django application container and map it to your local port `8000`:
```bash
docker run -d -p 8000:8000 --name todo-app-container poikka001/todoapp:2.0.0
```

### Step 3: Run Database Migrations
Since the database starts completely fresh, you need to apply the Django migrations inside the running app container to create the necessary tables:
```bash
docker exec -i todo-app-container python manage.py migrate
```

---

## How to Access the Application
Once all steps are completed and migrations have run successfully:
1. Open your web browser.
2. Navigate to: **http://localhost:8000**
3. You can now use the interactive Django-Todolist application securely connected to your MySQL container.
