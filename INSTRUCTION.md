# Instructions to Run Application and MySQL Database

## 1. Run MySQL Container with Volume
To run the MySQL container with a persistent volume, execute:
```
docker run -d \
  --name mysql-container \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  <your_dockerhub_username>/mysql-local:1.0.0
```

## 2. Run App Container

To run the Django application container linked to the database:
```
docker run -d \
  -p 8080:8080 \
  --name todoapp-container \
  <your_dockerhub_username>/todoapp:2.0.0
```
## 3. Docker Hub Repository Link

App Image Link: https://hub.docker.com/r/gradman/todoapp

## 4. Access Application via Browser

Once the container is running, open your web browser and go to:
http://localhost:8080/
