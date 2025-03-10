# Django TodoApp List Instruction

## Docker Hub Repository
You can find the pre-built Docker images of the application in my Docker Hub repository:

[Docker Hub Repository (mysql)](https://hub.docker.com/repository/docker/volodymyrdv/mysql-local/general)

[Docker Hub Repository (app)](https://hub.docker.com/repository/docker/volodymyrdv/todoapp/general)
___
## Running the Containers

### Run the Mysql Docker Container
After downloading the MySQL image from Docker Hub, you can start the container with the command:
```
docker run -p 3306:3306 -d -v mysql-data:/var/lib/mysql volodymyrdv/mysql-local:1.0.0
```
### Run the App Docker Container
To run the web application, use the following command:
```
docker run -p 8080:8080 -d volodymyrdv/todoapp:2.0.0
```
## Accessing the Application
Once the containers is running, open a web browser and go to:
```
http://localhost:8080
```