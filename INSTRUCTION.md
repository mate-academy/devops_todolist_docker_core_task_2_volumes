[Docker Image todoapp](https://hub.docker.com/r/somewellich/todoapp)

[Docker Image mysql-local](https://hub.docker.com/r/somewellich/mysql-local)

## Instructions for running the containers

**Step 1: Run the MySQL Database Container**
The database must be started first because the web application depends on it.

``` bash
docker run -d --name my-db -v mysql-data:/var/lib/mysql mysql-local:1.0.0
```

Note: Ensure the database container is assigned the IP address 172.17.0.2 (you can verify this using docker `inspect my-db`). The web app is configured to connect to this specific IP.

**Step 2: Run the Web Application Container**
Once the database is running, start the application container:

``` bash
docker run -d --name todo-web -p 8080:8080 todoapp:2.0.0
```

## Tagging and Pushing the Images (For Developers)

Tag:
```bash
docker tag todoapp:2.0.0 somewellich/todoapp:2.0.0
```

Push the container:
```bash
docker push somewellich/todoapp:2.0.0
```

Tag:
```bash
docker tag mysql-local:1.0.0 somewellich/mysql-local:1.0.0
```

Push the container:
```bash
docker push somewellich/mysql-local:1.0.0
```

## Instructions on accessing the application via a browser

http://localhost:8080/

OR

[http://127.0.0.1:8080/](http://127.0.0.1:8080/)