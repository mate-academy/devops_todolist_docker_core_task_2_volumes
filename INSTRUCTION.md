# Django-Todolist — Docker Instructions

## Docker Hub

### MySQL image

Docker Hub repository: ericca0203/mysql-local

Image:

```text
ericca0203/mysql-local:1.0.0
```

### Application image

Docker Hub repository: ericca0203/todoapp

Image:

```text
ericca0203/todoapp:2.0.0
```

---

## 1. Create a Docker volume for MySQL

Create a persistent volume for MySQL data:

```bash
docker volume create mysql-data
```

---

## 2. Run MySQL container

Run the MySQL container using the `mysql-local:1.0.0` image with the volume attached:

```bash
docker run -d --name mysql-local -v mysql-data:/var/lib/mysql mysql-local:1.0.0
```

Check that the MySQL container is running:

```bash
docker ps
```

The container should have the status:

```text
Up
```

Check the MySQL container logs:

```bash
docker logs mysql-local
```

MySQL should report:

```text
MySQL init process done. Ready for start up.
```

---

## 3. Get the MySQL container IP address

Get the IP address of the running MySQL container:

```bash
docker inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}" mysql-local
```

Example:

```text
172.17.0.5
```

Use the IP address returned by Docker as the database host.

---

## 4. Configure Django database connection

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
        'PORT': '',
    }
}
```

Replace `172.17.0.5` with the actual IP address of the running MySQL container if it is different.

---

## 5. Build the Django application image

Build the application image with tag `todoapp:2.0.0`:

```bash
docker build -t todoapp:2.0.0 .
```

Check the image:

```bash
docker images
```

---

## 6. Run the Django application container

Run the application container and expose port `8080`:

```bash
docker run -d --name todoapp-v2 -p 8080:8080 todoapp:2.0.0
```

Check that both containers are running:

```bash
docker ps
```

The following containers should be running:

```text
mysql-local
todoapp-v2
```

---

## 7. Access the application

Open the application in a web browser:

```text
http://localhost:8080
```

The Django ToDo application should be displayed.

---

## 8. Docker Hub images

The MySQL image:

```text
ericca0203/mysql-local:1.0.0
```

The Django application image:

```text
ericca0203/todoapp:2.0.0
```

Both images are available in the Docker Hub repositories.

---

## 9. Useful Docker commands

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

Stop the application:

```bash
docker stop todoapp-v2
```

Stop MySQL:

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

The MySQL data remains stored in the `mysql-data` volume.

---

## 10. Docker Hub

Application repository:

ericca0203/todoapp

MySQL repository:

ericca0203/mysql-local