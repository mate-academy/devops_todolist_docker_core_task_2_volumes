# Django-Todolist Docker Instructions

## 1. Run MySQL Container

Create a Docker volume:

```bash
docker volume create mysql-data
```

Run MySQL:

```bash
docker run -d \
  --name mysql-local \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  artemgrishko1/mysql-local:1.0.0
```

Database credentials:
- Database: `app_db`
- User: `app_user`
- Password: `1234`

## 2. Run Django Application

Pull the application image:

```bash
docker pull artemgrishko1/todoapp:2.0.0
```

Run the application:

```bash
docker run -d \
  --name todoapp \
  -p 8080:8080 \
  artemgrishko1/todoapp:2.0.0
```

## 3. Access the Application

Open in your browser:

- Application: http://localhost:8080/
- API: http://localhost:8080/api/

## 4. Docker Hub

- [MySQL Image](https://hub.docker.com/r/artemgrishko1/mysql-local)
- [Django Application Image](https://hub.docker.com/r/artemgrishko1/todoapp)