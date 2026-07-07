1. How to run MySQL container with a volume attached.

docker run -d -p 3306:3306 --name mysql-local -v mysql-data:/var/lib/mysql mysql-local:1.0.0

2. How to run an App container which will connect to a MySQL db container.

docker run -d -p 8080:8080 --name todoapp todolist_mysql:1.0

3. Link to my personal docker hub repository win an app image.

https://hub.docker.com/repository/docker/hrechukhao/todoapp/general

4. How to access the application via a browser.

http://localhost:8080/

5. Screenshot of a terminal with a successfully started application.

https://snipboard.io/cGHTvy.jpg