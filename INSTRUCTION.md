# Instructions to run the Todo Application

## 1. Run MySQL Container with Volume
To start the MySQL database container with persistent data storage, run the following command:
```bash
docker run -d --name todo-mysql -v todo-db-data:/var/lib/mysql mysql:8.0
```

## 2. Run Application Container
To start the Django application container and connect it to the running MySQL database, execute:
```bash
docker run -d -p 8080:8080 --name todoapp-container 1ntact/todoapp:2.0.0
```

## 3. Docker Hub Repository
The application image is hosted on Docker Hub:
https://hub.docker.com/r/1ntact/todoapp

## 4. Access the Application
Once both containers are running, you can access the application via your web browser at:
http://localhost:8080
