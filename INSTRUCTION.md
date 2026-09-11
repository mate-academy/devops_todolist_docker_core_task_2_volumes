# Running the Django ToDo application with MySQL

The application and MySQL images are available on Docker Hub:

- [Django application (`aleksmajlo/todoapp:2.0.0`)](https://hub.docker.com/r/aleksmajlo/todoapp/tags)
- [MySQL (`aleksmajlo/mysql-local:1.0.0`)](https://hub.docker.com/r/aleksmajlo/mysql-local/tags)

## Prerequisites

- Docker Desktop must be installed and running.
- Port `8000` must be available on the host machine.

## 1. Pull the images

```bash
docker pull aleksmajlo/mysql-local:1.0.0
docker pull aleksmajlo/todoapp:2.0.0
```

## 2. Create a volume for MySQL data

```bash
docker volume create mysql_data
```

The named volume keeps the database data when the MySQL container is stopped
or removed.

## 3. Run the MySQL container

Run MySQL before the application so that it receives the expected Docker IP
address (`172.17.0.2`):

```bash
docker run -d \
  --name mysql-container \
  -v mysql_data:/var/lib/mysql \
  aleksmajlo/mysql-local:1.0.0
```

Wait until MySQL is ready:

```bash
until docker exec mysql-container \
  mysqladmin ping -h 127.0.0.1 -uapp_user -p1234 --silent
do
  echo "Waiting for MySQL..."
  sleep 2
done
```

Check the MySQL container IP:

```bash
docker inspect \
  -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
  mysql-container
```

The output should be `172.17.0.2`, matching `HOST` in
`todolist/settings.py`. If another container already uses this address, stop
that container, recreate `mysql-container`, and check the address again.

## 4. Run the application container

```bash
docker run -d \
  --name todoapp-container \
  -p 8000:8080 \
  aleksmajlo/todoapp:2.0.0
```

## 5. Verify the containers

```bash
docker ps
docker logs mysql-container
docker logs todoapp-container
```

Both `mysql-container` and `todoapp-container` should have the `Up` status.

## 6. Open the application

Open the following address in a browser:

<http://localhost:8000>

The API is available at:

<http://localhost:8000/api/>

## Stop and start the containers

```bash
docker stop todoapp-container mysql-container
docker start mysql-container
docker start todoapp-container
```

## Remove the containers

```bash
docker rm -f todoapp-container mysql-container
```

Removing the containers does not remove the `mysql_data` volume. Do not remove
the volume if the database data must be preserved.
