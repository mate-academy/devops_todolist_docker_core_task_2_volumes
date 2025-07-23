docker run -d -p 3306:3306 -v mysql-local-data:/var/lib/mysql mysql-local
docker run -d -p 8080:8080 --name app todoapp:2.0.0
https://hub.docker.com/repository/docker/skermas48/mysql-local/general
http://localhost:8080/