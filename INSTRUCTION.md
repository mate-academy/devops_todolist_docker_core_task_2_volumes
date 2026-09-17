# Django ToDo List — Docker

## Docker Hub

### MySQL image
https://hub.docker.com/r/feofanyq/mysql-local

### Application image
https://hub.docker.com/r/feofanyq/todoapp

---

## Setup

### 1. Create a Docker network

A shared user-defined network lets containers resolve each other by name instead of relying on IP addresses, which can change whenever a container is recreated.

```bash
docker network create todoapp-net
```

### 2. Create a volume for persistent MySQL data

```bash
docker volume create mysql-data
```

### 3. Run the MySQL container on the network

```bash
docker run -d \
  --name mysql-local \
  --network todoapp-net \
  -v mysql-data:/var/lib/mysql \
  feofanyq/mysql-local:1.0.0
```

The MySQL container uses:

- Database: `app_db`
- User: `app_user`
- Password: `1234`
- Port: `3306`

Because both containers will share the `todoapp-net` network, the Django app can reach MySQL using the container name `mysql-local` as the hostname — no IP lookup needed.

### 4. Set the database host in `todolist/settings.py`

```python
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': 'mysql-local',
        'PORT': '',
    }
}
```

### 5. Build the application image

```bash
docker build -t todoapp:2.0.0 .
```

### 6. Run the application container on the same network

```bash
docker run -d \
  --name todoapp \
  --network todoapp-net \
  -p 8080:8080 \
  feofanyq/todoapp:2.0.0
```

---

## Access the application

Open the application in a web browser:

http://localhost:8080

---

## Setup order

Because `manage.py migrate` runs during the Django image build, and the app connects to MySQL by container name, the steps above must be followed in this order:

1. Create the shared Docker network
2. Create the MySQL volume
3. Start the MySQL container on the network
4. Set `HOST` to `mysql-local` in `todolist/settings.py`
5. Build the `todoapp` image
6. Run the `todoapp` container on the same network