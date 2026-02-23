
# Docker Hub Repositories
- [todoapp:2.0.0](https://hub.docker.com/r/bohn13/todoapp/tags)
- [mysql-local:1.0.0](https://hub.docker.com/r/bohn13/mysql-local/tags)

---

## 1. Environment Setup
To enable containers to communicate using names (DNS) instead of unstable IP addresses, create a dedicated Docker network:

```bash
docker network create todonet
```

---

## 2. MySQL Database Setup

### Build, Tag, and Push

If you are building the database image locally:

```bash
# Build the image from Dockerfile.mysql
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .

# Tag for your Docker Hub repository
docker tag mysql-local:1.0.0 bohn13/mysql-local:1.0.0

# Push to Docker Hub
docker push bohn13/mysql-local:1.0.0

```

### Run MySQL Container

Launch the MySQL container within the `todonet` network. This allows the app to find the DB using the hostname `mysql_data`.

```bash
docker run -d \
  --name mysql_data \
  --network todonet \
  -p 3306:3306 \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -e MYSQL_ROOT_PASSWORD=1234 \
  -v mysql-data-volume:/var/lib/mysql \
  bohn13/mysql-local:1.0.0

```

---

## 3. Todo Application Setup

### Build, Tag, and Push

Build and upload the application image:

```bash
# Build the application image
docker build -t todoapp:2.0.0 .

# Tag for your Docker Hub repository
docker tag todoapp:2.0.0 bohn13/todoapp:2.0.0

# Push to Docker Hub
docker push bohn13/todoapp:2.0.0

```

### Run App Container

Run the application container on the same network. We pass the database hostname via the `DB_HOST` environment variable.

```bash
docker run -d \
  --name todoapp \
  --network todonet \
  -p 8080:8000 \
  -e DB_HOST=mysql_data \
  bohn13/todoapp:2.0.0
```

---

## 4. Access and Verification

### Port Binding & Connectivity

* **Django Binding:** The server inside the container is configured to bind to `0.0.0.0:8000` to be accessible from outside the container.
* **Host Mapping:** The command `-p 8080:8000` maps your local machine's port `8080` to the container's internal port `8000`.
* **Service Discovery:** By using `--network todonet`, the app connects to the database via the container name (`mysql_data`).

### Access the Website

Open your browser and visit:
[http://127.0.0.1:8080/](http://127.0.0.1:8080/)

### Troubleshooting

Check the logs if the application fails to start:

```bash
docker logs todoapp
docker logs mysql_data
```

---

### Technical Note on Configuration

The `todolist/settings.py` uses literal values for `NAME`, `USER`, and `PASSWORD` as required. The `HOST` is dynamically managed via the `DB_HOST` environment variable, and `PORT` is set to an empty string `''` to utilize the default MySQL port.
