# Instructions

## 1. Create Docker network

```bash
docker network create todonet
```

## 2. Run MySQL container with volume

```bash
docker run -d -p 3307:3306 --name mysql-mate --network todonet -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
```

## 3. Get MySQL container IP

```bash
docker inspect mysql-mate | grep IPAddress
```

The app is configured to connect to this IP (`HOST` in `todolist/settings.py`). Update it if the IP differs.

## 4. Run App container

```bash
docker run -d -p 8000:8080 --name todoapp --network todonet vaitekusartem/todoapp:2.0.0
```

## 4. Access the application

Open http://localhost:8000/ in your browser.

## Docker Hub

https://hub.docker.com/r/vaitekusartem/todoapp