# How to run MySQL container with a volume attached:
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0 

docker run -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0

# How to run an App container which will connect to a MySQL db container:
docker network list

docker network inspect bridge
Searcing for our container and copy the ip to the 'HOST': '172.17.0.2'

docker build -t svyat2x/todoapp:2.0.0 -t todoapp .
docker push svyat2x/todoapp:2.0.0
Запуск: docker run -p 8080:8080 svyat2x/todoapp:2.0.0

docker ps

# Link to the Dockerhub:
https://hub.docker.com/r/svyat2x/todoapp/tags?name=2.0.0

# How to access the application via a browser:
http://localhost:8000 
http://localhost:8000/api/ 