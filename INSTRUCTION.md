## docker hub 
MySQL: https://hub.docker.com/r/storozhuk21/mysql-local
Django App: https://hub.docker.com/r/storozhuk21/todoapp


## instructions on how to run MySQL container with a volume attached
docker run -d --name mysql-container -v mysql-data:/var/lib/mysql -e MYSQL_DATABASE=app_db -e MYSQL_USER=app_user -e MYSQL_PASSWORD=1234 -e MYSQL_ROOT_PASSWORD=12345 storozhuk21/mysql-local:1.0.0


##  instructions on how to run an App container which will connect to a MySQL db container
docker run -d --name todo-container --network bridge -p 8000:8080 storozhuk21/todoapp:2.0.0


## docker hub repository 
https://hub.docker.com/r/storozhuk21/todoapp


##  instructions on how to access the application via a browser
http://localhost:8000