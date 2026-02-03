# Running the MySQL Container

1. Build the MySQL Docker image:
   docker build -f Dockerfile.mysql -t nnnikol/mysql-local:1.0.0 .

2.  Create a network, for example: docker network create todo-network

3. Run the MySQL container with a volume attached:
   docker run -d --name mysql-container -p 3306:3306 -v mysql-data:/var/lib/mysql --network todo-network nnnikol/mysql-local:1.0.0

# Running the App Container

1. Build the application Docker image:
   docker build -t nnnikol/todoapp:2.0.0 .

2. Run the application container:
   docker run -d --name todoapp-container -p 8080:8080 nnnikol/todoapp:2.0.0

# Accessing the App

1. Open your browser and navigate to: http://localhost:8080

# Docker Hub Repositories

- MySQL Image: https://hub.docker.com/r/nnnikol/mysql-local
- Application Image: https://hub.docker.com/r/nnnikol/todoapp
