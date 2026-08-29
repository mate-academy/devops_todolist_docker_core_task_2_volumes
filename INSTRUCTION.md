Use the following links below:

1. Link to the Docker Hub repository with an app image:
    https://hub.docker.com/repository/docker/nosenkoalena501/todoapp/general

2. All instructions for building image and running the container:
    - for build "mysql" image from the Dockerfile
        docker build . -t mysql-local:1.0.0 -f Dockerfile.mysql
    - for running MySQL container with a volume attached:
        docker run  -d -p 3306:3306 --name olena-mysql -v olena-mysql-data:/var/lib/mysql mysql-local:1.0.0
    - for build "app" image
        docker build . -t todoapp:2.0.0
    - for running an App container which will connect to a MySQL db container:
        docker run -p 8083:8080 --name app todoapp:2.0.0


3. Instructions on accessing the application via a browser:
   - API:
    http://localhost:8083/api/
   - Landing page:
    http://localhost:8083/