# Running the Todolist app with Docker (MySQL + volume)

The app (Django) connects to a MySQL database running in a separate container. The database data is stored in a Docker volume so it survives container removal.

Docker Hub images:
- App: https://hub.docker.com/r/chumba1100/todoapp (`chumba1100/todoapp:2.0.0`)
- MySQL: `chumba1100/mysql-local:1.0.0`

## 1. Run the MySQL container with a volume

Build the image from `Dockerfile.mysql` (or pull it from Docker Hub):

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
# or: docker pull chumba1100/mysql-local:1.0.0
```

Run the container with a named volume attached:

```bash
docker run -d --name mysql-db -v mysql_data:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0
```

- `-v mysql_data:/var/lib/mysql` mounts the volume `mysql_data` into the MySQL data directory.
- The image creates the database `app_db` and the user `app_user` (password `1234`) on first start via `ENV` variables.

Check that it is running:

```bash
docker ps
```

## 2. Run the app container and connect it to MySQL

1. Find the IP address of the MySQL container:

   ```bash
   docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-db
   ```

2. Open `todolist/settings.py` and put that IP into the `HOST` field of `DATABASES`:

   ```python
   DATABASES = {
       'default': {
           'ENGINE': 'mysql.connector.django',
           'NAME': 'app_db',
           'USER': 'app_user',
           'PASSWORD': '1234',
           'HOST': '<MYSQL_CONTAINER_IP>',
           'PORT': '',
       }
   }
   ```

3. Build the app image:

   ```bash
   docker build -t todoapp:2.0.0 .
   ```

   (or pull the ready image: `docker pull chumba1100/todoapp:2.0.0`)

4. Run the app container:

   ```bash
   docker run -d --name todoapp -p 8080:8080 todoapp:2.0.0
   ```

   Make sure the MySQL container is already running, otherwise the app cannot connect to the database.

## 3. Open the application in a browser

Go to http://localhost:8080

The API is available at http://localhost:8080/api/

## Screenshot

![App started successfully](screenshot.jpg)
