how to run MySQL container with a volume attached
docker run  -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0

how to run an App container which will connect to a MySQL db container.
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
docker tag mysql-local:1.0.0 alyonatym/mysql-local:1.0.0
docker push alyonatym/mysql-local:1.0.0
docker build . -t todoapp:2.0.0
docker run -p 8080:8080 --name app todoapp:2.0.0

links
https://hub.docker.com/repository/docker/alyonatym/todoapp2/general
https://hub.docker.com/repository/docker/alyonatym/mysql-local/general

how to access the application via a browser
http://localhost:8080/