# Django ToDo List — Docker + MySQL

This project runs a **Django ToDo application** and a **MySQL database** in separate Docker containers. The MySQL data is stored in a named Docker volume so that it persists when the database container is removed.

## Prerequisites

- Docker Desktop or Docker Engine is running.
- Run build commands from the project directory containing `Dockerfile`, `Dockerfile.mysql`, `manage.py`, `requirements.txt`, and `todolist/settings.py`.
- `requirements.txt` includes `mysql-connector-python==8.2.0`.

## Docker Hub images

| Service | Image | Docker Hub |
| --- | --- | --- |
| MySQL | `aniapavliuk9/mysql-local:1.0.0` | [MySQL repository](https://hub.docker.com/r/aniapavliuk9/mysql-local) |
| Django | `aniapavliuk9/todoapp:2.0.0` | [Django ToDo repository](https://hub.docker.com/r/aniapavliuk9/todoapp) |

## 1. Build the MySQL image

Build the image using the MySQL-specific Dockerfile:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

`Dockerfile.mysql` uses the official MySQL base image and sets the initialization variables for database `app_db`, user `app_user`, and a training-only password. The MySQL root password is also configured for initial setup.

> **Security note:** The credentials used here are only for a local educational project. The `ENV` values in a Dockerfile can be visible in the published image metadata. Never put real passwords or production secrets in a Dockerfile.

## 2. Run MySQL with a persistent Docker volume

Create and start the database container:

```bash
docker run -d \
  --name sql-local \
  -p 3306:3306 \
  -v volume_name:/var/lib/mysql \
  mysql-local:1.0.0
```

The Docker-managed volume `volume_name` is mounted at `/var/lib/mysql`, where MySQL stores its data.

Check the container, its logs, and the volume:

```bash
docker ps
docker logs sql-local
docker volume ls
```

Wait until the log contains **`ready for connections`** before starting Django. If the container already exists but is stopped, use `docker start sql-local`. If port `3306` on the host is already taken, you can use `-p 3307:3306` instead; port `3306` inside the MySQL container does not change.

## 3. Configure Django to connect to MySQL

Find the current IP address of the MySQL container:

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sql-local
```

In `todolist/settings.py`, configure the `DATABASES` dictionary. The following IP is an **example**; replace it with the IP shown by `docker inspect`:

```python
DATABASES = {
    "default": {
        "ENGINE": "mysql.connector.django",
        "NAME": "app_db",
        "USER": "app_user",
        "PASSWORD": "1234",
        "HOST": "172.17.0.2",
        "PORT": "3306",
    }
}
```

Do not set `HOST` to `localhost` when Django runs in a separate container. In that case, `localhost` refers to the Django container itself, not MySQL.

**Important:** This exercise uses the MySQL container IP on Docker's default bridge network. That IP can change if the container is recreated. If you change `settings.py`, rebuild the Django image before running it again. For production-style deployments, a user-defined Docker network and a database container hostname are preferable to a hard-coded IP.

## 4. Build the updated Django image

The Django `Dockerfile` uses a multi-stage build. Python dependencies, including MySQL Connector, are installed during the build.

```bash
docker build -t todoapp:2.0.0 .
```

Database migrations are **not** performed in the Dockerfile; they are run separately while MySQL is available.

## 5. Apply database migrations

With `sql-local` running, execute Django migrations in a temporary container:

```bash
docker run --rm --network bridge todoapp:2.0.0 python manage.py migrate
```

The temporary container is removed after the command finishes. The database records remain in the MySQL volume.

## 6. Run the Django application

Start the Django container:

```bash
docker run -d \
  --name todoapp2 \
  --network bridge \
  -p 8080:8080 \
  todoapp:2.0.0
```

Check that the application started successfully:

```bash
docker ps
docker logs --tail 50 todoapp2
```

Open the application in a browser:

- **Web interface:** <http://localhost:8080/>
- **API:** <http://localhost:8080/api/>

If host port `8080` is already in use, recreate the Django container with `-p 8081:8080` and open <http://localhost:8081/> instead. The internal Django port remains `8080`.

## 7. Tag and push images to Docker Hub

Log in to Docker Hub first if needed:

```bash
docker login
```

Tag and push the MySQL image:

```bash
docker tag mysql-local:1.0.0 aniapavliuk9/mysql-local:1.0.0
docker push aniapavliuk9/mysql-local:1.0.0
```

Tag and push the Django image:

```bash
docker tag todoapp:2.0.0 aniapavliuk9/todoapp:2.0.0
docker push aniapavliuk9/todoapp:2.0.0
```

To retrieve these images from Docker Hub on a different machine:

```bash
docker pull aniapavliuk9/mysql-local:1.0.0
docker pull aniapavliuk9/todoapp:2.0.0
```

A prebuilt Django image whose `settings.py` contains a hard-coded MySQL IP may require rebuilding with the database IP appropriate for the new machine.

## 8. Stop and restart containers

Stop the application before the database:

```bash
docker stop todoapp2 sql-local
```

Start the database first, then Django:

```bash
docker start sql-local
docker start todoapp2
```

After recreating containers, check the database IP again. Docker container deletion does not normally delete a named volume, but **deleting the volume deletes its persisted database data**.

## Submission checklist

- [ ] `Dockerfile.mysql` builds `mysql-local:1.0.0`.
- [ ] MySQL starts with the named volume attached.
- [ ] `requirements.txt` includes `mysql-connector-python==8.2.0`.
- [ ] `todolist/settings.py` connects to MySQL.
- [ ] `Dockerfile` builds and runs `todoapp:2.0.0`.
- [ ] Django migrations complete, and the application opens in a browser.
- [ ] Both image tags are pushed to the Docker Hub repositories linked above.
- [ ] A terminal screenshot demonstrates the successfully started application.
- [ ] The updated files and this `INSTRUCTION.md` are included in a GitHub pull request.
