Instruction

Docker Hub Repositories


MySQL image: https://hub.docker.com/r/klptu/mysql-local
Application image: https://hub.docker.com/r/klptu/todoapp


1. Building the images locally

Build the MySQL image:

docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .

Build the application image:

docker build -t todoapp:2.0.0 .

2. Running the MySQL container (with a persistent volume)

Pull the image from Docker Hub (or use the locally built one):

docker pull klptu/mysql-local:1.0.0

Run the container with a named volume so the database data survives container restarts:

docker run -d \
  -p 3306:3306 \
  --name mysql \
  -v my-mysql-data:/var/lib/mysql \
  klptu/mysql-local:1.0.0

Check that the container is running:

docker ps

Get the container's internal IP address (needed by the application container to connect to MySQL):

docker inspect -f "{{.NetworkSettings.IPAddress}}" mysql

3. Running the application container

Pull the image from Docker Hub (or use the locally built one):

docker pull klptu/todoapp:2.0.0

Before running, make sure todolist/settings.py has the HOST value in DATABASES set to the MySQL container's IP address obtained in the previous step.

Run the application container, publishing the port it listens on:

docker run -d \
  -p 8000:8080 \
  --name todoapp \
  klptu/todoapp:2.0.0

The application's entrypoint automatically applies database migrations and starts the development server.

Check the logs to confirm a successful startup:

docker logs todoapp

4. Accessing the application

Once both containers are running, open a browser and go to:

http://localhost:8000/

The Django ToDo application landing page should load. The API is available at:

http://localhost:8000/api/

Notes


Both containers must be on the same Docker network (or at least reachable from each other) for the application to connect to MySQL.
If the MySQL container is removed and recreated, its internal IP address may change — check it again with docker inspect and update settings.py accordingly before rebuilding the application image.