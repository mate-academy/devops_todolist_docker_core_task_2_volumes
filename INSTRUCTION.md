# TodoApp & MySQL Docker Setup

## 1. MySQL Docker Image
Docker Hub: https://hub.docker.com/r/vovakomar/mysql-local

### Build the MySQL image locally
`docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .`

### Tag the image for Docker Hub
`docker tag mysql-local:1.0.0 vovakomar/mysql-local:1.0.0`

### Log in to Docker Hub
`docker login`

### Push the image to Docker Hub
`docker push vovakomar/mysql-local:1.0.0`

### Create a Docker volume for persistent MySQL data
`docker volume create mysql_data`

### Create a user-defined bridge network
`docker network create todonet`

### Run MySQL container with volume and network
`docker run -d --name mysql-local --network todonet -v mysql_data:/var/lib/mysql vovakomar/mysql-local:1.0.0`

### Check MySQL logs
`docker logs mysql-local`

## 2. TodoApp Docker Image
Docker Hub: https://hub.docker.com/r/vovakomar/todoapp

### Build the TodoApp image locally
`docker build -t todoapp:2.0.0 -f Dockerfile.django .`

### Tag the image for Docker Hub
`docker tag todoapp:2.0.0 vovakomar/todoapp:2.0.0`

### Log in to Docker Hub (if not already)
`docker login`

### Push the TodoApp image to Docker Hub 
`docker push vovakomar/todoapp:2.0.0`

### Run the TodoApp container connected to MySQL network
`docker run -d --name todoapp --network todonet -p 8000:8000 vovakomar/todoapp:2.0.0`

## 3. Access Application
http://localhost:8000
> The Django server runs inside the container on 0.0.0.0:8000, mapped to host port 8000.

## 4. Migrations
Run migrations inside the container if not done during build
`docker exec -it todoapp python manage.py migrate`

## 5. Notes
- Both containers must be in the same Docker network `todonet`
- MySQL data persists thanks to the `mysql_data` volume

