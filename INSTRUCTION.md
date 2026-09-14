To run MYSQL container with volume run:
docker run -d -p 3306:3306 --name mysql -v my-sql-data:/var/lib/mysql mysql-local:1.0.0

To run App container that will connect to a MYSQL db container run:
docker run -p 8080:8080 --name app todoapp:2.0.0

DockerHub:
https://hub.docker.com/repository/docker/kapany322/todoapp/general

To access application via a browser search http://localhost:8000