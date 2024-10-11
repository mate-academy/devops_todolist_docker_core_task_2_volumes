# Django-Todolist

Django-Todolist is a todolist web application with the most basic features of most web apps, i.e. accounts/login, API and (somewhat) interactive UI.

## Setup

1. Pull TodoList App image

Link - https://hub.docker.com/repository/docker/ivanbilobrov/todoapp

```bash
docker pull ivanbilobrov/todoapp:2.0.0
```

2. Pull MySQL image

Link - https://hub.docker.com/repository/docker/ivanbilobrov/mysql-local

```bash
docker pull  ivanbilobrov/mysql-local:1.0.0
```

3. Run MySQL container

```bash
docker run -d -p 3306:3306 -v data:/var/lib/mysql ivanbilobrov/mysql-local:1.0.0
```

4. Run TodoList App container

```bash
docker run -d -p 8080:8080 ivanbilobrov/todoapp:2.0.0
```

5. Open application in browser

Link - http://localhost:8080/
