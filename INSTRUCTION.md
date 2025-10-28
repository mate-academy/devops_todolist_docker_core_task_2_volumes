This is an instruction for running MySql-container and Django app.
For running MySql container with volume attached you need:
1. - docker build -f Dockerfile.mysql -t <tag> . 
2. - docker run -d --name <name> -p 3306:3306 -v mysql-data:/var/lib/mysql <tag>
How to run an App container which will connect to a MySQL db container:
We should find ip of container with MySql:
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <name>
After this update the Python app db config with an IP of a running MySQL server container (todolist/settings.py, line 70, write your own IP instead 172.17.0.2)
Build image with updated settings.py:
docker build -f <app_name> -t <app_tag> . 
Now lets run container:
docker run -d --name <container_name> -p 8000:8080 <app_tag>
After this you will have acces to app by the ports that you gaive in the previus command:
http://localhost:8000/
Link to the DockerHub:
https://hub.docker.com/repository/docker/nizartem/todoapp/tags