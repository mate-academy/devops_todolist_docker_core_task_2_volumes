Download container with mysql and appliocation you can from repository
https://hub.docker.com/repository/docker/foxytail8

For build mysql need:
check file requirements.txt  line will be with mysql-connector-python==8.2.0
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
docker run -d -v mysql_data:/var/lib/mysql -p 3306:3306 --name mysql-container mysql-local:1.0.0
docker build -t todoapp:2.0.0 .
docker run -p 8080:8080 todoapp:2.0.0
Go to browser page http://localhost:8080 