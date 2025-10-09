# TodoList Application - Detailed Instructions

This guide will help you run the TodoList application using Docker containers with MySQL database and persistent volumes.

## Prerequisites

- Docker installed on your system
- Docker Hub account (for publishing images)
- Basic knowledge of Docker commands

---

## 1. Creating Volume for MySQL

### Q: How to create a volume for MySQL?

**A:** First, create a volume to store MySQL data:

```bash
docker volume create my-mysql-data
```

**Explanation:** 
- `my-mysql-data` - name of the volume that will store MySQL data
- This volume ensures data persistence between container restarts
- Data is preserved even after container deletion

**Verification:**
```bash
docker volume ls
docker volume inspect my-mysql-data
```

---

## 2. Building Images

### Q: How to build MySQL and application images?

**A:** Build both images with correct tags:

```bash
# Build MySQL image
docker build -t demops096/mysql-local:1.0.0 -f Dockerfile.mysql .

# Build application image
docker build -t demops096/todoapp:2.0.0 .
```

**Parameter explanations:**
- `-t` - sets image tag (name:version)
- `-f Dockerfile.mysql` - specifies particular Dockerfile for MySQL
- `demops096` - your Docker Hub username
- `mysql-local:1.0.0` - tag for MySQL image
- `todoapp:2.0.0` - tag for application

**Build verification:**
```bash
docker images | grep demops096
```

---

## 3. Publishing to Docker Hub

### Q: How to publish images to Docker Hub?

**A:** First login to Docker Hub, then publish images:

```bash
# Login to Docker Hub
docker login

# Push MySQL image
docker push demops096/mysql-local:1.0.0

# Push application image
docker push demops096/todoapp:2.0.0
```

**Explanation:**
- `docker login` - authorization in Docker Hub
- `docker push` - uploading image to repository
- After publishing, images will be available to everyone

**Publication verification:**
- Go to https://hub.docker.com/r/demops096/mysql-local
- Go to https://hub.docker.com/r/demops096/todoapp

---

## 4. Downloading Ready Images

### Q: How to download ready images from Docker Hub?

**A:** If you want to use already built images:

```bash
# Download MySQL image
docker pull demops096/mysql-local:1.0.0

# Download application image
docker pull demops096/todoapp:2.0.0
```

**Download verification:**
```bash
docker images demops096/*
```

---

## 5. Creating Network

### Q: How to create network for containers?

**A:** Create a custom network for container communication:

```bash
docker network create todonet
```

**Explanation:**
- `todonet` - network name
- Custom network allows containers to find each other by name
- Better than `--link` (deprecated approach)

**Network verification:**
```bash
docker network ls
docker network inspect todonet
```

---

## 6. Running MySQL Container

### Q: How to run MySQL container with volume?

**A:** Run MySQL container with volume and in network:

```bash
docker run -d \
  --network todonet \
  --name my-mysql \
  -v my-mysql-data:/var/lib/mysql \
  demops096/mysql-local:1.0.0
```

**Parameter explanations:**
- `-d` - run in background mode (detached)
- `--network todonet` - connect to network
- `--name my-mysql` - container name
- `-v my-mysql-data:/var/lib/mysql` - attach volume
- `demops096/mysql-local:1.0.0` - image to run

**MySQL startup verification:**
```bash
docker ps | grep my-mysql
docker logs my-mysql
```

**Expected log result:**
```
[Note] mysqld: ready for connections.
```

---

## 7. Running Application

### Q: How to run application that connects to MySQL?

**A:** Run application in the same network with environment variable configuration:

```bash
docker run -d \
  --network todonet \
  --name todoapp \
  -p 8000:8000 \
  -e MYSQL_HOST=my-mysql \
  demops096/todoapp:2.0.0
```

**Parameter explanations:**
- `--network todonet` - same network as MySQL
- `--name todoapp` - application container name
- `-p 8000:8000` - port mapping (host:container)
- `-e MYSQL_HOST=my-mysql` - environment variable for MySQL connection
- `demops096/todoapp:2.0.0` - application image

