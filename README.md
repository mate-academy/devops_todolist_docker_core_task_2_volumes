
# TODOLIST:2.0.0 INFO
# GET APPLICATION FROM DOCKERHUB

MYSQL IMAGE: https://hub.docker.com/repository/docker/efirshey/mysql-local/general
APPLICATION IMAGE: https://hub.docker.com/repository/docker/efirshey/todoapp/general

# START COUNTEINERS

1. docker volume create mysql-data
2. docker run -d -p 3306:3306 --name mysql -v mysql-data:/var/lib/mysql mysql-local:1.0.0
3. docker run -d -p 8080:8080 --name todo.app todoapp:2.0.0

# EXPLORE IN BROWSER
http://127.0.0.1:8080