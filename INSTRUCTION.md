# Todo App with MySQL (Docker)

This project demonstrates how to run a Django Todo application connected to a MySQL database using Docker containers and volumes.

Below are the instructions to run both containers and access the application in a browser.

---

## Docker Hub repositories

* Application image: [https://hub.docker.com/r/krizanivskak/todoapp](https://hub.docker.com/r/krizanivskak/todoapp)
* MySQL image: [https://hub.docker.com/r/krizanivskak/mysql-local](https://hub.docker.com/r/krizanivskak/mysql-local)

---

# Running MySQL container with volume

## Pull image

```bash
docker pull krizanivskak/mysql-local:1.0.0
```

## Run container with volume

```bash
docker run -d --name mysql-local -p 3306:3306 -v mysql_data:/var/lib/mysql krizanivskak/mysql-local:1.0.0
```

---

# Running application container (connects to MySQL)

## Get MySQL container IP

```bash
docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" mysql-local
```

## Update database config

In `todolist/settings.py` (lines 70-71) set:

```text
HOST = '<MYSQL_CONTAINER_IP>',
PORT = '3306',
```

---

## Pull application image

```bash
docker pull krizanivskak/todoapp:2.0.0
```

## Run application container

```bash
docker run -d --name todoapp -p 8080:8080 krizanivskak/todoapp:2.0.0
```

---

## Access application in browser

Open:

```text
http://localhost:8080
```

---

## Notes

* Make sure Docker is installed and the Docker daemon is running.
* If containers already exist, stop and remove them before running again:

```bash
docker stop todoapp mysql-local
docker rm todoapp mysql-local
```
