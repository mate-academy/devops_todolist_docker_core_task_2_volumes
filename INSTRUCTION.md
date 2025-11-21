# Run app guide

Firstly, you need to build and run sql database using this commands

```commandline
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
docker run  -d -p 3306:3306 --name mysql-local -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
```

After this you need to inspect the bridge and find the IP of mysql-local container
use this command 
```commandline
docker network inspect bridge
```
When you find the IP you need to change 'HOST' property in DATABASES variable to this IP
The next step, you need to build and run the app container

```commandline
docker build . -t todoapp:2.0.0
docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0
```

After complete launch of the database container and the todoapp container you can open http://localhost:8080/ link 
to get access to the app

Repositories links
- https://hub.docker.com/r/stassytnykov/todoapp
- https://hub.docker.com/r/stassytnykov/mysql-local