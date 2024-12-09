# Instruction for Running MySQL Container and Application

## 1. Running MySQL Container

To run the MySQL container, follow these steps:

1. **Build the MySQL image** from the Dockerfile if you haven't done it yet:

    ```bash
    docker build -t salo2452/mysql-local:1.0.0 .
    ```

2. **Run the MySQL container** with a mounted volume for data storage:

    ```bash
    docker run -d --name mysql-container -v mysql-data:/var/lib/mysql -p 3306:3306 salo2452/mysql-local:1.0.0
    ```

    - `-d` — run in detached mode.
    - `--name mysql-container` — specify the container name.
    - `-v mysql-data:/var/lib/mysql` — create a volume for MySQL data storage.
    - `-p 3306:3306` — open port 3306 for external MySQL access.

## 2. Running the Application Container

1. Update your application's configuration to connect to the MySQL container. Use the IP address of the MySQL container for the connection. You can find the IP address of the container with this command:

    ```bash
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-container
    ```

2. **Build the application image**:

    ```bash
    docker build -t salo2452/todoapp:2.0.0 .
    ```

3. **Run the application container** and link it to the MySQL container:

    ```bash
    docker run -d --name todoapp-container --link mysql-container:mysql -p 8000:8000 salo2452/todoapp:2.0.0
    ```

    - `--link mysql-container:mysql` — allows the application container to connect to the MySQL container.
    - `-p 8000:8000` — opens port 8000 for accessing the application through the browser.

## 3. Accessing the Application via Browser

To access your application, open a browser and go to:

## 4. Your Images on Docker Hub

- **MySQL Image**: [salo2452/mysql-local:1.0.0](https://hub.docker.com/r/salo2452/mysql-local)
- **Application**: [salo2452/todoapp:2.0.0](https://hub.docker.com/r/salo2452/todoapp)

## 5. Creating a Pull Request

1. Create a Pull Request with your changes on the platform for review.
