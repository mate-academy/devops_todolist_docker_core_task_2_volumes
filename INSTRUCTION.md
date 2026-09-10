

The public Docker image for this application is available at:
* **Docker Hub Link:** https://hub.docker.com/repository/docker/vadym192/mysql-local/
* **Image Name:** `vadym192/mysql-local`

---

## 1. Run MySQL Database Container with Volume

```docker run  -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0 ```

## 2. Run Application Container Connected to MySQL

```docker run -d -p 8080:8080 todoapp:2.0.0 ```

## Accessing the Application

Once the container is running:

Open your web browser.

Navigate to: http://localhost:8080 (or [http://127.0.0.1:8080](http://127.0.0.1:8080)).
