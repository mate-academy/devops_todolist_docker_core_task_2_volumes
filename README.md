# For using todo application with database please follow instruction below:

# Build new image for MYsql dataBase by executing
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
# Run container with this image in your local machine
docker run -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
# Build new image for MYsql dataBase by executing
docker build . -t todoapp:2.0.0
# Run container with this image in your local machine
docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0
# Use different port, if 8080 in use:
docker run -d -p *port_you_need*:8080 --name todoapp todoapp:2.0.0
# You can use todo-application on:
http://0.0.0.0:8080/
# You download docker images from:
https://hub.docker.com/layers/ikruglyak/todoapp/2.0.0/images/sha256-3fec1c9d29e9e33c9a2b7f8d98efeac0be9c0f60dd3923de11a13736a7e502bc?context=repo
https://hub.docker.com/repository/docker/ikruglyak/mysql-local/general
