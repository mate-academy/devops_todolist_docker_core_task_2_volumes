link to a personal docker hub repository with app image:
https://hub.docker.com/repository/docker/jacobsmonarh/todoapp/general

link to a personal docker hub repository with mysql image:
https://hub.docker.com/repository/docker/jacobsmonarh/mysql-local/general

to run MySQL container with a volume attached:
sudo docker run -d   --name mysql-db   --network my-network   -v mysql-data:/var/lib/mysql   -e MYSQL_ROOT_PASSWORD=1234   -e MYSQL_DATABASE=app_db   -e MYSQL_USER=app_user   -e MYSQL_PASSWORD=1234   mysql-local:1.0.0

to start the docker network:
sudo docker network create my-network

to run an App container which will connect to a MySQL db container:
sudo docker run -d   --name todoapp   --network my-network   -p 8080:8080   todoapp:2.0.0

 to access the application via a browser connect to:
 http://localhost:8080/
