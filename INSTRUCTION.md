# Instructions

## Docker Hub

- App image: [azartiksman/todoapp](https://hub.docker.com/r/azartiksman/todoapp) (tag `2.0.0`)
- MySQL image: [azartiksman/mysql-local](https://hub.docker.com/r/azartiksman/mysql-local) (tag `1.0.0`)

## 1. Run MySQL container with a volume attached

Build the image (or pull `azartiksman/mysql-local:1.0.0`):

```bash
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
```

Create a volume and run the container:

```bash
docker volume create mysql-data
docker run -d --name mysql-local -p 3306:3306 -v mysql-data:/var/lib/mysql mysql-local:1.0.0
```

The `app_db` database and `app_user` (password `1234`) are created automatically from ENV variables in `Dockerfile.mysql`.

Get the IP address of the MySQL container:

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local
```

## 2. Run the App container connected to MySQL

Put the IP from the previous step into `HOST` of `DATABASES` in `todolist/settings.py`, then build the image (migrations run during the build, so MySQL must be running):

```bash
docker build -t todoapp:2.0.0 .
```

Or pull the prebuilt image:

```bash
docker pull azartiksman/todoapp:2.0.0
```

Run the app container:

```bash
docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0
```

## 3. Access the application

Open in a browser:

- Landing page: http://localhost:8080/
- API: http://localhost:8080/api/
