# Instructions

Pull images:

```
docker pull guver2004/mysql-local:1.0.0
docker pull guver2004/todoapp:2.0.0
```

OR

Build images from Dockerfiles:
```
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
docker build -t todoapp:2.0.0
```

Run containers via this command
```
docker run -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
docker run -p 8080:8080 todoapp:2.0.0
```

Access application via browser by [link](http://localhost:8080)
