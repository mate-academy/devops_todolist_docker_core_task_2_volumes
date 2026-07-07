1. How to run MySQL container with a volume attached.

docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
docker run -d -p 3306:3306 --name mysql-local -v mysql-data:/var/lib/mysql mysql-local:1.0.0

2. How to push MySQL image to Docker Hub

docker tag mysql-local:1.0.0 hrechukhao/mysql-local:1.0.0
docker push hrechukhao/mysql-local:1.0.0 

3. How to run an App container which will connect to a MySQL db container.

docker build . -f Dockerfile -t todoapp:2.0.0 
docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0

4. How to push todoapp image to Docker Hub

docker tag todoapp:2.0.0 hrechukhao/todoapp:2.0.0
docker push hrechukhao/todoapp:2.0.0

5. Link to my personal Docker Hub repository with an MySQL image.

https://hub.docker.com/repository/docker/hrechukhao/mysql-local/general

6. Link to my personal Docker Hub repository with an todoapp image.

https://hub.docker.com/repository/docker/hrechukhao/todoapp/general

7. How to access the application via a browser.

http://localhost:8080/

8. Screenshot of a terminal with a successfully started application.

https://snipboard.io/aMTvKo.jpg