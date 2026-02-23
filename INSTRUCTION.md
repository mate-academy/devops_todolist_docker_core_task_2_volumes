
# Docker Hub Repositories
- [todoapp:2.0.0](https://hub.docker.com/r/bohn13/todoapp/tags)
- [mysql-local:1.0.0](https://hub.docker.com/r/bohn13/mysql-local/tags)

---

## 1. Pull Prebuilt Images
First, pull the necessary images from Docker Hub to your local machine:

```bash
docker pull bohn13/mysql-local:1.0.0
docker pull bohn13/todoapp:2.0.0
```

---

## 2. MySQL Database Setup

### Option A: Build the Image Manually

If you need to modify the MySQL credentials or configuration, edit `Dockerfile.mysql` and build the image locally:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

### Option B: Run MySQL Container

Run the container with a persistent volume and the required environment variables:

```bash
docker run -d --name mysql_data -p 3306:3306 -e MYSQL_DATABASE=app_db -e MYSQL_USER=app_user -e MYSQL_PASSWORD=1234 -e MYSQL_ROOT_PASSWORD=1234 -v mysql-data-volume:/var/lib/mysql mysql-local:1.0.0
```

> **Verification:** Check the logs to ensure the database is ready: `docker logs mysql_data`

---

## 3. Connect App to MySQL

The application requires the specific IP address of the running MySQL container to establish a connection.

1. **Retrieve Container IP:**
Run the following command to get the internal IP address of the `mysql_data` container:
```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql_data
```


2. **Update App Configuration:**
Open `todolist/settings.py`, find the `DATABASES` section, and replace the `HOST` value with the IP address retrieved in the previous step (e.g., `'HOST': '172.17.0.2'`).

3. **Rebuild App Image:**
After updating the host, rebuild the application image to apply the changes:
```bash
docker build -t bohn13/todoapp:2.0.0 .
```



---

## 4. Run Todo App Container

Once the database is running and the configuration is updated, launch the application container:

```bash
docker run -d --name todoapp -p 8080:8000 bohn13/todoapp:2.0.0
```

* **Port Mapping:** The application maps internal port `8000` to your local port `8080`.
* **Logs:** Monitor the application startup using `docker logs todoapp`.

---

## 5. Access the Application

Open your browser and navigate to:
[http://127.0.0.1:8080/](http://127.0.0.1:8080/)

---

### Technical Notes

* **Database:** This project uses MySQL. SQLite support has been removed to meet the deployment requirements.
* **Persistence:** Data is stored in the `mysql-data-volume` Docker volume to ensure it persists after container restarts.
* **Connectivity:** Ensure the MySQL container is started **before** the App container.
