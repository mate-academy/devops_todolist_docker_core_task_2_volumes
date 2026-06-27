## how to run MySQL container with a volume attached
docker run -d --name mysql-db -v mysql-data:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0

## how to run an App container which will connect to a MySQL db container.
docker run -d -p 8000:8000 --name django-app --link mysql-db -e DB_HOST=mysql-db todoapp:2.0.0


## how to access the application via a browser

http://localhost:8000/

https://hub.docker.com/repository/docker/margarita8454/todoapp/general

