## 1. Build and Push MySQL Image

Build the MySQL image using your custom `Dockerfile.mysql` (with capital "D"):

docker build -f Dockerfile.mysql -t demon9709/mysql-local:1.0.0 .
docker push demon9709/mysql-local:1.0.0

---

## 2. Build and Push Django Application Image

Build the Django application image and push it with the required name and tag:

docker build -t demon9709/todoapp:2.0.0 .
docker push demon9709/todoapp:2.0.0

---

## 3. Run MySQL Container with Volume

Create a Docker volume and run the MySQL container with persistent data storage:

docker volume create mysql_data

docker run -d
--name mysql-local
-e MYSQL_ROOT_PASSWORD=1234
-e MYSQL_DATABASE=app_db
-e MYSQL_USER=app_user
-e MYSQL_PASSWORD=1234
-v mysql_data:/var/lib/mysql
-p 3306:3306
demon9709/mysql-local:1.0.0

---

## 4. Run Django Application Container Connected to MySQL

Ensure the MySQL container (`mysql-local`) is running, then start the application container:

docker run -d
--name todoapp
--link mysql-local:mysql
-e DB_HOST=mysql-local
-e DB_USER=app_user
-e DB_PASSWORD=1234
-e DB_NAME=app_db
-p 8080:8080
demon9709/todoapp:2.0.0

The app listens on port 8080.

---

## 5. Access the Application via Browser

Open your web browser and navigate to:

http://localhost:8080

You should see the Django application homepage.

---

## 6. Docker Hub Repository Links

- MySQL custom image:  
  https://hub.docker.com/repository/docker/demon9709/mysql-local/tags/1.0.0/sha256-5d7d1891f1f816e24ca3064f147589dbf9146ff159333dc2bff50d4edd962c23

- Django app image:  
  https://hub.docker.com/repository/docker/demon9709/todoapp/tags/2.0.0/sha256-63508d9ec3e6d8adefd585b217466a07b3885a42a6bcc0aff71298af5cb9660d

---

## 7. Screenshot

You can view the screenshot here:  
https://take.ms/K9Fmi

---

Follow these steps sequentially to build, push, run, and verify your MySQL and Django application containers as per the assignment requirements.