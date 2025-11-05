# Docker Setup Instructions

This document provides step-by-step instructions for running the TodoList application with MySQL using Docker containers.

## Prerequisites

- Docker installed on your machine
- Docker Hub account (for pushing images)

## 1. MySQL Container Setup

### Build MySQL Image

Build the MySQL image from `Dockerfile.mysql`:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

### Run MySQL Container with Volume

Run the MySQL container with a named volume to persist data:

```bash
docker run -d \
  --name mysql-container \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  mysql-local:1.0.0
```

**Explanation:**
- `-d`: Run container in detached mode
- `--name mysql-container`: Name the container for easy reference
- `-p 3306:3306`: Map container port 3306 to host port 3306
- `-v mysql_data:/var/lib/mysql`: Create a named volume `mysql_data` and mount it to `/var/lib/mysql` for data persistence

### Verify MySQL Container is Running

```bash
docker ps
```

You should see the `mysql-container` running.

### Push MySQL Image to Docker Hub

First, tag the image with your Docker Hub username:

```bash
docker tag mysql-local:1.0.0 mariiahorbova/mysql-local:1.0.0
```

Then push to Docker Hub:

```bash
docker login
docker push mariiahorbova/mysql-local:1.0.0
```

### Pull and Run MySQL Image from Docker Hub

If you want to run the image from Docker Hub:

```bash
docker pull mariiahorbova/mysql-local:1.0.0
docker run -d \
  --name mysql-container \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  mariiahorbova/mysql-local:1.0.0
```

## 2. Application Container Setup

### Update Database Configuration

Before building the application image, you need to update the database configuration in `todolist/settings.py` with the MySQL container's IP address:

1. Get the MySQL container IP address:
```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-container
```

2. Open `todolist/settings.py` and replace `<mysql-container-ip>` in the `HOST` field of the `DATABASES` configuration with the actual IP address obtained above.

For example, if the IP is `172.17.0.2`, the configuration should look like:
```python
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': '172.17.0.2',  # MySQL container IP address
        'PORT': '',  # Leave this empty to use the default MySQL port (3306).
    }
}
```

### Build Application Image

Build the TodoList application image:

```bash
docker build -t todoapp:2.0.0 .
```

### Run Application Container Connected to MySQL

Run the application container:

```bash
docker run -d \
  --name todoapp-container \
  -p 8080:8080 \
  todoapp:2.0.0
```

**Note:** If you restart the MySQL container and its IP address changes, you will need to update `settings.py` with the new IP and rebuild the application image.

### Verify Application Container is Running

```bash
docker ps
```

Check the logs to ensure migrations ran successfully:

```bash
docker logs todoapp-container
```

### Push Application Image to Docker Hub

Tag the image with your Docker Hub username:

```bash
docker tag todoapp:2.0.0 mariiahorbova/todoapp:2.0.0
```

Push to Docker Hub:

```bash
docker push mariiahorbova/todoapp:2.0.0
```

**Docker Hub Repository:** https://hub.docker.com/r/mariiahorbova/todoapp

Replace `mariiahorbova` with your actual Docker Hub username.

## 3. Accessing the Application

Once both containers are running, access the application via your web browser:

- **Main Application:** http://localhost:8080
- **API Endpoint:** http://localhost:8080/api/
- **Admin Panel:** http://localhost:8080/admin/ (requires superuser account)

### Create a Superuser (Optional)

To access the admin panel, create a superuser:

```bash
docker exec -it todoapp-container python manage.py createsuperuser
```

Follow the prompts to create a username, email, and password.

## 4. Useful Docker Commands

### View Container Logs

```bash
docker logs mysql-container
docker logs todoapp-container
```

### Stop Containers

```bash
docker stop mysql-container todoapp-container
```

### Start Containers

```bash
docker start mysql-container todoapp-container
```

### Remove Containers

```bash
docker rm -f mysql-container todoapp-container
```

### Remove Volumes

```bash
docker volume rm mysql_data
```

### List Docker Volumes

```bash
docker volume ls
```

## 5. Troubleshooting

### Application cannot connect to MySQL

- Ensure MySQL container is running: `docker ps`
- Check MySQL container logs: `docker logs mysql-container`
- Verify the IP address in `settings.py` matches the current MySQL container IP (check with `docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-container`)
- If the MySQL container IP has changed, update `settings.py` and rebuild the application image
- Ensure both containers are running and can communicate

### Port Already in Use

If port 3306 or 8080 is already in use, change the port mapping:

```bash
docker run -d --name mysql-container -p 3307:3306 ...
docker run -d --name todoapp-container -p 8081:8080 ...
```

### Database Connection Errors

If you see database connection errors, wait a few seconds for MySQL to fully initialize, then restart the app container:

```bash
docker restart todoapp-container
```

