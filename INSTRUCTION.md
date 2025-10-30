# INSTRUCTION.md

This is an instruction for running the MySQL container and the Django ToDo App.

## 1. Run MySQL container with volume attached

Build the MySQL image (based on `Dockerfile.mysql`):
```bash
docker build -f Dockerfile.mysql -t zhevlakow/mysql-local:1.0.0 .
```

Run the container with a named volume:
```bash
docker run -d --name mysql-container -p 3306:3306 -v mysql-data:/var/lib/mysql zhevlakow/mysql-local:1.0.0
```

## 2. Run the App container connected to MySQL

Find the IP address of the running MySQL container:
```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-container
```

Update the Django settings (`todolist/settings.py`) with this IP in the `DATABASES` section.

Now build the app image:
```bash
docker build -t zhevlakow/todoapp:2.0.0 .
```

Run the app container and map it to port 8080:
```bash
docker run -d --name todoapp-container -p 8080:8080 zhevlakow/todoapp:2.0.0
```

## 3. Docker Hub repository

The application images are available on Docker Hub:
* [zhevlakow/todoapp](https://hub.docker.com/r/zhevlakow/todoapp)
* [zhevlakow/mysql-local](https://hub.docker.com/r/zhevlakow/mysql-local)

## 4. Access the application

After starting the app container, open your browser and go to:
```
http://localhost:8080/
```