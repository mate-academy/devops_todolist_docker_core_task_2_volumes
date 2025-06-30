### Docker hub repository with todoapp: [link](https://hub.docker.com/repository/docker/timnord1993/todoapp/general)

### To run MySQL container with volume:
docker run -d \
  --name mysql \
  -p 3306:3306 \
  -v my-mysql-data:/var/lib/mysql \
  mysql-local:1.0.0

### To run an app container which will connect to DB container:
build and run the app container:
docker build -t todoapp:2.0.0 .
docker run -p 8081:8080 --name todoapp todoapp:2.0.0

### To access the application via browser:
http://localhost:8081