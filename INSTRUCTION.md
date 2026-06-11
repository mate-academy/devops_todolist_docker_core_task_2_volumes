# **Instructions to Run the Todo Application**

This project consists of a Python/Django application and a custom MySQL database environment.

## **1. Run Custom MySQL Container with Volume**
The MySQL database image is built using `Dockerfile.mysql`, which automatically initializes the `app_db` database and `app_user` credentials via built-in environment variables.

To start the custom MySQL database container with persistent data storage, run:
```bash
docker run -d --name todo-mysql -v todo-db-data:/var/lib/mysql 1ntact/mysql-local:1.0.0
```

## 2. **Container Connectivity (Networking)**
The Django application connects to the MySQL container using its IP address. 

### **Step 2.1: Find the MySQL Container IP**
Since the application container depends on the database, **always start the MySQL container first**. Once it is running, find its dynamic IP address by running this command in your terminal:
```bash
docker inspect todo-mysql
```

### **Step 2.2: Update Settings**
Take the IP address from the output (usually 172.17.0.2) and make sure it matches the HOST field in your todolist/settings.py

## **3. Run Application Container**
To start the Django application container and connect it to the running MySQL database, execute:
```bash
docker run -d -p 8080:8080 --name todoapp-container 1ntact/todoapp:2.0.0
```
## **4. Docker Hub Repositories**
Both images are hosted on the personal Docker Hub repository:
*     Application Image: https://hub.docker.com/r/1ntact/todoapp
*     Custom MySQL Image: https://hub.docker.com/r/1ntact/mysql-local
## **5. Access the Application**
Once both containers are running, you can access the application via your web browser at:
http://localhost:8080
