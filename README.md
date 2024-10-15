MySQL image: https://hub.docker.com/repository/docker/levandrii1/mysql-local/general
Todoapp image: https://hub.docker.com/repository/docker/levandrii1/todoapp/general

## Instructions

1. Pull both images:
```bash
docker pull levandrii1/mysql-local:1.0.0
docker pull levandrii1/todoapp:2.0.0
```

2. Run MySQL container: 
```bash
docker run --name mysql_container -v mysql_data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root_password -d mysql-local:1.0.0
```

3. Open settings.py, edit the HOST setting in the DATABASES section on line #70 with your mysql_container IP address.

4. Build and run the app container:
```bash
docker run --name todoapp_container -p 8080:8080 todoapp:2.0.0
```

5. Access the app in your web browser at: http://localhost:8080/
