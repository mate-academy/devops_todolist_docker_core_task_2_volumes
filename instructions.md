Deployment Instructions for MySQL & Todo App Containers
1. Running the MySQL Container with a Volume Attached
Step 1: Pull the MySQL Image
Before running the MySQL container, pull the image from Docker Hub:
docker pull miamarichka/mysql-local:1.0.0

Step 2: Run MySQL Container
Run the MySQL container with persistent storage (volume attached):
docker run -d --name mysql_container \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -e MYSQL_ROOT_PASSWORD=root \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  miamarichka/mysql-local:1.0.0

Step 3: Verify MySQL is Running
To check if the container is running, use:
docker ps
To check the MySQL container logs:
docker logs mysql_container
To enter the MySQL shell inside the container:
docker exec -it mysql_container mysql -u app_user -p(1234)



2. Running the Todo App Container (Connected to MySQL)
Step 1: Pull the App Image
Pull the latest version of the Todo App from Docker Hub:
docker pull miamarichka/todoapp:2.0.0

Step 2: Run the App Container
Run the app container and link it to the MySQL container:
docker run -d --name todoapp_container \
  --link mysql_container:mysql \
  -p 8080:8080 \
  miamarichka/todoapp:2.0.0

Step 3: Verify the Application is Running
Check if the container is running:
docker ps
Check logs for any errors:
docker logs todoapp_container



3. Accessing the Application
Once the app is running, open your browser and go to:
http://localhost:8080
If everything is set up correctly, you should see the Todo App UI.



4. Troubleshooting
Check if MySQL is Running
docker ps
If MySQL is not running, start it:
docker start mysql_container
Check if App is Running
docker ps
If the app is not running, start it:
docker start todoapp_container



5. Stopping & Removing Containers
To stop both containers:
docker stop todoapp_container mysql_container
To remove both containers:
docker rm todoapp_container mysql_container
To remove the volume (WARNING: This deletes all database data!):
docker volume rm mysql_data



6. Docker Hub Repository Links
MySQL Image: https://hub.docker.com/r/miamarichka/mysql-local
App Image: https://hub.docker.com/r/miamarichka/todoapp

