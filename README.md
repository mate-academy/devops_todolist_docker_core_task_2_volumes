# Django-Todolist

Django-Todolist is a todolist web application with the most basic features of most web apps, i.e. accounts/login, API and (somewhat) interactive UI.

![ToDo logo](https://i.ibb.co/YDdCcZR/2.png)

## Setup

1. Docker MySQL image with a volume attached
```
https://hub.docker.com/r/lavryniuk/mysql-local
```

2. Docker App image
```
https://hub.docker.com/r/lavryniuk/todoapp
```

3. You need pull MySQL image with a volume attached locally
```
docker pull lavryniuk/mysql-local:1.0.0
```

4. You need pull App image locally
```
docker pull lavryniuk/todoapp:2.0.0
```

5. You need run a MySQL container
```
docker run -d -p 3307:3306 -v my-mysql-data:/var/lib/mysql lavryniuk/mysql-local:1.0.0
```

6. You need run App container
```
docker run -d -p 8081:8080 lavryniuk/todoapp:2.0.0
```

7. Open application in browser
```
http://localhost:8081/
```
