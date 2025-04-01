# Instructions for Running MySQL and Django Containers

## Container with MySQL and Mounted Volume 

### Retrieve the Application Image from Docker Hub and run


```sh
docker run -d --name my-mysql -p 3306:3306 -v mysql_data:/var/lib/mysql slradbez/mysql-local:1.0.0
```
### Get the Django Application Container and run

```sh
docker run -d --name django-app --network bridge -p 8080:8080 slradbez/todoapp:2.0.0
```

### Access the Application via Browser

```sh
http://localhost:8080
```
