# Run the application and MySQL containers

Build the MySQL image and create a network that provides DNS-based service
discovery between the containers:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
docker network create todo-network
```

Start MySQL. The container name is `mysql`, which is the hostname configured in
`todolist/settings.py`. The database port is available to the app through the
network, so it does not need to be published on the host.

```bash
docker run -d --name mysql --network todo-network \
  -v my-sql-data:/var/lib/mysql mysql-local:1.0.0
```

Build and run the application on the same network:

```bash
docker build -t todoapp:2.0.0 .
docker run -d --name app --network todo-network -p 8000:8000 todoapp:2.0.0
```

The app runs migrations automatically at startup. If MySQL is still
initializing, wait until `docker logs mysql` reports that it is ready, then run
the app command. Open http://localhost:8000 in a browser.

DockerHub: https://hub.docker.com/repository/docker/kapany322/todoapp/general
