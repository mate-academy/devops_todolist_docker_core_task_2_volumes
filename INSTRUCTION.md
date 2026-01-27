# Django TodoList — Docker Instructions

## Docker Hub Repository

**Application image:**
[https://hub.docker.com/r/yaroslapelenychka/todoapp](https://hub.docker.com/r/yaroslapelenychka/todoapp)

---

## 1. Create Docker network

Create a shared Docker network so containers can communicate using container names:

```bash
docker network create todo-network
```

---

## 2. Run MySQL container with a volume attached

### Pull MySQL image

```bash
docker pull yaroslapelenychka/mysql-local:1.0.0
```

### Run MySQL container

```bash
docker run -d \
  --name mysql-db \
  --network todo-network \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  yaroslapelenychka/mysql-local:1.0.0
```

### MySQL credentials

- **Database:** `app_db`
- **User:** `app_user`
- **Password:** `1234`
- **Host:** `mysql-db`
- **Port:** `3306`

### Verify MySQL is running

```bash
docker exec -it mysql-db mysql -uapp_user -p1234 -D app_db -e "SELECT 1;"
```

---

## 3. Run Django application container

### Pull application image

```bash
docker pull yaroslapelenychka/todoapp:2.0.0
```

### Run application container

```bash
docker run -d \
  --name todoapp \
  --network todo-network \
  -p 8080:8080 \
  yaroslapelenychka/todoapp:2.0.0
```

> The application connects to the MySQL database using the container name `mysql-db`.

---

## 4. Access the application via browser

Open your browser and go to:

```text
http://localhost:8080
```

---

## 5. Notes

- Docker volume `mysql_data` is used to persist MySQL data.
- Make sure ports **3306** and **8080** are not used by other applications.
- Both containers must be started inside the same Docker network.

---

## 6. Validation checklist

- MySQL container running with volume attached
- Django application container running successfully
- Containers communicate via Docker network
- Application accessible via browser

---

✅ Project is ready for review and validation.
