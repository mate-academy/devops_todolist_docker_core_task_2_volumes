# Create a Docker volume for MySQL persistent data
docker volume create mysql_data

# Run MySQL container with the created volume
docker run -d \
  --name mysql-local \
  -v mysql_data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -p 3306:3306 \
  your_dockerhub_username/mysql-local:1.0.0

Run Python App Container Connected to MySQL
  docker run -d \
  --name todoapp \
  --link mysql-local:mysql \
  -e DB_HOST=mysql-local \
  -e DB_NAME=app_db \
  -e DB_USER=app_user \
  -e DB_PASSWORD=1234 \
  -p 8000:8000 \
  your_dockerhub_username/todoapp:2.0.0

  https://hub.docker.com/repository/docker/bohdansukhy/todoapp/general

  http://localhost:8000

