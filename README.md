# Django-Todolist

Download mysql image from https://hub.docker.com/repository/docker/kagerou4649/mysql-local/general
Download app image from https://hub.docker.com/repository/docker/kagerou4649/todoapp/general

Pull Images:
docker pull kagerou4649/mysql-local:1.0.0
docker pull kagerou4649/todoapp:2.0.0

Run containers via this command
```
docker run -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
docker run -p 8080:8080 todoapp:2.0.0
```

Access application via browser by [link](http://localhost:8080)
