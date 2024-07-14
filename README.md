# Instruction

## Run MYSQL container

### Download image

```
docker pull zaavee/mysql-local:1.0.0
```

### Run container

``` 
docker run -d -p 3306:3306 -v mysql-db:/var/lib/mysql zaavee/mysql-local:1.0.0
```

## Run App container

### Download image

```
docker pull zaavee/todoapp:2.0.0
```

### Run container 

Before run app container you need to run mysql container

```
docker run -p 8080:8080 zaavee/todoapp:2.0.0
```

## Repositories

[Todoapp](https://hub.docker.com/r/zaavee/todoapp)

[Mysql](https://hub.docker.com/r/zaavee/mysql-local)

## Open the app in a browser

Open the program in a browser at this address [http://0.0.0.0:8080](http://0.0.0.0:8080)