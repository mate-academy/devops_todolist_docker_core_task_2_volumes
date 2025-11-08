Docker Hub:

App: https://hub.docker.com/repository/docker/taniakolesnik/todoapp/tags/2.0.0/sha256:18b534f176f53766ea3eed452bf9364bd7404812c5feaa6690658bc38939b818
Database: https://hub.docker.com/repository/docker/taniakolesnik/mysql-local/tags/1.0.0/sha256:c5d6f6e236d3e2f9df722dd459d1e061cf18de8d79f169a6e081882403c09a31

CREATE NETWORK:

docker network create todo-net

RUN DATABASE:

docker run -d --network todo-net --name database -p 3306:3306 -v database:/var/lib/mysql taniakolesnik/mysql-local:1.0.0

RUN APP:

docker run -d --network todo-net --name app -p 8080:8080 taniakolesnik/todoapp:2.0.0

ACCESS APP:

http://localhost:8080