# Dockerized Django ToDo App with MySQL

This project consists of two containers: a MySQL database and a Django application.

## Docker Hub Repositories
- **App:** [d4vp/todoapp:2.0.0](https://hub.docker.com/r/d4vp/todoapp)
- **Database:** [d4vp/mysql-local:1.0.0](https://hub.docker.com/r/d4vp/mysql-local)

---

## How to Run

### 1. Start the Database
First, run the MySQL container with a volume attached for data persistence.

```bash
docker run -d --name mysql-container -v mysql_data:/var/lib/mysql d4vp/mysql-local:1.0.0
2. Configure the App
Inspect the MySQL container IP:

Bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-container
Ensure the Django settings.py is configured to use this IP address.

3. Start the Application
Run the application container. Note that we map port 8088 on host to 8080 in container.

Bash
docker run -d -p 8088:8080 --name app-container d4vp/todoapp:2.0.0

Accessing the Application
Open your browser and navigate to: http://localhost:8088