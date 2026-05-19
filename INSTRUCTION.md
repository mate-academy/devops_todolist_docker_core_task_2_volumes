# ToDo App — Docker Instructions

## Docker Hub Repositories

- App image: [https://hub.docker.com/r/gurianov88/todoapp](https://hub.docker.com/r/gurianov88/todoapp)
- MySQL image: [https://hub.docker.com/r/gurianov88/mysql-local](https://hub.docker.com/r/gurianov88/mysql-local)


---

## 1. Build MySQL image

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

---

## 2. Run MySQL container with volume attached

```bash
docker run -d \
  --name mysql-local \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```


Get the IP address of the running MySQL container:

```bash
docker inspect mysql-local | grep IPAddress
```

---

## 3. Update app database config

Open `todolist/settings.py` and update the `HOST` field with the IP from the previous step:

```python
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': '<MYSQL_CONTAINER_IP>',
        'PORT': '',
    }
}
```

---

## 4. Build the app image

```bash
docker build -t todoapp:2.0.0 .
```

---

## 5. Run the app container

```bash
docker run -d \
  --name todoapp \
  -p 8080:8080 \
  todoapp:2.0.0
```

---

## 6. Access the application

Open your browser and go to:

- **Landing page:** [http://localhost:8080](http://localhost:8080)
- **API:** [http://localhost:8080/api/](http://localhost:8080/api/)

---