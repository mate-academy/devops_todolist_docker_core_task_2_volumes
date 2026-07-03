ToDo App Docker Instructions

MySQL image:
https://hub.docker.com/r/loki007777/mysql-local

Build image
docker build -f Dockerfile.mysql -t loki007777/mysql-local:1.0.0 .
Run container
docker run -d -p 8081:3306 -v mysqlvolume:/var/lib/mysql loki007777/mysql-local:1.0.0
Push image to Docker Hub
docker push loki007777/mysql-local:1.0.0

Before starting the app container, the MySQL container must already be running 
and settings.py must contain the IP of the MySQL container.

App image:
https://hub.docker.com/r/loki007777/todoapp

Build image
docker build -t loki007777/todoapp:2.0.0 .
Run container
docker run -p 8080:8080 loki007777/todoapp:2.0.0
Push image to Docker Hub
docker push loki007777/todoapp:2.0.0


Open application
Open the application in your browser: http://localhost:8080