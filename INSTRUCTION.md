[Docker Hub repo](https://hub.docker.com/repository/docker/cara7ies/todoapp/general)

## Step 1
---
Install docker on your computer

## Step 2
---
Pull docker images

```bash
docker pull cara7ies/mysql-local:1.0.0
docker pull cara7ies/todoapp:2.0.0
```

## Step 3
---
Navigate to the project’s root directory and start the container using the following command: 
```bash
docker run -d -p 3306:3306 --name mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
```
Update the Python app db config with an IP of a running MySQL server container (without it, the app container won’t build)
```bash
docker run -p 8000:8000 --name todolist todoapp:2.0.0
```

> [!NOTE]
> Add the `-d` flag to run the container in detached mode.

### Access the Application

Once the container is running, open `http://127.0.0.1:8000` in your browser to access the application.
