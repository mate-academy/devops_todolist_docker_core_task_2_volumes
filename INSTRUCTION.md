# Running the Todo App with a MySQL Container

## Docker Hub

- App image: https://hub.docker.com/repository/docker/stasisydorchuk/todoapp/general (tag `2.0.0`)
- MySQL image: https://hub.docker.com/repository/docker/stasisydorchuk/mysql-local/general (tag `1.0.0`)

## 1. Run the MySQL container with a volume attached

Build the MySQL image:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

Run the container with a named volume for the database files:

```bash
docker run -d --name mysql-local -p 3306:3306 -v mysql_data:/var/lib/mysql mysql-local:1.0.0
```

- `-v mysql_data:/var/lib/mysql` mounts the named volume `mysql_data` into the MySQL data directory, so the data survives if you remove or recreate the container.
- The image creates the database `app_db` and the user `app_user` with the password `1234`.

## 2. Point the app at the MySQL container

Get the IP address of the running MySQL container:

```bash
docker network inspect bridge
```

In `todolist/settings.py`, set `HOST` to that IP (for example `172.17.0.2`):

```python
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': '172.17.0.2',
        'PORT': '3306',
    }
}
```

## 3. Build and run the app container

The MySQL container must be running before you build: the build runs `python manage.py migrate` against the database.

```bash
docker build -t todoapp:2.0.0 .
docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0
```

The published image has the MySQL IP from the moment it was built. If your MySQL container gets a different IP, update `settings.py` and rebuild the image.

Check the logs:

```bash
docker logs todoapp
```

## 4. Open the app in a browser

- Landing page: http://localhost:8080/
- API: http://localhost:8080/api/
