# MySQL container run with a volume attached
docker network create app-net
docker run -d -p 3306:3306 --name mysql-local -v mysql-data:/var/lib/mysql --network app-net mysql-local:1.0.0
# App run
docker run -d -p 8080:8080 --name app-local --network app-net kulakovmaksym/todoapp:2.0.0
 # Link for docker hub app image
https://hub.docker.com/r/kulakovmaksym/todoapp
 # Get app
http://localhost:8080/

