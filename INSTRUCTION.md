## docker hub 
MySQL: https://hub.docker.com/r/storozhuk21/mysql-local
Django App: https://hub.docker.com/r/storozhuk21/todoapp


## instructions on how to run MySQL container with a volume attached
docker run -d -v mysql-data:/var/lib/mysql storozhuk21/mysql-local:1.0.0


##  instructions on how to run an App container which will connect to a MySQL db container
docker run -d -p 8000:8080 storozhuk21/todoapp:2.0.0


## docker hub repository 
https://hub.docker.com/r/storozhuk21/todoapp


##  instructions on how to access the application via a browser
http://localhost:8080