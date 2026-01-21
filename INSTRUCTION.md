## **Part 1: MySQL Database Container Setup**
### *Step 1: Build MySQL Image*
Build the MySQL Docker image from the `Dockerfile.mysql`:
```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

### *Step 2: Create Docker Volume for MySQL Data Persistence*
Create a Docker volume to persist MySQL data:
```bash
docker volume create mysql-data
```

### *Step 3: Run MySQL Container with Volume*
Run the MySQL container with the volume attached:
```bash
docker run -d \
  --name mysql-container \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  mysql-local:1.0.0
```

### *Step 4: Verify MySQL Container is Running*
Check that the MySQL container is running:
```bash
docker ps
```

### *Step 5: Get MySQL Container IP Address*
```bash
docker inspect mysql-container | findstr "IPAddress"
```

## **Part 2: Django Application Container Setup**
### *Step 6: Update Database Configuration*
Open `todolist/settings.py` and update the `HOST` field in the `DATABASES` configuration with the MySQL container's IP address:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': '172.17.0.2',
        'PORT': '3306',
        'OPTIONS': {
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'",
        }
    }
}
```
**Note:** Replace `172.17.0.2` with the actual IP address you obtained in Step 5.

### *Step 7: Build Django Application Image*
Build the Django application Docker image:
```bash
docker build -t todoapp:2.0.0 .
```

### *Step 8: Run Django Application Container*
Run the Django application container:
```bash
docker run -d \
  --name todoapp-container \
  -p 8080:8080 \
  todoapp:2.0.0
```

### *Step 9: Verify Application is Running*
Check the container logs to ensure the application started successfully:
```bash
docker logs todoapp-container
```

## **Part 3: Accessing the Application**
### *Step 10: Open in Browser*
Open your web browser and navigate to:

```
http://localhost:8080
```
You should see the Django-Todolist landing page.

## **Docker Hub Repository**
The application image is available on Docker Hub:
**Repository:** `nbkm29/todoapp:2.0.0`
