## Running MySQL container with a volume attached
```
docker run -d --name mysql-local -v my-sql-data:/var/lib/mysql mysql-local:1.0.0
```

## Running app container connected to a MySQL db container
```
docker run -p 8080:8080 --name todoapp todoapp:2.0.0
```

## Links to docker hub
[Todoapp image](https://hub.docker.com/r/artemmusii/todoapp)\
[MySQL image](https://hub.docker.com/r/artemmusii/mysql-local)


## Access application via browser
Open [localhost:8080](http://localhost:8080/) in browser
