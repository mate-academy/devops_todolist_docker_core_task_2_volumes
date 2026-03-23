## Network

Firstly create network:

```bash
docker network create todo-net
```

## Run Database

Run the database container on this network with a hostname:

```bash
docker run -d -p 3306:3306 -v checklistdb:/var/lib/mysql --network todo-net killingrace/mysql-local:1.0.0
```

## Run

Run app after running database container:

```bash
docker run -d -p 8080:8080 --network todo-net killingrace/todoapp:2.0.0
```

## Docker Hub

- Database app image from personal [Docker Hub](https://hub.docker.com/repository/docker/killingrace/mysql-local/general)

- Django app image from personal [Docker Hub](https://hub.docker.com/repository/docker/killingrace/todoapp/general)


## App Access

To access the application after running the app and db container follow the [link](http://localhost:8080)