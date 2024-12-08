#### Images: 
 - MySQL: `https://hub.docker.com/repository/docker/fredisson11/mysql-local`
 - Application: `https://hub.docker.com/repository/docker/fredisson11/todoapp`

### Running locally:
  
#### 1. Run mysql 
```
docker run -d \                                           
    -e MYSQL_ROOT_PASSWORD=1234 \
    -e MYSQL_DATABASE=app_db \
    -e MYSQL_USER=app_user \
    -e MYSQL_PASSWORD=1234 \
    -p 3306:3306 \
    -v mysql-data:/var/lib/mysql \
    fredisson11/mysql-local:1.0.0
```
  
#### 2. Run todoapp
```
docker run -d -p 8080:8080 fredisson11/todoapp:2.0.0
```
  
#### 3. The app will be available at 
```
localhost:8080
```
  