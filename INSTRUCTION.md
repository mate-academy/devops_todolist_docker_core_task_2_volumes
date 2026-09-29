Todo App Docker instructions

This instruction explains how to run the Todo application with a MySQL database using Docker

1. Pull Docker Images:

Pull the MySQL image:
docker pull leonbecken/mysql-local:1.0.0

Pull the Todo application image:
docker pull leonbecken/todoapp:2.0.0

2. Create a Docker Volume

Create a volume for persistent MySQL data:
docker volume create mysql-data:
Th volune keeps the MySQL database even if the MySQL container is removed.

3. Run the MySQL Container

Run the MySQL container and attach the volume:
docker run -d --name mysql-container -v mysql-data:/var/lib/mysql
leonbecken/mysql-local:1.0.0

Check that the container is running:
docker ps

4. Get the MySQL Container IP Addres

Run:
docker inspect mysql-container

You can find many information after this command, but you need to find IP Addres line.

5. Run the Todod Application

Run the application container:
docker run -d --name todoapp-container -p 8080:8080 leonbecken/todoapp:2.0.0

Check that boh containers are running:
docker ps

6. Access the Application

After both containers have started successfully, open the application in the browser:

http://localhost:8080

DockerHub
My Todo application image is available in my personal Docker Hub repository:

http://hub.docker.com/r/leonbeacken/todoapp