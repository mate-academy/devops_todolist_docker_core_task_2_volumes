### Database Setup (MySQL with Volume)
To run the MySQL database with persistent storage, use the following commands:

1. Build the database image:
   `docker build . -f Dockerfile.mysql -t mysql-local:1.0.0 .`

2. Next, create a network: docker network create mysql

A key modification was made to the todolist/settings.py file, where the DATABASES configuration's HOST field was updated to 'mysql'. This allows the application to resolve the database address using Docker's internal DNS by the container name.

3. Run the container with a volume attached:
   `docker run -d --name mysql --network mysql -v mysql-volume:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0`
   The `-v mysql-volume:/var/lib/mysql` flag ensures your data is saved even if the container stops.

### Connecting App to MySQL
To connect the application to the database:
1. Build the todoapp image:
`docker build . -f Dockerfile -t mysql-app:1.0.0`

2. Run the container with a volume:
`docker run -d --name todoapp --network mysql -p 8080:8080 mysql-app:1.0.0`

3. After starting the app container, run migrations to initialize the database:
   `docker exec todoapp python manage.py migrate`

### Accessing the Application
Once both containers are running and migrations are done, open your browser and go to:
http://localhost:8000 (or http://localhost:8080 if you mapped it to that port).

Links images:
https://ibb.co/gb3d0kH0

Link docker hub todoapp:
https://hub.docker.com/repository/docker/olegglv/todoapp/

Link docker hub mysql-local:
https://hub.docker.com/repository/docker/olegglv/mysql-local/
