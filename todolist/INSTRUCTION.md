# Instructions on how to run the Todo Application with MySQL inside Docker

This guide explains how to pull the images from Docker Hub, set up the containers, mount the MySQL database volume, and link the Django application to the database.

---

## Prerequisites
Make sure you have Docker installed and running on your machine.

---

## Step 1: Run the MySQL Database with Volume Attached

To start the MySQL database container with a persistent volume to preserve data, execute the following commands in your terminal:

```bash
 docker run --name app_my_sql -p 8080:3306 -v todo_mysql:/var/lib/mysql -d mysql-local:1.0.0
```

 ## Step 2: Run an App container which will connect to a MySQL db container.

 ```bash
 docker run --name todo_app -p 8000:8080 -d todoapp:2.0.0 
```

Docker Hub images:
1. for comand Step 1 -
                      |
                      |
                     \ /
                      |
https://hub.docker.com/repository/docker/petrosfas/mysql-local/general

2. for comand Step 2 -
                      |
                      |
                     \ /
                      |
https://hub.docker.com/repository/docker/petrosfas/todoapp/general

## Step 3: How to Access the Application via a Browser
Once both containers are successfully running, you can access the interactive user interface of the application.

Instructions:
Open your preferred web browser (e.g., Google Chrome, Firefox, Brave).

Type or copy-paste the following address into the URL bar:
👉 http://localhost:8000

Press Enter.

From the landing page, you can create accounts, log in, use the interactive UI, and fully manage your tasks.