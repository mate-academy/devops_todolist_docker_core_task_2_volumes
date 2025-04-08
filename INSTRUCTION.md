# Instructions for Setting Up and Running the Application with Docker

This guide provides instructions to run a MySQL container with a volume attached, an application container that connects
to the MySQL DB container, as well as how to access the application via a browser.

## Prerequisites

- Ensure Docker is installed on your machine.
- Pull the application image from my Docker Hub
  repository: [Docker Hub Repository for App Image](https://hub.docker.com/r/<your_dockerhub_username>/<app_image_name>) (
  replace `<your_dockerhub_username>` and `<app_image_name>` with the actual values).

---

## Step 1: Running the MySQL Container with a Volume Attached

1. Create a Docker volume to persist the database data:

   ```bash
   docker volume create mysql_data
   ```

2. Run the MySQL container:

   ```bash
   docker run -d \
   --name mysql-container \
   -e MYSQL_ROOT_PASSWORD=rootpassword \
   -e MYSQL_DATABASE=my_database \
   -e MYSQL_USER=my_user \
   -e MYSQL_PASSWORD=my_password \
   -v mysql_data:/var/lib/mysql \
   -p 3306:3306 \
   mysql:8.0
   ```

    - `MYSQL_ROOT_PASSWORD`: Set the root user password for MySQL.
    - `MYSQL_DATABASE`: Name of the database to be created.
    - `MYSQL_USER`: Name of the database user.
    - `MYSQL_PASSWORD`: Password for the database user.
    - `mysql_data:/var/lib/mysql`: Mount the volume to persist data.
    - `3306:3306`: Expose MySQL on port 3306.

---

## Step 2: Running the Application Container Connected to MySQL

After setting up the MySQL container, you can run the application container as follows:

1. Run the application container:

   ```bash
   docker run -d \
   --name app-container \
   -e DB_HOST=mysql-container \
   -e DB_PORT=3306 \
   -e DB_NAME=my_database \
   -e DB_USER=my_user \
   -e DB_PASSWORD=my_password \
   -p 8000:8000 \
   <your_dockerhub_username>/<app_image_name>
   ```

    - `DB_HOST`: Host name of the MySQL container.
    - `DB_PORT`: MySQL port (default `3306`).
    - `DB_NAME`: Database name.
    - `DB_USER`: Database user.
    - `DB_PASSWORD`: Database password.
    - `8000:8000`: Expose the application on port 8000.
    - `<your_dockerhub_username>/<app_image_name>`: Replace with the name of your app image in Docker Hub.

2. Ensure the application container starts successfully and connects to the MySQL database.

---

## Step 3: Accessing the Application via a Browser

1. Open your browser and go to:

   ```plaintext
   http://localhost:8000
   ```

2. You should see the application running. If not, verify that both the MySQL and application containers are running.

    - Check if containers are running:

      ```bash
      docker ps
      ```

    - Inspect container logs if needed:

      ```bash
      docker logs <container_name>
      ```

---

That's it! Your application should now be running and connected to the MySQL database.