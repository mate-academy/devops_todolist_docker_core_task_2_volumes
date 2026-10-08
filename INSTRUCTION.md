https://hub.docker.com/repository/docker/milokc/todoapp was updated to todoapp:2.0.0

To run MySQL container with a volume attached:
docker run -d -p 3306:3306 --name mysql -v todolist-db:/var/lib/mysql milokc/mysql-local:1.0.0

To run app container:
docker run -p 8080:8080 milokc/todoapp:2.0.0

To access app use link below: http://localhost:8080/

PS:
To avoid IP address missmatch you can run mysql container with:
# Create the network if not created
docker network create --subnet=172.17.0.0/16 mynetwork
# Run mysql server with special IP:
docker run -d --name mysql --network mynetwork --ip 172.17.0.2 mysql-local:1.0.0
