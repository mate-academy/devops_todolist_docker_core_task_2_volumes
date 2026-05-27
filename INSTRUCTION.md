# Instruction

## 1. Run MySQL container with volume

```bash
docker run -d \
  --name mysql-container \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  tanyasavenko/mysql-local:1.0.0
```

## 2. Get MySQL container IP

```bash
docker inspect mysql-container | grep IPAddress
```

## 3. Run App container connected to MySQL

```bash
docker run -d \
  --name app-container \
  --link mysql-container:mysql \
  -p 8080:8080 \
  tanyasavenko/todoapp:2.0.0
```

## 4. Access the application

Open your browser and go to:
```
http://localhost:8080
```
