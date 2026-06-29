# INSTRUCTION

## Running the MySQL container with a volume

**1. Build the MySQL image:**

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

**2. Run the container with an attached volume:**

```bash
docker run -d -p 3306:3306 --name my-mysql -v mysql-data:/var/lib/mysql mysql-local:1.0.0
```

**3. Verify that the database is ready:**

```bash
docker logs my-mysql
```

Look for the line `ready for connections` in the output — it means the database has started and is accepting connections.

## Running the application

**1. Find the IP address of the MySQL container:**

```bash
docker network inspect bridge
```

**2. Get the database IP.**

In the output, find the `IPv4Address` key inside the `Containers` section, for example `"IPv4Address": "172.17.0.2/16"`. Copy the address itself (`172.17.0.2`, without `/16`) and set it in `todolist/settings.py` under the `HOST` parameter:

```python
'HOST': '172.17.0.2',
```

**3. Build and run the application:**

Build the image:

```bash
docker build -t todoapp:2.0.0 .
```

Run the application:

```bash
docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0
```

> **Note:** the build connects to the database because `python manage.py migrate` runs during the build stage (`RUN` instruction). If the build fails with a database connection error, make sure the MySQL container is running and the IP is correct.

## A better approach: a user-defined network + container name

Hardcoding the IP is fragile — the IP in the default `bridge` network is not stable and may change when the container restarts. A cleaner way is to create your own (user-defined) network, where Docker provides automatic DNS, so containers can reach each other by name.

**1. Create a user-defined network:**

```bash
docker network create my-app
```

**2. Run both containers in this network:**

Database:

```bash
docker run -d -p 3306:3306 --name my-mysql --network my-app -v mysql-data:/var/lib/mysql mysql-local:1.0.0
```

Application:

```bash
docker run -d -p 8080:8080 --network my-app --name todoapp todoapp:2.0.0
```

**3. Use the container name instead of the IP** in `todolist/settings.py`:

```python
'HOST': 'my-mysql',
```

Docker's built-in DNS resolves the name `my-mysql` to the container's current IP, so a restart no longer breaks the connection.

## Docker Hub image links

- Database: https://hub.docker.com/repository/docker/trickykot3/mysql-local
- Application: https://hub.docker.com/repository/docker/trickykot3/todoapp

## Accessing the application via a browser

The application is available on the host machine at:

```
http://localhost:8080
```

## Screenshot of the running application

![Running application](https://snipboard.io/UhyJNK.jpg)