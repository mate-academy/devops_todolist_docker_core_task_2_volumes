# Instruction

## Docker Hub Repository

App image is available at:
**[https://hub.docker.com/r/dimonalek/todoapp](https://hub.docker.com/r/dimonalek/todoapp)**

---

## How DB Host Discovery Works

The app reads the MySQL host from the `DB_HOST` environment variable:

```python
'HOST': os.environ.get('DB_HOST', 'localhost')
```

- When running **locally** (without Docker): defaults to `localhost`
- When running **in Docker**: pass `-e DB_HOST=mysql-local` to point to the MySQL container by its hostname on the shared network

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
  dimonalek/mysql-local:1.0.0
```

Wait a few seconds for MySQL to fully initialize before proceeding.

---

## Step 3: Run the App Container

Pass `DB_HOST=mysql-local` so the app connects to the MySQL container by its hostname on the Docker network.

The Django server inside the container binds to `0.0.0.0:8080`, mapped to port **8080** on your host:

```bash
docker run -d \
  --name todoapp \
  --network todoapp-network \
  -e DB_HOST=mysql-local \
  -p 8080:8080 \
  dimonalek/todoapp:2.0.0
```

> **Port mapping:**
> - `http://localhost:8080` — containerized app (Docker, port 8080 → 8080)
> - `http://localhost:8000` — local dev only (`python manage.py runserver`, default Django port)

---

## Step 4: Run Database Migrations

After the app container starts, apply Django migrations to create the database schema:

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
