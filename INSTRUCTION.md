# Application Deployment Instructions

## 1. MySQL Database Container

The application uses a MySQL database running in a separate Docker container. A named Docker volume is attached to persist database data between container restarts and recreations.

### Run the MySQL container

```powershell
docker run -d `
  --name mysql-local `
  -p 3306:3306 `
  -v mysql-data:/var/lib/mysql `
  mysql-local:1.0.0
```

### MySQL configuration

| Parameter | Value |
|---|---|
| Container name | `mysql-local` |
| Image | `mysql-local:1.0.0` |
| Database | `app_db` |
| Database user | `app_user` |
| Database password | `1234` |
| Root password | `54321` |
| Port | `3306` |
| Volume | `mysql-data` |

Wait until MySQL has completed initialization:

```powershell
docker logs -f mysql-local
```

Press `Ctrl+C` to exit the logs.

### Verify the MySQL container

```powershell
docker ps
```

### Get the MySQL container IP address

```powershell
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local
```

The returned IP address must match the database host configured in the Django application.

---

## 2. Run the Application Container

The application runs in a separate Docker container and connects to the MySQL database container.

### Docker Hub repository

The application image is available at:

[Docker Hub – georgeatoyan/todoapp](https://hub.docker.com/r/georgeatoyan/todoapp)

Image version: `2.0.0`

### Pull the application image

```powershell
docker pull georgeatoyan/todoapp:2.0.0
```

### Run the application container

```powershell
docker run -d `
  --name todolist-app `
  -p 8081:8080 `
  georgeatoyan/todoapp:2.0.0
```

### Verify the application container

```powershell
docker ps
```

### Check application logs

```powershell
docker logs todolist-app
```

---

## 3. Access the Application

Once the application container is running, open the following address in your web browser:

**http://localhost:8081**

Docker maps port `8081` on the host machine to port `8080` inside the application container.

---

**Note:** The `mysql-data` named volume stores database files independently of the MySQL container. Removing the container does not automatically remove the volume.