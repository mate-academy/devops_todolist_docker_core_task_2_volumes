## To run the MySQL container with a volume attached, use the following command

### Build
    docker build -f Dockerfile.mysql -t mysql-local:1.0.0
### Run
    docker run -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0

## To run the app container that connects to the MySQL database container:

### Build

    docker build . -t todoapp:2.0.0
### Run

    docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0`

### To access locally go to http://localhost:8080 in browser.
### Docker hub repos:
* [todoapp](https://hub.docker.com/repository/docker/poznianski/todoapp)
* [mysql-local](https://hub.docker.com/repository/docker/poznianski/mysql-local)
