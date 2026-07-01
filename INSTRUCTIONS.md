# DevOps TodoList Docker Core (Flask + MySQL Volumes)

---

## 1. Docker Hub Repositories
- **Database Image**: [https://docker.com](https://docker.com)
- **Application Image**: [https://docker.com](https://docker.com)

---

## 2. Build Docker images
```bash
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
docker build -t todoapp:2.0.0 .
```

---

## 3. Database & Volumes setup
```bash
docker run -d \
  --name mysql-container \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```

---

## 4. Application start
```bash
docker run -d \
  --name app-container \
  -p 8080:8080 \
  --link mysql-container:db \
  todoapp:2.0.0
```

The application will be available at: [http://localhost:8080](http://localhost:8080)
