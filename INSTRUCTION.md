## docker hub 
MySQL: https://hub.docker.com/r/storozhuk21/mysql-local
Django App: https://hub.docker.com/r/storozhuk21/todoapp


## instructions on how to run MySQL container with a volume attached
docker run -v mysql-data


##  instructions on how to run an App container which will connect to a MySQL db container
docker run -v mysql_data:/var/lib/mysql mysql-local:1.0.0   


## docker hub repository 
https://hub.docker.com/r/storozhuk21/todoapp


##  instructions on how to access the application via a browser
http://localhost:8080