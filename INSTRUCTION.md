# Django ToDo List in Docker

Docker Hub (app image): https://hub.docker.com/r/ovasylkov/todoapp

## 1. Run MySQL with a volume

```bash
docker run -d --name mysql-db -v mysql_data:/var/lib/mysql -p 3306:3306 ovasylkov/mysql-local:1.0.0
```

The database `app_db` and user `app_user` (password `1234`) are created automatically. Data is stored in the `mysql_data` volume, so it stays after the container is removed.

## 2. Run the app (connects to MySQL)

Get the IP of the MySQL container:

```bash
docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" mysql-db
```

Put this IP into `HOST` in `todolist/settings.py`, then build and run the app:

```bash
docker build -t ovasylkov/todoapp:2.0.0 .
docker run -d --name todoapp -p 8080:8080 ovasylkov/todoapp:2.0.0
```

Or use the ready image from Docker Hub:

```bash
docker run -d --name todoapp -p 8080:8080 ovasylkov/todoapp:2.0.0
```

The MySQL container must be running first.

## 3. Open in browser

http://localhost:8080

https://snipboard.io/VflWn9.jpg