Link Docker Hub: https://hub.docker.com/repository/docker/olegglv/todoapp/

This document contains all instructions required to build, run, and access the Docker container for the Django application.

Make sure Docker is installed on your system and running.

From the root directory of the project, build the Docker image by running: docker build -f Dockerfile -t todoapp:1.0.0 . where todoapp is the local image name and 1.0.0 is the tag.

Once the build is complete, start the container with: docker run -p 8080:8080 todoapp:1.0.0 The -p 8080:8080 option maps port 8080 of the container to port 8080 on your host machine.

After the container starts, open a web browser and navigate to: http://localhost:8080 to access the Django application.

The container uses the environment variable PYTHONUNBUFFERED=1 to ensure Python output is unbuffered for better log visibility.

To stop the running container, press CTRL + C in the terminal where it is running, or find the container ID using: docker ps and stop it manually with: docker stop <container_id>

Make sure that requirements.txt exists in the project root and that port 8080 is not in use before starting the container.

Optionally, you can download the prebuilt image from Docker Hub.
Use the following command to pull the image: docker pull olegglv/todoapp

---------------------------------------

### Database Setup (MySQL with Volume)
To run the MySQL database with persistent storage, use the following commands:
1. Build the database image:
   `docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .`
2. Run the container with a volume attached:
   `docker run -d --name mysql -v app-volume:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0`
   The `-v app-volume:/var/lib/mysql` flag ensures your data is saved even if the container stops.

### Connecting App to MySQL
To connect the application to the database:
1. Get the MySQL container's internal IP:
   `docker network inspect bridge`
2. Update the `HOST` value in `todolist/settings.py` with this IP address before building the app image.
3. After starting the app container, run migrations to initialize the database:
   `docker exec app2 python manage.py migrate`

### Accessing the Application
Once both containers are running and migrations are done, open your browser and go to:
http://localhost:8000 (or http://localhost:8080 if you mapped it to that port).

Links images:
https://ibb.co/gb3d0kH0
 