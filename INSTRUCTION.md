
##  Run MySQL container with a volume attached
```
docker run -d \
  --name my-mysql \
  -p 3306:3306 \
  -v my-mysql-data:/var/lib/mysql \
  mysql-local:1.0.0
```

## Run an App container which will connect to a MySQL db container.

```
docker run -d --name todoapp-container \
  -e DB_HOST=172.17.0.2 \
  -p 8000:8000 \
  todoapp:2.0.0
```

## Docker Hub Repository
[Link to Docker Hub](https://hub.docker.com/repository/docker/alexkaie/mysql-local/general)
[Link to Docker Hub](https://hub.docker.com/repository/docker/alexkaie/todoapp/tags/2.0.0/sha256-7983adafc819e68e8c7c3dac45ab819e1d65118a50e53f6cfd9723e9a2aa26ba)

## Open in Browser
http://localhost:8000