# Django TodoList — Docker Instructions

## Docker Hub Repository

**Application image:**
[https://hub.docker.com/r/yaroslapelenychka/todoapp](https://hub.docker.com/r/yaroslapelenychka/todoapp)

---

## 1. Run MySQL container with a volume attached

### Pull or build MySQL image

```bash
docker pull yaroslapelenychka/mysql-local:1.0.0
```

### Run MySQL container

```bash
docker run -d \
  --name mysql-db \
  -p 3306:3306 \
  -v mysql_data:/var/lib/mysql \
  yaroslapelenychka/mysql-local:1.0.0
```

### MySQL credentials

- **Database:** `app_db`
- **User:** `app_user`
- **Password:** `1234`
- **Host:** `127.0.0.1`
- **Port:** `3306`

### Verify MySQL is running

```bash
docker exec -it mysql-db mysql -uapp_user -p1234 -D app_db -e "SELECT 1;"
```

---

## 2. Run Django application container

### Pull application image

```bash
docker pull yaroslapelenychka/todoapp:2.0.0
```

### Run application container

```bash
docker run -d \
  --name todoapp \
  -p 8080:8080 \
  yaroslapelenychka/todoapp:2.0.0
```

> ⚠️ The application is configured to connect to the MySQL database using the host IP of the running MySQL container.

---

## 3. Access the application via browser

Open your browser and go to:

```
http://localhost:8080
```

You should see the Django TodoList application running successfully.

---

## 4. Notes

- Make sure port **3306** is not used by another local MySQL instance.
- Docker volume `mysql_data` ensures MySQL data persistence between container restarts.
- The Django application runs migrations automatically on startup.

---

## 5. Validation

- Application image pushed with tag: **todoapp:2.0.0**
- MySQL image pushed with tag: **mysql-local:1.0.0**
- Containers start successfully and communicate correctly

---

✅ Project is ready for review and validation.
