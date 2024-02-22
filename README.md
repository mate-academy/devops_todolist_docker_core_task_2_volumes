For using amazing todo application with database please follow instruction below
1. Build new image for MYsql dataBase by executing
```
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
```
2. Run container with this image in your local machine
```
docker run -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
```
3. Build new image for MYsql dataBase by executing
```
docker build . -t todoapp:2.0.0
```
4. Run container with this image in your local machine
```
docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0
```
5. You can enjoy fantastic todo application on http://0.0.0.0:8080/

You could download docker images from:
- [mysql-local](https://hub.docker.com/r/rozdorozhnii/mysql-local/)
- [todoapp:2.0.0](https://hub.docker.com/layers/rozdorozhnii/todoapp/2.0.0/images/sha256-d89f7be74770e6e4dee36b8e67b7864fb339899380d41a99ea0ffba32eb6c45b/)
