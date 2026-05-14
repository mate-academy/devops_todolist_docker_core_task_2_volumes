# Todo Application

## Pull MySQL image

docker pull grom201/mysql-local:1.0.0

---

## Create Docker Volume

docker volume create mysql_data

---

## Run MySQL Container

docker run -d \
--name mysql-container \
-p 3306:3306 \
-v mysql_data:/var/lib/mysql \
grom201/mysql-local:1.0.0

---

## Run Application Container

docker run -d \
--name todoapp-container \
-p 5000:5000 \
grom201/todoapp:2.0.0

---

## Docker Hub Repository

https://hub.docker.com/r/YOUR_DOCKERHUB_USERNAME/todoapp

---

## Access Application

Open browser:

http://localhost:5000