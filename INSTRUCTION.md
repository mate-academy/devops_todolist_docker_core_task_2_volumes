1. Run MySQL Container
   
Run the MySQL container with a volume attached:
```
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
docker network create todolist-net
docker run -d \
  --name mysql-local \
  --network todolist-net \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0

```

2. Run Django App Container

Build and run the Django App container:

```
docker build -t todoapp:2.0.0 -f Dockerfile.app .
docker run -d \
  --name todoapp \
  --network todolist-net \
  -p 8000:8000 \
  todoapp:2.0.0
```

3. Update settings.py

```
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': 'mysql-local',
        'PORT': '3306',
    }
}

```


4. Docker Hub Images
    - MySQL image: https://hub.docker.com/repository/docker/yurirr/mysql-local/general
    -  Django App image: https://hub.docker.com/repository/docker/yurirr/todoapp/general





