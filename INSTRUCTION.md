##Link to local
http://localhost:8080/

##My Docker Hub
https://hub.docker.com/repository/docker/vovalogic/todoapp/general

##Build and Tag the MySQL Image
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .

##Push the MySQL Image to Docker Hub
docker login
docker tag mysql-local:1.0.0 <username>/mysql-local:1.0.0
docker push <username>/mysql-local:1.0.0

##Run the MySQL Container
docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=app_db -e MYSQL_USER=app_user -e MYSQL_PASSWORD=1234 -v mysql_data:/var/lib/mysql -d mysql-local:1.0.0

##Build and Run the Python App
docker build -t todoapp:2.0.0 .
docker run --name todoapp-container --link mysql-container:mysql -p 8080:8080 -d todoapp:2.0.0

##Push the App Image to Docker Hub
docker tag todoapp:2.0.0 <username>/todoapp:2.0.0
docker push <username>/todoapp:2.0.0
