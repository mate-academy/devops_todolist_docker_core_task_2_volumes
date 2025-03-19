13.
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
docker run -d -p 3306:3306 --name mysql-local -v .mysql-local-data:/var/lib/mysql mysql-local:1.0.0
docker volume list

14.
docker network list
docker network inspect bridge

15.
https://hub.docker.com/repository/docker/alinamoskovchuk18/todoapp/tags/2.0.0/sha256-d8ee58e1632ed8a9d98c3fcaed9600252d84a0bdf983d7b00359517bc45f4cfd?tab=layers

16.
For example: '172.17.0.2:3306'
