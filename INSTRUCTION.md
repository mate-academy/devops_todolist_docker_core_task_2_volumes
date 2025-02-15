# Link to the DockerHub repository: 
```
https://hub.docker.com/repository/docker/narberal90/todoapp/tags/2.0.0/sha256-fd4a2465b4e0a2cfe4e231fff9ab9e23ad69beb8ec83fe92d6ea13a4db879000
```


1. Clone the repository:
```
git clone https://github.com/Narberal90/devops_todolist_docker_core_task_2_volumes.git
```
Navigate to the project folder:
```
cd devops_todolist_docker_core_task_2_volumes
```

2. Create the SQL container:
```
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql . 
```
Make sure to include the dot at the end of the command.

3.5. Update the .env file:
In the project folder, you should see an example .env.example file. Copy the contents of this file to create a new .env file (if it doesn't already exist) 
Run the MySQL server:
```
docker run --env-file .env -d -p 3306:3306 --name sql mysql-local:1.0.0
```

4. Find the `IPv4Address` of the container:
Use the following command:
```
docker network inspect bridge
```

Add the DB_HOST variable to the .env file, and paste the copied IPv4Address into it.
The address for the container named `sql`.


6. Build the todoapp:2.0.0 image, create a container, and run it:
```
docker build -t todoapp:2.0.0 -f Dockerfile .
docker run -d --name api -p 8080:8080 todoapp:2.0.0
```

7. Access the server:
Now, the server is available at [http://127.0.0.1:8080/](http://127.0.0.1:8080/)