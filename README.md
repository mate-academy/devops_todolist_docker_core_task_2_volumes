## Running the MySQL Container
To run the MySQL container with the required environment variables and a volume attached, execute:

docker run -d -p 3306:3306 --name mysql-local -v mysql_data:/var/lib/mysql okochubei/mysql-local:1.0.0

## Running the Django Application Container
To run the Django application container which will connect to the MySQL container, execute:

docker run -d -p 8081:8080 --name todoapp --link mysql-local:mysql-local okochubei/todoapp:2.0.0

## Accessing the Application
Once both containers are running, you can access the application via a browser at:
[http://localhost:8081](http://127.0.0.1:8081)

## Docker Hub Repositories
- MySQL Image: [okochubei/mysql-local](https://hub.docker.com/r/okochubei/mysql-local)
- Django Application Image: [okochubei/todoapp](https://hub.docker.com/r/okochubei/todoapp)
