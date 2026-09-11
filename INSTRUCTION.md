# Instructions

## 1. Build MySQL Image

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

## 2. Run MySQL Container with Volume

```bash
docker run -d --name mysql-db -v mysql-data:/var/lib/mysql mysql-local:1.0.0
```

## 3. Check MySQL Logs

```bash
docker logs mysql-db
```

## 4. Get MySQL Container IP

```bash
docker inspect mysql-db
```

Find the container IP address and update the `HOST` value in `todolist/settings.py` with this IP.

## 5. Run Application Container

```bash
docker run -d --name todoapp -p 8080:8080 userdockerana/todoapp:2.0.0
```

## 6. Access the Application

Open the application in a browser:

```text
http://localhost:8080
```

## Docker Hub Repository

Application image:

`https://hub.docker.com/r/userdockerana/todoapp`
