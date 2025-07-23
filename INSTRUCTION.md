## 📦 Docker Hub Repository

The Docker image for the application is publicly available on Docker Hub:

🔗 **[Docker app image](https://hub.docker.com/layers/gseniv/todoapp/2.0.0/images/sha256-bbacf23ab1f1e8edd2287fa46e96aab199bc984b5607f2d957052a8135ae3d56)**


🔗 **[Docker mysql image](https://hub.docker.com/layers/gseniv/mysql-local/1.0.0/images/sha256-e7d93a9d5aaecaf6d2f0d7f70ee1d4ce9ffda3a974bb97ad08a163caa1fdacf0)**

You can pull it directly using:

```bash
docker pull gseniv/todoapp:2.0.0
docker pull gseniv/mysql-local:1.0.0
```

---

## 🛠 Build and Run Locally

### ✅ Step 1: Build the Docker image

Make sure you're in the root project directory (where the Dockerfile is located), then run:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
docker build . -t todoapp:2.0.0
```

### ✅ Step 2: Run the container

Use the following command to run the container:

```bash
docker run -d -p 3306:3306 --name mysql-local -v mysql-data:/var/lib/mysql mysql-local:1.0.0
docker run --name todoapp -p 8080:8080 todoapp:2.0.0
```

## 🌐 Accessing the Application

Once the container is running, open your browser and visit:

👉 **[http://localhost:8080](http://localhost:8000)**

This will load the main page of your application.
