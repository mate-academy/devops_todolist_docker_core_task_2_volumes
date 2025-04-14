# Django-Todolist Instructions

This document provides detailed instructions for running the Django-Todolist application and its MySQL database using Docker containers.

## Prerequisites

- **Docker**: Ensure Docker is installed and running on your machine. Download from docker.com if needed.
- **Docker Hub Account**: Optional for pulling images directly from Docker Hub.
- **Terminal Access**: A command-line interface to execute Docker commands.

## Running the MySQL Container

The MySQL container hosts the database (`app_db`) for the Django-Todolist application. A persistent volume is used to ensure data is not lost when the container stops.

1. **Pull the MySQL Image**:

   - Retrieve the pre-built MySQL image from Docker Hub:

     ```bash
     docker pull lexm7/mysql-local:1.0.0
     ```
   - Alternatively, if you have the `Dockerfile.mysql`, you can build it locally:

     ```bash
     docker build -f Dockerfile.mysql -t lexm7/mysql-local:1.0.0 .
     ```

2. **Create a Named Volume**:

   - To persist MySQL data, create a Docker volume:

     ```bash
     docker volume create mysql-data
     ```
   - This volume will store the database files at `/var/lib/mysql` inside the container.

3. **Run the MySQL Container**:

   - Start the container with the volume attached:

     ```bash
     docker run -d --name mysql-container -v mysql-data:/var/lib/mysql -p 3306:3306 lexm7/mysql-local:1.0.0
     ```
   - **Flags Explained**:
     - `-d`: Runs the container in the background (detached mode).
     - `--name mysql-container`: Assigns a name to the container for easy reference.
     - `-v mysql-data:/var/lib/mysql`: Mounts the `mysql-data` volume to the container’s MySQL data directory to persist data across container restarts.
     - `-p 3306:3306`: Maps port 3306 (MySQL’s default port) on the host to port 3306 in the container, allowing access via `localhost:3306`.

4. **Verify the Container**:

   - Check that the container is running:

     ```bash
     docker ps
     ```
   - You should see `mysql-container` in the list.
   - Optionally, view logs to ensure MySQL started correctly:

     ```bash
     docker logs mysql-container
     ```

## Running the App Container

The app container runs the Django-Todolist application and connects to the MySQL database hosted in the `mysql-container`.

1. **Pull the App Image**:

   - Retrieve the pre-built app image from Docker Hub:

     ```bash
     docker pull lexm7/todoapp:2.0.0
     ```
   - Alternatively, build it locally if you have the `Dockerfile`:

     ```bash
     docker build -t lexm7/todoapp:2.0.0 .
     ```

2. **Ensure Database Configuration**:

   - The `todolist/settings.py` file should have the following database configuration:

     ```python
     DATABASES = {
         'default': {
             'ENGINE': 'mysql.connector.django',
             'NAME': 'app_db',
             'USER': 'app_user',
             'PASSWORD': '1234',
             'HOST': 'localhost',
             'PORT': '',
         }
     }
     ```
   - **Note**: The `HOST` is set to `'localhost'` because the MySQL container’s port 3306 is mapped to the host’s port 3306 (`-p 3306:3306`), allowing the app to connect via `localhost`.

3. **Run the App Container**:

   - Start the app container:

     ```bash
     docker run -d --name todoapp-container -p 8000:8000 lexm7/todoapp:2.0.0
     ```
   - **Flags Explained**:
     - `-d`: Runs the container in the background.
     - `--name todoapp-container`: Names the container.
     - `-p 8000:8000`: Maps port 8000 (Django’s default port) on the host to port 8000 in the container.

4. **Verify the App**:

   - Check the container’s logs to confirm the Django server started:

     ```bash
     docker logs todoapp-container
     ```
   - Look for output like:

     ```
     Starting development server at http://0.0.0.0:8000/
     ```
   - If you see errors (e.g., database connection issues), ensure the MySQL container is running and accessible on `localhost:3306`.

## Accessing the Application

To interact with the Django-Todolist application:

1. Open a web browser (e.g., Chrome, Firefox).
2. Navigate to the following URL:

   ```
   http://localhost:8000
   ```
3. You should see the application’s landing page or API interface, depending on the route.
   - The landing page provides a user interface for the todo list.
   - The API can be explored at routes like `/api/` (check the app’s documentation for specific endpoints).

## Docker Hub Repository

The container images are hosted on Docker Hub:

- **Application Image**: lexm7/todoapp:2.0.0
- **MySQL Image**: lexm7/mysql-local:1.0.0

These images can be pulled directly to run the application without building locally.
