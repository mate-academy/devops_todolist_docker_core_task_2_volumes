Django-Todolist Docker Setup

Docker Hub Repositories

MySQL image: https://hub.docker.com/r/valyadard/mysql-local

Django application image: https://hub.docker.com/r/valyadard/todoapp

1. Create Docker Network

docker network create todo-network

2. Create Docker Volume

docker volume create mysql-data

The volume is used to persist MySQL database data.

3. Run MySQL Container

Pull the MySQL image:

docker pull valyadard/mysql-local:1.0.0

Run the MySQL container with the volume attached:

docker run -d \
  --name mysql-container \
  --network todo-network \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  valyadard/mysql-local:1.0.0

MySQL configuration:

Database: app_db

Username: app_user

Password: 1234

Port: 3306

Check MySQL logs:

docker logs mysql-container

Wait until MySQL reports ready for connections.

4. Run Django Application

Pull the application image:

docker pull valyadard/todoapp:2.0.0

Run the application in the same Docker network:

docker run -d \
  --name todoapp-container \
  --network todo-network \
  -p 8080:8080 \
  valyadard/todoapp:2.0.0

The Django application connects to MySQL using the hostname mysql-container and port 3306.

Database migrations are executed automatically when the Django container starts.

5. Verify Containers

docker ps

Check application logs:

docker logs todoapp-container

The application should start without errors.

6. Access the Application

Open your browser:

http://localhost:8080

API:

http://localhost:8080/api/

7. Stop Containers

docker stop todoapp-container mysql-container

The MySQL data remains stored in the Docker volume mysql-data.
