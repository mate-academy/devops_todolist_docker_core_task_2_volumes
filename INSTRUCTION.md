Running MySQL and Django Todo App Containers

1. Running MySQL Container with a Volume

1.1 Build and Push MySQL Image

Create a Dockerfile.mysql with the following content:

FROM mysql:latest
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=app_db
ENV MYSQL_USER=app_user
ENV MYSQL_PASSWORD=1234
EXPOSE 3306
VOLUME /var/lib/mysql

Build and push the image:

docker build -t maxisky2595/mysql-local:1.0.0 -f Dockerfile.mysql .
docker push maxisky2595/mysql-local:1.0.0

1.2 Run MySQL Container with Volume

docker run -d --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  maxisky2595/mysql-local:1.0.0

Find the container's IP:

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-container

Update todolist/settings.py with this IP under DATABASES['default']['HOST'].

2. Running the Todo App Container

2.1 Build and Push the App Image

Create a Dockerfile:

FROM python:3.8
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
EXPOSE 8080

Build and push the image:

docker build -t maxisky2595/todoapp:2.0.0 .
docker push maxisky2595/todoapp:2.0.0

2.2 Run the Todo App Container

docker run -d --name todoapp-container \
  --env-file .env \
  -p 8080:8080 \
  --network bridge \
  maxisky2595/todoapp:2.0.0

3. Access the Application

Open a browser and go to:

http://localhost:8080

4. Docker Hub Repository Links

MySQL Image: maxisky2595/mysql-local

App Image: maxisky2595/todoapp

