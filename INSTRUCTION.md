How to run MySQL container with a volume attached:
docker run -d -v mysqldata:/var/lib/mysql -p 3306:3306 --name mysql-container mysql-local:1.0.0

How to run an App container which will connect to a MySQL db container:
docker run -p 8000:8000 todoapp:2.0.0

Link to my personal docker hub repository with an todoapp image:
https://hub.docker.com/repository/docker/nook17n1/todoapp

How to access the application via a browser:
http://localhost:8000/