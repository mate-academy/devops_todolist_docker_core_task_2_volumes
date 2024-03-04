# Django-Todolist

Django-Todolist is a todolist web application with the most basic features of most web apps, i.e. accounts/login, API and (somewhat) interactive UI.

## Instructions for running MySQL container with a volume attached

1. Pull the MySQL image and run a container with a volume attached using the following command:
    ```bash
    docker run -d -v mysql_data:/var/lib/mysql --name mysql-container
    ```
   This command will create a MySQL container named `mysql-container`.

2. Verify that the MySQL container is running:
    ```bash
    docker ps
    ```

## Instructions for running the App container which connects to a MySQL database container

1. Update the Python app's database configuration with the IP address of the running MySQL server container. This can typically be the container name if they are on the same Docker network. For example, if the MySQL container is named `mysql-container`, update the database configuration to use `mysql-container` as the hostname.

2. Build the Docker image for the application:
    ```bash
    docker build -t todoapp:2.0.0 .
    ```

3. Run the Docker container for the application:
    ```bash
    docker run -d -p 8080:8080 --name todoapp-container todoapp:2.0.0
    ```

4. Verify that the application container is running:
    ```bash
    docker ps
    ```
## Docker Hub Repository

The Docker images for this project are available on Docker Hub:

- [todoapp](https://hub.docker.com/repository/docker/krillpolozenko/todoapp/general)
- [mysql-local](https://hub.docker.com/repository/docker/krillpolozenko/mysql-local/general)
