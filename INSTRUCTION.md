# Django-Todolist — Docker Instructions

## Docker Hub

### MySQL image

Docker Hub repository:

https://hub.docker.com/r/ericca0203/mysql-local

Image:

```text
ericca0203/mysql-local:1.0.0
```

### Application image

Docker Hub repository:

https://hub.docker.com/r/ericca0203/todoapp

Image:

```text
ericca0203/todoapp:2.0.0
```

---

## 1. Create a Docker volume for MySQL

Create a persistent volume for MySQL data:

```bash
docker volume create mysql_data
```

---

## 2. Build the MySQL image

Build the MySQL image from `Dockerfile.mysql`:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

Tag the image for Docker Hub:

```bash
docker tag mysql-local:1.0.0 ericca0203/mysql-local:1.0.0
```

Push the image to Docker Hub:

```bash
docker push ericca0203/mysql-local:1.0.0
```

---

## 3. Run the MySQL container

Run the MySQL container with the persistent volume attached:

```bash
docker run -d --name mysql-local -v mysql_data:/var/lib/mysql mysql-local:1.0.0
```

Check that the container is running:

```bash
docker ps
```

Check MySQL logs:

```bash
docker logs mysql-local
```

MySQL should report:

```text
MySQL init process done. Ready for start up.
```

and:

```text
ready for connections
```

---

## 4. Get the MySQL container IP address

Get the IP address of the running MySQL container:

```bash
docker inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}" mysql-local
```

Example:

```text
172.17.0.5
```

Use the IP address returned by Docker in `todolist/settings.py`.

---

## 5. Configure the Django database connection

Open:

```text
todolist/settings.py
```

Update the `DATABASES` configuration:

```python
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': '172.17.0.5',
        'PORT': '3306',
    }
}
```

Replace `172.17.0.5` with the actual IP address of the running MySQL container if it is different.

---

## 6. Install Python dependencies

The project requires the MySQL connector:

```text
mysql-connector-python==8.2.0
```

Install all project dependencies:

```bash
pip install -r requirements.txt
```

---

## 7. Build the Django application image

Build the application image:

```bash
docker build -t todoapp:2.0.0 .
```

Tag the image for Docker Hub:

```bash
docker tag todoapp:2.0.0 ericca0203/todoapp:2.0.0
```

Push the image to Docker Hub:

```bash
docker push ericca0203/todoapp:2.0.0
```

---

## 8. Run the Django application container

Run the application container:

```bash
docker run -d --name todoapp-v2 -p 8080:8080 todoapp:2.0.0
```

Check that both MySQL and Django containers are running:

```bash
docker ps
```

The following containers should be running:

```text
mysql-local
todoapp-v2
```

---

## 9. Access the application

Open the application in a web browser:

```text
http://localhost:8080
```

The Django ToDo application should be displayed.

---

## 10. Useful Docker commands

Check running containers:

```bash
docker ps
```

Check all containers:

```bash
docker ps -a
```

Check MySQL logs:

```bash
docker logs mysql-local
```

Check application logs:

```bash
docker logs todoapp-v2
```

Stop the application container:

```bash
docker stop todoapp-v2
```

Stop the MySQL container:

```bash
docker stop mysql-local
```

Remove the application container:

```bash
docker rm todoapp-v2
```

Remove the MySQL container:

```bash
docker rm mysql-local
```

The MySQL data remains stored in the `mysql_data` volume.

---

## 11. Docker Hub repositories

MySQL repository:

https://hub.docker.com/r/ericca0203/mysql-local

Application repository:

https://hub.docker.com/r/ericca0203/todoapp

MySQL image:

```text
ericca0203/mysql-local:1.0.0
```

Application image:

```text
ericca0203/todoapp:2.0.0
```