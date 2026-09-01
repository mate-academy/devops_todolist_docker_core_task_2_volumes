# Instructions for Running Django TodoList with MySQL in Docker

## Docker Hub Repository
- **Application Image Repository:** [https://hub.docker.com/r/leonetsbogdan/todoapp](https://hub.docker.com/r/leonetsbogdan/todoapp)
- **Image Tag:** `leonetsbogdan/todoapp:2.0.0`

---

## 1. How to Run MySQL Container with Volume Attached

To run the MySQL database container with persistent storage using a Docker Volume (`mysql_data`), execute the following command:

```bash
docker run -d \
  --name mysql-container \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  leonetsbogdan/mysql-local:1.0.0
```

> **Note:** The `-v mysql_data:/var/lib/mysql` flag mounts a named Docker volume to ensure database persistence between container restarts.

---

## 2. How to Run the App Container Connected to MySQL

1. Ensure the MySQL container is up and running.
2. Run the application container with port forwarding:

```bash
docker run -d \
  --name todoapp-container \
  -p 8080:8080 \
  leonetsbogdan/todoapp:2.0.0
```

---

## 3. How to Access the Application via Browser

Once both containers are running, open your web browser and navigate to:

- **Main Landing Page:** [http://localhost:8080/](http://localhost:8080/)
- **API Endpoint:** [http://localhost:8080/api/](http://localhost:8080/api/)
