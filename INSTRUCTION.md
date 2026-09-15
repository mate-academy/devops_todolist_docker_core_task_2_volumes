# Django-Todolist Deployment Instructions

Docker Hub Repository with the application image:
https://hub.docker.com/r/rtemiis/todoapp

---

## 1. Run MySQL Container with Volume Attached

To run the MySQL database container with persistent storage, execute:

```bash
docker run -d --name mysql-server -v mysql_data:/var/lib/mysql -p 3306:3306 rtemiis/mysql-local:1.0.0