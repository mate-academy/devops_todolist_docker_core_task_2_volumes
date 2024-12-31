# Instructions to Run MySQL and App Containers


## Running MySQL Container with Volume Attached
```bash
docker run -d --name mysql-container --env-file .env -v ~/mysql-data:/var/lib/MySQL -p 3306:3306 mysql-local:1.0.0
```

## Running App Container with Volume Attached
```bash
docker run -d --name todoapp-container --env-file .env -p 8000:8080 todoapp:2.0.0
```
## Accessing the Application

Open your browser and go to: http://localhost:8000

## Docker Hub Repositories
MySQL Image: 88victory88/mysql-local
App Image: 88victory88/todoapp