## how to run MySQL container with a volume attached

# Create network first, it would be needed later
docker network create my-app-network
# if builded and run locally
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
docker run -d --network my-app-network -p 3306:3306 -v mysql-dev:/var/lib/mysql --name my-sql-server mysql-local:1.0.0

# remote run
docker run -d --network my-app-network -p 3306:3306 -v mysql-dev:/var/lib/mysql --name my-sql-server sydor101/mysql-local:1.0.0

## how to run an App container which will connect to a MySQL db container
# local run
docker build -t todoapp:2.0.0 .
docker run -d --network my-app-network -p 8080:8080 --name todoapp todoapp:2.0.0
# remote run
docker run -d --network my-app-network -p 8080:8080 --name todoapp sydor101/todoapp:2.0.0

## link to the personal docker hub repository with an app image
https://hub.docker.com/r/sydor101/todoapp
## how to access the application via a browser
localhost:8080
