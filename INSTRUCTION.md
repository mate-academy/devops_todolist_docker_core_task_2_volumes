# Todo App Docker Instructions

Docker Hub app image: [prostoponchik/todoapp](https://hub.docker.com/r/prostoponchik/todoapp)

## Run MySQL with Volume

Build the MySQL image:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

Run the MySQL container with a volume:

```bash
docker run -d --name mysql-local -v mysql-data:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0
```

Get the MySQL container IP:

```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local
```

Use this IP as the `MYSQL_HOST` value when building the app image.

## Run the App Container

Build the app image:

```bash
docker build --build-arg MYSQL_HOST=172.17.0.2 -t todoapp:2.0.0 .
```

Run the app container:

```bash
docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0
```

Open the app in a browser:

```text
http://localhost:8080/
```

## Push Images to Docker Hub

```bash
docker login
docker tag mysql-local:1.0.0 prostoponchik/mysql-local:1.0.0
docker push prostoponchik/mysql-local:1.0.0
docker tag todoapp:2.0.0 prostoponchik/todoapp:2.0.0
docker push prostoponchik/todoapp:2.0.0
```
