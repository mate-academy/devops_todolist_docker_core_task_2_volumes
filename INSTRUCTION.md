# Instruction

## Docker Hub Repository

App image is available at:
**[https://hub.docker.com/r/dimonalek/todoapp](https://hub.docker.com/r/dimonalek/todoapp)**

---

## Step 1: Create a Docker Network

Create a dedicated network so the app and MySQL containers can communicate by name:

```bash
docker network create todoapp-network
```

---

## Step 2: Run MySQL Container with a Volume

Run the MySQL container with a named volume to persist database data:

```bash
docker run -d \
  --name mysql-local \
  --network todoapp-network \
  -v mysql-data:/var/lib/mysql \
  mysql-local:1.0.0
```

Or pull and run directly from Docker Hub:

```bash
docker run -d \
  --name mysql-local \
  --network todoapp-network \
  -v mysql-data:/var/lib/mysql \
  dimonalek/mysql-local:1.0.0
```

Wait a few seconds for MySQL to fully initialize before proceeding.

---

## Step 3: Run the App Container

Run the application container connected to the same network.
The app runs on port **8080** inside the container, mapped to port **8080** on your host:

```bash
docker run -d \
  --name todoapp \
  --network todoapp-network \
  -p 8080:8080 \
  dimonalek/todoapp:2.0.0
```

> **Note on ports:**
> - `http://localhost:8080` — access the **containerized** app (Docker)
> - `http://localhost:8000` — access the app when running locally via `python manage.py runserver` (default Django dev server port)

---

## Step 4: Run Database Migrations

After the app container starts, run Django migrations to create the database schema:

```bash
docker exec todoapp python manage.py migrate
```

> This step is required on first run or after any model changes.

---

## Step 5: Access the Application

Once migrations are complete, open your browser and navigate to:

- **Landing page:** [http://localhost:8080](http://localhost:8080)
- **API:** [http://localhost:8080/api/](http://localhost:8080/api/)

---

## Useful Commands

Check running containers:
```bash
docker ps
```

View app logs:
```bash
docker logs todoapp
```

View MySQL logs:
```bash
docker logs mysql-local
```

Stop and remove containers:
```bash
docker stop todoapp mysql-local
docker rm todoapp mysql-local
```

Remove the volume (this will delete all database data):
```bash
docker volume rm mysql-data
```
