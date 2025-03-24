# [Django ToDo list with MySQL server Docker image](https://hub.docker.com/r/amylnikova/todoapp)

# 📌 TodoApp Docker server + app Instructions

This document provides instructions on how to download, run, and use the `todoapp` with mySQL server Docker container from Docker Hub.

## 1️⃣ Prerequisites

Ensure that you have Docker installed on your system. If not, you can download and install it from:  
[https://www.docker.com/get-started](https://www.docker.com/get-started)

---

## 2️⃣ Pull the Docker Image

To download the latest version of the `todoapp` image from Docker Hub, run:  

```sh
docker pull amylnikova/todoapp:2.0.0
```

---

## 3️⃣ Running the Server Container

To run a MySQL server container with a volume attached, run:

```sh
docker run -d -p 3306:3306 --name my-mysql -v local-mysql-data:/var/lib/mysql mysql:latest
```

- `-d` runs the container in detached mode (in the background).  
- `-p 3306:3306` maps port **3306** on your machine to port **3306** in the container.  
- `--name my-mysql` assigns a custom name to the running container. 
- `-v local-mysql-data:/var/lib/mysql` mounts a volume named local-mysql-data from the host to the container’s /var/lib/mysql directory, ensuring persistent storage for MySQL data.

---

## 4️⃣ Running the App Container 

to run App container and connect it to the MySQL container, run:

```sh
docker run -d --name my-todoapp --link my-mysql:mysql -p 8000:8000 amylnikova/todoapp:2.0.0
```

- `--name my-todoapp` names the App container “my-todoapp.”
- `--link my-mysql:mysql` links the App container to the running MySQL container (my-mysql) and aliases it as mysql. This makes the MySQL container accessible from the app container by hostname mysql.
- `-p 8000:8000` exposes port 8000 on your host, where the app will be accessible.

## 5️⃣ Checking Running Containers

To verify that the containers are running, use:

```sh
docker ps
```

---

## 6️⃣ Access the Application

After running the container, open your browser and go to:

```sh
http://localhost:8000
```

If running on a remote server, replace localhost with the server’s IP address.

---