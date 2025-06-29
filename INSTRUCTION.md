# Django Todo Application with MySQL - Docker Setup Instructions

## Overview

This guide provides step-by-step instructions to run the Django Todo application with MySQL database using Docker containers.

## Prerequisites

- Docker installed on your machine
- Docker Hub account (for pulling images)

## Step 1: Run MySQL Container with Volume

1. **Pull MySQL image from Docker Hub:**

   ```bash
   docker pull sano11/mysql-local:1.0.0
   ```

2. **Run MySQL container with volume attached:**

   ```bash
   docker run -d \
     --name mysql-container \
     -p 3306:3306 \
     -v mysql-data:/var/lib/mysql \
     sano11/mysql-local:1.0.0
   ```

3. **Verify MySQL container is running:**

   ```bash
   docker ps
   ```

4. **Check MySQL container IP address:**
   ```bash
   docker inspect mysql-container | grep "IPAddress"
   ```

## Step 2: Run Application Container

1. **Pull the application image from Docker Hub:**

   ```bash
   docker pull sano11/todoapp:2.0.0
   ```

2. **Run the application container:**
   ```bash
   docker run -p 8080:8080 sano11/todoapp:2.0.0
   ```

## Step 3: Access the Application

1. **Open your web browser and navigate to:**

   ```
   http://localhost:8080
   ```

2. **Available endpoints:**
   - Main application: `http://localhost:8080/`
   - API documentation: `http://localhost:8080/api/`
   - Admin panel: `http://localhost:8080/admin/`

## Docker Hub Repository Links

- **Application Image:** `https://hub.docker.com/r/sano11/todoapp`
- **MySQL Image:** `https://hub.docker.com/r/sano11/mysql-local`

## Troubleshooting

### If application fails to connect to MySQL:

1. Ensure MySQL container is running and fully initialized
2. Check the IP address of MySQL container
3. Wait a few seconds for MySQL to complete initialization
4. Restart the application container if needed

### If port 8080 is already in use:

```bash
docker run -p 8081:8080 sano11/todoapp:2.0.0
```

Then access via `http://localhost:8081`

### To stop containers:

```bash
docker stop mysql-container
docker stop $(docker ps -q --filter ancestor=sano11/todoapp:2.0.0)
```

### To remove containers and volumes:

```bash
docker rm mysql-container
docker volume rm mysql-data
```

## Application Features

- **User Authentication:** Register and login functionality
- **Todo Management:** Create, read, update, and delete todo items
- **API Access:** RESTful API for programmatic access
- **Responsive UI:** Clean and simple interface using Skeleton CSS

## Technical Details

- **Python Version:** 3.8
- **Django Version:** 4.1.10
- **MySQL Version:** 8.0
- **Database:** MySQL with persistent volume storage
- **Port Mapping:** Application runs on port 8080, MySQL on port 3306
