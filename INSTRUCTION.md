# Docker Run Instructions

## 1. Run MySQL container with a volume attached

Build the MySQL image:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

Run the MySQL container and attach a Docker volume for data persistence:

```bash
docker run --name mysql-local -d -p 3306:3306 -v mysql_data:/var/lib/mysql mysql-local:1.0.0
```

This command does the following:
- `--name mysql-local` gives the container a name
- `-d` runs it in detached mode
- `-p 3306:3306` exposes MySQL port 3306
- `-v mysql_data:/var/lib/mysql` mounts a Docker volume so data remains after container restarts

To check that MySQL is running:

```bash
docker ps
```

Optional: inspect the container logs:

```bash
docker logs mysql-local
```

---

## 2. Run the application container and connect it to MySQL

Build the application image:

```bash
docker build -t todoapp:2.0.0 .
```

Tag the image for Docker Hub:

```bash
docker tag todoapp:2.0.0 your-dockerhub-username/todoapp:2.0.0
```

Push it to Docker Hub:

```bash
docker push your-dockerhub-username/todoapp:2.0.0
```

Run the app container and connect it to the MySQL container:

```bash
docker run --name todoapp -d -p 8000:8000 --link mysql-local:db todoapp:2.0.0
```

If the app is configured to use the MySQL container IP, update the database settings in `todolist/settings.py` to use the correct `HOST` value before running the app container.

Example:

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

> Replace the IP with the actual IP address of the MySQL container.

---

## 3. Docker Hub repository link

App image repository:

https://hub.docker.com/r/your-dockerhub-username/todoapp

Replace `your-dockerhub-username` with your actual Docker Hub username.

---

## 4. Access the application in a browser

After the app container is running, open the browser and go to:

```text
http://localhost:8000/
```

If the app is running on a different host, use that host's IP or Docker host address instead of `localhost`.

Example:

```text
http://127.0.0.1:8000/
```

---

## Useful commands

```bash
docker ps

docker logs mysql-local

docker logs todoapp

```
