Create mysql image:
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
*This image in DockerHub: https://hub.docker.com/r/adryga/mysql-local

Run mysql container:
docker run -d -v mysql_data:/var/lib/mysql --name mysql-local -p 3306:3306 mysql-local:1.0.0

Create app image:
docker build -t app:2.0.0 .
*This image in DockerHub: https://hub.docker.com/r/adryga/todoapp

Run app container:
docker run -d --name app -p 8080:8080 app:2.0.0

Check localhost:8080 in your browser