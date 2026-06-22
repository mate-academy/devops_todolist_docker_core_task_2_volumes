# Todo App Docker Instructions

Docker Hub repository:

https://hub.docker.com/repository/docker/alexey211204/todoapp/general

## 1. Run MySQL container

```bash
docker volume create my-mysql-data

docker run -d \
  --name mysql \
  -p 3306:3306 \
  -v my-mysql-data:/var/lib/mysql \
  mysql-local:1.0.0
```

`my-mysql-data` is a named Docker volume used to persist MySQL data.

## 2. Find MySQL container IP

After starting the MySQL container, inspect the default Docker bridge network:

```bash
docker network inspect bridge
```

In the output, find the container named `mysql` and copy its `IPv4Address`.

Example:

```text
"Name": "mysql"
"IPv4Address": "172.17.0.3/16"
```

Use only the IP address without `/16`:

```text
172.17.0.3
```

## 3. Update Django database HOST

Open `todolist/settings.py` and put the MySQL container IP into `HOST`:

```python
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': '172.17.0.3',
        'PORT': '',
    }
}
```

The project must also contain this dependency in `requirements.txt`:

```txt
mysql-connector-python==8.2.0
```

After changing `settings.py`, rebuild the app image:

```bash
docker build -f Dockerfile . -t todoapp:2.0.0
```

## 4. Run application container

```bash
docker run -d \
  --name app \
  -p 8080:8080 \
  todoapp:2.0.0
```

## 5. Open application

Open in browser:

```text
http://localhost:8080/
```
