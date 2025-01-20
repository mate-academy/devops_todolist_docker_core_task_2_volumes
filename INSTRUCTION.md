# Instructions to Run MySQL and App Containers

## Prerequisites

Before proceeding, make sure you have Docker installed on your machine.

- **Docker**: [Download Docker](https://www.docker.com/products/docker-desktop)
- **Docker Hub Account**: [Sign up for Docker Hub](https://hub.docker.com/)

## 1. **Run MySQL Container with Volume Attached**

To run the MySQL container with a volume attached, follow these steps:

### 1.1 **Pull the MySQL Image**

First, pull the official MySQL Docker image:

```bash
docker pull mysql:latest
```

### 1.2 **Run MySQL Container**

Run the MySQL container with the following command. This will use the official MySQL image, set the root password, create the `app_db` database, and create a user (`app_user`) for your app to connect.
! for learning purposes env info shown

```bash
docker run -d -p 3306:3306 --name my-mysql-container \
-v my-mysql-data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=1234 \
-e MYSQL_DATABASE=app_db \
-e MYSQL_USER=app_user \
-e MYSQL_PASSWORD=1234 \
mysql:latest
```

- **Port 3306** will be exposed for database connections.
- The `my-mysql-data` volume is used to persist the MySQL data.
- The environment variables are used to set the root password, create the `app_db` database, and create the `app_user` user.

### 1.3 **Verify MySQL Container is Running**

To verify that the MySQL container is running, use the following command:

```bash
docker ps
```

This will list the running containers. You should see the `my-mysql-container` listed.

## 2. **Run the App Container (Connecting to MySQL Database)**

Once the MySQL container is running, proceed to run the app container that will connect to the MySQL database.

### 2.1 **Build the App Image**

If you haven't built the app image yet, navigate to your app's root directory and build the image:

```bash
docker build -t todo-python-app .
```

This will create an image tagged `todo-python-app`.

### 2.2 **Run the App Container**

Now, run the app container and link it to the MySQL container. Use the following command:

```bash
docker run -d --name todo-python-app --link my-mysql-container:mysql -p 8000:8000 todo-python-app
```

This will:

- Link the `todo-python-app` container to the `my-mysql-container` MySQL container.
- Expose port `8000` for the application.

### 2.3 **Verify the App Container is Running**

To verify that the app container is running, use the following command:

```bash
docker ps
```

You should see the `todo-python-app` container listed.

## 3. **Access the Application via Browser**

Once the app container is running, you can access the application in your web browser.

1. Open your browser and navigate to:

   ```
   http://localhost:8000
   ```

2. You should see the app's interface, which is now connected to the MySQL database.

## 4. **App Image on Docker Hub**

You can also pull the app image directly from my Docker Hub repository:

- **Repository Link**: [srtrace/todoapp:2.0.0](https://hub.docker.com/repository/docker/srtrace/todoapp)

To pull the image, run:

```bash
docker pull srtrace/todoapp:2.0.0
```

Then, run the container using:

```bash
docker run -d --name todo-python-app --link my-mysql-container:mysql -p 8000:8000 srtrace/todoapp:2.0.0
```

This will pull the image from Docker Hub and run it just like the local image.

---
