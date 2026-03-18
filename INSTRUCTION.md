# Instructions

## Docker Hub

- **App image:** [mutnenka/todoapp](https://hub.docker.com/r/mutnenka/todoapp) (tag: `2.0.0`)
- **MySQL image:** [mutnenka/mysql-local](https://hub.docker.com/r/mutnenka/mysql-local) (tag: `1.0.0`)

---

## 13. Run MySQL container with a volume attached

1. Create a network (so the app can reach MySQL by container name):

   ```bash
   docker network create todo-net
   ```

2. Run the MySQL container with a volume for data persistence:

   ```bash
   docker run -d --name mysql-todo --network todo-net -v mysql_data:/var/lib/mysql -p 3306:3306 mutnenka/mysql-local:1.0.0
   ```

   - `-v mysql_data:/var/lib/mysql` — data persists after the container is removed.
   - `--name mysql-todo` — container name (the app connects to this hostname).

---

## 14. Run the App container (connect to MySQL)

Ensure the MySQL container is running and on the same network, then:

```bash
docker run -d --name app-todo --network todo-net -p 8080:8080 mutnenka/todoapp:2.0.0
```

Or if you built the app image locally:

```bash
docker build . -t todoapp:2.0.0
docker run -d --name app-todo --network todo-net -p 8080:8080 todoapp:2.0.0
```

---

## 16. Access the application via a browser

- **Application:** http://localhost:8080
- **API:** http://localhost:8080/api/

The app listens on port **8080**; `-p 8080:8080` maps it to your machine.
