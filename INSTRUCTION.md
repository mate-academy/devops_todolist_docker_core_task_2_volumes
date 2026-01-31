# Instructions

## Run the Container

## 1. Create a Docker Network

```bash
docker network create todo-network
```

## 2. Run the MySQL Database Container

```bash
docker run -d \
  --name db \
  --network todo-network \
  -v mysql_data:/var/lib/mysql \
  popik88/mysql-local:1.0.0
```
*   **-v mysql_data:/var/lib/mysql**: This attaches a volume `mysql_data` to the MySQL data directory inside the container.

## 3. Run the Application Container
Run Django on the same network. The app will connect to the database using the hostname `db` (the name of the MySQL container):

```bash
docker run -d \
  --name app \
  --network todo-network \
  -p 8000:8080 \
  popik88/todoapp:2.0.0
```
*   **--network todo-network**: This allows the app to find the MySQL container at the address `db:3306`.

## 4. Access the Application

[http://localhost:8000](http://localhost:8000)

## Docker Hub Repository
[https://hub.docker.com/repositories/popik88](https://hub.docker.com/repositories/popik88)
