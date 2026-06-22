link to the [dockerhub repo](https://hub.docker.com/repository/docker/alexey211204/todoapp/general)

running container with database from the image mysql-local:1.0.0
```bash
docker run -d -p 3306:3306 --name mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0   
```
runnung docker container from the image  
```bash
docker run -p 8080:8080 todoapp:2.0.0
```

Open http://localhost:8080/ in your browser