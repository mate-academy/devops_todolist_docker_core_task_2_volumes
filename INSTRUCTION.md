# Instructions for Running Django-Todolist

This guide explains how to deploy the Django-Todolist web application using Docker. The application uses MySQL as its database. Follow these steps to run the MySQL and application containers.

## Prerequisites

- Docker installed.
- Access to Docker Hub.
- A web browser to access the application.

## Running the MySQL Container

1. **Pull the MySQL image** from Docker Hub:

   docker pull <your_username>/mysql-local:1.0.0

2. **Create a volume** for persistent database storage:

   docker volume create mysql_data

3. **Run the MySQL container**:

   docker run -d --name mysql-container -v mysql_data:/var/lib/mysql -p 3306:3306 <your_username>/mysql-local:1.0.0

- `-v mysql_data:/var/lib/mysql` ensures database data persists.
- `-p 3306:3306` exposes the MySQL port.
- The container initializes the `app_db` database and creates the `app_user` with password `1234`.

4. **Verify the container is running**:

   docker ps

## Running the Application Container

1. **Pull the application image** from Docker Hub:

   docker pull <your_username>/todoapp:2.0.0

2. **Find the MySQL container’s IP address**:

   docker inspect mysql-container | grep IPAddress

Note the IP address (e.g., `172.17.0.2`).

3. **Update the database configuration**:
- Open the `todolist/settings.py` file in your project.
- In the `DATABASES` section, set the `HOST` to the MySQL container’s IP address:
  ```python
  'HOST': '<container_ip>',
  ```
- Ensure the other settings match:
  ```python
  DATABASES = {
      'default': {
          'ENGINE': 'mysql.connector.django',
          'NAME': 'app_db',
          'USER': 'app_user',
          'PASSWORD': '1234',
          'HOST': '<container_ip>',
          'PORT': '',
      }
  }
  ```

4. **Run the application container**:

   docker run -d --name todoapp-container -p 8000:8000 --link mysql-container <your_username>/todoapp:2.0.0

- `-p 8000:8000` exposes the application port.
- `--link mysql-container` connects the application to the MySQL container (note: modern Docker recommends using networks, but `--link` is used here for simplicity).

5. **Check the application logs**:

   docker logs todoapp-container

Ensure the server started without errors.

## Accessing the Application

- Open a browser and navigate to: `http://localhost:8000`.
- The Django-Todolist landing page should load.
- The API is available at the same address, e.g., `http://localhost:8000/api/`.

## Docker Hub Repository

- MySQL image: `https://hub.docker.com/r/rootdebian/mysql-local`
- Application image: `https://hub.docker.com/r/rootdebian/todoapp`

## Troubleshooting

- If the application fails to connect to MySQL:
  - Verify the MySQL container is running (`docker ps`).
  - Confirm the IP address in `settings.py` is correct.
- If port `8000` is in use, map a different port, e.g.:

  docker run -d --name todoapp-container -p 8080:8000 --link mysql-container <your_username>/todoapp:2.0.0

Then access `http://localhost:8080`.

## Notes

- The `mysql_data` volume ensures persistent MySQL data storage.
- For a more streamlined setup, consider using Docker Compose (not required for this task).

