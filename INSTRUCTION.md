# Todo App — Docker Instructions
 
## Docker Hub
 
The Docker images are available on my personal Docker Hub repository.
 
- **MySQL image:** `sangooooo/mysql-local:1.0.0` — https://hub.docker.com/r/sangooooo/mysql-local
- **Application image:** `sangooooo/todoapp:2.0.0` — https://hub.docker.com/r/sangooooo/todoapp
---
 
## 1. Pull the MySQL Image
 
Pull the prepared MySQL image from Docker Hub:
 
```bash
docker pull sangooooo/mysql-local:1.0.0
```
 
Verify that the image was downloaded:
 
```bash
docker images
```
 
---
 
## 2. Run MySQL Container
 
Create a Docker volume for MySQL data:
 
```bash
docker volume create mysql-data
```
 
Run the MySQL container with the volume attached:
 
```bash
docker run -d \
  --name mysql-local \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  sangooooo/mysql-local:1.0.0
```
 
Check that the MySQL container is running:
 
```bash
docker ps
```
 
Check MySQL container logs:
 
```bash
docker logs mysql-local
```
 
---
 
## 3. Get MySQL Container IP Address
 
Get the IP address of the running MySQL container:
 
```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local
```
 
Example output:
 
```text
172.17.0.2
```
 
Use this IP address as the MySQL database host in the application's database configuration.
 
---
 
## 4. Build the Application Image
 
Build the application image:
 
```bash
docker build -t todoapp:2.0.0 .
```
 
Verify that the image was created:
 
```bash
docker images
```
 
---
 
## 5. Run the Application Container
 
Run the application container:
 
```bash
docker run -d \
  --name todoapp \
  -p 8080:8080 \
  todoapp:2.0.0
```
 
Check that the application container is running:
 
```bash
docker ps
```
 
Check application logs:
 
```bash
docker logs todoapp
```
 
The application should start successfully and connect to the MySQL database.
 
---
 
## 6. Access the Application
 
Open the application in a web browser:
 
```text
http://localhost:8080
```
 
If the application uses the `/todolist/1/` endpoint, open:
 
```text
http://localhost:8080/todolist/1/
```
 
---
 
## 7. Docker Hub
 
The application image is available on Docker Hub:
 
```text
sangooooo/todoapp:2.0.0
```
 
Pull it with:
 
```bash
docker pull sangooooo/todoapp:2.0.0
```
 
Docker Hub repositories:
 
- https://hub.docker.com/r/sangooooo/todoapp
- https://hub.docker.com/r/sangooooo/mysql-local