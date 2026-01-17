# Instructions for Running Django-Todolist with MySQL

## Prerequisites
- Docker installed on your machine
- Docker Hub account

## Step 1: Build MySQL Image

Build the MySQL image from the Dockerfile.mysql:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

## Step 2: Run MySQL Container with Volume Attached

Run the MySQL container with a persistent volume:

```bash
docker run -d \
  --name mysql \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```

Wait for MySQL to fully initialize (about 30 seconds), then verify it's running:

```bash
docker logs mysql
```

## Step 3: Build the Application Image

Build the Django application image:

```bash
docker build -t todoapp:2.0.0 .
```

## Step 4: Run the Application Container

Run the app container connected to the MySQL container:

```bash
docker run -d \
  --name todoapp \
  --link mysql:mysql \
  -p 8080:8080 \
  todoapp:2.0.0
```

## Step 5: Access the Application

Open your browser and navigate to:

```
http://localhost:8080
```

## Docker Hub Repository

The application image is available at:
- **Docker Hub**: https://hub.docker.com/r/unlie9/todoapp

The MySQL image is available at 
- **Docker Hub**: https://hub.docker.com/r/unlie9/mysql-local 

To push images to Docker Hub:

```bash
# Login to Docker Hub
docker login

# Tag and push MySQL image
docker tag mysql-local:1.0.0 <YOUR_DOCKERHUB_USERNAME>/mysql-local:1.0.0
docker push <YOUR_DOCKERHUB_USERNAME>/mysql-local:1.0.0

# Tag and push App image
docker tag todoapp:2.0.0 unlie9/todoapp:2.0.0
docker push unlie9/todoapp:2.0.0
```

## Using Docker Network (Alternative to --link)

For better container networking, you can use Docker networks:

```bash
# Create a network
docker network create todoapp-network

# Run MySQL container on the network
docker run -d \
  --name mysql \
  --network todoapp-network \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0

# Run App container on the same network
docker run -d \
  --name todoapp \
  --network todoapp-network \
  -p 8080:8080 \
  todoapp:2.0.0
```

## Stopping and Removing Containers

```bash
# Stop containers
docker stop todoapp mysql

# Remove containers
docker rm todoapp mysql

# Remove volume (if needed)
docker volume rm mysql_data
```
