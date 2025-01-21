# Instructions for Running the Application with Docker

## Prerequisites
- Install [Docker](https://www.docker.com/get-started).
- Ensure you have access to the internet to pull images from Docker Hub.

---

## Step 1: Pull MySQL Docker Image
Run the following command to pull the official MySQL image:

```bash
docker pull mysql:latest
```

## Step 2: Create a Volume for MySQL Data
To persist MySQL data, create a Docker volume:

```bash
docker volume create mysql_data
```

## Step 3: Run the MySQL Container
Start a MySQL container with the volume attached and environment variables:

```bash
docker run -d \
  --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql:latest
```

# Step 4: Pull the Application Image from Docker Hub
Pull the prebuilt application image from your Docker Hub repository:

```bash
docker pull xeomzi/todoapp:latest
```

---

## Step 5: Run the Application Container
Run the application container and link it to the MySQL container:

```bash
docker run -d \
  --name todoapp-container \
  -p 8080:8080 \
  --link mysql-container:mysql \
  xeomzi/todoapp:latest
```


## Step 6: Access the Application
Open your web browser and navigate to:

```
http://localhost:8080
```

You should see the application running.

---

## Docker Hub Repository Link
You can find the application image here: [My Docker Hub Repository](https://hub.docker.com/repository/docker/xeomzi/todoapp)
