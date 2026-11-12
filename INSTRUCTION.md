# Todo App with MySQL in Docker

## Docker Hub
- MySQL image: https://hub.docker.com/r/<dockerhub-user>/mysql-local
- App image: https://hub.docker.com/r/<dockerhub-user>/todoapp

## 1. Run the MySQL container with a volume

```bash
docker pull agarnaga/mysql-local:1.0.0

docker run -d --name mysql-db \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  <dockerhub-user>/mysql-local:1.0.0
```

The `mysql_data` volume keeps database data after the container is removed.
The image creates database `app_db` and user `app_user` (password `1234`).

If port 3306 is already in use on your machine, use `-p 3307:3306` instead.

Get the container IP:

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-db
```

## 2. Run the app container (connects to MySQL)

Set `HOST` in `todolist/settings.py` to the IP from the previous step
(the MySQL container must be running, because migrations run during the build), then:

```bash
docker build -t todoapp:2.0.0 .
docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0
```

Or use the published image:

```bash
docker pull agarnaga/todoapp:2.0.0
docker run -d --name todoapp -p 8080:8080 <dockerhub-user>/todoapp:2.0.0
```

Note: the published image has the MySQL IP baked in at build time. If your
MySQL container gets a different IP, rebuild the image with the correct `HOST`.

## 3. Access the app

Open http://localhost:8080 in your browser.

## Troubleshooting
- `docker logs todoapp` / `docker logs mysql-db`
- Make sure the MySQL container is running before starting the app.