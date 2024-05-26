### Run mysql container
    docker run --name mysql-container -p 3306:3306 -v mysql:/var/lib/mysql dkrusr2001/mysql-local:1.0.0

### Run app container
    docker run --name todo-container -p 8080:8080 dkrusr2001/todoapp:2.0.0

Visit http://localhost:8080/

---
Dockerhub:
 * [DB](https://hub.docker.com/repository/docker/dkrusr2001/mysql-local/general)
 * [App](https://hub.docker.com/repository/docker/dkrusr2001/todoapp/general)
