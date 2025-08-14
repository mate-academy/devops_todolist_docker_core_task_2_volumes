# How to Run MySQL Container with a Volume Attached
1. Create a Docker Network
To allow the application and the MySQL database to communicate using the container name instead of an IP address, first create a shared network:

bash
docker network create todo-net

2. Run the MySQL Container on This Network
Add the --network todo-net option when starting MySQL:

bash
docker run --name mysql-container -d -p 3306:3306 -v my-sql-data:/var/lib/mysql --network todo-net mysql-local:1.0.0

3. Run the Application Container on the Same Network
Similarly, connect the application container to the same todo-net network:

bash
docker run -d --name app -p 8080:8080 -network todo-net todoapp:2.0.0

# How to run an App container which will connect to a MySQL db container
1. Find MySQL container IP:
docker inspect mysql-container | grep "IPAddress"
2. Update settings.py to Use the MySQL Container Name
In your application’s settings.py, locate the database configuration section and set the HOST parameter to the MySQL container’s name.
For example:
python
HOST = 'mysql-container'
This ensures that when both the MySQL and application containers are on the same Docker network (e.g., todo-net), the application will connect to MySQL using the container name.
3.  Run the Application Container
Run the application attached to the same network so it can reach the MySQL container:
bash
docker run -d --name app -p 8080:8080 --network todo-net todoapp:2.0.0
ccess the Application
Once the container is running, open your browser and go to:
http://localhost:8080

# Docker hub 
https://hub.docker.com/repository/docker/vitaliiog/todoapp/tags/2.0.0/sha256-a83a78057ba8c72210878d9e73df3c0509f839a626664692d04b0eadaad5dca8
https://hub.docker.com/repository/docker/vitaliiog/mysql-local/tags/1.0.0/sha256-5d7d1891f1f816e24ca3064f147589dbf9146ff159333dc2bff50d4edd962c23

# How to access the application via a browser
Main App: http://localhost:8080
API: http://localhost:8080/api/