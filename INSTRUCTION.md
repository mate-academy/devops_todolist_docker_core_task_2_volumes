To run MySQL container with a volume attached use command: 
    docker run --name my-sql -d -p 3306:3306 -v my-sql-data:/var/lib/mysql mysql-local:1.0.0

To run an App container which will connect to a MySQL db container use command:
    docker run -p 8080:8080 --name new-todoapp todoapp:2.0.0 

Repository link:
    https://hub.docker.com/repository/docker/eug696/todoapp/tags

To access the application via a browser, go to link:
    http://localhost:8080/