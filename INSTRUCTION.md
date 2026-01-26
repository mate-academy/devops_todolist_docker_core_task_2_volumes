# Project Instructions

### Docker Hub Repository
You can find the images here:
`docker pull nickptrnko/mysql-local:1.0.0`
`docker pull nickptrnko/todoapp:2.0.0`

### Create virtual network for Docker container
```
docker network create <your_network_name>
```

### Run the MySQL Container
To run MySQL container with a volume attached, execute the following command:
```
docker run  -d -p 3306:3306 --name db_container --network <your_network_name> -v <your_volume_name>:/var/lib/mysql nickptrnko/mysql-local:1.0.0
```

### Run the App Container
Execute the following command to start the app:
```
docker run --network <your_network_name> -p 8080:8080 todoapp:2.0.0
```
### Accessing the Application
Once the containers is running, open your browser and navigate to: http://localhost:8080
