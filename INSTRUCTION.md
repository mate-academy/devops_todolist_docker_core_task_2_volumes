# ToDo App in Docker

## Docker Hub Repository
[Docker Hub Repository Link](https://hub.docker.com/repository/docker/beliar25/todoapp2.0/general)
[Mysql](https://hub.docker.com/repository/docker/beliar25/mysql-test-db/general)

## Build and Run Instructions

### Build the Docker Image
To build the Docker image, run the following command:
```bash
# Run App container
docker run -p 8080:8080 --name app app:1.0

# Build App image
docker build . -f Dockerfile -t app:1.0

# Run MySQL container
docker run -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql my-sql:1.0

# Build MySQL image
docker build . -f Dockerfile.mysql -t my-sql:1.0

