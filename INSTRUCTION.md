1. Running the MySQL Container with a Volume Attached

Step 1: Build the MySQL Image

docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .

Step 2: Run the MySQL Container

docker run -d \
 --name mysql-container \
 -e MYSQL_DATABASE=app_db \
 -e MYSQL_USER=app_user \
 -e MYSQL_PASSWORD=1234 \
 -e MYSQL_ROOT_PASSWORD=rootpassword \
 -v mysql_data:/var/lib/mysql \
 -p 3306:3306 \
 mysql-local:1.0.0

2. Running the App Container Connected to the MySQL DB Container

Step 1: Build the App Image

docker build -t todoapp:2.0.0 .

Step 2: Run the App Container

docker run -d \
 --name todoapp-container \
 --link mysql-container:mysql \
 -p 8080:8080 \
 todoapp:2.0.0

3. Accessing the Application via a Browser

Open your browser
Go to: http://localhost:8080

If running on a remote server, replace localhost with the server's IP address.

4. Docker Hub Repository

You can find the app image in my Docker Hub repository:

https://hub.docker.com/r/kov280396/todoapp
