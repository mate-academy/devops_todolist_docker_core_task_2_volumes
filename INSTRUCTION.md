## Instructions for launch "Todo App"

Here is link to: [Docker Hub Repository](https://hub.docker.com/repository/docker/mykytakovalenko/todoapp/general)
## Clone the repository
````bash
git clone https://github.com/betterthink/devops_todolist.git
````
## Run MySql container
### 1. Build image from Dockerfile
````bash
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
````
### 2. Run container from image with volume 
````bash
docker run -d -p 3306:3306 --name mysql -v my-mysql-data:/var/lib/mysql mysql:1.0.0 
````
## Running app with which connect to MySQL db container
### 1. Finding ip of container 
Run this command to find ip of container with MySQL db
```bash
docker network inspect bridge
```
Find Container with "Name": "_your name of container_" and copy his IPv4Address
It looks like that:
````       
"Containers": {
            "37000a4f380fc073a8170d5368ae5b6ca74399782c205a57cfcb2ade442f4667": {
                "Name": "mysql",
                "EndpointID": "e743b04f270a72822a1554ca5fc470250062bb3b7297e895f4b20bf4f6ababc4",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            },
````
## 2. Updating settings.py
Go to line 70 and update value of 'HOST' with ip from previous step 

## 3. Build todo app image
```bash
docker build -t todoapp:2.0.0 .
````
## 4. Running todo app 
````bash
docker run -d -p 8080:8080 todoapp:2.0.0
````
## 5. Check if both containers are running
````bash
docker ps
````
## Access via browser
For access via browser follow the link 
 ```
 http://localhost:8080
 ```