# Instructions

## Running the MySQL Container

1. Build the MySQL Docker image:
    ```sh
    docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
    ```

2. Run the MySQL container with a volume attached:
    ```sh
    docker run -d --name mysql-container -v mysql_data:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0
    ```

## Running the Django Application Container

1. Update the `DATABASES` setting in `todolist/settings.py` to use the IP address of the running MySQL container.

2. Build the Django application Docker image:
    ```sh
    docker build -t todoapp:2.0.0 .
    ```

3. Run the Django application container:
    ```sh
    docker run -d --name todoapp-container --link mysql-container:mysql -p 8080:8080 todoapp:2.0.0
    ```

## Accessing the Application

1. Open your web browser and navigate to [http://localhost:8080](http://localhost:8080) to access the Django application.

## Docker Hub Repository

- The MySQL image is available at: [Your Docker Hub Repository for mysql-local](https://hub.docker.com/repository/docker/semorgana/mysql-local/general)
- The Django application image is available at: [Your Docker Hub Repository for todoapp](https://hub.docker.com/repository/docker/semorgana/todoapp/general)