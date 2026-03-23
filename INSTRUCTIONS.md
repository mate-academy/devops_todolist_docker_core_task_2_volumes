## Run Database

Run database with volume attached

```bash
docker run -d -p 3306:3306 -v checklistdb:/var/lib/mysql killingrace/mysql-local:1.0.0
```

## Run

Run app after running database container 

```bash
docker run -d -p 8080:8080 django-app:latest
```

## Docker Hub

- Database app image from personal [Docker Hub](https://hub.docker.com/repository/docker/killingrace/mysql-local/general)

- Django app image from personal [Docker Hub](https://hub.docker.com/repository/docker/killingrace/todoapp/general)


## App Access

To access the application after running the app and db container follow the [link](http://localhost:8080)