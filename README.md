### Instructions for running app with Docker

1. Pull app-database image and run container:

```
docker pull zabftft/mysql-local:1.0.0
docker run --name mate-db -d -p 3306:3306 -v mysql-data:/var/lib/mysql zabftft/mysql-local:1.0.0
```

2. Pull app image, build and run container:

```
docker pull zabftft/todoapp:2.0.0
docker run --name mate-app -d -p 8080:8080 zabftft/todoapp:2.0.0
```

3. To access app via browser, type 'http://localhost:8080' in address bar.

4. DockerHub links:
   DB - https://hub.docker.com/repository/docker/zabftft/mysql-local/general
   APP - https://hub.docker.com/repository/docker/zabftft/todoapp/general
