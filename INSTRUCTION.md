# How to run the Todo app with a MySQL container

## Docker Hub images

- App image: https://hub.docker.com/r/lehotskyimykhailo/todoapp (tag `2.0.0`)
- MySQL image: https://hub.docker.com/r/lehotskyimykhailo/mysql-local (tag `1.0.0`)

## 1. Run the MySQL container with a volume attached

Build the MySQL image (or skip this and use the image from Docker Hub):

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

Create a named volume to keep the database data:

```bash
docker volume create mysql_data
```

Run the MySQL container with the volume mounted to `/var/lib/mysql`:

```bash
docker run -d --name mysql-db -v mysql_data:/var/lib/mysql lehotskyimykhailo/mysql-local:1.0.0
```

The image creates the `app_db` database and the `app_user` user (password `1234`) on the first start.
Data is stored in the `mysql_data` volume, so it survives removing and re-creating the container.

## 2. Run the App container connected to the MySQL container

Get the IP address of the MySQL container:

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-db
```

Make sure `HOST` in `DATABASES` in `todolist/settings.py` matches this IP (currently `172.17.0.2`).
If it differs, update it and rebuild the app image:

```bash
docker build -t todoapp:2.0.0 .
```

Wait until MySQL is ready (`docker logs mysql-db` shows `ready for connections`), then run the app:

```bash
docker run -d --name todoapp -p 8080:8080 lehotskyimykhailo/todoapp:2.0.0
```

On start the container applies the database migrations to MySQL and starts the Django server on port 8080.
Check the logs with:

```bash
docker logs todoapp
```

## 3. Access the application in a browser

- Landing page: http://localhost:8080/
- API: http://localhost:8080/api/
