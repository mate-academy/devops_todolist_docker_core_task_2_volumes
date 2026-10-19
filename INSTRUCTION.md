Instructions for Building, Publishing, and Running the Todo App with MySQL & Volumes

Prerequisites & Getting the Code

Docker Engine installed on your system.

Git installed on your system.

Note for Linux users: If your user is not added to the docker group, you will need to prepend sudo to all Docker commands.

First, clone your fork of the repository to your local machine, switch to the correct branch, and navigate into the project directory:

git clone https://github.com/dimamikolaichuk13-jpg/devops_todolist_docker_core_task_2_volumes.git
cd devops_todolist_docker_core_task_2_volumes
git checkout Solution

Docker Hub Repositories

App image (todoapp): mykolaichukdmytro/todoapp, tag 2.0.0

Database image (mysql-local): mykolaichukdmytro/mysql-local, tag 1.0.0

Building and Running the MySQL Container with Volumes

Choose one of the options below to get the MySQL database running.

Option A: Build and Run Locally

Build the MySQL image locally:

docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .

Create a Docker volume and run the MySQL container:

docker volume create mysql-data
docker run -d --name mysql-db -v mysql-data:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0

(Note: Environment variables for database name, user, and password are baked into the image via Dockerfile.mysql).

Option B: Pull Pre-built Image from Docker Hub

If you prefer to bypass building the MySQL image locally, create the volume and run directly using the Docker Hub repository:

docker volume create mysql-data
docker pull mykolaichukdmytro/mysql-local:1.0.0
docker run -d --name mysql-db -v mysql-data:/var/lib/mysql -p 3306:3306 mykolaichukdmytro/mysql-local:1.0.0

Verify Database Readiness

Check that MySQL started properly:

docker logs mysql-db

Look for the log message indicating that the database server is ready for connections.

Configuring and Building the Application Container

Since database migrations (RUN python manage.py migrate) execute at build time inside the Dockerfile, the MySQL container must be running before you build the application image.

1. Retrieve the MySQL Container IP Address

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-db

(Note: The IP address is typically 172.17.0.2, but it may vary depending on your local Docker network setup).

2. Configure Database Parameters in todolist/settings.py

Open todolist/settings.py and ensure the DATABASES configuration fields are set as follows:

HOST: IP address obtained from the docker inspect command above (e.g. '172.17.0.2')

NAME: 'app_db'

USER: 'app_user'

PASSWORD: '1234'

PORT: '3306'

3. Build the Application Image

docker build -t todoapp .

Running the Application Container

Run the locally built application container, mapping host port 8080:

docker run -d -p 8080:8080 --name todoapp-container todoapp

Note on Pre-built Docker Hub Image (2.0.0):
If you pull and run mykolaichukdmytro/todoapp:2.0.0 directly from Docker Hub, keep in mind that the database IP address was hardcoded during its specific build phase. Building locally as outlined above ensures your local MySQL IP matches the Django database configuration.

Verifying Database Persistence

To verify that the application is successfully creating tables and storing data in MySQL:

docker exec -it mysql-db mysql -u app_user -p1234 app_db -e "SHOW TABLES;"

You should see Django and Todo app tables listed (such as django_migrations, todo_task, etc.).

Accessing the Application via a Browser

Open your web browser and navigate to:
http://localhost:8080

Expected Output: You should see the interactive Django Todo application interface, allowing you to create, view, and manage your tasks.

Port Conflict Note: If port 8080 is occupied on your host system, map to a different port (e.g. 8081):

docker run -d -p 8081:8080 --name todoapp-container todoapp

Then access the app at http://localhost:8081.

Managing Running Containers

View container logs:

docker logs todoapp-container
docker logs mysql-db

Stop the containers:

docker stop todoapp-container mysql-db

Remove the containers:

docker rm todoapp-container mysql-db

Publishing to Docker Hub (Optional)

If you have built new images locally and wish to push them to Docker Hub:

Log in to your Docker Hub account:

docker login

Tag both images appropriately and push to your repositories:

docker tag todoapp mykolaichukdmytro/todoapp:2.0.0
docker push mykolaichukdmytro/todoapp:2.0.0

docker tag mysql-local:1.0.0 mykolaichukdmytro/mysql-local:1.0.0
docker push mykolaichukdmytro/mysql-local:1.0.0
