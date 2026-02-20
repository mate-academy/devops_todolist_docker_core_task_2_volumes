# INSTRUCTION

---

## 0. Prerequisite

Ensure `requirements.txt` contains:

```
mysql-connector-python==8.2.0
```

---

## 1. Build MySQL image (local)

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

---

## 2. Tag and push MySQL image to Docker Hub

```bash
docker login
docker tag mysql-local:1.0.0 dtsy/mysql-local:1.0.0
docker push dtsy/mysql-local:1.0.0
```

Local image name:
mysql-local:1.0.0

Pushed image name:
dtsy/mysql-local:1.0.0

---

## 3. Create Docker network

```bash
docker network create todo-network
```

---

## 4. Run MySQL container with volume attached

```bash
docker volume create mysql_data
```

```bash
docker run -d \
  --name mysql-db \
  --network todo-network \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  dtsy/mysql-local:1.0.0
```

---

## 5. Update Django settings

In `todolist/settings.py`:

```python
import os

DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': os.getenv('DJANGO_DB_HOST', 'localhost'),
        'PORT': '',
    }
}
```

---

## 6. Build Django application image (local)

```bash
docker build -t todoapp:2.0.0 .
```

---

## 7. Tag and push Django image

```bash
docker tag todoapp:2.0.0 dtsy/todoapp:2.0.0
docker push dtsy/todoapp:2.0.0
```

Local image name:
todoapp:2.0.0

Pushed image name:
dtsy/todoapp:2.0.0

---

## 8. Run Django application container

```bash
docker run -d \
  --name todo-app \
  --network todo-network \
  -e DJANGO_DB_HOST=mysql-db \
  -p 8080:8000 \
  dtsy/todoapp:2.0.0
```

---

## 9. Docker Hub repositories

MySQL image:
https://hub.docker.com/r/dtsy/mysql-local

Application image:
https://hub.docker.com/r/dtsy/todoapp

---

## 10. Access the application

http://localhost:8080/

API:
http://localhost:8080/api/