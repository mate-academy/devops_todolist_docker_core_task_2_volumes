# Instruction

## 1. Run MySQL container with a volume attached

```bash
docker run -d \
  --name mysql-container \
  -v mysql_data:/var/lib/mysql \
  mysql-local:1.0.0
```

Get the IP address of the running MySQL container:

```bash
docker inspect mysql-container --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
```

## 2. Update the app DB config

Open `todolist/settings.py` and update the `HOST` field in `DATABASES` with the IP address obtained above:

```python
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': '<mysql-container-ip>',
        'PORT': '',
    }
}
```

## 3. Run the App container

```bash
docker run -d \
  --name todoapp-container \
  -p 8080:8080 \
  todoapp:2.0.0
```

## 4. Access the application via a browser

Open your browser and navigate to:

```
http://localhost:8080
```

To browse the REST API:

```
http://localhost:8080/api/
```

## 5. Docker Hub

App image on Docker Hub: https://hub.docker.com/repository/docker/boda4ek888/todoapp
