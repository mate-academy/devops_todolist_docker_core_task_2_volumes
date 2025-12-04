Repository link Database : https://hub.docker.com/repository/docker/tongobash/mysql-local/tags/1.0.0/sha256-1ffc24e31c7115cee9f252c3b0fa393d29795da95d572c177806188610c64b8e

Repository link App: https://hub.docker.com/repository/docker/tongobash/todoapp/tags/2.0.0/sha256-1eeeaf1dcfdc1592840044eac487da07ba89db2ae2487615ecdfe063c13b3143

CREATE network:

docker network create todo-net

RUN DATABASE:

docker run -d --network todo-net --name database -p 3306:3306 -v database:/var/lib/mysql tongobash/mysql-local:1.0.0

RUN APP:

docker run -d --network todo-net --name app -p 8080:8080 tongobash/todoapp:2.0.0

ACCESS APP:

http://localhost:8080
