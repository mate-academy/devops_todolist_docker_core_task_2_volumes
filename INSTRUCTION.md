# Django Todolist + MySQL (Docker)

This project runs a Django Todolist application connected to a MySQL database using Docker networking and volumes.

## Docker Hub Images

- App image: `krizanivskak/todoapp:2.0.0`
- MySQL image: `krizanivskak/mysql-local:1.0.0`

---

## 1) Create a shared Docker network

```bash
docker network create todo-net
```

## 2) Run MySQL container with a volume attached
```bash
docker run -d --name mysql-container --network todo-net -v mysql_data:/var/lib/mysql -p 3306:3306 krizanivskak/mysql-local:1.0.0
```
**MySQL is initialized with:** \
Database: app_db \
User: app_user \
Password: 1234

## 3) Run Django application container (connects to MySQL container)
```bash
docker run -d --name todoapp-container --network todo-net -p 8080:8080 -e DB_NAME=app_db -e DB_USER=app_user -e DB_PASSWORD=1234 -e DB_HOST=mysql-container -e DB_PORT="" krizanivskak/todoapp:2.0.0
```

## 4) Apply Django migrations

Run migrations inside the running application container:
```bash
docker exec -it todoapp-container python manage.py migrate
```

## 5) Access the application in a browser

Open: http://localhost:8080