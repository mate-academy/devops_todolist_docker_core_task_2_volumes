## Running the MySQL Container
To run the MySQL container with the required environment variables and a volume attached, execute:
```bash
docker run -d -p 3306:3306 --name mysql-container -v mysql_data:/var/lib/mysql shu418/mysql-local:1.0.0
```
## Running the Django Application Container
To run the Django application container which will connect to the MySQL container, execute:
```bash
docker run -d -p 8081:8080 --name todoapp-container --link mysql-container:mysql-local shu418/todoapp:2.0.0
```
## Accessing the Application
Once both containers are running, you can access the application via a browser at:
[http://localhost:8081](http://127.0.0.1:8081)

## Docker Hub Repositories
- MySQL Image: [shu418/mysql-local](https://hub.docker.com/r/shu418/mysql-local)
- Django Application Image: [shu418/todoapp](https://hub.docker.com/r/shu418/todoapp)
