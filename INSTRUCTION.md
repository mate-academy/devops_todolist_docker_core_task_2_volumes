# TodoApp + MySQL — Docker runbook

## 1. Build the MySQL image
```bash
docker build -f Dockerfile.mysql -t difuz1x/mysql-local:1.0.0 .
```

## 2. Create a volume for the database
```bash
docker volume create MySQL-local
```

## 3. Run the MySQL container
```bash
docker run -d \
  --name mysql-local \
  -v MySQL-local:/var/lib/mysql \
  -p 3306:3306 \
  --restart unless-stopped \
  difuz1x/mysql-local:1.0.0
```

## 4. Get the container IP for settings.py
Add this IP as `HOST` in the `DATABASES` section of `todolist/settings.py`.
```bash
# Clean output — prints only the IP
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local

# Or the original one-liner
docker container inspect mysql-local | grep -i "IPAddress"
```

## 5. Build the app image
```bash
docker build -f Dockerfile -t difuz1x/todoapp:2.0.0 .
```

## 6. Run the app container
```bash
docker run -d \
  --name todoapp2 \
  -p 8080:8080 \
  difuz1x/todoapp:2.0.0
```

App is available at http://localhost:8080

---

https://hub.docker.com/repository/docker/difuz1x/todoapp/general


https://hub.docker.com/repository/docker/difuz1x/mysql-local