# Django-Todolist
This is a simple Django-based To-Do List application built with Docker.

## Docker Hub Repository
You can find the Docker images for this application on Docker Hub:

https://hub.docker.com/repository/docker/limbx/mysql-local/general

https://hub.docker.com/repository/docker/limbx/todoapp/general

To pull the image from Docker Hub

docker pull limbx/mysql-local:1.0.0

docker pull limbx/todoapp:2.0.0

## GitHub

### Clone the Repository
If you're working with the source code, clone the project repository:

git clone https://github.com/L1mbxbx/devops_todolist_docker_core_task_2_volumes/tree/develop cd devops_todolist

## Building your application

### Step 1: Building the Docker volume
If you want to create docker volume to store your data persistantly, run:

docker volume create my-mysql-data

### Step 2: Building the Docker Image for database
If you want to build the Docker image for database, run:

docker build . -f Dockerfile.mysql -t mysql-local:1.0.0

### Step 3: Running the database Docker container
If you want to run docker container with database, use the following commnad:

docker run -d -p 3306:3306 --name <mysql_db_name> -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0

### Step 4: Building the Docker Image for application
If you want to build the Docker image for databese, run:

docker build . -f Dockerfile -t todoapp:2.0.0 

### Step 5: Running the application Docker container:
If you want to run docker container with your application, use the following command:

docker run -d -p 8080:8080 --name <name_of_container> todoapp:2.0.0

## Access the Application in a Browser
Once the container is running, open a web browser and go to:

http://localhost:8080

## Stoping Containers
o stop the running container, find the container ID using:

docker ps docker stop <container_id>

Replace <container_id> with the actual container ID.
