## Link to Docker Hub repositories

- [todoapp](https://hub.docker.com/repository/docker/vadk1m/todoapp)
- [MySQL](https://hub.docker.com/repository/docker/vadk1m/mysql-local)

## How to run the program

Steps:

1. Build mysql image.
2. Run mysql container with volume attached.
3. Find mysql container host address.
4. Update settings.py with mysql container host address.
5. Build todoapp image.
6. Run todoapp container.

To build the image for MySQL container run the following command:

```bash
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
```

To run the container from MySQL image with a volume attached execute the following command:

```bash
docker run -v db-volume:/var/lib/mysql -d -p 3306:3306 mysql-local:1.0.0
```

To find the MySQL container address run the following command:

```bash
docker network inspect bridge
```

The address will be in Containers:IPv4Address field. Paste the value in the 'HOST' property of the DATABASES object

To build the todoapp image run the following command:

```bash
docker build -t todoapp:2.0.0 .
```

To run the todoapp container execute the following command:

```bash
docker run -p 8080:8080 todoapp:2.0.0
```

## How to access the application via a browser

Go to the website `http://localhost:8080/`
