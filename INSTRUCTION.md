how to run MySQL container with a volume attached
docker run -d -p 3306:3306 --name mysql-local \
-e MYSQL_ROOT_PASSWORD=1234 \
-e MYSQL_USER=app_user \
-e MYSQL_PASSWORD=1234 \
-e MYSQL_DATABASE=app_db \
-v mysql-volume:/var/lib/mysql \
mysql-local:1.0.0

how to run an App container connected to a MySQL db container
docker run -d -p 8081:8080 --name todoapp todoapp:2.0.0

link to docker hub repository with an app image
https://hub.docker.com/repository/docker/deadmarvald/todoapp

access the application via a browser
http://localhost:8081/
