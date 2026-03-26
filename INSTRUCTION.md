## link to repository:
https://hub.docker.com/repository/docker/andriis9/todoapp/general

## Running MySQL container:
1. Pull image andriis9/mysql-local:1.0.0
2. Run command:
    ````
   docker run -d -p 3306:3306 --name mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
   ````

## Running App container:
1. Pull image andriis9/todoapp:2.0.0
2. Run command:
    ````
   docker run -d -p 8080:8080 todoapp:2.0.0
   ````

## To access the app:
````
http://localhost:8080
````
   
