## run MySQL container with a volume attached:

docker run -d \
  --name mysql-container \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0

## run an App container which will connect to a MySQL db container:

docker run -d --name todoapp-container -p 8000:8000 todoapp:2.0.0

## link to my personal docker hub repository win an app image:

https://hub.docker.com/repository/docker/konstant1nou77/mysql-local/
docker pull konstant1nou77/mysql-local:1.0.0

https://hub.docker.com/repository/docker/konstant1nou77/todoapp/
docker pull konstant1nou77/todoapp:2.0.0


##  how to access the application via a browser:

Open your browser and go to http://localhost:8080