**Application startup verification:**
```bash
docker ps | grep todoapp
docker logs todoapp
```

---

## 8. Accessing Application

### Q: How to open application in browser?

**A:** Go to the following address in your browser:

**Main URLs:**
- **Home page:** http://localhost:8000
- **Admin panel:** http://localhost:8000/admin/
- **API:** http://localhost:8000/api/

**Test steps:**
1. Open http://localhost:8000
2. Create a new task list
3. Add tasks to the list
4. Verify that data is saved

---

## 9. Verification

### Q: How to verify everything works?

**A:** Execute a series of commands for verification:

```bash
# Check container status
docker ps

# Check MySQL logs
docker logs my-mysql

# Check application logs
docker logs todoapp

# Check database connection from application
docker exec -it todoapp python manage.py dbshell
```

**Expected `docker ps` result:**
```
CONTAINER ID   IMAGE                          COMMAND                  CREATED         STATUS         PORTS                    NAMES
abc123def456   demops096/todoapp:2.0.0        "python manage.py ru…"   2 minutes ago   Up 2 minutes   0.0.0.0:8000->8000/tcp   todoapp
def456ghi789   demops096/mysql-local:1.0.0    "docker-entrypoint.s…"   3 minutes ago   Up 3 minutes   3306/tcp                 my-mysql
```

---

## 10. Working with Tags

### Q: What to do if built locally without username?

**A:** Use docker tag to add correct tag:

```bash
# Add tag to MySQL image
docker tag mysql-local:1.0.0 demops096/mysql-local:1.0.0

# Add tag to application image
docker tag todoapp:2.0.0 demops096/todoapp:2.0.0

# Verify new tags
docker images | grep demops096
```

**Explanation:**
- `docker tag` creates a new tag for existing image
- Does not create a copy, only an additional tag
- Allows publishing images with correct name

---

## 11. Stopping and Cleanup

### Q: How to stop everything?

**A:** Stop containers and remove resources:

```bash
# Stop containers
docker stop todoapp my-mysql

# Remove containers
docker rm todoapp my-mysql

# Remove network
docker network rm todonet

# Optionally: remove volume (WARNING: data loss!)
# docker volume rm my-mysql-data
```

**Explanation:**
- `docker stop` - stops containers
- `docker rm` - removes containers
- `docker network rm` - removes network
- Volume remains for data preservation

---

## 12. Troubleshooting

### Q: What to do if it doesn't work?

**A:** Perform diagnostics step by step:

**1. Container status check:**
```bash
docker ps
docker ps -a  # including stopped ones
```

**2. Log checking:**
```bash
docker logs todoapp
docker logs my-mysql
```

**3. Network verification:**
```bash
docker network ls
docker network inspect todonet
```

**4. Connection verification:**
```bash
# Check if application can reach MySQL
docker exec -it todoapp ping my-mysql

# Check database settings
docker exec -it todoapp env | grep MYSQL
```

**5. Port verification:**
```bash
docker port todoapp
netstat -tlnp | grep 8000  # Linux
lsof -i :8000  # macOS
```

**Common problems and solutions:**

| Problem | Solution |
|---------|----------|
| Container won't start | `docker logs <container_name>` |
| Port is busy | Change port or stop process |
| MySQL not accessible | Check network and logs |
| App can't connect to DB | Check MYSQL_HOST variable |

---

## 13. Useful Commands

**Resource monitoring:**
```bash
docker stats
docker system df
```

**System cleanup:**
```bash
docker system prune  # remove unused resources
docker image prune   # remove unused images
```

**Data backup:**
```bash
# Create database backup
docker exec my-mysql mysqldump -u app_user -p1234 app_db > backup.sql

# Restore from backup
docker exec -i my-mysql mysql -u app_user -p1234 app_db < backup.sql
```

---

## Support

If problems occur:
1. Check container logs
2. Ensure all ports are free
3. Check network connection between containers
4. Make sure environment variables are set correctly

**Useful links:**
- Docker documentation: https://docs.docker.com/
- Django documentation: https://docs.djangoproject.com/
- MySQL documentation: https://dev.mysql.com/doc/