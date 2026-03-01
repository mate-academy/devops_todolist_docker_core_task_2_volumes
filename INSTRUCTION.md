# Repository
https://hub.docker.com/repository/docker/ivanoid777/todoapp/general
https://hub.docker.com/repository/docker/ivanoid777/mysql-local/general
# -------- Dockerfile --------

# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder

# Set the working directory
WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN python manage.py migrate

# Run database migrations and start the Django application
ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8080"]

# -------- Dockerfile.mysql --------
FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=toor
ENV MYSQL_DATABASE=app_db
ENV MYSQL_USER=app_user
ENV MYSQL_PASSWORD=1234

EXPOSE 3306
VOLUME /var/lib/mysql

# -------- How to build and run --------
# 1. Set up a network
docker network create <todo_net>

# 2. Change the todolist/settings.py on 64 line()
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': 'mysql-local',  # You can use a different host in your MySQL server is on a remote machine.
        'PORT': '',  # Leave this empty to use the default MySQL port (3306).
    }

# 3. Build image from Dockerfile.mysql
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .

# 4. Run mysql container
docker run --name mysql-local \
-v <path>:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=<root_password> \
-d \
--network <todo_net> \
mysql-local:1.0.0


# 5. Build image from Dockerfile
docker build -t todoapp:2.0.0 .

# 6. Run app container 
docker run \
--name todoapp \
-d \
-p <host_port>:<container_port> \
--network <todo_net> \
todoapp:2.0.0

# 7. Open in browser
http://127.0.0.1:<host_port>