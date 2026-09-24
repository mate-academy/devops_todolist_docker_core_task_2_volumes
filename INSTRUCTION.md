
## Create Docker Network

Create a network for communication between MySQL and Django containers:

docker network create todo-network


## MySQL

Build MySQL image:

docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .

Create volume:

docker volume create mysql_data

Run MySQL container with volume attached:

docker run -d --name mysql-todo --network todo-network -v mysql_data:/var/lib/mysql mysql-local:1.0.0

Check that MySQL container is running:

docker ps

Check MySQL logs:

docker logs mysql-todo


## Application

Build application image:

docker build -t todoapp:2.0.0 .

Run application container:

docker run -d --name todoapp --network todo-network -e DB_HOST=mysql-todo -e DB_PORT=3306 -p 8080:8080 todoapp:2.0.0

Run database migrations:

docker exec todoapp python manage.py migrate

Check application logs:

docker logs todoapp


## Browser

Open the application in a browser:

http://localhost:8080

API:

http://localhost:8080/api/


## Push MySQL Image to Docker Hub

Tag MySQL image:

docker tag mysql-local:1.0.0 khrystyna079/mysql-local:1.0.0

Push MySQL image:

docker push khrystyna079/mysql-local:1.0.0

MySQL Docker Hub repository:

https://hub.docker.com/r/khrystyna079/mysql-local


## Push Application Image to Docker Hub

Tag application image:

docker tag todoapp:2.0.0 khrystyna079/todoapp:2.0.0

Push application image:

docker push khrystyna079/todoapp:2.0.0

Application Docker Hub repository:

https://hub.docker.com/r/khrystyna079/todoapp


## Run Images from Docker Hub

Pull MySQL image:

docker pull khrystyna079/mysql-local:1.0.0

Pull application image:

docker pull khrystyna079/todoapp:2.0.0

Create Docker network:

docker network create todo-network

Create MySQL volume:

docker volume create mysql_data

Run MySQL container:

docker run -d --name mysql-todo --network todo-network -v mysql_data:/var/lib/mysql khrystyna079/mysql-local:1.0.0

Run application container:

docker run -d --name todoapp --network todo-network -e DB_HOST=mysql-todo -e DB_PORT=3306 -p 8080:8080 khrystyna079/todoapp:2.0.0

Run database migrations:

docker exec todoapp python manage.py migrate

Open the application in a browser:

http://localhost:8080

Open API:

http://localhost:8080/api/


## Stop Containers

docker stop todoapp mysql-todo


## Remove Containers

docker rm todoapp mysql-todo