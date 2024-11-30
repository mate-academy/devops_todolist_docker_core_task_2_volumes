To run the application:

1. Start the database MySQL image container
docker pull niklafinskiy/mysql-local:1.0.0
docker run -d --name mysql-db -p 3306:3306 -v mysql-data:/var/lib/mysql niklafinskiy/mysql-local:1.0.0

2. Start the application server connected to the MySQL DB container:
docker pull niklafinskiy/todoapp:2.0.0
docker run -d --name todoapp -p 8080:8080 niklafinskiy/todoapp:2.0.0 

The application is going to be accessible at http://localhost:8080

Links to the dockerhub repositories containing the images:
https://hub.docker.com/r/niklafinskiy/todoapp
https://hub.docker.com/r/niklafinskiy/mysql-local
