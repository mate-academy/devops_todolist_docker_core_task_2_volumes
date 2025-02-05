# Deployment instructions

## Build MySQL container with a volume attached

```
docker build . -f Dockerfile.mysql -t my-sql:1.0.0
```

## Run MySQL container with a volume attached

```
docker run  -d -p 3306:3306 --name my-mysql my-sql:1.0.0
```

## Build and run the App container

```
docker build . -f Dockerfile -t todoapp:2.0.0 
docker run --name todoapp -p 8080:8080 todoapp:2.0.0
```

## Tag and push to docker hub repository

```
docker tag my-sql:1.0.0 uka0001/mysql-local:1.0.0
docker push uka0001/mysql-local:1.0.0
docker tag todoapp:2.0.0 uka0001/todoapp:2.0.0
docker push uka0001/todoapp:2.0.0 
```
