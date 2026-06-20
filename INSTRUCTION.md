# Docker Core / Containerizing an App / Docker by practice | ToDo App

## Docker Hub Repository

MySQL database server image on Docker Hub:

[https://hub.docker.com/repository/docker/maxmlv/mysql-local](https://hub.docker.com/repository/docker/maxmlv/mysql-local)

The application image on Docker Hub:

[https://hub.docker.com/repository/docker/maxmlv/todoapp](https://hub.docker.com/repository/docker/maxmlv/todoapp)

## Create the network

```bash
docker network create todo-app-network
```

## Set-up MySQL database

Create docker volume `mysql-data`:

```bash
docker volume create mysql-data
```

Pull the `mysql-local` image:

```bash
docker pull maxmlv/mysql-local:1.0.0
```

Run the `mysql-local` container with volume attached:

```bash
docker run -d --name mysql-local --network todo-app-network -v mysql-data:/var/lib/mysql -p 3306:3306 maxmlv/mysql-local:1.0.0 
```


## Run the application from the Docker Hub image

### Pull the image

```bash
docker pull maxmlv/todoapp:2.0.0
```


### Run the Container

```bash
docker run -d --name todoapp --network todo-app-network -p 8080:8080 -e DB_HOST=mysql-local maxmlv/todoapp:2.0.0
```

- `-d` - run in detached mode (in the background)
- `-p 8080:8080` - map container port 8080 to host port 8080
- `--name todoapp` - name the running container
- `--network todo-app-network` - include user-defined network
- `-e DB_HOST=mysql-local` - pass the database container name as an env variable. Built-in DNS resolves `mysql-local` to the correct container automatically.

## Our application is up and running!

![Project Screenshot](./screenshots/Screenshot%202026-06-21%20002759.png)

## Access the Application

Once the container is running, open your browser and go to:

[http://localhost:8080](http://localhost:8080)

## Stopping the Containers

```bash
docker stop todoapp mysql-local
docker rm todoapp mysql-local
```