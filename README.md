1. Build MYSQL image
```
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
```
2. Run container
```
docker run -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
```
3. Build app
```
docker build . -t todoapp:2.0.0
```
4. Run app
```
docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0
```


Links:
- [mysql-local](https://hub.docker.com/repository/docker/vdzhyranov/mysql-local/general)
- [todoapp:2.0.0](https://hub.docker.com/layers/vdzhyranov/todoapp/2.0.0/images/sha256-2e687beffd25a904d966239f5712788eabb816e5a31e2d37424fb82a5f3385c6?context=repo)