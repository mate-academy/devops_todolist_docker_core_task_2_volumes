# Run Instructions

## 1. Run MySQL container with a volume

```bash
docker run -d \
  --name mysql-local \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  ten4i/mysql-local:1.0.0
```

The volume `mysql_data` persists the database between container restarts.

Check the MySQL container IP (should be `172.17.0.2` on a default bridge network):

```bash
docker inspect mysql-local | grep '"IPAddress"'
```

## 2. Run the App container

```bash
docker run -d \
  --name todoapp \
  -p 8080:8080 \
  ten4i/todoapp:2.0.0
```

The app connects to MySQL at `172.17.0.2:3306` using `app_user` / `1234`.
Make sure the MySQL container is running before starting the app.

## 3. Access the application

Open your browser and go to:

```
http://localhost:8080
```

API is available at:

```
http://localhost:8080/api/
```

## Docker Hub

App image: https://hub.docker.com/r/ten4i/todoapp;
