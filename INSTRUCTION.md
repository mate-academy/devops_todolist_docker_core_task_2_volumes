# Instructions — ToDo App with MySQL (Docker)

## Docker Hub repositories

- App image: https://hub.docker.com/r/sem4ik77/todoapp (tag: 2.0.0)
- MySQL image: https://hub.docker.com/r/sem4ik77/mysql-local (tag: 1.0.0)

## 1. Run the MySQL container with a volume attached

Pull the image:

```bash
docker pull sem4ik77/mysql-local:1.0.0
```

Run it with a named volume so the database data survives container removal:

```bash
docker run -d --name mysql-container -p 3306:3306 -v mysql_data:/var/lib/mysql sem4ik77/mysql-local:1.0.0
```

On first start this automatically creates the `app_db` database and the `app_user` user (password `1234`).

Find the container's IP address (the app needs it to connect):

```bash
docker inspect -f "{{.NetworkSettings.IPAddress}}" mysql-container
```

## 2. Run the App container connected to MySQL

Make sure `mysql-container` is up and running (see step 1) before starting the app — the app image runs database migrations during build/start and needs a live connection.

Pull the image:

```bash
docker pull sem4ik77/todoapp:2.0.0
```

Run it:

```bash
docker run -p 8080:8080 sem4ik77/todoapp:2.0.0
```

## Access the application

Once the container is running, open your browser at:

http://localhost:8080
