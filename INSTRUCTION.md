# ToDo App — Docker Instructions

## Docker Hub

App image repository: [artemzakharchukhome/todoapp](https://hub.docker.com/r/artemzakharchukhome/todoapp)

App tag: `2.0.0` — [artemzakharchukhome/todoapp:2.0.0](https://hub.docker.com/repository/docker/artemzakharchukhome/todoapp/tags/2.0.0/sha256-c19fbb3da3b043b6c5609e60285c683312807f0b792992a4a5a7c1848ee07228)

MySQL image repository: [artemzakharchukhome/mysql-local](https://hub.docker.com/repository/docker/artemzakharchukhome/mysql-local/general)

MySQL tag: `1.0.0` — [artemzakharchukhome/mysql-local:1.0.0](https://hub.docker.com/r/artemzakharchukhome/mysql-local/tags?name=1.0.0)

## Build the images

From the project root directory:

```bash
docker build -f Dockerfile.mysql . -t mysql-local:1.0.0
docker build . -t todoapp:2.0.0
```

> **Note:** Before building the app image, start the MySQL container (see below), get its IP address, and update `HOST` in `todolist/settings.py`.

## Run MySQL container with a volume attached

```bash
docker run -d --name mysql-local -v mysql_data:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0
```

## Run the App container (connect to MySQL)

```bash
docker run -p 8080:8080 -d todoapp:2.0.0
```

## Access the application in a browser

After both containers are running, open:

- Landing page: [http://localhost:8080/](http://localhost:8080/)
- API: [http://localhost:8080/api/](http://localhost:8080/api/)
