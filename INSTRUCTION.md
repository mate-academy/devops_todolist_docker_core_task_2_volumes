# Django TodoList Application (Dockerized)

This project contains a Dockerized Django TodoList application connected to a MySQL database.

---

## Docker Hub Repositories

MySQL Image:
https://hub.docker.com/r/petliuk/mysql-local

Todo Application Image:
https://hub.docker.com/r/petliuk/todoapp

---

# 1️⃣ Run MySQL Container with Volume

Create a volume:

docker volume create mysql-data

Run MySQL container:

docker run -d \
  --name mysql-local \
  -p 3306:3306 \
  --network todonetwork \
  -v mysql-data:/var/lib/mysql \
  petliuk/mysql-local:1.0.0

---

# 2️⃣ Run Application Container

Run Django application container:

docker run -d \
  --name todoapp \
  -p 8080:8080 \
  --network todonetwork \
  petliuk/todoapp:2.0.0

---

# 3️⃣ Access the Application

Open your browser and go to:

http://localhost:8080

The application should be running and connected to the MySQL database.

---

# 4️⃣ Verify Running Containers

Check running containers:

docker ps

Check logs:

docker logs todoapp